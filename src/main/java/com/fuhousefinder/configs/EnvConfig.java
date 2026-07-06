package com.fuhousefinder.configs;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;

public final class EnvConfig {

    private static volatile Map<String, String> DOTENV_VALUES;

    private EnvConfig() {
    }

    public static String read(String key) {
        String value = System.getenv(key);
        if (isBlank(value)) {
            value = System.getProperty(key);
        }
        if (isBlank(value)) {
            value = getDotEnvValues().get(key);
        }
        return isBlank(value) ? null : value;
    }

    public static String read(String key, String fallback) {
        String value = read(key);
        return isBlank(value) ? fallback : value;
    }

    private static Map<String, String> getDotEnvValues() {
        Map<String, String> values = DOTENV_VALUES;
        if (values == null) {
            synchronized (EnvConfig.class) {
                values = DOTENV_VALUES;
                if (values == null) {
                    values = loadDotEnv();
                    DOTENV_VALUES = values;
                }
            }
        }
        return values;
    }

    private static Map<String, String> loadDotEnv() {
        Map<String, String> values = new HashMap<>();
        mergeFromResource(values, ".env.local");

        Path envFile = locateEnvFile();
        if (envFile == null) {
            return values;
        }

        try (BufferedReader reader = Files.newBufferedReader(envFile, StandardCharsets.UTF_8)) {
            String line;
            while ((line = reader.readLine()) != null) {
                String trimmed = line.trim();
                if (trimmed.isEmpty() || trimmed.startsWith("#")) {
                    continue;
                }
                if (trimmed.startsWith("export ")) {
                    trimmed = trimmed.substring("export ".length()).trim();
                }

                int equalsIndex = trimmed.indexOf('=');
                if (equalsIndex <= 0) {
                    continue;
                }

                String key = trimmed.substring(0, equalsIndex).trim();
                String value = trimmed.substring(equalsIndex + 1).trim();
                if (!key.isEmpty() && !value.isEmpty()) {
                    values.put(key, stripQuotes(value));
                }
            }
        } catch (IOException ignored) {
            // Ignore and fall back to real env/system properties.
        }

        return values;
    }

    private static void mergeFromResource(Map<String, String> values, String resourceName) {
        ClassLoader classLoader = EnvConfig.class.getClassLoader();
        try (InputStream inputStream = classLoader.getResourceAsStream(resourceName)) {
            if (inputStream == null) {
                return;
            }

            try (BufferedReader reader = new BufferedReader(new java.io.InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    addLine(values, line);
                }
            }
        } catch (IOException ignored) {
            // Ignore and continue with file-system loading.
        }
    }

    private static void addLine(Map<String, String> values, String line) {
        String trimmed = line.trim();
        if (trimmed.isEmpty() || trimmed.startsWith("#")) {
            return;
        }
        if (trimmed.startsWith("export ")) {
            trimmed = trimmed.substring("export ".length()).trim();
        }

        int equalsIndex = trimmed.indexOf('=');
        if (equalsIndex <= 0) {
            return;
        }

        String key = trimmed.substring(0, equalsIndex).trim();
        String value = trimmed.substring(equalsIndex + 1).trim();
        if (!key.isEmpty() && !value.isEmpty()) {
            values.putIfAbsent(key, stripQuotes(value));
        }
    }

    private static Path locateEnvFile() {
        String explicit = System.getProperty("APP_ENV_FILE");
        if (!isBlank(explicit)) {
            Path explicitPath = Path.of(explicit);
            if (Files.exists(explicitPath)) {
                return explicitPath;
            }
        }

        Path current = Path.of(System.getProperty("user.dir", ".")).toAbsolutePath();
        for (int i = 0; i < 6 && current != null; i++) {
            Path localCandidate = current.resolve(".env.local");
            if (Files.exists(localCandidate)) {
                return localCandidate;
            }
            current = current.getParent();
        }

        String catalinaBase = System.getProperty("catalina.base");
        if (!isBlank(catalinaBase)) {
            Path basePath = Path.of(catalinaBase);
            Path[] candidates = new Path[] {
                basePath.resolve(".env.local"),
                basePath.resolve("conf").resolve(".env.local"),
            };
            for (Path candidate : candidates) {
                if (Files.exists(candidate)) {
                    return candidate;
                }
            }
        }

        String catalinaHome = System.getProperty("catalina.home");
        if (!isBlank(catalinaHome)) {
            Path homePath = Path.of(catalinaHome);
            Path[] candidates = new Path[] {
                homePath.resolve(".env.local"),
                homePath.resolve("conf").resolve(".env.local"),
            };
            for (Path candidate : candidates) {
                if (Files.exists(candidate)) {
                    return candidate;
                }
            }
        }

        return null;
    }

    private static String stripQuotes(String value) {
        if (value.length() >= 2) {
            char first = value.charAt(0);
            char last = value.charAt(value.length() - 1);
            if ((first == '"' && last == '"') || (first == '\'' && last == '\'')) {
                return value.substring(1, value.length() - 1);
            }
        }
        return value;
    }

    private static boolean isBlank(String value) {
        return value == null || value.isBlank();
    }
}
