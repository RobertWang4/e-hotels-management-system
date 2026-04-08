DROP TABLE IF EXISTS payment CASCADE;
DROP TABLE IF EXISTS renting CASCADE;
DROP TABLE IF EXISTS booking CASCADE;
DROP TABLE IF EXISTS room_amenity CASCADE;
DROP TABLE IF EXISTS amenity CASCADE;
DROP TABLE IF EXISTS room CASCADE;
DROP TABLE IF EXISTS employee_has_role CASCADE;
DROP TABLE IF EXISTS employee_role CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS hotel CASCADE;
DROP TABLE IF EXISTS hotel_chain CASCADE;
DROP TABLE IF EXISTS customer CASCADE;

CREATE TABLE hotel_chain (
    chain_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    central_office_address VARCHAR(255) NOT NULL,
    contact_email VARCHAR(100) NOT NULL,
    contact_phone VARCHAR(20) NOT NULL
);

CREATE TABLE hotel (
    hotel_id SERIAL PRIMARY KEY,
    chain_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    category INT NOT NULL CHECK (category BETWEEN 1 AND 5),
    address VARCHAR(255) NOT NULL,
    area VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) NOT NULL,
    contact_phone VARCHAR(20) NOT NULL,
    -- Kept nullable at insert time because hotel creation precedes the first employee assignment.
    manager_employee_id INT,
    FOREIGN KEY (chain_id) REFERENCES hotel_chain(chain_id) ON DELETE CASCADE
);

CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY,
    hotel_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    ssn_sin VARCHAR(20) UNIQUE NOT NULL,
    FOREIGN KEY (hotel_id) REFERENCES hotel(hotel_id) ON DELETE CASCADE
);

ALTER TABLE hotel
ADD FOREIGN KEY (manager_employee_id) REFERENCES employee(employee_id) ON DELETE SET NULL;

CREATE TABLE employee_role (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE employee_has_role (
    employee_id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (employee_id, role_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES employee_role(role_id) ON DELETE CASCADE
);

CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    id_type VARCHAR(50) NOT NULL,
    id_number VARCHAR(50) NOT NULL,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE room (
    room_id SERIAL PRIMARY KEY,
    hotel_id INT NOT NULL,
    room_number VARCHAR(100) NOT NULL,
    capacity VARCHAR(20) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
    view_type VARCHAR(20),
    extendable BOOLEAN NOT NULL DEFAULT FALSE,
    problems TEXT,
    UNIQUE (hotel_id, room_number),
    FOREIGN KEY (hotel_id) REFERENCES hotel(hotel_id) ON DELETE CASCADE
);

CREATE TABLE amenity (
    amenity_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE room_amenity (
    room_id INT NOT NULL,
    amenity_id INT NOT NULL,
    PRIMARY KEY (room_id, amenity_id),
    FOREIGN KEY (room_id) REFERENCES room(room_id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES amenity(amenity_id) ON DELETE CASCADE
);

CREATE TABLE booking (
    booking_id SERIAL PRIMARY KEY,
    customer_id INT,
    room_id INT,
    customer_name_snapshot VARCHAR(100) NOT NULL,
    customer_id_number_snapshot VARCHAR(50) NOT NULL,
    room_number_snapshot VARCHAR(100) NOT NULL,
    hotel_name_snapshot VARCHAR(100) NOT NULL,
    room_price_snapshot DECIMAL(10, 2) NOT NULL CHECK (room_price_snapshot > 0),
    room_capacity_snapshot VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE SET NULL,
    FOREIGN KEY (room_id) REFERENCES room(room_id) ON DELETE SET NULL
);

CREATE TABLE renting (
    renting_id SERIAL PRIMARY KEY,
    customer_id INT,
    room_id INT,
    employee_id INT,
    booking_id INT,
    customer_name_snapshot VARCHAR(100) NOT NULL,
    customer_id_number_snapshot VARCHAR(50) NOT NULL,
    room_number_snapshot VARCHAR(100) NOT NULL,
    hotel_name_snapshot VARCHAR(100) NOT NULL,
    room_price_snapshot DECIMAL(10, 2) NOT NULL CHECK (room_price_snapshot > 0),
    room_capacity_snapshot VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    check_in_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE SET NULL,
    FOREIGN KEY (room_id) REFERENCES room(room_id) ON DELETE SET NULL,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE SET NULL,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE SET NULL
);

CREATE TABLE payment (
    payment_id SERIAL PRIMARY KEY,
    renting_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
    paid_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (renting_id) REFERENCES renting(renting_id) ON DELETE CASCADE
);
