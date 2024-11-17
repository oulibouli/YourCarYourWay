CREATE DATABASE yc_your_way_db;
USE yc_your_way_db;

-- Table Agency
CREATE TABLE Agency (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    location VARCHAR(255)
);

-- Table Vehicle
CREATE TABLE Vehicle (
    id INT PRIMARY KEY AUTO_INCREMENT,
    agency_id INT,
    model VARCHAR(100),
    category VARCHAR(50),
    available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (agency_id) REFERENCES Agency(id)
);

-- Table Users
CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table Audit_Log
CREATE TABLE Audit_Log (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    type_action VARCHAR(255),
    time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- Table Notification
CREATE TABLE Notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    message VARCHAR(255),
    status ENUM('unread', 'read') DEFAULT 'unread',
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- Table Reservation
CREATE TABLE Reservation (
    id INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(255),
    user_id INT,
    vehicle_id INT,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending',
    start_agency INT,
    end_agency INT,
    price DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(id),
    FOREIGN KEY (start_agency) REFERENCES Agency(id),
    FOREIGN KEY (end_agency) REFERENCES Agency(id)
);

-- Table Invoice
CREATE TABLE Invoice (
    id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT,
    amount DECIMAL(10, 2),
    date DATE,
    status ENUM('unpaid', 'paid', 'overdue') DEFAULT 'unpaid',
    FOREIGN KEY (reservation_id) REFERENCES Reservation(id)
);

-- Table Support_Ticket
CREATE TABLE Support_Ticket (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    type ENUM('async', 'chat', 'visio'),
    status ENUM('opened', 'closed') DEFAULT 'opened',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- Table Message
CREATE TABLE Messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT,
    sender ENUM('user', 'support'),
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (ticket_id) REFERENCES Support_Ticket(id)
);

-- Table Visio
CREATE TABLE Visio (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT,
    link VARCHAR(255),
    scheduled_at TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES Support_Ticket(id)
);