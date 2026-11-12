-- SkillHub database (PostgreSQL / Neon)

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(10) NOT NULL DEFAULT 'user' CHECK (role IN ('user', 'admin'))
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE workshops (
    workshop_id SERIAL PRIMARY KEY,
    category_id INT NOT NULL REFERENCES categories(category_id),
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    city VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price DECIMAL(7, 2) NOT NULL CHECK (price BETWEEN 0 AND 2000),
    capacity INT NOT NULL CHECK (capacity BETWEEN 5 AND 100),
    image_name VARCHAR(255) NOT NULL,
    CHECK (end_date >= start_date)
);

CREATE TABLE registrations (
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    workshop_id INT NOT NULL REFERENCES workshops(workshop_id) ON DELETE CASCADE,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, workshop_id)
);