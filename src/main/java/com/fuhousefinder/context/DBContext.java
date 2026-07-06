package com.fuhousefinder.context;

import java.sql.*;
import java.sql.SQLException;
import java.util.logging.*;

public class DBContext {

    private static final String DRIVER_CLASS = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String DEFAULT_URL = "jdbc:sqlserver://localhost:1433;databaseName=FUHF2;encrypt=false;trustServerCertificate=true";
    private static final String USER = readConfig("DB_USER", "sa");
    private static final String PASS = readConfig("DB_PASSWORD", "");
    private static final String URL = resolveUrl();

    public DBContext() {
        loadDriver();
    }

    private static void loadDriver() {
        try {
            Class.forName(DRIVER_CLASS);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Connection getConnection() throws SQLException {
        if (PASS.isBlank()) {
            throw new SQLException("DB_PASSWORD is missing. Set DB_PASSWORD as an environment variable or JVM system property.");
        }
        return DriverManager.getConnection(URL, USER, PASS);
    }

    private static String resolveUrl() {
        String explicitUrl = readConfig("DB_URL", null);
        if (explicitUrl != null && !explicitUrl.isBlank()) {
            return explicitUrl;
        }

        String host = readConfig("DB_HOST", null);
        String port = readConfig("DB_PORT", null);
        String database = readConfig("DB_NAME", null);
        String instance = readConfig("DB_INSTANCE", null);

        if ((host != null && !host.isBlank()) || (port != null && !port.isBlank()) || (database != null && !database.isBlank()) || (instance != null && !instance.isBlank())) {
            String resolvedHost = (host == null || host.isBlank()) ? "localhost" : host;
            String resolvedPort = (port == null || port.isBlank()) ? "1433" : port;
            String resolvedDatabase = (database == null || database.isBlank()) ? "FUHF2" : database;
            StringBuilder builder = new StringBuilder("jdbc:sqlserver://");
            builder.append(resolvedHost);
            if (instance != null && !instance.isBlank()) {
                builder.append("\\").append(instance);
            } else {
                builder.append(":").append(resolvedPort);
            }
            builder.append(";databaseName=").append(resolvedDatabase);
            builder.append(";encrypt=").append(readConfig("DB_ENCRYPT", "false"));
            builder.append(";trustServerCertificate=true");
            return builder.toString();
        }

        return DEFAULT_URL;
    }

    private static String readConfig(String key, String fallback) {
        return com.fuhousefinder.configs.EnvConfig.read(key, fallback);
    }

    public void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public void closeResultSet(ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException ex) {
                Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public void closeStatement(PreparedStatement statement) {
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException ex) {
                Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
