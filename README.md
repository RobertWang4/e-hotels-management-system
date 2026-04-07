# e-Hotels Management System

CSI2132 — Databases I, Winter 2026, University of Ottawa  
**Group Members**: Tianqi Jiang, Mengchen Wang  
**Section A** | Instructor: Verena Kantere

## Tech Stack

- **Database**: PostgreSQL 17
- **Backend**: Java 17+ / Spring Boot 3.4
- **Caching**: Redis
- **Frontend**: Thymeleaf + Custom CSS
- **Build**: Maven

## Prerequisites

Make sure you have installed:

- **Java 17+**: `java -version`
- **PostgreSQL**: `psql --version`
- **Redis**: `redis-cli --version`

### macOS (Homebrew)

```bash
brew install openjdk@17 postgresql@17 redis
brew services start postgresql@17
brew services start redis
```

## Getting Started

### 1. Clone the repository

```bash
git clone git@github.com:RobertWang4/e-hotels-management-system.git
cd e-hotels-management-system
```

### 2. Create the database

```bash
createdb ehotels
```

### 3. Configure database connection

Edit `src/main/resources/application.properties` if your PostgreSQL username or password is different:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/ehotels
spring.datasource.username=YOUR_USERNAME
spring.datasource.password=YOUR_PASSWORD
```

### 4. Run the application

```bash
./mvnw spring-boot:run
```

The app will automatically:
- Create all tables (schema.sql)
- Populate sample data (data.sql)
- Create triggers, views, and indexes (DatabaseObjectsInitializer)

### 5. Open in browser

```
http://localhost:8080
```

## Application Pages

| URL | Description |
|-----|-------------|
| `/` | Home — choose Guest or Staff |
| `/search` | Search and book available rooms |
| `/employee/dashboard` | Employee: check-in, walk-in rental, payment |
| `/admin/customers` | CRUD customers |
| `/admin/employees` | CRUD employees |
| `/admin/hotels` | CRUD hotels |
| `/admin/rooms` | CRUD rooms |
| `/views/available-rooms` | SQL View: available rooms per area |
| `/views/hotel-capacity` | SQL View: hotel aggregated capacity |

## Project Structure

```
ehotels/
├── pom.xml
├── sql/
│   ├── queries.sql          # 8 SQL queries (2c)
│   ├── triggers.sql         # 6 triggers (2d)
│   ├── indexes.sql          # 8 indexes (2e)
│   └── views.sql            # 2 views (2f)
├── src/main/java/com/ehotels/
│   ├── EhotelsApplication.java
│   ├── config/
│   │   ├── RedisConfig.java
│   │   └── DatabaseObjectsInitializer.java
│   ├── model/               # JPA entities
│   ├── repository/          # Data access layer
│   ├── service/             # Business logic + Redis caching
│   └── controller/          # HTTP request handlers
└── src/main/resources/
    ├── application.properties
    ├── schema.sql            # DDL (2a)
    ├── data.sql              # Sample data (2b)
    ├── templates/            # Thymeleaf HTML pages
    └── static/css/           # Stylesheets
```

## Database

- **5 hotel chains**, 8 hotels each (40 total)
- **200 rooms** (5 per hotel)
- **80 employees**, 20 customers
- **20 bookings**, 15 rentings, 10 payments
- **6 triggers** enforcing business rules
- **8 indexes** with justifications
- **2 SQL views** (available rooms per area, hotel aggregated capacity)

## Troubleshooting

**Port 8080 already in use:**
```bash
lsof -i :8080 | grep LISTEN | awk '{print $2}' | xargs kill
```

**Redis not running:**
```bash
brew services start redis
```

**Database already exists:**
```bash
dropdb ehotels && createdb ehotels
```
