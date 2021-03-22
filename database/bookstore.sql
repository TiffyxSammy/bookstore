-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 22, 2021 at 09:10 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookstore`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `ADDRESS_ID` int(11) NOT NULL COMMENT 'Address ID, Auto generated',
  `FIRST_NAME` varchar(255) NOT NULL COMMENT 'User First Name',
  `LAST_NAME` varchar(255) NOT NULL COMMENT 'User Last Name',
  `STREET` varchar(255) NOT NULL COMMENT 'Street of Address',
  `CITY` varchar(255) NOT NULL COMMENT 'City of Address',
  `STATE` varchar(255) NOT NULL COMMENT 'State of Address',
  `ZIP` int(5) NOT NULL COMMENT 'Zip Code of Address'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `BOOK_ID` int(11) NOT NULL COMMENT 'Book ID, Auto generated',
  `TITLE` varchar(255) NOT NULL COMMENT 'Title of Book',
  `ISBN` varchar(13) NOT NULL COMMENT '(International Standard Book Number). A unique 13 digit identifier given to each edition of a book',
  `AUTHOR_NAME` varchar(255) NOT NULL COMMENT 'Name of Author of Book',
  `CATEGORIES` varchar(255) NOT NULL COMMENT 'Category of Book',
  `DESCRIPTION` varchar(255) NOT NULL COMMENT 'Description of Book',
  `COVER_PICTURE` varchar(1000) NOT NULL COMMENT 'Cover Image of Book',
  `EDITION` int(11) NOT NULL COMMENT 'Edition of Book',
  `PUBLISHER_NAME` varchar(50) NOT NULL COMMENT 'Name of Publisher of Book',
  `PUBLISHER_YEAR` year(4) NOT NULL COMMENT 'Publisher Year of Book',
  `PRICE` double(10,2) NOT NULL COMMENT 'Price of Book',
  `QUANTITY` int(11) NOT NULL COMMENT 'Amount of Books in the system',
  `KEYWORDS` varchar(255) DEFAULT NULL COMMENT 'Keywords related to the book',
  `STATUS` int(11) DEFAULT NULL COMMENT 'Status of book',
  `QUANTITY_ON_HAND` int(11) DEFAULT NULL,
  `MINIMUM_THRESHOLD` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `CART_ID` int(11) NOT NULL COMMENT 'Cart ID, Auto generated',
  `USER_ID` int(11) NOT NULL COMMENT 'User ID that is associated to the cart'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cart_item`
--

CREATE TABLE `cart_item` (
  `CART_ID` int(11) NOT NULL COMMENT 'Cart ID that is associated to the book in cart',
  `BOOK_ID` int(11) NOT NULL COMMENT 'Book ID that is associated to the cart item',
  `QUANTITY` int(11) NOT NULL COMMENT 'Amount of item for the given cart item'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `ORDER_ID` int(11) NOT NULL COMMENT 'Order ID, auto generated',
  `USER_ID` int(11) NOT NULL COMMENT 'User ID that is associated to the order',
  `PAYMENT_ID` int(11) NOT NULL COMMENT 'Payment ID that is associated to the order',
  `SUBTOTAL` double(10,2) NOT NULL COMMENT 'The amount of the order before taxes',
  `TOTAL_TAX` double(10,2) NOT NULL COMMENT 'The tax calculated based on the sub total of the order',
  `GRAND_TOTAL` double(10,2) NOT NULL COMMENT 'The total of the order including taxes',
  `PROMO_ID` int(11) NOT NULL COMMENT 'Promo ID that is associated to the order',
  `ORDER_DATE_TIME` datetime NOT NULL COMMENT 'The data and time of the order',
  `SHIPPING_TYPE` int(11) NOT NULL COMMENT 'The type of shipping that is associated to the order'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `ORDER_ID` int(11) NOT NULL COMMENT 'Order ID, auto generated',
  `BOOK_ID` int(11) NOT NULL COMMENT 'Book ID associated to the order item',
  `QUANTITY` int(11) NOT NULL COMMENT 'Amount of Book for given item'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payment_card`
--

CREATE TABLE `payment_card` (
  `PAYMENT_ID` int(11) NOT NULL COMMENT 'Payment ID, auto generated',
  `CARD_NUM` bigint(16) NOT NULL COMMENT 'Card Number',
  `USER_ID` int(11) NOT NULL COMMENT 'User ID associated to the payment method',
  `BILLING_ADDRESS` int(11) NOT NULL COMMENT 'Billing Address for the payment method',
  `TYPE` varchar(255) NOT NULL COMMENT 'Type of Card Payment',
  `EXP_DATE` date NOT NULL COMMENT 'Expiration Date for Card',
  `CVV` int(3) NOT NULL COMMENT 'Card Verification Value'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `promotion`
--

CREATE TABLE `promotion` (
  `PROMO_ID` int(11) NOT NULL COMMENT 'Promo ID, auto generated',
  `START_DATE` date NOT NULL COMMENT 'Promotion Start Date',
  `END_DATE` date NOT NULL COMMENT 'Promotion End Date',
  `DISCOUNT` double(10,2) NOT NULL COMMENT 'Amount of Discount for Promotion'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shipping_type`
--

CREATE TABLE `shipping_type` (
  `SHIPPING_ID` int(11) NOT NULL COMMENT 'Shipping ID, auto generated',
  `SHIPPING_NAME` varchar(255) NOT NULL COMMENT 'Shipping Method Name',
  `SHIPPING_COST` double(10,2) NOT NULL COMMENT 'Cost of Shipping Method',
  `SHIPPING_SPEED` varchar(255) NOT NULL COMMENT 'Speed for Shipping Method'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `shipping_type`
--

INSERT INTO `shipping_type` (`SHIPPING_ID`, `SHIPPING_NAME`, `SHIPPING_COST`, `SHIPPING_SPEED`) VALUES
(1, 'Standard Shipping', 4.99, '3-5 Business Days'),
(2, 'Express Shipping', 7.99, '2-3 Business Days'),
(3, 'Expedited Shipping', 15.99, '1-2 Business Days');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `USER_ID` int(11) NOT NULL COMMENT 'User ID, auto generated',
  `FIRST_NAME` varchar(255) NOT NULL COMMENT 'First Name of User',
  `LAST_NAME` varchar(255) NOT NULL COMMENT 'Last Name of User',
  `PHONE_NUMBER` int(10) DEFAULT NULL COMMENT 'Phone Number of User',
  `EMAIL_ADDRESS` varchar(255) NOT NULL COMMENT 'Email Address of User',
  `USER_NAME` varchar(255) NOT NULL COMMENT 'Username of User',
  `PASSWORD` varchar(255) NOT NULL COMMENT 'Password of User',
  `BIRTHDAY` date DEFAULT NULL COMMENT 'Birthday of User',
  `USER_STATUS` int(2) NOT NULL DEFAULT 2 COMMENT 'Status of User',
  `USER_TYPE` int(2) NOT NULL DEFAULT 2 COMMENT 'Type of User',
  `SHIPPING_ADDRESS` int(11) DEFAULT NULL COMMENT 'Shipping Address of User'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_status`
--

CREATE TABLE `user_status` (
  `STATUS_ID` int(2) NOT NULL COMMENT 'Status ID, auto generated',
  `STATUS_NAME` varchar(255) NOT NULL COMMENT 'Status of User'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_status`
--

INSERT INTO `user_status` (`STATUS_ID`, `STATUS_NAME`) VALUES
(1, 'Inactive/Unregistered'),
(2, 'Active/Registered'),
(3, 'Suspended');

-- --------------------------------------------------------

--
-- Table structure for table `user_type`
--

CREATE TABLE `user_type` (
  `TYPE_ID` int(2) NOT NULL COMMENT 'Type ID, auto generated',
  `TYPE_NAME` varchar(255) NOT NULL COMMENT 'Type of User, 1 for Admin, 2 for Customer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_type`
--

INSERT INTO `user_type` (`TYPE_ID`, `TYPE_NAME`) VALUES
(1, 'Admin'),
(2, 'Customer');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`ADDRESS_ID`);

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`BOOK_ID`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`CART_ID`),
  ADD KEY `USER_ID` (`USER_ID`);

--
-- Indexes for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD KEY `CART_ID` (`CART_ID`),
  ADD KEY `BOOK_ID` (`BOOK_ID`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`ORDER_ID`),
  ADD KEY `USER_ID` (`USER_ID`),
  ADD KEY `PAYMENT_ID` (`PAYMENT_ID`),
  ADD KEY `PROMO_ID` (`PROMO_ID`),
  ADD KEY `SHIPPING_TYPE` (`SHIPPING_TYPE`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD KEY `ORDER_ID` (`ORDER_ID`),
  ADD KEY `BOOK_ID` (`BOOK_ID`);

--
-- Indexes for table `payment_card`
--
ALTER TABLE `payment_card`
  ADD PRIMARY KEY (`PAYMENT_ID`),
  ADD KEY `USER_ID` (`USER_ID`),
  ADD KEY `BILLING_ADDRESS` (`BILLING_ADDRESS`);

--
-- Indexes for table `promotion`
--
ALTER TABLE `promotion`
  ADD PRIMARY KEY (`PROMO_ID`);

--
-- Indexes for table `shipping_type`
--
ALTER TABLE `shipping_type`
  ADD PRIMARY KEY (`SHIPPING_ID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`USER_ID`),
  ADD UNIQUE KEY `USER_NAME` (`USER_NAME`),
  ADD UNIQUE KEY `EMAIL_ADDRESS` (`EMAIL_ADDRESS`),
  ADD KEY `USER_STATUS` (`USER_STATUS`),
  ADD KEY `USER_TYPE` (`USER_TYPE`),
  ADD KEY `SHIPPING_ADDRESS` (`SHIPPING_ADDRESS`);

--
-- Indexes for table `user_status`
--
ALTER TABLE `user_status`
  ADD PRIMARY KEY (`STATUS_ID`);

--
-- Indexes for table `user_type`
--
ALTER TABLE `user_type`
  ADD PRIMARY KEY (`TYPE_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `ADDRESS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Address ID, Auto generated';

--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `BOOK_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Book ID, Auto generated';

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `CART_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Cart ID, Auto generated';

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `ORDER_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Order ID, auto generated';

--
-- AUTO_INCREMENT for table `payment_card`
--
ALTER TABLE `payment_card`
  MODIFY `PAYMENT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Payment ID, auto generated';

--
-- AUTO_INCREMENT for table `promotion`
--
ALTER TABLE `promotion`
  MODIFY `PROMO_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Promo ID, auto generated';

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `USER_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'User ID, auto generated';

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`);

--
-- Constraints for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD CONSTRAINT `cart_item_ibfk_1` FOREIGN KEY (`CART_ID`) REFERENCES `cart` (`CART_ID`),
  ADD CONSTRAINT `cart_item_ibfk_2` FOREIGN KEY (`BOOK_ID`) REFERENCES `book` (`BOOK_ID`);

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`),
  ADD CONSTRAINT `order_ibfk_2` FOREIGN KEY (`PAYMENT_ID`) REFERENCES `payment_card` (`PAYMENT_ID`),
  ADD CONSTRAINT `order_ibfk_3` FOREIGN KEY (`PROMO_ID`) REFERENCES `promotion` (`PROMO_ID`),
  ADD CONSTRAINT `order_ibfk_4` FOREIGN KEY (`SHIPPING_TYPE`) REFERENCES `shipping_type` (`SHIPPING_ID`);

--
-- Constraints for table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`ORDER_ID`) REFERENCES `order` (`ORDER_ID`),
  ADD CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`BOOK_ID`) REFERENCES `book` (`BOOK_ID`);

--
-- Constraints for table `payment_card`
--
ALTER TABLE `payment_card`
  ADD CONSTRAINT `payment_card_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`),
  ADD CONSTRAINT `payment_card_ibfk_2` FOREIGN KEY (`BILLING_ADDRESS`) REFERENCES `address` (`ADDRESS_ID`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`USER_STATUS`) REFERENCES `user_status` (`STATUS_ID`),
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`USER_TYPE`) REFERENCES `user_type` (`TYPE_ID`),
  ADD CONSTRAINT `user_ibfk_3` FOREIGN KEY (`SHIPPING_ADDRESS`) REFERENCES `address` (`ADDRESS_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
