-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 10, 2025 at 09:45 AM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `stamp`
--

-- --------------------------------------------------------

--
-- Table structure for table `band`
--

CREATE TABLE IF NOT EXISTS `band` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `invalid_logins`
--

CREATE TABLE IF NOT EXISTS `invalid_logins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `failed_attempts` int(11) DEFAULT '0',
  `last_failed_attempt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `load_data`
--

CREATE TABLE IF NOT EXISTS `load_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `cert_no` varchar(100) DEFAULT NULL,
  `contract_no` varchar(100) DEFAULT NULL,
  `ex_form_no` varchar(100) DEFAULT NULL,
  `qty_goods` int(11) DEFAULT NULL,
  `remaining_qty` int(11) DEFAULT NULL,
  `bol_no` varchar(100) DEFAULT NULL,
  `exporter` varchar(255) DEFAULT NULL,
  `goods` varchar(255) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `replacement` varchar(100) DEFAULT NULL,
  `date_of_replacement` date DEFAULT NULL,
  `date_of_complet` date DEFAULT NULL,
  `upload_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `load_data`
--

INSERT INTO `load_data` (`id`, `no`, `date`, `cert_no`, `contract_no`, `ex_form_no`, `qty_goods`, `remaining_qty`, `bol_no`, `exporter`, `goods`, `qty`, `country`, `replacement`, `date_of_replacement`, `date_of_complet`, `upload_no`) VALUES
(1, -1, '2025-04-10', '00/1863', '00002025/00280', '00002025/00445', 0, 0, 'PZU0000000', 'KIAN FOR SOFTWARE SOLUTIONS', 'GOODS014', 200, 'SUDAN', NULL, NULL, '2025-04-28', 1),
(2, 0, '2025-04-10', '00/1864', '00002025/00281', '00002025/00446', 0, 0, 'PZU0000000', 'KIAN FOR SOFTWARE SOLUTIONS', 'GOODS', 172, 'SUDAN', NULL, NULL, '2025-04-28', 1),
(3, -1, '2025-04-10', '00/1863', '00002025/00280', '00002025/00445', 0, 0, 'PZU0000000', 'KIAN', 'LAMP', 200, 'QATAR', NULL, NULL, '2025-04-10', 2),
(4, 0, '2025-04-10', '00/1864', '00002025/00281', '00002025/00446', 0, 0, 'PZU0000000', 'KIAN', 'LAMP', 172, 'QATAR', NULL, NULL, '2025-04-10', 2),
(5, -1, '2025-04-10', '00/1863', '00002025/00280', '00002025/00445', 0, 0, 'PZU0000000', 'SUDA CROP FOR TRADING AND INVESTMENT', 'RED SESAME SEEDS', 200, 'CHINA ', NULL, NULL, '2025-04-10', 3),
(6, 0, '2025-04-10', '00/1864', '00002025/00281', '00002025/00446', 0, 0, 'PZU0000000', 'SUDA CROP FOR TRADING AND INVESTMENT', 'RED SESAME SEEDS', 172, 'CHINA ', NULL, NULL, '2025-04-10', 3),
(7, 8888, '2025-06-27', '000/888', '00008080888', '0000808088', 0, 0, 'AH989898000', 'china', 'suger', 800, 'sudan', 'no', '2025-06-01', '2025-06-28', 4);

-- --------------------------------------------------------

--
-- Table structure for table `main`
--

CREATE TABLE IF NOT EXISTS `main` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `MAIN_BAND_NO` int(11) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `MAIN_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `MAIN_BAND_NO` (`MAIN_BAND_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `saveentry`
--

CREATE TABLE IF NOT EXISTS `saveentry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `credit_account` varchar(255) DEFAULT NULL,
  `debit_account` varchar(255) DEFAULT NULL,
  `credit_amount` decimal(10,2) DEFAULT NULL,
  `debit_amount` decimal(10,2) DEFAULT NULL,
  `credit_description` text,
  `debit_description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `subband`
--

CREATE TABLE IF NOT EXISTS `subband` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `band_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `band_id` (`band_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `upload_no`
--

CREATE TABLE IF NOT EXISTS `upload_no` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upload_no` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `upload_no`
--

INSERT INTO `upload_no` (`id`, `upload_no`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `failed_attempts` int(11) DEFAULT '0',
  `last_failed_attempt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `pass`, `failed_attempts`, `last_failed_attempt`) VALUES
(1, 'ali', '$2b$10$BdUyqcu/PHxURNBCe.1M3O8ujGCBAXn1gaKq3Awu6ZDtsQEH52uIS', 0, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `main`
--
ALTER TABLE `main`
  ADD CONSTRAINT `main_ibfk_1` FOREIGN KEY (`MAIN_BAND_NO`) REFERENCES `subband` (`id`);

--
-- Constraints for table `subband`
--
ALTER TABLE `subband`
  ADD CONSTRAINT `subband_ibfk_1` FOREIGN KEY (`band_id`) REFERENCES `band` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
