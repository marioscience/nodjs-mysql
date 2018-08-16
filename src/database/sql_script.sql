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

INSERT INTO transactions (amount, transaction_date, user_id) VALUES 
	(1231.00, '2016-01-21 12:49:01', 1),
    (2123.00, '2016-01-21 12:49:01', 1),
    (423.00, '2015-01-22 12:49:01', 2),
    (11.00, '2015-01-21 12:49:01', 1),
    (12312.00, '2014-01-21 12:49:01', 2),
    (11.00, '2014-01-21 12:49:01', 2),
    (12312.00, '2013-01-21 12:49:01', 1),
    (112.00, '2012-01-21 12:49:01', 1);