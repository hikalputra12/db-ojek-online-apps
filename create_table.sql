-- CREATE TABLE: USERS
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(200) NOT NULL,
    role VARCHAR(20) CHECK (role IN ('admin', 'customer', 'driver')),
    create_at TIMESTAMP DEFAULT NOW(),
    update_at TIMESTAMP DEFAULT NOW()
);

-- CREATE TABLE: CUSTOMER
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    address VARCHAR(255),
    phone_number VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES users(user_id)
);

-- CREATE TABLE: DRIVER
CREATE TABLE driver (
    driver_id INT PRIMARY KEY,
    phone_number VARCHAR(20),
    vehicle_number VARCHAR(20),
    type_of_vehicle VARCHAR(50),
    FOREIGN KEY (driver_id) REFERENCES users(user_id)
);

-- CREATE TABLE: USER ACTIVITY LOG
CREATE TABLE user_activity_log (
    activity_id SERIAL PRIMARY KEY,
    user_id INT,
    activity_type VARCHAR(20) CHECK (activity_type IN ('login', 'logout')),
    activity_time TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- CREATE TABLE: ORDERS
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    driver_id INT,
    pickup_location VARCHAR(255),
    destination_location VARCHAR(255),
    distance FLOAT,
    cost INT,
    status_order VARCHAR(20) CHECK (status_order IN ('pending','accepted','completed','canceled')),
    order_time TIMESTAMP DEFAULT NOW(),
    finish_time TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (driver_id) REFERENCES driver(driver_id)
);

-- CREATE TABLE: TRAVEL HISTORY
CREATE TABLE travel_history (
    travel_history_id SERIAL PRIMARY KEY,
    order_id INT,
    customer_id INT,
    travel_time TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);


-- CREATE TABLE: DRIVER MONTHLY HISTORY
CREATE TABLE driver_monthly_history (
    driver_monthly_history_id SERIAL PRIMARY KEY,
    drive_id INT,
    month INT CHECK (month BETWEEN 1 AND 12),
    year INT,
    total_orders INT,
    FOREIGN KEY (drive_id) REFERENCES driver(driver_id)
);
