CREATE DATABASE IF NOT EXISTS `bookstore`;

USE `bookstore`;

 CREATE TABLE IF NOT EXISTS `user_type` (
     `TYPE_ID` int(2) NOT NULL,
     `TYPE_NAME` VARCHAR(255) NOT NULL,
     PRIMARY KEY (`TYPE_ID`)
 );

 CREATE TABLE IF NOT EXISTS `user_status` (
     `STATUS_ID` int(2) NOT NULL,
     `STATUS_NAME` VARCHAR(255) NOT NULL,
     PRIMARY KEY (`STATUS_ID`)
 );

CREATE TABLE IF NOT EXISTS `address` (
    `ADDRESS_ID` INT(11) NOT NULL AUTO_INCREMENT,
    `STREET` VARCHAR(255) NOT NULL,
    `CITY` VARCHAR(255) NOT NULL,
    `STATE` VARCHAR(255) NOT NULL,
    `ZIP` INT(5) NOT NULL,
    PRIMARY KEY (`ADDRESS_ID`) 
);

CREATE TABLE IF NOT EXISTS `user` (
  `USER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NAME` varchar(255) NOT NULL UNIQUE,
  `EMAIL_ADDRESS` varchar(255) NOT NULL UNIQUE,
  `PASSWORD` varchar(255) NOT NULL,
  `FIRST_NAME` text NOT NULL,
  `LAST_NAME` text NOT NULL,
  `PHONE_NUMBER` int(10),
  `BIRTHDAY` DATE, 
  `USER_STATUS` INT(2) DEFAULT 2 NOT NULL,
  `USER_TYPE` INT(2) DEFAULT 2 NOT NULL,
  `SHIPPING_ADDRESS` INT(11),
  PRIMARY KEY (`USER_ID`), 
  FOREIGN KEY (`USER_STATUS`) REFERENCES `user_status` (`STATUS_ID`),
  FOREIGN KEY (`USER_TYPE`) REFERENCES `user_type` (`TYPE_ID`),
  FOREIGN KEY (`SHIPPING_ADDRESS`) REFERENCES `address` (`ADDRESS_ID`)
);


CREATE TABLE IF NOT EXISTS `payment_card` (
    `PAYMENT_ID` int(11) NOT NULL AUTO_INCREMENT,
    `CARD_NUM` int(16) NOT NULL,
    `USER_ID` int(11) NOT NULL,
    `BILLING_ADDRESS` int(11) NOT NULL,
    `TYPE` VARCHAR(255) NOT NULL,
    `EXP_DATE` DATE NOT NULL,
    `CCV` INT(3) NOT NULL,
    PRIMARY KEY (`PAYMENT_ID`), 
    FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`),
    FOREIGN KEY (`BILLING_ADDRESS`) REFERENCES `address` (`ADDRESS_ID`)
);



CREATE TABLE IF NOT EXISTS `book` (
    `BOOK_ID` int(11) NOT NULL AUTO_INCREMENT,
    `TITLE` VARCHAR(255) NOT NULL,
    `ISBN` VARCHAR(13) NOT NULL,
    `AUTHOR_NAME` varchar(255) NOT NULL,
    `CATEGORIES` varchar(255) NOT NULL,
    `DESCRIPTION` varchar(255) NOT NULL,
    `COVER_PICTURE` varchar(1000) NOT NULL,
    `EDITION` int(11) NOT NULL,
    `PUBLISHER_NAME` varchar(50) NOT NULL,
    `PUBLISHER_YEAR` YEAR(4) NOT NULL,
    `PRICE` DOUBLE(10, 2) NOT NULL,
    `QUANTITY` int(11) NOT NULL,
    `KEYWORDS` VARCHAR(255), 
    `STATUS` INT(11),
    `QUANTITY_ON_HAND` INT(11),
    `MINIMUM_THRESHOLD` INT(11),
    PRIMARY KEY (`BOOK_ID`)
);


-- CREATE TABLE IF NOT EXISTS `inventory_book` (
--     `INV_BOOK_ID` int(11) NOT NULL AUTO_INCREMENT,
--     `BOOK_ID` int(11) NOT NULL,
--     `QUANTITY_ON_HAND` INT(11) NOT NULL,
--     `STATUS` INT(11) NOT NULL,
--     `PRICE` DOUBLE(10, 2) NOT NULL,
--     PRIMARY KEY (`INV_BOOK_ID`),
--     FOREIGN KEY (`BOOK_ID`) REFERENCES `book` (`BOOK_ID`)
-- );



CREATE TABLE IF NOT EXISTS `cart` (
    `CART_ID` INT(11) NOT NULL AUTO_INCREMENT,
    `USER_ID` int(11) NOT NULL,
    PRIMARY KEY (`CART_ID`), 
    FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`)
);

CREATE TABLE IF NOT EXISTS `cart_item` (
    `CART_ID` INT(11) NOT NULL,
    `BOOK_ID` INT(11) NOT NULL,
    `QUANTITY` INT(11) NOT NULL,
    FOREIGN KEY (`CART_ID`) REFERENCES `cart` (`CART_ID`),
    FOREIGN KEY (`BOOK_ID`) REFERENCES `book` (`BOOK_ID`)
);




CREATE TABLE IF NOT EXISTS `promotion` (
    `PROMO_ID` INT(11) NOT NULL AUTO_INCREMENT,
    `START_DATE` DATE NOT NULL,
    `END_DATE` DATE NOT NULL,
    `DISCOUNT` DOUBLE(10, 2) NOT NULL,
    PRIMARY KEY (`PROMO_ID`)
);


CREATE TABLE IF NOT EXISTS `shipping_type` (
    `SHIPPING_ID` INT(11) NOT NULL,
    `SHIPPING_NAME` VARCHAR(255) NOT NULL,
    `SHIPPING_COST` DOUBLE(10, 2) NOT NULL,
    `SHIPPING_SPEED` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`SHIPPING_ID`)
);


CREATE TABLE IF NOT EXISTS `order` (
    `ORDER_ID` INT(11) NOT NULL AUTO_INCREMENT,
    `USER_ID` INT(11) NOT NULL,
    `PAYMENT_ID` INT(11) NOT NULL,
    `SUBTOTAL` DOUBLE(10, 2) NOT NULL,
    `TOTAL_TAX` DOUBLE(10, 2) NOT NULL,
    `GRAND_TOTAL` DOUBLE(10, 2) NOT NULL,
    `PROMO_ID` INT(11) NOT NULL,
    `ORDER_DATE_TIME` DATETIME NOT NULL,
    `SHIPPING_TYPE` INT(11) NOT NULL,
    PRIMARY KEY (`ORDER_ID`), 
    FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`),
    FOREIGN KEY (`PAYMENT_ID`) REFERENCES `payment_card` (`PAYMENT_ID`),
    FOREIGN KEY (`PROMO_ID`) REFERENCES `promotion` (`PROMO_ID`),
    FOREIGN KEY (`SHIPPING_TYPE`) REFERENCES `shipping_type` (`SHIPPING_ID`)
);


CREATE TABLE IF NOT EXISTS `order_item` (
    `ORDER_ID` INT(11) NOT NULL,
    `BOOK_ID` INT(11) NOT NULL,
    `QUANTITY` INT(11) NOT NULL,
    FOREIGN KEY (`ORDER_ID`) REFERENCES `order` (`ORDER_ID`),
    FOREIGN KEY (`BOOK_ID`) REFERENCES `book` (`BOOK_ID`)
);



 -- These are example values for the different type tables 

INSERT INTO `user_type` (`TYPE_ID`, `TYPE_NAME`) VALUES 
(1, "Admin"), 
(2, "Customer");

INSERT INTO `user_status` (`STATUS_ID`, `STATUS_NAME`) VALUES 
(1, "Inactive/Unregistered"), 
(2, "Active/Registered"), 
(3, "Suspended");


INSERT INTO `shipping_type`(`SHIPPING_ID`, `SHIPPING_NAME`, `SHIPPING_COST`, `SHIPPING_SPEED`) VALUES 
(1, "Standard Shipping", 4.99, "3-5 Business Days"), 
(2, "Express Shipping", 7.99, "2-3 Business Days"), 
(3, "Expedited Shipping", 15.99, "1-2 Business Days")