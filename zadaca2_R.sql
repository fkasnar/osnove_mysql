DROP DATABASE IF EXISTS library;

CREATE DATABASE IF NOT EXISTS library DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE library;



CREATE TABLE IF NOT EXISTS members (
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    userID INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    contact VARCHAR(12),
    membershipActive BOOLEAN
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS memberCard (
    userID INT,
    FOREIGN KEY (userID) REFERENCES members(userID),
    dateIssued DATE NOT NULL,
    expiryDate DATE NOT NULL,
    IDCardNumber UNSIGNED AUTO_INCREMENT NOT NULL UNIQUE
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS borrows (
    borrowID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userID INT,
    FOREIGN KEY (userID) REFERENCES members(userID),
    bookID INT AUTO_INCREMENT,
    FOREIGN KEY (bookID) REFERENCES book(bookID),
    bookGenreID VARCHAR(3),
    FOREIGN KEY (bookGenreID) REFERENCES genre(bookGenreID),
    dateBorrowed DATE NOT NULL,
    returnDateLimit DATE NOT NULL,
    late BOOLEAN
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS fee (
    borrowID INT NOT NULL,
    FOREIGN KEY (borrowID) REFERENCES borrows(borrowID),
    daysLate INT,
    finePerDay INT,
    fineAmount INT
)ENGINE=InnoDB;


/////////////////////////////////////////////////////////////////////7777

CREATE TABLE IF NOT EXISTS book (
    bookID INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    isbn13 INT (13) NOT NULL,
    bookGenreID INT UNSIGNED NOT NULL,
    bookTitle VARCHAR(100) NOT NULL,
    FOREIGN KEY (bookGenreID) REFERENCES BookGenre(id)
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS genre (
    bookGenreID INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    genreName VARCHAR(100) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS bookCopy (
    bookID INT NOT NULL,
    FOREIGN KEY (bookID) REFERENCES book(bookID),
    stock int (100) NOT NULL
)ENGINE=InnoDB;




















CREATE TABLE IF NOT EXISTS cjenik (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    tip_filma VARCHAR(20) NOT NULL,
    cijena DECIMAL(10,2) NOT NULL,
    zakasnina_po_danu DECIMAL(10,2) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS mediji (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    tip VARCHAR(100) NOT NULL,
    zaliha INT NOT NULL,
    koeficijent FLOAT NOT NULL
)ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS posudba (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    datum_posudbe DATE NOT NULL,
    datum_povrata DATE NOT NULL,
    film_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (film_id) REFERENCES filmovi(id),
    clan_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (clan_id) REFERENCES clanovi(id),
    cjenik_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (cjenik_id) REFERENCES cjenik(id),
    medij_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (medij_id) REFERENCES mediji(id)
)ENGINE=InnoDB;

ALTER TABLE mediji DROP COLUMN zaliha;

CREATE TABLE IF NOT EXISTS film_medij (
    film_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (film_id) REFERENCES filmovi(id),
    medij_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (medij_id) REFERENCES mediji(id),
    zaliha INT NOT NULL
)