-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 02, 2025 at 02:29 PM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `fersan`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE IF NOT EXISTS `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '-',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`id`, `name`) VALUES
(1, 'الخزنة'),
(2, 'المبيعات'),
(3, 'مغلق البشاري'),
(4, 'حساب الشيكات'),
(5, 'بنك امدرمان'),
(6, 'ناجي السر'),
(7, 'شركة نيو سفلايزيشن'),
(8, 'رصيد افتتاحي'),
(9, 'حساب المبيعات'),
(10, 'مجدي عمر الفقير'),
(11, 'الكنوز'),
(12, 'المنار سلالاب '),
(13, 'الياس'),
(14, 'الايجار '),
(15, 'المرتبات '),
(16, 'النظافه '),
(17, 'الفطور '),
(18, 'المصروفات المكتبيه '),
(19, 'ترحيل '),
(20, 'عتاله'),
(21, 'مصروفات بنكيه'),
(22, 'مصروفات اخري '),
(23, 'شاي والجبنه'),
(24, 'ماء'),
(25, 'الكهرباء'),
(26, 'مصاريف مجدي اليوميه ');

-- --------------------------------------------------------

--
-- Table structure for table `band`
--

CREATE TABLE IF NOT EXISTS `band` (
  `BAND_NO` decimal(6,0) NOT NULL,
  `BAND_NAME` varchar(24) CHARACTER SET utf8 NOT NULL,
  `BAND_TYPE` varchar(24) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`BAND_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `band`
--

INSERT INTO `band` (`BAND_NO`, `BAND_NAME`, `BAND_TYPE`) VALUES
(1, 'assets', 'الاصول'),
(2, 'الخصوم', 'الخصوم');

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE IF NOT EXISTS `bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bankname` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`id`, `bankname`) VALUES
(1, 'faisal'),
(2, 'khartoum'),
(3, 'other'),
(4, 'alneel');

-- --------------------------------------------------------

--
-- Table structure for table `bank_det`
--

CREATE TABLE IF NOT EXISTS `bank_det` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `bankname` int(11) NOT NULL,
  `status` varchar(30) NOT NULL,
  `date` date NOT NULL,
  `notes` varchar(100) NOT NULL,
  `user` varchar(30) NOT NULL,
  `doc_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `barcode`
--

CREATE TABLE IF NOT EXISTS `barcode` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL,
  `code` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=51 ;

--
-- Dumping data for table `barcode`
--

INSERT INTO `barcode` (`id`, `item_id`, `code`) VALUES
(41, 1, NULL),
(42, 2, NULL),
(43, 3, NULL),
(44, 4, NULL),
(45, 5, NULL),
(46, 6, NULL),
(47, 7, NULL),
(48, 8, NULL),
(49, 7, NULL),
(50, 8, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `batches`
--

CREATE TABLE IF NOT EXISTS `batches` (
  `item` varchar(80) CHARACTER SET utf8 DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `quantity` float DEFAULT NULL,
  `serial` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL,
  `invoice_no` int(11) DEFAULT NULL,
  `store` int(11) NOT NULL,
  `wg` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`serial`),
  KEY `invoice_no` (`invoice_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `batches`
--

INSERT INTO `batches` (`item`, `expiry`, `quantity`, `serial`, `item_id`, `invoice_no`, `store`, `wg`) VALUES
('كلادن', '2023-08-31', 461, 1, 1, 1, 1, 0),
('بنر', '2023-08-31', 0, 2, 2, 2, 1, 0),
('Baner', '2023-08-31', 0, 3, 3, 3, 1, 0),
('Sticker', '2023-08-31', 0, 4, 4, 4, 1, 0),
('Flex', '2023-08-31', 0, 5, 5, 5, 1, 0),
('Mush', '2023-08-31', 968, 6, 6, 6, 1, 0),
('sticker item', '2023-08-31', 1982, 7, 7, 7, 1, 0),
('new23', '2023-09-03', 0.75, 8, 8, 8, 1, 0),
('بنر', '2023-09-03', 0, 9, 2, 9, 1, 0),
('Flex', '2023-09-03', 986958, 10, 5, 10, 1, 0),
('sticker item', '2023-09-03', 665766, 11, 7, 11, 1, 0),
('بنر', '2023-09-04', 99968.8, 12, 2, 12, 1, 0),
('Baner', '2023-09-05', 13357.8, 13, 3, 13, 1, 0),
('Sticker', '2023-09-05', 34758.9, 14, 4, 14, 1, 0),
('Sticker', '2023-09-05', 100000, 15, 4, 14, 1, 0),
('Flex', '2023-09-05', 100000, 16, 5, 15, 1, 0),
('Mush', '2023-09-05', 100000, 17, 6, 16, 1, 0),
('item 2424', '2024-04-23', 50, 18, 7, 17, 1, 0),
('2424', '2024-11-01', 9, 19, 8, 18, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE IF NOT EXISTS `class` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`id`, `class_name`) VALUES
(9, 'تصنيف 1');

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE IF NOT EXISTS `company` (
  `address` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `TEL` varchar(50) DEFAULT NULL,
  `NAME` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `percent` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dollarprice` double NOT NULL DEFAULT '1',
  `com` varchar(10) NOT NULL DEFAULT 'com1',
  `smsflag` int(11) NOT NULL DEFAULT '1',
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`address`, `EMAIL`, `TEL`, `NAME`, `percent`, `id`, `dollarprice`, `com`, `smsflag`) VALUES
('portsudan', '-', '09111', 'new civiliazations', 0, 1, 1, 'com6', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cust_name` varchar(50) DEFAULT NULL,
  `cust_rate` int(11) DEFAULT '0',
  `tel` varchar(30) NOT NULL DEFAULT '-',
  `address` varchar(50) NOT NULL DEFAULT '-',
  `company` varchar(40) NOT NULL DEFAULT '-',
  `type` varchar(30) NOT NULL DEFAULT '-',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=39 ;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `cust_name`, `cust_rate`, `tel`, `address`, `company`, `type`) VALUES
(1, 'مباشر', 0, '-', '-', '-', '-'),
(6, 'تاج السر القاضي', 0, '0123449530', 'نادي الشبيبة', 'القاضي للدعاية والاعلان', '-'),
(7, 'شرقاوي لاعلان', 10, '0900000007', 'سلالاب', 'اعلانات', '-'),
(8, 'ناظم', 0, '0911396143', '', 'اعلان', '-'),
(9, 'فارس', 0, '091234273', '', 'اعلانات', '-'),
(10, 'حسن لاعلان', 0, '', '', '', '-'),
(11, 'مكرمي لاعلانات', 0, '', '', '', '-'),
(12, 'بطه لاعلانات', 0, '', '', '', '-'),
(13, 'القاضي لاعلانات', 0, '', '', '', '-'),
(14, 'عوض لاعلانات', 0, '', '', '', '-'),
(15, 'ابداع لاعلانات', 0, '', '', '', '-'),
(16, 'ناظم لاعلانات', 0, '', '', '', '-'),
(17, 'الشائق لاعلانات', 0, '', '', '', '-'),
(18, 'علاء الدين لاعلانات', 0, '', '', '', '-'),
(19, 'مساعد لاعلانات', 0, '', '', '', '-'),
(20, 'عثمان لاعلانات', 0, '', '', '', '-'),
(21, 'قذافي لاعلانات ', 0, '', '', '', '-'),
(22, 'خميس للاعلانات', 0, '', '', '', '-'),
(23, 'عبداللـه طاهر للاعلانات', 0, '', '', '', '-'),
(24, 'محمود لاعلانات', 0, '', '', '', '-'),
(25, 'كبسور للاعلانات', 0, '', '', '', '-'),
(26, 'يسري لاعلانات', 0, '', '', '', '-'),
(27, 'ذا النون للاعلانات', 0, '', '', '', '-'),
(28, 'النعيم  الشكري', 0, '', '', '', '-'),
(29, 'محمود فنتاستك للاعلانات', 0, '', '', '', '-'),
(30, 'عثمان مقص', 0, '', '', '', '-'),
(31, 'مرج للخدمات', 0, '', '', '', '-'),
(32, 'اعمال ابو انس الهندسية', 0, '', '', '', '-'),
(33, 'الامبراطور', 0, '', '', '', '-'),
(34, 'ملك الطعمية', 0, '', '', '', '-'),
(35, 'االخليجي كهرباء', 0, '', '', '', '-'),
(36, 'اتصلات عبد الحليم', 0, '', '', '', '-'),
(37, 'اتصالات عبد الحليم', 0, '', '', '', '-'),
(38, 'سيما جاتبيه مستعجله', 0, '', '', '', '-');

-- --------------------------------------------------------

--
-- Table structure for table `cust_det`
--

CREATE TABLE IF NOT EXISTS `cust_det` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `debit` double DEFAULT '0',
  `credit` double DEFAULT '0',
  `inv_no` varchar(20) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `card` bigint(20) DEFAULT '0',
  `type` varchar(10) DEFAULT NULL,
  `bank` varchar(50) DEFAULT NULL,
  `date_bank` date DEFAULT NULL,
  `date` date DEFAULT NULL,
  `shift` varchar(20) DEFAULT NULL,
  `user` varchar(20) DEFAULT NULL,
  `schno` int(11) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `paycount` int(11) DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `chamount` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1902 ;

--
-- Dumping data for table `cust_det`
--

INSERT INTO `cust_det` (`id`, `name`, `debit`, `credit`, `inv_no`, `notes`, `card`, `type`, `bank`, `date_bank`, `date`, `shift`, `user`, `schno`, `status`, `paycount`, `duedate`, `chamount`) VALUES
(1850, '1', 0, 3900, '1', 'مبيعات', 0, NULL, NULL, NULL, '2023-08-31', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1851, '1', 0, 7920, '344', 'مبيعات', 0, NULL, NULL, NULL, '2023-08-31', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1852, '3', 0, 1500, '345', 'مبيعات', 0, NULL, NULL, NULL, '2023-08-31', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1853, '3', 500, 0, 'نقدا', 'سداد', 0, 'نقدا', 'نقدا', '2023-08-31', '2023-08-31', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1854, '2', 0, 16800, '346', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-03', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1855, '1', 0, 15600, '347', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-03', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1856, '1', 0, 20800, '348', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-03', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1857, '1', 0, 1350, '349', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-03', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1858, '1', 0, 12155, '350', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-03', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1859, '4', 0, 33170, '351', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-03', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1860, '5', 0, 538500, '352', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-03', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1861, '5', 500000, 0, 'نقدا', 'سداد', 0, 'شيك', 'نقدا', '2023-09-03', '2023-09-03', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1862, '1', 0, 70000000, '353', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-04', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1863, '22', 0, 10537.65, '354', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-04', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1864, '31', 0, 8000, '355', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1865, '31', 0, 150, '356', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1866, '31', 0, 8000, '357', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1867, '1', 0, 3500, '358', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1868, '1', 0, 11500, '359', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1869, '31', 0, 10500, '360', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1870, '33', 0, 10000, '361', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1871, '34', 0, 13000, '362', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1872, '35', 0, 10000, '363', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1873, '37', 0, 7500, '364', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1874, '1', 0, 55000, '365', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1875, '1', 0, 15500, '366', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1876, '1', 0, 7500, '367', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1877, '1', 0, 25600, '368', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1878, '1', 0, 25600, '369', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-05', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1879, '1', 0, 800, '370', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-06', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1880, '1', 0, 400, '371', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-09', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1881, '8', 0, 2000, '372', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-09', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1882, '9', 0, 1111, '373', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-09', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1883, '34', 0, 3333, '374', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-09', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1884, '9', 0, 4000, '375', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-09', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1885, '33', 0, 1234, '376', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-09', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1886, '1', 0, 1.25, '377', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-09', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1887, '1', 0, 1000, '378', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-10', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1888, '1', 0, 2000, '379', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-10', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1889, '1', 0, 3000, '380', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-10', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1890, '1', 0, 0.08, '381', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-17', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1891, '1', 0, 0.08, '382', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-17', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1892, '1', 0, 5000, '383', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-17', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1893, '8', 0, 5000, '384', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-17', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1894, '1', 0, 7000, '385', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-17', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1895, '1', 0, 750000, '386', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-18', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1896, '1', 0, 6000000, '387', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-18', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1897, '1', 0, 529254000, '388', 'مبيعات', 0, NULL, NULL, NULL, '2023-09-18', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1898, '1', 0, 36000, '389', 'مبيعات', 0, NULL, NULL, NULL, '2024-04-15', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1899, '1', 0, 60, '390', 'مبيعات', 0, NULL, NULL, NULL, '2024-04-23', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1900, '1', 0, 900, '391', 'مبيعات', 0, NULL, NULL, NULL, '2024-04-23', '1', 'احمد ', NULL, NULL, NULL, NULL, 0),
(1901, '1', 0, 138.89, '392', 'مبيعات', 0, NULL, NULL, NULL, '2024-11-01', '1', 'احمد ', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `cust_det2`
--

CREATE TABLE IF NOT EXISTS `cust_det2` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `debit` double DEFAULT '0',
  `credit` double DEFAULT '0',
  `inv_no` varchar(20) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `card` bigint(20) DEFAULT '0',
  `type` varchar(10) DEFAULT NULL,
  `bank` varchar(50) DEFAULT NULL,
  `date_bank` date DEFAULT NULL,
  `date` date DEFAULT NULL,
  `shift` varchar(20) DEFAULT NULL,
  `user` varchar(20) DEFAULT NULL,
  `schno` int(11) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `paycount` int(11) DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cust_det3`
--

CREATE TABLE IF NOT EXISTS `cust_det3` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `debit` double DEFAULT '0',
  `credit` double DEFAULT '0',
  `inv_no` varchar(20) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `card` bigint(20) DEFAULT '0',
  `type` varchar(10) DEFAULT NULL,
  `bank` varchar(50) DEFAULT NULL,
  `date_bank` date DEFAULT NULL,
  `date` date DEFAULT NULL,
  `shift` varchar(20) DEFAULT NULL,
  `user` varchar(20) DEFAULT NULL,
  `schno` int(11) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `paycount` int(11) DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `chamount` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE IF NOT EXISTS `expenses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `shift` bigint(20) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `item` varchar(100) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL,
  `print` varchar(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `expense_items`
--

CREATE TABLE IF NOT EXISTS `expense_items` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `expense_items`
--

INSERT INTO `expense_items` (`id`, `name`) VALUES
(12, 'ماء'),
(13, 'كهرباء'),
(14, 'نظافة'),
(15, 'وجبة افطار'),
(18, 'وجبة غداء');

-- --------------------------------------------------------

--
-- Table structure for table `fastitemsset`
--

CREATE TABLE IF NOT EXISTS `fastitemsset` (
  `b1` varchar(30) NOT NULL,
  `b2` varchar(30) NOT NULL,
  `b3` varchar(30) NOT NULL,
  `b4` varchar(30) NOT NULL,
  `b5` varchar(30) NOT NULL,
  `b6` varchar(30) NOT NULL,
  `b7` varchar(30) NOT NULL,
  `b8` varchar(30) NOT NULL,
  `b9` varchar(30) NOT NULL,
  `b10` varchar(30) NOT NULL,
  `b11` varchar(30) NOT NULL,
  `b12` varchar(30) NOT NULL,
  `b13` varchar(30) NOT NULL,
  `b14` varchar(30) NOT NULL,
  `b15` varchar(30) NOT NULL,
  `b16` varchar(30) NOT NULL,
  `b17` varchar(30) NOT NULL,
  `b18` varchar(30) NOT NULL,
  `b19` varchar(30) NOT NULL,
  `b20` varchar(30) NOT NULL,
  `b21` varchar(30) NOT NULL,
  `b22` varchar(30) NOT NULL,
  `b23` varchar(30) NOT NULL,
  `b24` varchar(30) NOT NULL,
  `b25` varchar(30) NOT NULL,
  `b26` varchar(30) NOT NULL,
  `b27` varchar(30) NOT NULL,
  `b28` varchar(30) NOT NULL,
  `b29` varchar(30) NOT NULL,
  `b30` varchar(30) NOT NULL,
  `b31` varchar(30) NOT NULL,
  `b32` varchar(30) NOT NULL,
  `b33` varchar(30) NOT NULL,
  `b34` varchar(30) NOT NULL,
  `b35` varchar(30) NOT NULL,
  `b36` varchar(30) NOT NULL,
  `b37` varchar(30) NOT NULL,
  `b38` varchar(30) NOT NULL,
  `b39` varchar(30) NOT NULL,
  `b40` varchar(30) NOT NULL,
  `b41` varchar(30) NOT NULL,
  `b42` varchar(30) NOT NULL,
  `b43` varchar(30) NOT NULL,
  `b44` varchar(30) NOT NULL,
  `b45` varchar(30) NOT NULL,
  `b46` varchar(30) NOT NULL,
  `b47` varchar(30) NOT NULL,
  `b48` varchar(30) NOT NULL,
  `b49` varchar(30) NOT NULL,
  `b50` varchar(30) NOT NULL,
  `b51` varchar(30) NOT NULL,
  `b52` varchar(30) NOT NULL,
  `b53` varchar(30) NOT NULL,
  `b54` varchar(30) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `user` varchar(30) NOT NULL,
  `modifycount` int(11) NOT NULL DEFAULT '1',
  `b55` varchar(50) NOT NULL,
  `b56` varchar(50) NOT NULL,
  `b57` varchar(50) NOT NULL,
  `b58` varchar(50) NOT NULL,
  `b59` varchar(50) NOT NULL,
  `b60` varchar(50) NOT NULL,
  `b61` varchar(50) NOT NULL,
  `b62` varchar(50) NOT NULL,
  `b63` varchar(50) NOT NULL,
  `b64` varchar(50) NOT NULL,
  `b65` varchar(50) NOT NULL,
  `b66` varchar(50) NOT NULL,
  `b67` varchar(50) NOT NULL,
  `b68` varchar(50) NOT NULL,
  `b69` varchar(50) NOT NULL,
  `b70` varchar(50) NOT NULL,
  `b71` varchar(50) NOT NULL,
  `b72` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `fastitemsset`
--

INSERT INTO `fastitemsset` (`b1`, `b2`, `b3`, `b4`, `b5`, `b6`, `b7`, `b8`, `b9`, `b10`, `b11`, `b12`, `b13`, `b14`, `b15`, `b16`, `b17`, `b18`, `b19`, `b20`, `b21`, `b22`, `b23`, `b24`, `b25`, `b26`, `b27`, `b28`, `b29`, `b30`, `b31`, `b32`, `b33`, `b34`, `b35`, `b36`, `b37`, `b38`, `b39`, `b40`, `b41`, `b42`, `b43`, `b44`, `b45`, `b46`, `b47`, `b48`, `b49`, `b50`, `b51`, `b52`, `b53`, `b54`, `id`, `date`, `user`, `modifycount`, `b55`, `b56`, `b57`, `b58`, `b59`, `b60`, `b61`, `b62`, `b63`, `b64`, `b65`, `b66`, `b67`, `b68`, `b69`, `b70`, `b71`, `b72`) VALUES
('', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'Axe', 'Baby Oil', '', '', '', '', 'Axe', '', '', '', '', '', '', '', 1, '2020-03-06', 'user', 1, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `groupname`
--

CREATE TABLE IF NOT EXISTS `groupname` (
  `groupname` varchar(100) NOT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`groupname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `insurance_co`
--

CREATE TABLE IF NOT EXISTS `insurance_co` (
  `company` varchar(50) CHARACTER SET utf8 NOT NULL,
  `percent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inveq`
--

CREATE TABLE IF NOT EXISTS `inveq` (
  `id` bigint(20) NOT NULL,
  `date` date DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL,
  `confirm` varchar(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `inveq`
--

INSERT INTO `inveq` (`id`, `date`, `notes`, `user`, `confirm`) VALUES
(1, '2022-02-02', 'خطا  مطبعي', 'احمد ', '1');

-- --------------------------------------------------------

--
-- Table structure for table `inveqdet`
--

CREATE TABLE IF NOT EXISTS `inveqdet` (
  `id` bigint(20) DEFAULT NULL,
  `item` varchar(100) DEFAULT NULL,
  `exp` date DEFAULT NULL,
  `qbefore` double DEFAULT NULL,
  `qnt` double DEFAULT NULL,
  `qafter` double DEFAULT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `batch` varchar(20) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `item_name` varchar(100) NOT NULL,
  `item_scname` varchar(100) DEFAULT NULL,
  `item_supplier` varchar(100) NOT NULL,
  `item_class` varchar(100) NOT NULL,
  `item_unitp` varchar(50) NOT NULL,
  `item_units` varchar(50) NOT NULL,
  `item_packp` int(11) DEFAULT NULL,
  `item_packs` varchar(50) DEFAULT NULL,
  `item_avgcost` double DEFAULT NULL,
  `item_lprice` double DEFAULT NULL,
  `item_hcost` double DEFAULT NULL,
  `item_profitr` int(11) DEFAULT NULL,
  `item_secprice` double DEFAULT NULL,
  `item_wprice` double DEFAULT NULL,
  `item_source` varchar(50) DEFAULT NULL,
  `item_store` varchar(50) DEFAULT NULL,
  `item_max` int(11) NOT NULL,
  `item_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_qnt` double DEFAULT NULL,
  `item_min` bigint(20) NOT NULL,
  `item_counter_no` int(11) NOT NULL DEFAULT '1',
  `wg` double NOT NULL DEFAULT '0',
  `paid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_name`, `item_scname`, `item_supplier`, `item_class`, `item_unitp`, `item_units`, `item_packp`, `item_packs`, `item_avgcost`, `item_lprice`, `item_hcost`, `item_profitr`, `item_secprice`, `item_wprice`, `item_source`, `item_store`, `item_max`, `item_id`, `item_qnt`, `item_min`, `item_counter_no`, `wg`, `paid`) VALUES
('Baner', '', 'مورد 1', 'تصنيف 1', 'حبة', 'حبة', 0, '0', 300.005, 0.01, 600, 0, 6000, 4000, '', '', 100, 3, 13357.85, 10, 1, 5000, 0),
('Sticker', '', 'مورد 1', 'تصنيف 1', 'حبة', 'حبة', 0, '0', 21.673333333333336, 0.01, 65, 0, 0.01, 0, '', '', 100, 4, 94756, 10, 1, 0, 0),
('Flex', '', 'مورد 1', 'تصنيف 1', 'حبة', 'حبة', 0, '0', 218.5633333333333, 0.01, 650, 0, 0.01, 4000, '', '', 100, 5, 1086949, 10, 1, 4500, 0),
('Mush', '', 'مورد 1', 'تصنيف 1', 'حبة', 'حبة', 0, '0', 1800.005, 0.01, 3600, 0, 0.01, 5500, '', '', 100, 6, 100968, 10, 1, 6000, 0),
('item 2424', '', 'مورد 1', 'تصنيف 1', 'حبة', 'حبة', 0, '0', 10, 10, 10, 0, 10, 0, '', '', 100, 7, 44, 10, 1, 0, 0),
('2424', '', 'مورد 1', 'تصنيف 1', 'حبة', 'حبة', 0, '0', 555.56, 555.56, 555.56, 0, 555.56, 0, '', '', 100, 8, 8.75, 10, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `journal`
--

CREATE TABLE IF NOT EXISTS `journal` (
  `ID` int(11) DEFAULT NULL,
  `JOURNAL_DATE` date NOT NULL,
  `JOURNAL_NO` decimal(6,0) NOT NULL,
  `JOURNAL_SUBMAIN_NO` decimal(6,0) NOT NULL,
  `JOURNAL_DOCNO` varchar(100) DEFAULT NULL,
  `JOURNAL_DESC` varchar(200) NOT NULL,
  `JOURNAL_USER` varchar(50) NOT NULL,
  `JOURNAL_DR` double DEFAULT NULL,
  `JOURNAL_CR` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `main`
--

CREATE TABLE IF NOT EXISTS `main` (
  `ID` int(11) DEFAULT NULL,
  `MAIN_NO` decimal(6,0) NOT NULL,
  `MAIN_NAME` varchar(50) NOT NULL,
  `MAIN_BAND_NO` decimal(6,0) DEFAULT NULL,
  PRIMARY KEY (`MAIN_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `main`
--

INSERT INTO `main` (`ID`, `MAIN_NO`, `MAIN_NAME`, `MAIN_BAND_NO`) VALUES
(NULL, 1, 'bank1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `posaccounts`
--

CREATE TABLE IF NOT EXISTS `posaccounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` varchar(30) NOT NULL,
  `using` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `posaccounts`
--

INSERT INTO `posaccounts` (`id`, `name`, `type`, `using`) VALUES
(1, '1n', '1t', 0);

-- --------------------------------------------------------

--
-- Table structure for table `posjournal`
--

CREATE TABLE IF NOT EXISTS `posjournal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cdate` date NOT NULL,
  `cname` varchar(100) NOT NULL DEFAULT '-',
  `vdesc` varchar(100) NOT NULL DEFAULT '0.00',
  `debit` double NOT NULL DEFAULT '0',
  `credit` double NOT NULL DEFAULT '0',
  `user` varchar(50) NOT NULL DEFAULT 'user',
  `shift` int(11) NOT NULL DEFAULT '0',
  `cid` int(11) NOT NULL DEFAULT '0',
  `voucher` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `premium`
--

CREATE TABLE IF NOT EXISTS `premium` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inv` int(11) NOT NULL,
  `schno` int(11) NOT NULL,
  `paydate` date DEFAULT NULL,
  `duedate` date NOT NULL,
  `status` varchar(20) NOT NULL,
  `paycount` int(11) NOT NULL,
  `credit` double NOT NULL,
  `name` int(11) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT '-',
  `bank` varchar(40) NOT NULL DEFAULT '-',
  `shift` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE IF NOT EXISTS `purchases` (
  `invoice_no` int(11) NOT NULL AUTO_INCREMENT,
  `item_total_price` double DEFAULT NULL,
  `item_suplier` varchar(50) DEFAULT NULL,
  `item_discount` float DEFAULT NULL,
  `item_exchange_rate` double DEFAULT NULL,
  `item_date` varchar(20) DEFAULT NULL,
  `confirm` varchar(10) DEFAULT '0',
  `store` int(11) NOT NULL,
  `shift` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`invoice_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`invoice_no`, `item_total_price`, `item_suplier`, `item_discount`, `item_exchange_rate`, `item_date`, `confirm`, `store`, `shift`) VALUES
(1, 650000, 'مورد 1', 0, NULL, '2023-08-31', '0', 1, 0),
(2, 12000000, 'مورد 1', 0, NULL, '2023-08-31', '0', 1, 0),
(3, 600000, 'مورد 1', 0, NULL, '2023-08-31', '0', 1, 0),
(4, 650000, 'مورد 1', 0, NULL, '2023-08-31', '0', 1, 0),
(5, 6500000, 'مورد 1', 0, NULL, '2023-08-31', '0', 1, 0),
(6, 3600000, 'مورد 1', 0, NULL, '2023-08-31', '0', 1, 0),
(7, 250000, 'مورد 1', 0, NULL, '2023-08-31', '0', 1, 0),
(8, 1500, 'مورد 1', 0, NULL, '2023-09-03', '0', 1, 0),
(9, 1595756, 'مورد 1', 0, NULL, '2023-09-03', '0', 1, 0),
(10, 11351312, 'مورد 1', 0, NULL, '2023-09-03', '0', 1, 0),
(11, 193396968, 'مورد 1', 0, NULL, '2023-09-03', '0', 1, 0),
(12, 3001000, 'مورد 1', 0, NULL, '2023-09-04', '0', 1, 0),
(13, 1000, 'مورد 1', 0, NULL, '2023-09-05', '0', 1, 0),
(14, 2000, 'مورد 1', 0, NULL, '2023-09-05', '0', 1, 0),
(15, 1000, 'مورد 1', 0, NULL, '2023-09-05', '0', 1, 0),
(16, 1000, 'مورد 1', 0, NULL, '2023-09-05', '0', 1, 0),
(17, 500, 'مورد 1', 0, NULL, '2024-04-23', '0', 1, 0),
(18, 5000, 'مورد 1', 0, NULL, '2024-11-01', '0', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `purchases_det`
--

CREATE TABLE IF NOT EXISTS `purchases_det` (
  `item_name` varchar(100) DEFAULT NULL,
  `item_qty` double DEFAULT NULL,
  `item_bouns` int(11) DEFAULT NULL,
  `item_exp_date` date DEFAULT NULL,
  `item_pay_unit` varchar(30) DEFAULT NULL,
  `item_number` int(11) DEFAULT NULL,
  `item_total` double DEFAULT NULL,
  `item_sale_unit` varchar(30) DEFAULT NULL,
  `item_sale_unit_price` double DEFAULT NULL,
  `sale_price` double DEFAULT NULL,
  `invoice_no` int(11) DEFAULT NULL,
  `item_scname` varchar(60) NOT NULL,
  `shift` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL DEFAULT '0',
  `wg` double NOT NULL DEFAULT '0',
  KEY `invoice_no` (`invoice_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `purchases_det`
--

INSERT INTO `purchases_det` (`item_name`, `item_qty`, `item_bouns`, `item_exp_date`, `item_pay_unit`, `item_number`, `item_total`, `item_sale_unit`, `item_sale_unit_price`, `sale_price`, `invoice_no`, `item_scname`, `shift`, `item_id`, `wg`) VALUES
('كلادن', 500, 0, '2023-08-31', 'حبة', 650000, 500, 'حبة', 1300, 1300, 1, '', 0, 1, 0),
('بنر', 10000, 0, '2023-08-31', 'حبة', 12000000, 10000, 'حبة', 1200, 1200, 2, '', 0, 2, 0),
('Baner', 1000, 0, '2023-08-31', 'حبة', 600000, 1000, 'حبة', 600, 600, 3, '', 0, 3, 0),
('Sticker', 10000, 0, '2023-08-31', 'حبة', 650000, 10000, 'حبة', 65, 65, 4, '', 0, 4, 0),
('Flex', 10000, 0, '2023-08-31', 'حبة', 6500000, 10000, 'حبة', 650, 650, 5, '', 0, 5, 0),
('Mush', 1000, 0, '2023-08-31', 'حبة', 3600000, 1000, 'حبة', 3600, 3600, 6, '', 0, 6, 0),
('sticker item', 2000, 0, '2023-08-31', 'حبة', 250000, 2000, 'حبة', 125, 125, 7, '', 0, 7, 0),
('new23', 10, 0, '2023-09-03', 'حبة', 1500, 10, 'حبة', 150, 150, 8, '', 0, 8, 0),
('بنر', 9999, 0, '2023-09-03', 'حبة', 797878, 9999, 'حبة', 4000, 79.8, 9, '', 0, 2, 0),
('Flex', 999999, 0, '2023-09-03', 'حبة', 5675656, 999999, 'حبة', 5000, 5.68, 10, '', 0, 5, 0),
('sticker item', 665766, 0, '2023-09-03', 'حبة', 64465656, 665766, 'حبة', 5000, 96.83, 11, '', 0, 7, 0),
('بنر', 100000, 0, '2023-09-04', 'حبة', 1000, 100000, 'حبة', 0.01, 0.01, 12, '', 0, 2, 0),
('Baner', 100000, 0, '2023-09-05', 'حبة', 1000, 100000, 'حبة', 0.01, 0.01, 13, '', 0, 3, 0),
('Sticker', 100000, 0, '2023-09-05', 'حبة', 1000, 100000, 'حبة', 0.01, 0.01, 14, '', 0, 4, 0),
('Sticker', 100000, 0, '2023-09-05', 'حبة', 1000, 100000, 'حبة', 0.01, 0.01, 14, '', 0, 4, 0),
('Flex', 100000, 0, '2023-09-05', 'حبة', 1000, 100000, 'حبة', 0.01, 0.01, 15, '', 0, 5, 0),
('Mush', 100000, 0, '2023-09-05', 'حبة', 1000, 100000, 'حبة', 0.01, 0.01, 16, '', 0, 6, 0),
('item 2424', 50, 0, '2024-04-23', 'حبة', 500, 50, 'حبة', 10, 10, 17, '', 0, 7, 0),
('2424', 9, 0, '2024-11-01', 'حبة', 5000, 9, 'حبة', 555.56, 555.56, 18, '', 0, 8, 0);

-- --------------------------------------------------------

--
-- Table structure for table `refund`
--

CREATE TABLE IF NOT EXISTS `refund` (
  `refund_id` int(10) NOT NULL AUTO_INCREMENT,
  `refund_date` date DEFAULT NULL,
  `refund_total` double DEFAULT NULL,
  `refund_suplier` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `user` varchar(50) CHARACTER SET utf8 NOT NULL,
  `shift` int(11) NOT NULL,
  PRIMARY KEY (`refund_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Dumping data for table `refund`
--

INSERT INTO `refund` (`refund_id`, `refund_date`, `refund_total`, `refund_suplier`, `user`, `shift`) VALUES
(1, '2023-03-06', 0.43, NULL, 'بابكر', 1),
(2, '2023-03-07', 0.43, NULL, 'بابكر', 1),
(3, '2023-03-07', 0.43, NULL, 'بابكر', 1),
(4, '2023-03-07', 0.43, NULL, 'بابكر', 1),
(5, '2023-03-20', 45000, NULL, 'احمد ', 1),
(8, '2023-03-27', 1720000, NULL, 'بابكر', 1),
(9, '2023-05-02', 920000, NULL, 'بابكر', 1),
(10, '2023-05-02', 4000000, NULL, 'بابكر', 1),
(11, '2023-05-11', 250000, NULL, 'بابكر', 1),
(12, '2023-05-14', 1200000, NULL, 'بابكر', 1),
(13, '2023-05-15', 42000, NULL, 'بابكر', 1),
(14, '2023-05-23', 390000, NULL, 'بابكر', 1),
(15, '2023-06-07', 11372000, NULL, 'بابكر', 1),
(16, '2023-06-07', 9009750, NULL, 'بابكر', 1),
(17, '2023-06-13', 8000000, NULL, 'بابكر', 1),
(18, '2023-06-17', 44000, NULL, 'بابكر', 1),
(19, '2023-07-04', 45000, NULL, 'بابكر', 1),
(20, '2023-07-25', 280000, NULL, 'بابكر', 1),
(21, '2023-08-02', 5500000, NULL, 'بابكر', 1),
(22, '2023-08-10', 2000000, NULL, 'بابكر', 1),
(23, '2023-08-10', 900000, NULL, 'بابكر', 1);

-- --------------------------------------------------------

--
-- Table structure for table `refund_det`
--

CREATE TABLE IF NOT EXISTS `refund_det` (
  `refund_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `re_exp_date` date DEFAULT NULL,
  `re_qnt` int(11) DEFAULT NULL,
  `re_total` int(11) DEFAULT NULL,
  `re_unit_price` double DEFAULT NULL,
  `item_id` varchar(20) NOT NULL,
  KEY `refund_id` (`refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `refund_det`
--

INSERT INTO `refund_det` (`refund_id`, `name`, `re_exp_date`, `re_qnt`, `re_total`, `re_unit_price`, `item_id`) VALUES
(1, 'موتور نص حصان', NULL, 1, 0, 0.43, '1.0'),
(2, 'موتور نص حصان', NULL, 1, 0, 0.43, '1.0'),
(3, 'موتور نص حصان', NULL, 1, 0, 0.43, '1.0'),
(4, 'موتور نص حصان', NULL, 1, 0, 0.43, '1.0'),
(5, 'موتور نص حصان', NULL, 1, 45000, 45000, '1.0'),
(8, 'موتور نص حصان', NULL, 20, 800000, 40000, '1.0'),
(9, 'تحضير واحد حصان ', NULL, 1, 920000, 920000, '28.0'),
(10, 'موتور نص حصان', NULL, 10, 4000000, 400000, '1.0'),
(11, 'موتور غاطس 2 حصان 2 بوصه 2 خط', NULL, 1, 250000, 250000, '6.0'),
(12, 'موتور نص حصان', NULL, 30, 1200000, 40000, '1.0'),
(13, 'موتور نص حصان', NULL, 1, 42000, 42000, '1.0'),
(14, 'موتور غاطس 2 حصان 2 بوصه 2 خط', NULL, 1, 390000, 390000, '6.0'),
(15, 'موتور نص حصان', NULL, 100, 4000000, 40000, '1.0'),
(15, 'تحضير واحد حصان ', NULL, 50, 4600000, 92000, '28.0'),
(15, 'موتور 1 حصان ريشة', NULL, 30, 2772000, 92400, '2.0'),
(16, 'تحضير واحد حصان ', NULL, 100, 8355000, 83550, '28.0'),
(16, 'جهاز اتومتيك', NULL, 30, 654750, 21825, '8.0'),
(17, 'موتور نص حصان', NULL, 200, 8000000, 40000, '1.0'),
(18, 'موتور نص حصان', NULL, 1, 44000, 44000, '1.0'),
(19, 'موتور نص حصان', NULL, 1, 45000, 45000, '1.0'),
(20, 'موتور 2 حصان تحضير ', NULL, 1, 280000, 280000, '29.0'),
(21, 'موتور نص حصان', NULL, 70, 3500000, 50000, '1.0'),
(21, 'تحضير واحد حصان ', NULL, 15, 1500000, 100000, '28.0'),
(21, 'موتور 1 حصان ريشة', NULL, 5, 500000, 100000, '2.0'),
(22, 'موتور نص حصان', NULL, 20, 1000000, 50000, '1.0'),
(22, 'تحضير واحد حصان ', NULL, 10, 1000000, 100000, '28.0'),
(23, 'موتور ريشه     2 حصان 2 بوصه ', NULL, 3, 900000, 300000, '3.0');

-- --------------------------------------------------------

--
-- Table structure for table `registration`
--

CREATE TABLE IF NOT EXISTS `registration` (
  `username` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  `NameOfUser` varchar(250) NOT NULL,
  `ContactNo` varchar(15) NOT NULL,
  `Email` varchar(250) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `registration`
--

INSERT INTO `registration` (`username`, `password`, `NameOfUser`, `ContactNo`, `Email`) VALUES
('admin', '12345', 'mohamed', '011111', '011222@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `saledets`
--

CREATE TABLE IF NOT EXISTS `saledets` (
  `FK` int(11) NOT NULL DEFAULT '1',
  `QTY` double NOT NULL DEFAULT '0',
  `UP` double NOT NULL DEFAULT '0',
  `TP` double NOT NULL DEFAULT '0',
  `GS` date DEFAULT NULL,
  `BALANCE` double NOT NULL DEFAULT '0',
  `BATCH` int(11) NOT NULL DEFAULT '0',
  `UC` double DEFAULT '0',
  `TC` double DEFAULT '0',
  `PROFIT` double DEFAULT '0',
  `item_name` varchar(50) DEFAULT NULL,
  `counter_no` int(11) NOT NULL DEFAULT '1',
  `user` varchar(11) NOT NULL DEFAULT 'user',
  `id` int(11) NOT NULL,
  `flag` int(11) NOT NULL DEFAULT '0',
  `waiter` varchar(50) NOT NULL DEFAULT '-',
  `room` double NOT NULL DEFAULT '0',
  `roomflag` double NOT NULL DEFAULT '0',
  `h1` int(11) NOT NULL DEFAULT '0',
  `tableid` int(11) NOT NULL AUTO_INCREMENT,
  `method` varchar(100) NOT NULL DEFAULT '-',
  `cno` int(11) NOT NULL DEFAULT '0',
  `wg` double NOT NULL DEFAULT '0',
  `order1` int(11) NOT NULL DEFAULT '0',
  `refund` int(11) NOT NULL DEFAULT '0',
  `sizew` double NOT NULL DEFAULT '0',
  `sizeh` double NOT NULL DEFAULT '0',
  `staff` varchar(50) NOT NULL DEFAULT '0',
  `staffid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tableid`),
  KEY `FK` (`FK`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=75 ;

--
-- Dumping data for table `saledets`
--

INSERT INTO `saledets` (`FK`, `QTY`, `UP`, `TP`, `GS`, `BALANCE`, `BATCH`, `UC`, `TC`, `PROFIT`, `item_name`, `counter_no`, `user`, `id`, `flag`, `waiter`, `room`, `roomflag`, `h1`, `tableid`, `method`, `cno`, `wg`, `order1`, `refund`, `sizew`, `sizeh`, `staff`, `staffid`) VALUES
(1, 3, 1300, 3900, '2023-08-31', 497, 1, 1300, 3900, 0, 'كلادن', 1, 'احمد ', 1, 1, '-', 0, 1, 0, 1, '1', 1, 0, 0, 0, 3, 1, '0', 0),
(344, 6.6, 1200, 7920, '2023-08-31', 9993.4, 2, 1200, 7920, 0, 'بنر', 1, 'احمد ', 2, 1, '-', 0, 1, 0, 2, '1', 1, 0, 0, 0, 1.2, 5.5, '0', 0),
(345, 12, 125, 1500, '2023-08-31', 1988, 7, 125, 1500, 0, 'sticker item', 1, 'احمد ', 7, 1, '-', 0, 1, 0, 3, '1', 3, 0, 0, 0, 2, 6, '0', 0),
(347, 12, 1300, 15600, '2023-09-03', 485, 1, 1300, 15600, 0, 'كلادن', 1, 'احمد ', 1, 1, '-', 0, 1, 0, 4, '1', 1, 0, 0, 0, 3, 4, 'محمـد', 2),
(348, 16, 1300, 20800, '2023-09-03', 469, 1, 1300, 20800, 0, 'كلادن', 1, 'احمد ', 1, 1, '-', 0, 1, 0, 5, '1', 1, 0, 0, 0, 4, 4, 'osman', 1),
(349, 1, 150, 150, '2023-09-03', 9, 8, 150, 150, 0, 'new23', 1, 'احمد ', 8, 1, '-', 0, 1, 0, 6, '1', 1, 0, 0, 0, 1, 1, 'osman', 1),
(349, 8, 150, 1200, '2023-09-03', 1, 8, 150, 1200, 0, 'new23', 1, 'احمد ', 8, 1, '-', 0, 1, 0, 7, '1', 1, 0, 0, 0, 4, 2, 'osman', 1),
(350, 6, 1300, 7800, '2023-09-03', 463, 1, 1300, 7800, 0, 'كلادن', 1, 'احمد ', 1, 1, '-', 0, 1, 0, 8, '1', 1, 0, 0, 0, 3, 2, 'osman', 1),
(350, 2, 1300, 2600, '2023-09-03', 461, 1, 1300, 2600, 0, 'كلادن', 1, 'احمد ', 1, 1, '-', 0, 1, 0, 9, '1', 1, 0, 0, 0, 2, 1, 'osman', 1),
(350, 12, 65, 780, '2023-09-03', 9988, 4, 65, 780, 0, 'Sticker', 1, 'احمد ', 4, 1, '-', 0, 1, 0, 10, '1', 1, 0, 0, 0, 4, 3, 'osman', 1),
(350, 15, 65, 975, '2023-09-03', 9973, 4, 65, 975, 0, 'Sticker', 1, 'احمد ', 4, 1, '-', 0, 1, 0, 11, '1', 1, 0, 0, 0, 5, 3, 'osman', 1),
(351, 8, 4000, 32000, '2023-09-03', 19984, 2, 4000, 5112, 26888, 'بنر', 1, 'احمد ', 2, 1, '-', 0, 1, 0, 12, '1', 4, 0, 0, 0, 1, 8, 'osman', 1),
(351, 18, 65, 1170, '2023-09-03', 9955, 4, 65, 1170, 0, 'Sticker', 1, 'احمد ', 4, 1, '-', 0, 1, 0, 13, '1', 4, 0, 0, 0, 2, 9, 'osman', 1),
(352, 3, 6000, 18000, '2023-09-03', 1009996, 5, 6000, 981, 17019, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 14, '1', 5, 0, 0, 0, 1.5, 2, 'osman', 1),
(352, 2.4000000000000004, 6000, 14400, '2023-09-03', 1009993.6, 5, 6000, 784.8000000000001, 13615.200000000003, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 15, '1', 5, 0, 0, 0, 1.6, 1.5, 'osman', 1),
(352, 1.7, 6000, 10200, '2023-09-03', 1009991.3, 5, 6000, 555.9, 9644.1, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 16, '1', 5, 0, 0, 0, 2, 0.85, 'osman', 1),
(352, 2, 6000, 12000, '2023-09-03', 1009989, 5, 6000, 654, 11346, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 17, '1', 5, 0, 0, 0, 2, 1, 'osman', 1),
(352, 4.199999999999999, 6000, 25200, '2023-09-03', 1009984.8, 5, 6000, 1373.3999999999999, 23826.599999999995, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 18, '1', 5, 0, 0, 0, 1.5, 2.8, 'osman', 1),
(352, 4.5, 6000, 27000, '2023-09-03', 1009979.5, 5, 6000, 1471.5, 25528.5, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 19, '1', 5, 0, 0, 0, 3, 1.5, 'osman', 1),
(352, 4.5, 6000, 27000, '2023-09-03', 1009974.5, 5, 6000, 1471.5, 25528.5, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 20, '1', 5, 0, 0, 0, 3, 1.5, 'osman', 1),
(352, 4.199999999999999, 6000, 25200, '2023-09-03', 1009969.8, 5, 6000, 1373.3999999999999, 23826.599999999995, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 21, '1', 5, 0, 0, 0, 1.5, 2.8, 'osman', 1),
(352, 6, 6000, 36000, '2023-09-03', 1009963, 5, 6000, 1962, 34038, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 22, '1', 5, 0, 0, 0, 4, 1.5, 'osman', 1),
(352, 7.199999999999999, 6000, 43200, '2023-09-03', 1009955.8, 5, 6000, 2354.3999999999996, 40845.6, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 23, '1', 5, 0, 0, 0, 4.8, 1.5, 'osman', 1),
(352, 10.4, 6000, 62400, '2023-09-03', 1009944.6, 5, 6000, 3400.8, 58999.200000000004, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 24, '1', 5, 0, 0, 0, 5.2, 2, 'osman', 1),
(352, 9.45, 6000, 56700, '2023-09-03', 1009934.55, 5, 6000, 3090.1499999999996, 53609.85, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 25, '1', 5, 0, 0, 0, 6.3, 1.5, 'osman', 1),
(352, 10.5, 6000, 63000, '2023-09-03', 1009923.5, 5, 6000, 3433.5, 59566.5, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 26, '1', 5, 0, 0, 0, 7, 1.5, 'osman', 1),
(352, 7.2, 6000, 43200, '2023-09-03', 1009915.8, 5, 6000, 2354.4, 40845.6, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 27, '1', 5, 0, 0, 0, 7.2, 1, 'osman', 1),
(352, 9.5, 6000, 57000, '2023-09-03', 1009905.5, 5, 6000, 3106.5, 53893.5, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 28, '1', 5, 0, 0, 0, 9.5, 1, 'osman', 1),
(352, 3, 6000, 18000, '2023-09-03', 1009902, 5, 6000, 981, 17019, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 29, '1', 5, 0, 0, 0, 2, 1.5, 'osman', 1),
(353, 20000, 3500, 70000000, '2023-09-04', 99984, 2, 3500, 8520000, 61480000, 'بنر', 1, 'احمد ', 2, 1, '-', 0, 1, 0, 30, '1', 1, 0, 0, 0, 100, 200, 'osman', 1),
(354, 0.6375, 65, 41.44, '2023-09-04', 9954.3625, 4, 65, 41.4375, 0, 'Sticker', 1, 'احمد ', 4, 1, '-', 0, 1, 0, 31, '1', 22, 0, 0, 0, 0.75, 0.85, 'osman', 1),
(354, 0.81, 65, 52.65, '2023-09-04', 9953.19, 4, 65, 52.650000000000006, 0, 'Sticker', 1, 'احمد ', 4, 1, '-', 0, 1, 0, 32, '1', 22, 0, 0, 0, 0.9, 0.9, 'osman', 1),
(354, 0.335, 65, 21.78, '2023-09-04', 9952.665, 4, 65, 21.775000000000002, 0, 'Sticker', 1, 'احمد ', 4, 1, '-', 0, 1, 0, 33, '1', 22, 0, 0, 0, 0.5, 0.67, 'osman', 1),
(354, 0.335, 65, 21.78, '2023-09-04', 9951.665, 4, 65, 21.775000000000002, 0, 'Sticker', 1, 'احمد ', 4, 1, '-', 0, 1, 0, 34, '1', 22, 0, 0, 0, 0.67, 0.5, 'osman', 1),
(354, 160, 65, 10400, '2023-09-04', 9791, 4, 65, 10400, 0, 'Sticker', 1, 'احمد ', 4, 1, '-', 0, 1, 0, 35, '1', 22, 0, 0, 0, 200, 0.8, 'osman', 1),
(355, 1.5, 0.01, 8000, '2023-09-05', 109789.5, 4, 0.01, 31.5, -31.485, 'Sticker', 1, 'احمد ', 4, 1, '-', 0, 1, 0, 36, '1', 31, 0, 1, 0, 1, 1.5, 'osman', 1),
(356, 15000, 0.01, 150, '2023-09-05', 94789, 4, 0.01, 315000, -314850, 'Sticker', 1, 'احمد ', 4, 1, '-', 0, 1, 0, 37, '1', 31, 0, 1, 0, 150, 100, 'osman', 1),
(357, 1.5, 0.01, 8000, '2023-09-05', 94787.5, 4, 0.01, 31.5, -31.485, 'Sticker', 1, 'احمد ', 4, 1, '-', 0, 1, 0, 38, '1', 31, 0, 1, 0, 1, 1.5, 'osman', 1),
(358, 2809, 0.01, 3500, '2023-09-05', 1107093, 5, 0.01, 612362, -612333.91, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 39, '1', 1, 0, 2, 0, 53, 53, 'osman', 1),
(359, 23400, 0.01, 11500, '2023-09-05', 77572, 3, 0.01, 7020000, -7019766, 'Baner', 1, 'احمد ', 3, 1, '-', 0, 1, 0, 40, '1', 1, 0, 1, 0, 390, 60, 'osman', 1),
(360, 21000, 0.01, 10500, '2023-09-05', 56572, 3, 0.01, 6300000, -6299790, 'Baner', 1, 'احمد ', 3, 1, '-', 0, 1, 0, 41, '1', 31, 0, 1, 0, 350, 60, 'محمـد', 2),
(361, 2, 0.01, 10000, '2023-09-05', 56570, 3, 0.01, 600, -599.98, 'Baner', 1, 'احمد ', 3, 1, '-', 0, 1, 0, 42, '1', 33, 0, 1, 0, 1, 2, 'محمـد', 2),
(362, 22000, 0.01, 13000, '2023-09-05', 34570, 3, 0.01, 6600000, -6599780, 'Baner', 1, 'احمد ', 3, 1, '-', 0, 1, 0, 43, '1', 34, 0, 1, 0, 88, 250, 'محمـد', 2),
(363, 20000, 0.01, 10000, '2023-09-05', 1087093, 5, 0.01, 4360000, -4359800, 'Flex', 1, 'احمد ', 5, 1, '-', 0, 1, 0, 44, '1', 35, 0, 1, 0, 100, 200, 'محمـد', 2),
(364, 11200, 0.01, 7500, '2023-09-05', 23370, 3, 0.01, 3360000, -3359888, 'Baner', 1, 'احمد ', 3, 1, '-', 0, 1, 0, 45, '1', 37, 0, 1, 0, 80, 140, 'osman', 1),
(365, 2, 0.01, 55000, '2023-09-05', 23368, 3, 0.01, 600, -599.98, 'Baner', 1, 'احمد ', 3, 1, 'مكتبه المعلم بك', 0, 1, 0, 46, '1', 1, 0, 2, 0, 2, 1, 'محمـد', 2),
(366, 3.9, 0.01, 15500, '2023-09-05', 1087089.1, 5, 0.01, 850.1999999999999, -850.1610000000001, 'Flex', 1, 'احمد ', 5, 1, 'يس', 0, 1, 0, 47, '1', 1, 0, 1, 0, 3.9, 1, 'محمـد', 2),
(367, 112, 0.01, 7500, '2023-09-05', 1086977, 5, 0.01, 24416, -24414.88, 'Flex', 1, 'احمد ', 5, 1, 'اتصلات عبد الحليم', 0, 1, 0, 48, '1', 1, 0, 1, 0, 80, 1.4, 'محمـد', 2),
(368, 6.4, 0.01, 25600, '2023-09-05', 1086970.6, 5, 0.01, 1395.2, -1395.1360000000002, 'Flex', 1, 'احمد ', 5, 1, 'محمد ازهري', 0, 1, 0, 49, '1', 1, 0, 1, 0, 0.8, 8, 'محمـد', 2),
(369, 6.4, 0.01, 25600, '2023-09-05', 1086963.6, 5, 0.01, 1395.2, -1395.1360000000002, 'Flex', 1, 'احمد ', 5, 1, 'محمد ازهري', 0, 1, 0, 50, '1', 1, 0, 1, 0, 8, 0.8, 'محمـد', 2),
(370, 6, 0.01, 800, '2023-09-06', 23362, 3, 0.01, 1800, -1799.94, 'Baner', 1, 'احمد ', 3, 1, 'محمـد ازهري', 0, 1, 0, 51, '1', 1, 0, 4, 0, 2, 3, 'osman', 1),
(371, 3, 0.01, 400, '2023-09-09', 23359, 3, 0.01, 900, -899.97, 'Baner', 1, 'احمد ', 3, 1, 'محمـد ازهري', 0, 1, 0, 52, '1', 1, 0, 2, 0, 3, 1, 'osman', 1),
(372, 30, 0.01, 2000, '2023-09-09', 23329, 3, 0.01, 9000, -8999.7, 'Baner', 1, 'احمد ', 3, 1, 'محمـد ازهري', 0, 1, 0, 53, '1', 8, 0, 3, 0, 6, 5, 'osman', 1),
(373, 12, 0.01, 1111, '2023-09-09', 94775, 4, 0.01, 252, -251.88, 'Sticker', 1, 'احمد ', 4, 1, 'محمـد ازهري', 0, 1, 0, 54, '1', 9, 0, 2, 0, 3, 4, 'osman', 1),
(374, 12, 0.01, 3333, '2023-09-09', 100988, 6, 0.01, 21600, -21599.88, 'Mush', 1, 'احمد ', 6, 1, 'محمـد ازهري', 0, 1, 0, 55, '1', 34, 0, 7, 0, 4, 3, 'osman', 1),
(375, 4, 0.01, 4000, '2023-09-09', 1086959, 5, 0.01, 872, -871.96, 'Flex', 1, 'احمد ', 5, 1, 'محمـد ازهري1212', 0, 1, 0, 56, '1', 9, 0, 2, 0, 2, 2, 'osman123', 1),
(376, 4, 0.01, 1234, '2023-09-09', 1086955, 5, 0.01, 872, -871.96, 'Flex', 1, 'احمد ', 5, 1, 'محمـد ازهري333', 0, 1, 0, 57, '1', 33, 0, 2, 0, 2, 2, 'osman33', 1),
(377, 25, 0.01, 1.25, '2023-09-09', 23304, 3, 0.01, 7500, -7499.75, 'Baner', 1, 'احمد ', 3, 1, 'محمـد ازهري', 0, 1, 0, 58, '1', 1, 0, 5, 0, 5, 5, 'osman', 1),
(378, 6, 0.01, 1000, '2023-09-10', 94769, 4, 0.01, 126, -125.94, 'Sticker', 1, 'احمد ', 4, 1, 'محمـد ازهري', 0, 1, 0, 59, '1', 1, 0, 1, 0, 3, 2, 'osman', 1),
(379, 2, 0.01, 2000, '2023-09-10', 23302, 3, 0.01, 600, -599.98, 'Baner', 1, 'احمد ', 3, 1, 'محمـد ازهري', 1100, -900, 0, 60, '1', 1, 0, 3, 0, 2, 1, 'osman', 1),
(380, 9, 0.01, 3000, '2023-09-10', 94760, 4, 0.01, 189, -188.91, 'Sticker', 1, 'احمد ', 4, 1, 'محمـد ازهري', 1500, -1500, 0, 61, '1', 1, 0, 2, 0, 3, 3, 'osman', 1),
(381, 4, 0.01, 0.08, '2023-09-17', 23298, 3, 0.01, 1200, -1199.96, 'Baner', 1, 'احمد ', 3, 1, 'محمـد ازهري', 0, 0, 0, 62, '1', 1, 0, 2, 0, 2, 2, 'محمـد', 2),
(382, 4, 0.01, 0.08, '2023-09-17', 23294, 3, 0.01, 1200, -1199.96, 'Baner', 1, 'احمد ', 3, 1, 'محمـد ازهري', 0.08, 0, 0, 63, '1', 1, 0, 2, 0, 2, 2, 'محمـد', 1),
(383, 4, 0.01, 5000, '2023-09-17', 23290, 3, 0.01, 1200, -1199.96, 'Baner', 1, 'احمد ', 3, 1, 'محمـد ازهري', 5000, 0, 0, 64, '1', 1, 0, 3, 0, 2, 2, 'محمـد', 2),
(384, 4, 0.01, 5000, '2023-09-17', 94756, 4, 0.01, 84, -83.96, 'Sticker', 1, 'احمد ', 4, 1, 'محمـد ازهري', 3000, -2000, 0, 65, '1', 8, 0, 3, 0, 2, 2, 'محمـد', 1),
(385, 6, 0.01, 3000, '2023-09-17', 1086949, 5, 0.01, 1308, -1307.94, 'Flex', 1, 'احمد ', 5, 1, 'محمـد ازهري', 0, 0, 0, 66, '1', 1, 0, 5, 0, 3, 2, 'osman', 1),
(385, 20, 0.01, 4000, '2023-09-17', 100968, 6, 0.01, 36000, -35999.8, 'Mush', 1, 'احمد ', 6, 1, 'محمـد ازهري', 0, 0, 0, 67, '1', 1, 0, 6, 0, 5, 4, 'osman', 1),
(386, 25, 6000, 750000, '2023-09-18', 23265, 3, 6000, 7500, 142500, 'Baner', 1, 'احمد ', 3, 1, 'محمـد ازهري', 0, 0, 0, 68, '1', 1, 0, 5, 0, 5, 5, 'osman', 1),
(387, 100, 6000, 6000000, '2023-09-18', 23165, 3, 6000, 30000, 570000, 'Baner', 1, 'احمد ', 3, 1, 'محمـد ازهري', 0, 0, 0, 69, '1', 1, 0, 10, 0, 10, 10, 'osman', 1),
(388, 9801, 6000, 529254000, '2023-09-18', 13364, 3, 6000, 2940300, 55865700, 'Baner', 1, 'احمد ', 3, 1, 'محمـد ازهري', 0, 0, 0, 70, '1', 1, 0, 9, 0, 99, 99, 'osman', 1),
(389, 6, 6000, 36000, '2024-04-15', 13358, 3, 6000, 1800, 34200, 'Baner', 1, 'احمد ', 3, 1, 'محمـد ازهري', 0, 0, 0, 71, '1', 1, 0, 1, 0, 3, 2, 'osman', 1),
(390, 6, 10, 60, '2024-04-23', 44, 7, 10, 60, 0, 'item 2424', 1, 'احمد ', 7, 1, 'محمـد ازهري', 0, 0, 0, 72, '1', 1, 0, 1, 0, 3, 2, 'osman', 1),
(391, 0.15, 6000, 900, '2024-04-23', 13357.85, 3, 6000, 45, 855, 'Baner', 1, 'احمد ', 3, 1, 'محمـد ازهري', 0, 0, 0, 73, '1', 1, 0, 1, 0, 0.3, 0.5, 'osman', 1),
(392, 0.25, 555.56, 138.89, '2024-11-01', 8.75, 8, 555.56, 138.75, 0.13999999999998636, '2424', 1, 'احمد ', 8, 1, 'محمـد ازهري', 0, 0, 0, 74, '1', 1, 0, 1, 0, 0.5, 0.5, 'osman', 1);

-- --------------------------------------------------------

--
-- Table structure for table `saledets2`
--

CREATE TABLE IF NOT EXISTS `saledets2` (
  `FK` int(11) NOT NULL DEFAULT '1',
  `QTY` double NOT NULL DEFAULT '0',
  `UP` double NOT NULL DEFAULT '0',
  `TP` double NOT NULL DEFAULT '0',
  `GS` date DEFAULT NULL,
  `BALANCE` double NOT NULL DEFAULT '0',
  `BATCH` int(11) NOT NULL DEFAULT '0',
  `UC` double DEFAULT '0',
  `TC` double DEFAULT '0',
  `PROFIT` double DEFAULT '0',
  `item_name` varchar(50) DEFAULT NULL,
  `counter_no` int(11) NOT NULL DEFAULT '1',
  `user` varchar(11) NOT NULL DEFAULT 'user',
  `id` int(11) NOT NULL,
  `flag` int(11) NOT NULL DEFAULT '0',
  `waiter` varchar(50) NOT NULL DEFAULT '-',
  `room` varchar(30) NOT NULL DEFAULT '0',
  `roomflag` int(11) NOT NULL DEFAULT '1',
  `h1` int(11) NOT NULL DEFAULT '0',
  `tableid` int(11) NOT NULL AUTO_INCREMENT,
  `method` varchar(100) NOT NULL DEFAULT '-',
  `cno` int(11) NOT NULL DEFAULT '0',
  `wg` double NOT NULL DEFAULT '0',
  `order1` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tableid`),
  KEY `FK` (`FK`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `saledets2`
--

INSERT INTO `saledets2` (`FK`, `QTY`, `UP`, `TP`, `GS`, `BALANCE`, `BATCH`, `UC`, `TC`, `PROFIT`, `item_name`, `counter_no`, `user`, `id`, `flag`, `waiter`, `room`, `roomflag`, `h1`, `tableid`, `method`, `cno`, `wg`, `order1`) VALUES
(1, 1, 110000, 110000, '2023-04-01', 0, 0, 110000, 0, 0, 'تحضير واحد حصان ', 1, 'بابكر', 28, 1, '-', '0', 1, 0, 1, '1', 53, 0, 0),
(2, 1, 105000, 105000, '2023-06-17', 0, 0, 105000, 0, 0, 'تحضير واحد حصان ', 1, 'بابكر', 28, 1, '-', '0', 1, 0, 2, '1', 1, 0, 0),
(3, 10, 395000, 3950000, '2023-07-15', 0, 0, 395000, 0, 0, 'موتور نص حصان', 1, 'بابكر', 1, 1, '-', '0', 1, 0, 3, '1', 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE IF NOT EXISTS `sales` (
  `DEALER` int(11) DEFAULT NULL,
  `TOTAL` double DEFAULT NULL,
  `PAID` double DEFAULT NULL,
  `DEBIT` double DEFAULT NULL,
  `USR` varchar(10) DEFAULT NULL,
  `SHIFT` int(11) DEFAULT NULL,
  `CARD` varchar(16) DEFAULT NULL,
  `MON` int(11) DEFAULT NULL,
  `REV` int(11) DEFAULT NULL,
  `GS` date DEFAULT NULL,
  `TC` double DEFAULT NULL,
  `PROFIT` double DEFAULT NULL,
  `DISC` double DEFAULT NULL,
  `PP` char(10) DEFAULT NULL,
  `RR` double DEFAULT NULL,
  `FV` double DEFAULT NULL,
  `POSTED` int(11) DEFAULT NULL,
  `BALANCE` double DEFAULT NULL,
  `POSTEDBY` varchar(50) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DAT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flag` int(11) NOT NULL DEFAULT '0',
  `method` varchar(50) NOT NULL DEFAULT '-',
  `order1` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=393 ;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`DEALER`, `TOTAL`, `PAID`, `DEBIT`, `USR`, `SHIFT`, `CARD`, `MON`, `REV`, `GS`, `TC`, `PROFIT`, `DISC`, `PP`, `RR`, `FV`, `POSTED`, `BALANCE`, `POSTEDBY`, `id`, `DAT`, `flag`, `method`, `order1`) VALUES
(1, 3900, 3900, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-08-31', NULL, 3900, NULL, NULL, NULL, NULL, NULL, NULL, '', 343, '2023-08-31 08:47:45', 1, '1', 0),
(1, 7920, 7920, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-08-31', NULL, 7920, NULL, NULL, NULL, NULL, NULL, NULL, '', 344, '2023-08-31 09:35:59', 1, '1', 0),
(1, 1500, 1500, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-08-31', NULL, 1500, NULL, NULL, NULL, NULL, NULL, NULL, '', 345, '2023-08-31 11:12:28', 1, '1', 0),
(1, 16800, 16800, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-03', NULL, 16800, NULL, NULL, NULL, NULL, NULL, NULL, '', 346, '2023-09-03 14:59:20', 1, '1', 0),
(1, 15600, 15600, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-03', NULL, 15600, NULL, NULL, NULL, NULL, NULL, NULL, '', 347, '2023-09-03 15:01:01', 1, '1', 0),
(1, 20800, 20800, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-03', NULL, 20800, NULL, NULL, NULL, NULL, NULL, NULL, '', 348, '2023-09-03 15:40:18', 1, '1', 0),
(1, 1350, 1350, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-03', NULL, 1350, NULL, NULL, NULL, NULL, NULL, NULL, '', 349, '2023-09-03 16:41:08', 1, '1', 0),
(1, 12155, 12155, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-03', NULL, 12155, NULL, NULL, NULL, NULL, NULL, NULL, '', 350, '2023-09-03 17:16:35', 1, '1', 0),
(1, 33170, 33170, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-03', NULL, 33170, NULL, NULL, NULL, NULL, NULL, NULL, '', 351, '2023-09-03 17:39:13', 1, '1', 0),
(1, 538500, 538500, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-03', NULL, 538500, NULL, NULL, NULL, NULL, NULL, NULL, '', 352, '2023-09-03 18:11:38', 1, '1', 0),
(1, 70000000, 70000000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-04', NULL, 70000000, NULL, NULL, NULL, NULL, NULL, NULL, '', 353, '2023-09-04 13:05:49', 1, '1', 0),
(1, 10537.65, 10537.65, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-04', NULL, 10537.65, NULL, NULL, NULL, NULL, NULL, NULL, '', 354, '2023-09-04 14:22:28', 1, '1', 0),
(1, 8000, 8000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 8000, NULL, NULL, NULL, NULL, NULL, NULL, '', 355, '2023-09-05 13:18:32', 1, '1', 0),
(1, 150, 150, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 150, NULL, NULL, NULL, NULL, NULL, NULL, '', 356, '2023-09-05 13:31:41', 1, '1', 0),
(1, 8000, 8000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 8000, NULL, NULL, NULL, NULL, NULL, NULL, '', 357, '2023-09-05 13:37:12', 1, '1', 0),
(1, 3500, 3500, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 3500, NULL, NULL, NULL, NULL, NULL, NULL, '', 358, '2023-09-05 13:46:12', 1, '1', 0),
(1, 11500, 11500, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 11500, NULL, NULL, NULL, NULL, NULL, NULL, '', 359, '2023-09-05 13:58:44', 1, '1', 0),
(1, 10500, 10500, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 10500, NULL, NULL, NULL, NULL, NULL, NULL, '', 360, '2023-09-05 14:05:31', 1, '1', 0),
(1, 10000, 10000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 10000, NULL, NULL, NULL, NULL, NULL, NULL, '', 361, '2023-09-05 14:27:18', 1, '1', 0),
(1, 13000, 13000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 13000, NULL, NULL, NULL, NULL, NULL, NULL, '', 362, '2023-09-05 14:30:28', 1, '1', 0),
(1, 10000, 10000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 10000, NULL, NULL, NULL, NULL, NULL, NULL, '', 363, '2023-09-05 14:33:00', 1, '1', 0),
(1, 7500, 7500, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 7500, NULL, NULL, NULL, NULL, NULL, NULL, '', 364, '2023-09-05 14:50:32', 1, '1', 0),
(1, 55000, 55000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 55000, NULL, NULL, NULL, NULL, NULL, NULL, '', 365, '2023-09-05 15:15:45', 1, '1', 0),
(1, 15500, 15500, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 15500, NULL, NULL, NULL, NULL, NULL, NULL, '', 366, '2023-09-05 15:25:48', 1, '1', 0),
(1, 7500, 7500, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 7500, NULL, NULL, NULL, NULL, NULL, NULL, '', 367, '2023-09-05 15:29:00', 1, '1', 0),
(1, 25600, 25600, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 25600, NULL, NULL, NULL, NULL, NULL, NULL, '', 368, '2023-09-05 15:32:27', 1, '1', 0),
(1, 25600, 25600, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-05', NULL, 25600, NULL, NULL, NULL, NULL, NULL, NULL, '', 369, '2023-09-05 15:34:10', 1, '1', 0),
(1, 800, 800, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-06', NULL, 800, NULL, NULL, NULL, NULL, NULL, NULL, '', 370, '2023-09-06 11:05:00', 1, '1', 0),
(1, 400, 400, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-09', NULL, 400, NULL, NULL, NULL, NULL, NULL, NULL, '', 371, '2023-09-09 10:29:01', 1, '1', 0),
(1, 2000, 2000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-09', NULL, 2000, NULL, NULL, NULL, NULL, NULL, NULL, '', 372, '2023-09-09 10:29:20', 1, '1', 0),
(1, 1111, 1111, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-09', NULL, 1111, NULL, NULL, NULL, NULL, NULL, NULL, '', 373, '2023-09-09 10:59:19', 1, '1', 0),
(1, 3333, 3333, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-09', NULL, 3333, NULL, NULL, NULL, NULL, NULL, NULL, '', 374, '2023-09-09 10:59:40', 1, '1', 0),
(1, 4000, 4000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-09', NULL, 4000, NULL, NULL, NULL, NULL, NULL, NULL, '', 375, '2023-09-09 11:00:24', 1, '1', 0),
(1, 1234, 1234, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-09', NULL, 1234, NULL, NULL, NULL, NULL, NULL, NULL, '', 376, '2023-09-09 11:01:09', 1, '1', 0),
(1, 1.25, 1.25, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-09', NULL, 1.25, NULL, NULL, NULL, NULL, NULL, NULL, '', 377, '2023-09-09 16:50:14', 1, '1', 0),
(1, 1000, 1000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-10', NULL, 1000, NULL, NULL, NULL, NULL, NULL, NULL, '', 378, '2023-09-10 06:06:43', 1, '1', 0),
(1, 2000, 2000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-10', NULL, 2000, NULL, NULL, NULL, NULL, NULL, NULL, '', 379, '2023-09-10 06:49:52', 1, '1', 0),
(1, 3000, 3000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-10', NULL, 3000, NULL, NULL, NULL, NULL, NULL, NULL, '', 380, '2023-09-10 07:55:52', 1, '1', 0),
(1, 0.08, 0.08, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-17', NULL, 0.08, NULL, NULL, NULL, NULL, NULL, NULL, '', 381, '2023-09-17 11:45:21', 1, '1', 0),
(1, 0.08, 0.08, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-17', NULL, 0.08, NULL, NULL, NULL, NULL, NULL, NULL, '', 382, '2023-09-17 12:02:15', 1, '1', 0),
(1, 5000, 5000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-17', NULL, 5000, NULL, NULL, NULL, NULL, NULL, NULL, '', 383, '2023-09-17 18:35:21', 1, '1', 0),
(1, 5000, 5000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-17', NULL, 5000, NULL, NULL, NULL, NULL, NULL, NULL, '', 384, '2023-09-17 19:03:42', 1, '1', 0),
(1, 7000, 7000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-17', NULL, 7000, NULL, NULL, NULL, NULL, NULL, NULL, '', 385, '2023-09-17 19:26:06', 1, '1', 0),
(1, 750000, 750000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-18', NULL, 750000, NULL, NULL, NULL, NULL, NULL, NULL, '', 386, '2023-09-18 10:45:58', 1, '1', 0),
(1, 6000000, 6000000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-18', NULL, 6000000, NULL, NULL, NULL, NULL, NULL, NULL, '', 387, '2023-09-18 10:46:45', 1, '1', 0),
(1, 529254000, 529254000, 0, 'احمد ', 1, NULL, NULL, NULL, '2023-09-18', NULL, 529254000, NULL, NULL, NULL, NULL, NULL, NULL, '', 388, '2023-09-18 10:47:09', 1, '1', 0),
(1, 36000, 36000, 0, 'احمد ', 1, NULL, NULL, NULL, '2024-04-15', NULL, 36000, NULL, NULL, NULL, NULL, NULL, NULL, '', 389, '2024-04-15 21:05:13', 1, '1', 0),
(1, 60, 60, 0, 'احمد ', 1, NULL, NULL, NULL, '2024-04-23', NULL, 60, NULL, NULL, NULL, NULL, NULL, NULL, '', 390, '2024-04-23 13:18:43', 1, '1', 0),
(1, 900, 900, 0, 'احمد ', 1, NULL, NULL, NULL, '2024-04-23', NULL, 900, NULL, NULL, NULL, NULL, NULL, NULL, '', 391, '2024-04-23 13:20:37', 1, '1', 0),
(1, 138.89, 138.89, 0, 'احمد ', 1, NULL, NULL, NULL, '2024-11-01', NULL, 138.89, NULL, NULL, NULL, NULL, NULL, NULL, '', 392, '2024-11-01 10:49:22', 1, '1', 0);

-- --------------------------------------------------------

--
-- Table structure for table `sales2`
--

CREATE TABLE IF NOT EXISTS `sales2` (
  `DEALER` int(11) DEFAULT NULL,
  `TOTAL` double DEFAULT NULL,
  `PAID` double DEFAULT NULL,
  `DEBIT` double DEFAULT NULL,
  `USR` varchar(10) DEFAULT NULL,
  `SHIFT` int(11) DEFAULT NULL,
  `CARD` varchar(16) DEFAULT NULL,
  `MON` int(11) DEFAULT NULL,
  `REV` int(11) DEFAULT NULL,
  `GS` date DEFAULT NULL,
  `TC` double DEFAULT NULL,
  `PROFIT` double DEFAULT NULL,
  `DISC` double DEFAULT NULL,
  `PP` char(10) DEFAULT NULL,
  `RR` double DEFAULT NULL,
  `FV` double DEFAULT NULL,
  `POSTED` int(11) DEFAULT NULL,
  `BALANCE` double DEFAULT NULL,
  `POSTEDBY` varchar(50) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DAT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flag` int(11) NOT NULL DEFAULT '0',
  `method` varchar(50) NOT NULL DEFAULT '-',
  `order1` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `sales2`
--

INSERT INTO `sales2` (`DEALER`, `TOTAL`, `PAID`, `DEBIT`, `USR`, `SHIFT`, `CARD`, `MON`, `REV`, `GS`, `TC`, `PROFIT`, `DISC`, `PP`, `RR`, `FV`, `POSTED`, `BALANCE`, `POSTEDBY`, `id`, `DAT`, `flag`, `method`, `order1`) VALUES
(1, 110000, 110000, 0, 'بابكر', 1, NULL, NULL, NULL, '2023-04-01', NULL, 110000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2023-04-01 09:09:39', 1, '1', 0),
(1, 105000, 105000, 0, 'بابكر', 1, NULL, NULL, NULL, '2023-06-17', NULL, 105000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, '2023-06-17 14:04:55', 1, '1', 0),
(1, 3950000, 3950000, 0, 'بابكر', 1, NULL, NULL, NULL, '2023-07-15', NULL, 3950000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, '2023-07-15 09:10:34', 1, '1', 0);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE IF NOT EXISTS `services` (
  `ServiceID` int(11) NOT NULL AUTO_INCREMENT,
  `ServiceName` varchar(250) NOT NULL,
  `ServiceDate` varchar(50) NOT NULL,
  `PatientID` varchar(50) NOT NULL,
  `ServiceCharges` int(11) NOT NULL,
  `piad` bigint(20) DEFAULT NULL,
  `paid` bigint(20) DEFAULT NULL,
  `advances` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ServiceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `servicesset`
--

CREATE TABLE IF NOT EXISTS `servicesset` (
  `basicprice` double NOT NULL DEFAULT '0',
  `name` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '-',
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE IF NOT EXISTS `setting` (
  `prfit_percent` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE IF NOT EXISTS `shifts` (
  `user` varchar(50) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `cash` double DEFAULT NULL,
  `dif` double DEFAULT NULL,
  `fr` double DEFAULT NULL,
  `finvoice` bigint(20) DEFAULT NULL,
  `linvoice` bigint(20) DEFAULT NULL,
  `edate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `flag` varchar(10) DEFAULT NULL,
  `stime` varchar(20) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `shifts`
--

INSERT INTO `shifts` (`user`, `total`, `cash`, `dif`, `fr`, `finvoice`, `linvoice`, `edate`, `flag`, `stime`, `id`) VALUES
('احمد ', NULL, NULL, NULL, NULL, 1, NULL, '0000-00-00 00:00:00', '0', '2023-03-05 12:31:35', 1);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE IF NOT EXISTS `staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '-',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `name`) VALUES
(1, 'osman'),
(2, 'محمـد');

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE IF NOT EXISTS `store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `store`
--

INSERT INTO `store` (`id`, `name`) VALUES
(1, 'المعرض'),
(2, 'طلمبات المعرض الخرطوم');

-- --------------------------------------------------------

--
-- Table structure for table `storerecord`
--

CREATE TABLE IF NOT EXISTS `storerecord` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL,
  `item_name` varchar(50) DEFAULT NULL,
  `qnt` double DEFAULT NULL,
  `fromstore` bigint(20) DEFAULT NULL,
  `tostore` bigint(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `submain`
--

CREATE TABLE IF NOT EXISTS `submain` (
  `ID` int(11) DEFAULT NULL,
  `SUBMAIN_NO` decimal(6,0) NOT NULL,
  `SUBMAIN_NAME` varchar(24) NOT NULL,
  `SUBMAIN_MAIN_NO` decimal(6,0) DEFAULT NULL,
  `SUBMAIN_STATUS` int(11) DEFAULT '0',
  PRIMARY KEY (`SUBMAIN_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `submain`
--

INSERT INTO `submain` (`ID`, `SUBMAIN_NO`, `SUBMAIN_NAME`, `SUBMAIN_MAIN_NO`, `SUBMAIN_STATUS`) VALUES
(NULL, 1, 'bank1', 1, 1),
(NULL, 2, 'cash', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE IF NOT EXISTS `suppliers` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `supp_name` varchar(50) NOT NULL,
  `supp_debit` double NOT NULL DEFAULT '0',
  `supp_credit` double NOT NULL DEFAULT '0',
  `address` varchar(100) NOT NULL DEFAULT '-',
  `balance` double NOT NULL DEFAULT '0',
  `percent` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `supp_name`, `supp_debit`, `supp_credit`, `address`, `balance`, `percent`) VALUES
(1, 'مورد 1', 0, 0, '-', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `supp_det`
--

CREATE TABLE IF NOT EXISTS `supp_det` (
  `name` varchar(50) DEFAULT NULL,
  `debit` double DEFAULT '0',
  `credit` double DEFAULT '0',
  `inv_no` varchar(20) DEFAULT '0',
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `notes` varchar(100) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `bank` varchar(50) DEFAULT NULL,
  `date_bank` date DEFAULT NULL,
  `shift` varchar(20) DEFAULT NULL,
  `user` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `supp_det`
--

INSERT INTO `supp_det` (`name`, `debit`, `credit`, `inv_no`, `id`, `notes`, `date`, `type`, `bank`, `date_bank`, `shift`, `user`) VALUES
('1', 650000, 0, '1', 1, NULL, '2023-08-31', NULL, NULL, NULL, NULL, NULL),
('1', 12000000, 0, '2', 2, NULL, '2023-08-31', NULL, NULL, NULL, NULL, NULL),
('1', 600000, 0, '3', 3, NULL, '2023-08-31', NULL, NULL, NULL, NULL, NULL),
('1', 650000, 0, '4', 4, NULL, '2023-08-31', NULL, NULL, NULL, NULL, NULL),
('1', 6500000, 0, '5', 5, NULL, '2023-08-31', NULL, NULL, NULL, NULL, NULL),
('1', 3600000, 0, '6', 6, NULL, '2023-08-31', NULL, NULL, NULL, NULL, NULL),
('1', 250000, 0, '7', 7, NULL, '2023-08-31', NULL, NULL, NULL, NULL, NULL),
('1', 1500, 0, '8', 8, NULL, '2023-09-03', NULL, NULL, NULL, NULL, NULL),
('1', 1595756, 0, '9', 9, NULL, '2023-09-03', NULL, NULL, NULL, NULL, NULL),
('1', 11351312, 0, '10', 10, NULL, '2023-09-03', NULL, NULL, NULL, NULL, NULL),
('1', 193396968, 0, '11', 11, NULL, '2023-09-03', NULL, NULL, NULL, NULL, NULL),
('1', 3001000, 0, '12', 12, NULL, '2023-09-04', NULL, NULL, NULL, NULL, NULL),
('1', 1000, 0, '13', 13, NULL, '2023-09-05', NULL, NULL, NULL, NULL, NULL),
('1', 2000, 0, '14', 14, NULL, '2023-09-05', NULL, NULL, NULL, NULL, NULL),
('1', 1000, 0, '15', 15, NULL, '2023-09-05', NULL, NULL, NULL, NULL, NULL),
('1', 1000, 0, '16', 16, NULL, '2023-09-05', NULL, NULL, NULL, NULL, NULL),
('1', 500, 0, '17', 17, NULL, '2024-04-23', NULL, NULL, NULL, NULL, NULL),
('1', 5000, 0, '18', 18, NULL, '2024-11-01', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sysyear`
--

CREATE TABLE IF NOT EXISTS `sysyear` (
  `SYSTEMYEAR` int(11) NOT NULL DEFAULT '2017',
  PRIMARY KEY (`SYSTEMYEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sysyear`
--

INSERT INTO `sysyear` (`SYSTEMYEAR`) VALUES
(2017);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE IF NOT EXISTS `units` (
  `unit_name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `unit_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`unit_name`, `unit_id`) VALUES
('حبة', 50),
('باكو', 51),
('كرتونه', 52),
('طن', 53);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `name` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `pass` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `level1` varchar(10) CHARACTER SET utf8 DEFAULT '0',
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `LEVEL2` varchar(10) CHARACTER SET utf8 DEFAULT '0',
  `level3` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `level4` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `level5` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `level6` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `level7` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `level8` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `level9` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `level10` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `level11` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `level12` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `level13` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `level14` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `level15` varchar(10) CHARACTER SET utf8 DEFAULT '0',
  `level16` varchar(10) CHARACTER SET utf8 DEFAULT '0',
  `level17` varchar(10) CHARACTER SET utf8 DEFAULT '0',
  `level18` varchar(10) CHARACTER SET utf8 DEFAULT '0',
  `level19` varchar(10) CHARACTER SET utf8 DEFAULT '0',
  `level20` varchar(10) CHARACTER SET utf8 DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`name`, `pass`, `level1`, `id`, `LEVEL2`, `level3`, `level4`, `level5`, `level6`, `level7`, `level8`, `level9`, `level10`, `level11`, `level12`, `level13`, `level14`, `level15`, `level16`, `level17`, `level18`, `level19`, `level20`) VALUES
('احمد ', '1', '1', 3, '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0', '1', '1', '1', '0'),
('mohamed', '99', '0', 4, '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

-- --------------------------------------------------------

--
-- Table structure for table `yeartopno`
--

CREATE TABLE IF NOT EXISTS `yeartopno` (
  `TOPNO` int(11) NOT NULL DEFAULT '0',
  `SYSYEAR` int(11) NOT NULL DEFAULT '2017'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `yeartopno`
--

INSERT INTO `yeartopno` (`TOPNO`, `SYSYEAR`) VALUES
(1, 2017);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `batches`
--
ALTER TABLE `batches`
  ADD CONSTRAINT `batches_ibfk_1` FOREIGN KEY (`invoice_no`) REFERENCES `purchases` (`invoice_no`);

--
-- Constraints for table `inveqdet`
--
ALTER TABLE `inveqdet`
  ADD CONSTRAINT `inveqdet_ibfk_1` FOREIGN KEY (`id`) REFERENCES `inveq` (`id`);

--
-- Constraints for table `purchases_det`
--
ALTER TABLE `purchases_det`
  ADD CONSTRAINT `purchases_det_ibfk_1` FOREIGN KEY (`invoice_no`) REFERENCES `purchases` (`invoice_no`);

--
-- Constraints for table `refund_det`
--
ALTER TABLE `refund_det`
  ADD CONSTRAINT `refund_det_ibfk_1` FOREIGN KEY (`refund_id`) REFERENCES `refund` (`refund_id`);

--
-- Constraints for table `saledets2`
--
ALTER TABLE `saledets2`
  ADD CONSTRAINT `saledets2_ibfk_1` FOREIGN KEY (`FK`) REFERENCES `sales2` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
