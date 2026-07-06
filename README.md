# FU House Finder

JSP/Servlet application built with Maven and packaged as a WAR. The project uses Microsoft SQL Server and can be run in two ways:

1. Local development with Maven + your own Tomcat
2. Docker demo with one command for both the web app and database

## Tech Stack

- Java 11
- Jakarta EE 10 / Servlet 6
- Maven WAR packaging
- JSP, Servlet, JSTL
- Microsoft SQL Server 2022
- Apache Tomcat 10.1 in Docker

## Repository Layout

- `src/main/java` - Java source code
- `src/main/webapp` - JSP, HTML, CSS, JS, and web descriptors
- `fuhf-sqlserver.sql` - database schema and seed data
- `Dockerfile` - builds the WAR and deploys it to Tomcat
- `docker-compose.yml` - runs SQL Server and the web app together
- `.env.example` - sample environment variables for local and Docker runs
- `.gitignore` - excludes build output and local secrets
- `.dockerignore` - keeps the Docker build context small

## Important Runtime Variables

The project no longer stores secrets in the repository. Configure these values through environment variables or JVM system properties.

When running locally, the app also tries to auto-read a `.env.local` file.

The app looks for config in this order:

1. Real environment variables
2. JVM system properties
3. `.env.local`

When running locally, the app also tries to auto-read config files from:

- the current working directory
- parent directories up to a few levels up
- `catalina.base` or `catalina.home` if you are using an external Tomcat

In Docker, the variables are passed in directly through `docker-compose.yml`. The root `.env` file is only for Docker Compose variable substitution.

Default ports for the demo setup:

- Local SQL Server: `localhost:1433`
- Docker SQL Server: `localhost:14330`

### Database

- `DB_HOST`
- `DB_PORT`
- `DB_NAME`
- `DB_USER`
- `DB_PASSWORD`
- `DB_ENCRYPT`
- `DB_AUTO_INIT`
- `DB_INIT_SCRIPT_PATH`

### Google Login

- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`
- `GOOGLE_REDIRECT_URI`

### VNPAY

- `VNPAY_TMN_CODE`
- `VNPAY_SECRET_KEY`
- `VNPAY_PAY_URL`
- `VNPAY_RETURN_URL`
- `VNPAY_API_URL`

### Mail

- `MAIL_USERNAME`
- `MAIL_PASSWORD`

## Docker Demo

This is the easiest way to demo the application.

### 1. Prepare the environment file

Copy `.env.example` to `.env` and fill in your real values:

```bash
copy .env.example .env
```

On Windows PowerShell you can also use:

```powershell
Copy-Item .env.example .env
```

Update at least these values:

- `DB_PASSWORD`
- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`
- `VNPAY_TMN_CODE`
- `VNPAY_SECRET_KEY`
- `MAIL_USERNAME`
- `MAIL_PASSWORD`

### 2. Start Docker

```bash
docker compose up --build
```

The first startup may take a while because SQL Server needs time to initialize before the app seeds the database.

### 3. Open the app

Use this URL:

```text
http://localhost:8080/HFManagementSystem/
```

Useful direct links:

```text
http://localhost:8080/HFManagementSystem/home
http://localhost:8080/HFManagementSystem/pages/system/login.jsp
```

### 4. Database access from host

The SQL Server container is published to host port `14330`, so it will not conflict with a local SQL Server using `1433`.

Use the following connection info from your machine:

- Server: `localhost,14330`
- User: `sa`
- Password: value from `DB_PASSWORD`

### 5. Stop Docker

```bash
docker compose down
```

To remove the database volume and reseed everything from scratch:

```bash
docker compose down -v
```

## Local Development

You can also run the WAR outside Docker.

### 1. Build the project

```bash
mvn -DskipTests package
```

This produces:

```text
target/HFManagementSystem-1.0-SNAPSHOT.war
```

### 2. Deploy to Tomcat

Copy the WAR into your local Tomcat `webapps` directory and start Tomcat 10.1.

### 3. Provide environment variables

Set the same variables listed above in one of these ways:

- IDE run configuration
- System environment variables
- JVM system properties

Examples:

```powershell
$env:DB_HOST = "localhost"
$env:DB_PORT = "1433"
$env:DB_NAME = "FUHF2"
$env:DB_USER = "sa"
$env:DB_PASSWORD = "your_password"
```

Or with JVM properties:

```text
-DDB_HOST=localhost -DDB_PORT=1433 -DDB_NAME=FUHF2 -DDB_USER=sa -DDB_PASSWORD=your_password
```

## How Configuration Works

The code reads configuration in this order:

1. Environment variable
2. JVM system property
3. Fallback value, if one is safe to use

That means you can use the same code in both:

- local development
- Docker Compose demo

without committing secrets to GitHub.

## Database Bootstrap

When the app starts, the bootstrap listener tries to:

1. Connect to SQL Server
2. Create the database if it does not exist
3. Run the seed script `fuhf-sqlserver.sql`
4. Leave the app running even if bootstrap fails, so startup logs stay visible

If the seed has already been imported, the listener should not re-create everything unless you remove the Docker volume or reset the database manually.

## Troubleshooting

### 404 on the root URL

If `http://localhost:8080/HFManagementSystem/` returns 404:

1. Make sure Tomcat is running
2. Make sure the WAR deployed successfully
3. Rebuild the Docker image if you changed web files:

```bash
docker compose down
docker compose up --build
```

### Database starts slowly

This is normal on the first run. SQL Server can take some time to initialize, especially on Docker Desktop.

### `No suitable driver found`

This usually means the JDBC driver is missing from the runtime classpath or the app has not been rebuilt with the latest dependencies.

### Mail, Google login, or VNPAY do not work

Check that the matching environment variables are set:

- Mail: `MAIL_USERNAME`, `MAIL_PASSWORD`
- Google login: `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`, `GOOGLE_REDIRECT_URI`
- VNPAY: `VNPAY_TMN_CODE`, `VNPAY_SECRET_KEY`, `VNPAY_RETURN_URL`

## Notes

- Tomcat is required because this is a WAR-based JSP/Servlet project.
- SQL Server is required because the DAO layer uses Microsoft SQL Server JDBC.
- The repository is now safe to push to GitHub because secrets are read from environment variables instead of being committed in source files.

## Next Steps

1. If you want, I can also add a small `.env` loader note to `docker-compose.yml` comments.
2. I can make the local development section even more explicit for IntelliJ IDEA or Eclipse.
3. I can scan the repo once more for any remaining hardcoded credentials or tokens.
