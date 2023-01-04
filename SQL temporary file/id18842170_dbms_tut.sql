-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 01, 2022 at 02:28 PM
-- Server version: 10.5.12-MariaDB
-- PHP Version: 7.3.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id18842170_dbms_tut`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`email`) VALUES
('admin@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `payment_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `vaccine_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`payment_id`, `email`, `vaccine_code`, `amount`, `date`) VALUES
('pay_JPk7M96s6581T1', 'gautam@gmail.com', '131714', '95', '2022-05-17'),
('pay_JPu40TOdylcE6d', 'gautam@gmail.com', '131714', '95', '2022-05-12'),
('pay_JPuvN8squAheAu', 'gautam@gmail.com', '131714', '95', '2022-05-23'),
('pay_JPv0EE5b5WS1OK', 'gautam@gmail.com', '131714', '95', '2022-05-16'),
('pay_JPv2U12h1eEOit', 'gautam@gmail.com', '131714', '95', '2022-05-10'),
('pay_JPvSUJ7d07ee59', 'monu@gmail.com', '911', '195', '2023-05-12'),
('pay_JPwqjOSOm3l672', 'iit2020540@iiita.ac.in', '911', '195', '2022-05-01');

-- --------------------------------------------------------

--
-- Table structure for table `logindetails`
--

CREATE TABLE `logindetails` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `logindetails`
--

INSERT INTO `logindetails` (`email`, `password`, `username`) VALUES
('admin@gmail.com', '123456', 'Admin'),
('gautam@gmail.com', '123456', 'Gautam'),
('iit2020540@iiita.ac.in', 'gautam', 'group54'),
('monu@gmail.com', '123456', 'Alt'),
('staff@gmail.com', '123456', 'Staff');

-- --------------------------------------------------------

--
-- Table structure for table `staff_account`
--

CREATE TABLE `staff_account` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `staff_account`
--

INSERT INTO `staff_account` (`email`) VALUES
(''),
('staff@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `trial`
--

CREATE TABLE `trial` (
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roll` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `marks` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trial`
--

INSERT INTO `trial` (`name`, `roll`, `subject`, `marks`) VALUES
('Gautam', 'iib2020039', 'maths', 100),
('shantanu', 'iit2020166', 'physics', 0),
('Ambikesh', 'IIT2020095', 'Chemistry', 69),
('Shivansh', 'IEC2020050', 'Biologo', 131714),
('Divyanshu', 'IIB2020029', 'Apple ke noobs', 100),
('hehe', 'iiii', 'idk', 123),
('lmao ', 'iit', 'cn', 2),
('shantanu', '166', 'all', 1000000);

-- --------------------------------------------------------

--
-- Table structure for table `vaccine`
--

CREATE TABLE `vaccine` (
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `efficacy` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cost` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `vaccine`
--

INSERT INTO `vaccine` (`code`, `name`, `efficacy`, `cost`) VALUES
('131714', 'Covid19', '98', '95'),
('911', 'Covid 20', '99', '195');

-- --------------------------------------------------------

--
-- Table structure for table `vaccine_stock`
--

CREATE TABLE `vaccine_stock` (
  `stock_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `vaccine_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `stock_total` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expiry_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `vaccine_stock`
--

INSERT INTO `vaccine_stock` (`stock_id`, `vaccine_code`, `stock_total`, `expiry_date`) VALUES
('GLHF', '131714', '90', '2022-05-31'),
('100', '911', '99', '2025-01-01'),
('817', '911', '1000', '2024-09-17'),
('234', '911', '189', '2023-05-17');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `logindetails`
--
ALTER TABLE `logindetails`
  ADD PRIMARY KEY (`email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
