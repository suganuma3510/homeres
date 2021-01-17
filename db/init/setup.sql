CREATE DATABASE homeres;

use homeres;

CREATE TABLE users (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    password VARCHAR(64) NOT NULL,
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    PRIMARY KEY (id)
);

INSERT INTO users (name, password) VALUES ("test01", "password");
INSERT INTO users (name, password) VALUES ("test02", "password");