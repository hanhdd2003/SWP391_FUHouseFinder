package com.fuhousefinder.context;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.logging.Logger;

public class DatabaseBootstrapListener implements ServletContextListener {

    private static final String DRIVER_CLASS = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final Logger LOGGER = Logger.getLogger(DatabaseBootstrapListener.class.getName());
    private static final String DEFAULT_SCRIPT_PATH = "/opt/tomcat/fuhf-sqlserver.sql";

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            loadDriver();
            if (isAutoInitEnabled()) {
                bootstrap();
            } else {
                LOGGER.info("Database auto-init is disabled.");
            }
        } catch (Throwable ex) {
            LOGGER.severe("Database bootstrap failed, but the web app will still start: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    private void bootstrap() throws Exception {
        String dbName = config("DB_NAME", "FUHF2");
        String scriptPath = config("DB_INIT_SCRIPT_PATH", DEFAULT_SCRIPT_PATH);

        waitForSqlServer();

        try (Connection masterConnection = openMasterConnection(); Statement statement = masterConnection.createStatement()) {
            if (!databaseExists(statement, dbName)) {
                LOGGER.info(() -> "Database " + dbName + " does not exist yet, creating it.");
                statement.execute("CREATE DATABASE " + bracket(dbName));
            }
        }

        try (Connection databaseConnection = openDatabaseConnection(dbName)) {
            if (tableExists(databaseConnection, "USERS")) {
                LOGGER.info(() -> "Database " + dbName + " already contains schema, skipping bootstrap.");
                return;
            }

            LOGGER.info(() -> "Database " + dbName + " exists but schema is missing, replaying seed script.");
            runSeedScript(databaseConnection, scriptPath);
        }
    }

    private void waitForSqlServer() throws InterruptedException {
        long deadline = System.currentTimeMillis() + 300000L;
        while (System.currentTimeMillis() < deadline) {
            try (Connection ignored = openMasterConnection()) {
                return;
            } catch (SQLException ex) {
                LOGGER.info(() -> "Waiting for SQL Server to become ready: " + ex.getMessage());
                Thread.sleep(5000L);
            }
        }

        throw new IllegalStateException("SQL Server was not ready within the bootstrap timeout.");
    }

    private Connection openMasterConnection() throws SQLException {
        return DriverManager.getConnection(buildJdbcUrl("master"), config("DB_USER", "sa"), requirePassword());
    }

    private Connection openDatabaseConnection(String databaseName) throws SQLException {
        return DriverManager.getConnection(buildJdbcUrl(databaseName), config("DB_USER", "sa"), requirePassword());
    }

    private void loadDriver() {
        try {
            Class.forName(DRIVER_CLASS);
        } catch (ClassNotFoundException ex) {
            throw new IllegalStateException("SQL Server JDBC driver not found in the application classpath", ex);
        }
    }

    private String buildJdbcUrl(String databaseName) {
        String explicitUrl = config("DB_URL", null);
        if (explicitUrl != null && !explicitUrl.isBlank()) {
            return explicitUrl;
        }

        String host = config("DB_HOST", null);
        String port = config("DB_PORT", null);
        String instance = config("DB_INSTANCE", null);

        String resolvedHost = (host == null || host.isBlank()) ? "localhost" : host;
        String resolvedPort = (port == null || port.isBlank()) ? "1433" : port;
        String resolvedDatabase = (databaseName == null || databaseName.isBlank()) ? "FUHF2" : databaseName;

        StringBuilder builder = new StringBuilder("jdbc:sqlserver://");
        builder.append(resolvedHost);
        if (instance != null && !instance.isBlank()) {
            builder.append("\\").append(instance);
        } else {
            builder.append(":").append(resolvedPort);
        }
        builder.append(";databaseName=").append(resolvedDatabase);
        builder.append(";encrypt=").append(config("DB_ENCRYPT", "false"));
        builder.append(";trustServerCertificate=true");
        return builder.toString();
    }

    private boolean databaseExists(Statement statement, String dbName) throws SQLException {
        try (ResultSet resultSet = statement.executeQuery("SELECT CASE WHEN DB_ID(N'" + escapeSql(dbName) + "') IS NULL THEN 0 ELSE 1 END")) {
            return resultSet.next() && resultSet.getInt(1) == 1;
        }
    }

    private boolean tableExists(Connection connection, String tableName) throws SQLException {
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery("SELECT CASE WHEN OBJECT_ID(N'dbo." + escapeSql(tableName) + "', N'U') IS NULL THEN 0 ELSE 1 END")) {
            return resultSet.next() && resultSet.getInt(1) == 1;
        }
    }

    private void runSeedScript(Connection connection, String scriptPath) throws IOException, SQLException {
        String script = readSeedScript(scriptPath);
        script = stripDatabaseBootstrapStatements(script);

        List<String> batches = splitSqlBatches(script);
        try (Statement statement = connection.createStatement()) {
            for (String batch : batches) {
                String trimmed = batch.trim();
                if (trimmed.isEmpty()) {
                    continue;
                }
                statement.execute(batch);
            }
        }
    }

    private String readSeedScript(String scriptPath) throws IOException {
        Path fileSystemPath = Path.of(scriptPath);
        if (Files.exists(fileSystemPath)) {
            return Files.readString(fileSystemPath, StandardCharsets.UTF_8);
        }

        try (var inputStream = DatabaseBootstrapListener.class.getClassLoader().getResourceAsStream("fuhf-sqlserver.sql")) {
            if (inputStream != null) {
                return new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);
            }
        }

        throw new IOException("Seed script not found at " + scriptPath + " or on the classpath.");
    }

    private String stripDatabaseBootstrapStatements(String script) {
        String[] lines = script.split("\\r?\\n");
        StringBuilder cleaned = new StringBuilder();
        for (String line : lines) {
            String trimmed = line.trim();
            if (trimmed.isEmpty()) {
                cleaned.append(line).append(System.lineSeparator());
                continue;
            }
            if (trimmed.startsWith("--")) {
                cleaned.append(line).append(System.lineSeparator());
                continue;
            }
            if (trimmed.matches("(?i)^CREATE\\s+DATABASE\\b.*")) {
                continue;
            }
            if (trimmed.matches("(?i)^USE\\s+FUHF2\\s*;?$")) {
                continue;
            }
            cleaned.append(line).append(System.lineSeparator());
        }
        return cleaned.toString();
    }

    private List<String> splitSqlBatches(String script) {
        List<String> batches = new ArrayList<>();
        StringBuilder current = new StringBuilder();
        String[] lines = script.split("\\r?\\n");
        for (String line : lines) {
            if (line.trim().equalsIgnoreCase("GO")) {
                batches.add(current.toString());
                current.setLength(0);
            } else {
                current.append(line).append(System.lineSeparator());
            }
        }
        if (current.length() > 0) {
            batches.add(current.toString());
        }
        return batches;
    }

    private String escapeSql(String value) {
        return value.replace("'", "''");
    }

    private String bracket(String value) {
        return "[" + value.replace("]", "]]") + "]";
    }

    private boolean isAutoInitEnabled() {
        String value = config("DB_AUTO_INIT", "false");
        return value == null || !value.toLowerCase(Locale.ROOT).equals("false");
    }

    private String config(String key, String fallback) {
        return com.fuhousefinder.configs.EnvConfig.read(key, fallback);
    }

    private String requirePassword() throws SQLException {
        String password = config("DB_PASSWORD", "");
        if (password.isBlank()) {
            throw new SQLException("DB_PASSWORD is missing. Set DB_PASSWORD as an environment variable or JVM system property.");
        }
        return password;
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Nothing to clean up.
    }
}
