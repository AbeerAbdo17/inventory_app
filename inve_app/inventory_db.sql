-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 17, 2025 at 08:23 AM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `inventory_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `name`, `unit_price`, `created_at`) VALUES
(1, 'غسول', 1700.00, '2025-08-12 12:32:49'),
(2, 'صابون', 22000.00, '2025-08-12 12:32:56'),
(3, 'شامبو', 80000.00, '2025-08-12 12:33:09'),
(4, 'مرطب', 17000.00, '2025-08-12 13:07:04'),
(8, 'عسل', 15000.00, '2025-08-13 06:07:05'),
(9, 'ليف ان', 14000.00, '2025-08-13 06:40:20'),
(10, 'عدس', 4200.00, '2025-08-13 08:43:10'),
(16, 'شعرية', 1500.00, '2025-08-13 12:06:05'),
(26, 'بطاطس', 720.00, '2025-08-13 12:50:57'),
(29, 'قلم', 1000.00, '2025-08-14 13:37:00');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `type` enum('add','withdraw') NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=50 ;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `item_id`, `type`, `quantity`, `created_at`) VALUES
(1, 1, 'add', 100, '2025-08-12 12:31:12'),
(2, 1, 'withdraw', 30, '2025-08-12 12:31:12'),
(3, 2, 'add', 50, '2025-08-12 12:31:12'),
(4, 2, 'withdraw', 10, '2025-08-12 12:31:12'),
(5, 3, 'add', 200, '2025-08-12 12:31:12'),
(6, 3, 'withdraw', 50, '2025-08-12 12:31:12'),
(7, 8, 'add', 100, '2025-08-13 06:23:11'),
(8, 8, 'add', 60, '2025-08-13 06:39:14'),
(10, 1, '', 1, '2025-08-13 06:44:23'),
(11, 8, 'withdraw', 100, '2025-08-13 06:51:06'),
(17, 3, 'add', 20, '2025-08-13 07:24:21'),
(18, 8, 'add', 400, '2025-08-13 07:28:37'),
(19, 2, 'add', 43, '2025-08-13 07:43:53'),
(21, 4, 'add', 400, '2025-08-13 07:47:27'),
(23, 4, 'withdraw', 10, '2025-08-13 07:49:56'),
(24, 4, 'withdraw', 140, '2025-08-13 07:56:50'),
(25, 3, 'add', 450, '2025-08-13 08:00:04'),
(33, 10, 'add', 15, '2025-08-13 11:37:09'),
(43, 16, 'add', 100, '2025-08-13 13:48:15'),
(44, 10, 'add', 50, '2025-08-14 06:00:04'),
(45, 16, 'add', 41, '2025-08-14 13:25:52'),
(46, 16, 'withdraw', 80, '2025-08-14 13:25:59'),
(48, 10, 'withdraw', 9, '2025-08-14 13:28:50');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `email`) VALUES
(2, 'Abeer', '123456', 'user', 'abr@gmail.com'),
(3, 'علي', '123456', 'user', 'ali@gmail.com'),
(5, 'reem', '123', 'user', 'reem@gmail.com'),
(6, 'هبه', '$2b$10$5vMLH8ls18Y/5YF0iQkowe7/TpEKcNTpEiZuIog.KrMA.fHzddU3.', 'user', NULL),
(9, 'عهد', '$2b$10$YPdNifDpKBO0FNnUrPQzIOHM0eJroL/dLXPY4X7ntFeY5qoDvLQA.', 'user', NULL),
(11, 'abeero', '$2b$10$UXf9wBfZn7O4Xgf1/T7JgesVLChyCvjyUJdFtpbCfuwvzamqiaR62', 'user', 'abeer@gmail.com'),
(12, 'aber', '$2b$10$DOugYGPEkQQtDexV5in13eSF3Vvo34C7InIEfEK8.9lo5rwfueFS6', 'user', 'abeer2@gmail.com'),
(13, 'ahmed', '$2b$10$gEm.j4/m5poeArCFlcXjOe8iGWLmwWAeHc4qRMRLzye4Dne9.QCu6', 'admin', 'admin@gmail.com');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
