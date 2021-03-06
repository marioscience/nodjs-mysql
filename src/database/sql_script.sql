-- This sql file has the database creation as well as all tables
-- and seed data. Ideally as the project grows these files owuld 
-- need to be segmented and organized.
CREATE DATABASE IF NOT EXISTS ibanonline;

USE ibanonline;

CREATE TABLE IF NOT EXISTS ibanonline.users (
	user_id BIGINT NOT NULL AUTO_INCREMENT,
    username VARCHAR(30),
    password_hash VARCHAR(50),
    PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS ibanonline.transactions (
	transaction_id BIGINT NOT NULL AUTO_INCREMENT,
    amount DECIMAL NOT NULL,
    transaction_date DATETIME NOT NULL,
    user_id BIGINT,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    INDEX (amount),
    INDEX (transaction_date)
);

-- The amount and dates should contain indexes because they are
-- going to be used heavily to filter queries

INSERT INTO users (user_id, username, password_hash) VALUES
	(1, "testuser", "f8qnyc98hfho8fw8yrn9cYPA8YXUWuf9NWEFYNEWIF"),
    (2, "regularUser", "fyn2c983rypfaeunfyo872tbxuyagkfoz9naxpyechbv");


-- Write script to generate data that is relative to current date. That way the seed data doesn't get outdated and
-- is generated more easily
INSERT INTO transactions (amount, transaction_date, user_id) VALUES
    (2123.00, '2018-08-11 12:49:01', 1),
    (423.00, '2018-08-12 12:49:01', 2),
    (11.00, '2018-08-13 12:49:01', 1),
    (12312.00, '2018-08-14 12:49:01', 2),
	(1231.00, '2018-08-15 12:49:01', 1),
    (2123.00, '2018-08-15 12:59:01', 1),
    (423.00, '2018-08-16 12:49:01', 2),
    (11.00, '2018-08-17 12:49:01', 1),
    (12312.00, '2018-08-17 12:49:01', 2),
    (11.00, '2018-08-18 12:49:01', 2),
    (12312.00, '2018-08-01 12:49:01', 1),
    (2123.00, '2018-08-05 12:49:01', 1),
    (423.00, '2018-08-06 12:49:01', 2),
    (11.00, '2018-08-10 12:49:01', 1),
    (12312.00, '2018-07-22 12:49:01', 2),
    (11.00, '2018-07-23 12:49:01', 2),
    (12312.00, '2018-07-21 12:49:01', 1),
    (2123.00, '2018-07-23 12:49:01', 1),
    (423.00, '2018-07-24 12:49:01', 2),
    (11.00, '2018-07-25 12:49:01', 1),
    (12312.00, '2018-07-26 12:49:01', 2),
    (11.00, '2018-07-27 12:49:01', 2),
    (12312.00, '2018-07-28 12:49:01', 1),
    (12312.00, '2018-07-29 12:49:01', 1),
    (11.00, '2018-01-21 12:49:01', 2),
    (12312.00, '2018-01-21 12:49:01', 1),
    (12312.00, '2018-01-21 12:49:01', 1),
    (2123.00, '2018-01-21 12:49:01', 1),
    (423.00, '2018-01-22 12:49:01', 2),
    (11.00, '2018-01-21 12:49:01', 1),
    (12312.00, '2018-01-21 12:49:01', 2),
    (11.00, '2018-01-21 12:49:01', 2),
    (12312.00, '2018-01-21 12:49:01', 1),
    (112.00, '2018-01-21 12:49:01', 1);