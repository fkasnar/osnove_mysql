DROP DATABASE IF EXISTS tvrtka;

CREATE DATABASE IF NOT EXISTS tvrtka DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE tvrtka;

/* OVO JE KOMENTAR */

CREATE TABLE IF NOT EXISTS poslovnice(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    ime VARCHAR(20) NOT NULL,
    adresa VARCHAR(255) NOT NULL,
    broj_telefona VARCHAR(12),
    grad VARCHAR(20)
)ENGINE=InnoDB;