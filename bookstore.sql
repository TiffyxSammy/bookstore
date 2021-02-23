-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 23, 2021 at 09:01 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.2

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
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `USER_ID` int(11) NOT NULL,
  `USERNAME` varchar(255) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL,
  `FIRST_NAME` text NOT NULL,
  `LAST_NAME` text NOT NULL,
  `PHONE_NUMBER` int(10) NOT NULL,
  `EMAIL_ADDRESS` varchar(255) NOT NULL,
  `STREET` varchar(255) NOT NULL,
  `CITY` text NOT NULL,
  `STATE` text NOT NULL,
  `ZIPCODE` int(5) NOT NULL,
  `CARD_TYPE` varchar(50) NOT NULL,
  `CARD_NUMBER` varchar(25) NOT NULL,
  `EXP_DATE` int(4) NOT NULL,
  `MONTH_BDAY` varchar(255) NOT NULL,
  `DAY_BDAY` varchar(255) NOT NULL,
  `YEAR_BDAY` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `bookInformation`
--

CREATE TABLE `bookInformation` (
  `BOOK_ID` int(11) NOT NULL,
  `ISBN` int(13) NOT NULL,
  `BOOK_CATEGORY` varchar(30) NOT NULL,
  `AUTHOR_NAME` varchar(100) NOT NULL,
  `BOOK_TITLE` varchar(100) NOT NULL,
  `COVER_PICTURE` varchar(1000) NOT NULL,
  `BOOK_EDITION` int(11) NOT NULL,
  `PUBLISHER_NAME` varchar(50) NOT NULL,
  `PUBLISHER_YEAR` year(4) NOT NULL,
  `BOOK_QUANTITY` int(11) NOT NULL,
  `MINIMUM_THRESHOLD` int(11) NOT NULL,
  `BUYING_PRICE` decimal(10,0) NOT NULL,
  `SELLING_PRICE` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`USER_ID`),
  ADD UNIQUE KEY `USERNAME` (`USERNAME`,`EMAIL_ADDRESS`);

--
-- Indexes for table `bookInformation`
--
ALTER TABLE `bookInformation`
  ADD PRIMARY KEY (`BOOK_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `USER_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookInformation`
--
ALTER TABLE `bookInformation`
  MODIFY `BOOK_ID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
