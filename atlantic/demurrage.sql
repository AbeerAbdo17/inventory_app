-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 05, 2025 at 03:21 PM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `k_shipping_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `demurrage`
--

CREATE TABLE IF NOT EXISTS `demurrage` (
  `dem_date` date NOT NULL,
  `dem_clearer` varchar(100) NOT NULL,
  `dem_usdvalue` double NOT NULL DEFAULT '0',
  `dem_usdbalance` double NOT NULL DEFAULT '0',
  `dem_sudanamount` double NOT NULL DEFAULT '0',
  `dem_vat` double NOT NULL DEFAULT '0',
  `dem_subtotal` double NOT NULL DEFAULT '0',
  `dem_gtotal` double NOT NULL DEFAULT '0',
  `dem_comments` varchar(100) DEFAULT NULL,
  `dem_paid` int(11) NOT NULL DEFAULT '0',
  `dem_piaddate` date DEFAULT NULL,
  `dem_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dem_user` varchar(100) NOT NULL DEFAULT '-',
  `dem_serial` bigint(20) NOT NULL,
  `dem_deposit` double NOT NULL DEFAULT '0',
  `dem_discount` double NOT NULL DEFAULT '0',
  `dem_causes` varchar(100) NOT NULL DEFAULT '-',
  `INSURANCE40` double NOT NULL DEFAULT '45',
  PRIMARY KEY (`dem_serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `demurrage`
--

INSERT INTO `demurrage` (`dem_date`, `dem_clearer`, `dem_usdvalue`, `dem_usdbalance`, `dem_sudanamount`, `dem_vat`, `dem_subtotal`, `dem_gtotal`, `dem_comments`, `dem_paid`, `dem_piaddate`, `dem_timestamp`, `dem_user`, `dem_serial`, `dem_deposit`, `dem_discount`, `dem_causes`, `INSURANCE40`) VALUES
('2024-01-10', 'ABD ALHAFEEZ SALIH ALI', 325000, 325000, 325000, 55250, 380250, 435500, NULL, 0, NULL, '2024-01-10 11:49:50', '-', 1, 0, 0, '', 45),
('2024-01-10', 'ABBAS ABDALLA RAMLI', 3000, 3000, 1800000, 508.3, 3498.3, 2412000, NULL, 0, NULL, '2024-01-10 12:57:27', '-', 2, 0, 10, '', 45),
('2024-01-28', 'ABDELAZIZ OSMAN MOSTAFA', 100000, 100000, 60000000, 17000, 117000, 80400000, NULL, 0, NULL, '2024-01-28 11:42:33', '-', 3, 0, 0, '', 45),
('2024-07-22', 'ABD ALHAFIZ YOSIF AHMAD HASSAN', 1000, 1000, 600000, 170, 103000, 804000, NULL, 0, NULL, '2024-07-22 09:57:40', '-', 4, 0, 0, '', 45),
('2025-04-30', 'SAAD ABDELGADER BASTAWI', 64000, 64000, 38400000, 10880, 74880, 51456000, NULL, 0, NULL, '2025-04-30 16:20:45', '-', 5, 0, 0, '', 45),
('2025-05-01', 'SALAH FAKI ALHASSAN HASSAN', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, '2025-05-01 09:40:40', '-', 6, 0, 0, '', 45),
('2025-05-06', 'MOUSA AWAD MOUSA', 110000, 110000, 66000000, 18700, 128700, 88440000, NULL, 0, NULL, '2025-05-06 10:18:14', '-', 7, 0, 0, '', 45),
('2025-05-06', 'ABDUL ALNASIR TAHA MOHMMED OSMAN', 60000, 60000, 36000000, 10200, 70200, 48240000, NULL, 0, NULL, '2025-05-06 11:29:32', '-', 8, 0, 0, '', 45),
('2025-05-06', 'ABDEL NASER TAHA MOHAMMED OSMAN ', 160000, 160000, 96000000, 27200, 187200, 128640000, NULL, 0, NULL, '2025-05-06 12:24:04', '-', 9, 0, 0, '', 45),
('2025-05-15', 'HAMED MOHAMED FADUL', 2800, 2800, 1680000, 476, 3276, 2251200, NULL, 0, NULL, '2025-05-15 08:20:45', '-', 10, 0, 0, '', 45);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `delband` ON SCHEDULE AT '2017-04-28 15:31:00' ON COMPLETION PRESERVE DISABLE DO delete from band$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
