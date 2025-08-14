-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2025 at 01:07 PM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `posall`
--

-- --------------------------------------------------------

--
-- Table structure for table `balancesheet`
--

CREATE TABLE IF NOT EXISTS `balancesheet` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(4) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `ACCOUNTNAME` varchar(50) NOT NULL,
  `sdgtotal` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `balancesheet`
--

INSERT INTO `balancesheet` (`id`, `serial`, `amount`, `ACCOUNTNAME`, `sdgtotal`) VALUES
(3, '1', 11621873, 'الأصول المتداولة', NULL),
(4, NULL, NULL, 'جملة الاصول  ', 11621873);

-- --------------------------------------------------------

--
-- Table structure for table `band`
--

CREATE TABLE IF NOT EXISTS `band` (
  `BAND_NO` decimal(6,0) NOT NULL,
  `BAND_NAME` varchar(24) CHARACTER SET utf8 NOT NULL,
  `BAND_TYPE` varchar(24) CHARACTER SET utf32 NOT NULL,
  `root_no` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`BAND_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `band`
--

INSERT INTO `band` (`BAND_NO`, `BAND_NAME`, `BAND_TYPE`, `root_no`) VALUES
(1, 'الاصول', 'الاصول', 1),
(2, 'الخصوم', 'الخصوم', 2),
(3, 'الايرادات', 'الايرادات', 3),
(4, 'المصروفات', 'المصروفات', 4),
(5, 'حقوق المكلية', 'حقوق الملكية', 5);

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
-- Table structure for table `banking`
--

CREATE TABLE IF NOT EXISTS `banking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reqno` int(11) NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT '0',
  `cdate` date DEFAULT NULL,
  `type` varchar(100) NOT NULL DEFAULT '-',
  `notes` varchar(300) NOT NULL DEFAULT '-',
  `voucher` int(11) NOT NULL DEFAULT '0',
  `typename` varchar(20) NOT NULL DEFAULT 'مصروفات بنكية',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `bankingitem`
--

CREATE TABLE IF NOT EXISTS `bankingitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '-',
  `price` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `bankingitem`
--

INSERT INTO `bankingitem` (`id`, `name`, `price`) VALUES
(1, 'مصروف بنكي', 0),
(2, 'مصروف بنكي 1', 0);

-- --------------------------------------------------------

--
-- Table structure for table `bank_det`
--

CREATE TABLE IF NOT EXISTS `bank_det` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `bank_det`
--

INSERT INTO `bank_det` (`id`, `date`) VALUES
(1, '2025-07-03');

-- --------------------------------------------------------

--
-- Table structure for table `barcode`
--

CREATE TABLE IF NOT EXISTS `barcode` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(200) DEFAULT NULL,
  `code` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `barcode`
--

INSERT INTO `barcode` (`id`, `item_id`, `code`) VALUES
(1, 1, NULL),
(2, 2, NULL),
(3, 3, NULL),
(4, 4, NULL);

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
  `store` int(11) NOT NULL DEFAULT '1',
  `wg` double NOT NULL DEFAULT '0',
  `serial_no` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  PRIMARY KEY (`serial`),
  KEY `invoice_no` (`invoice_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `batches`
--

INSERT INTO `batches` (`item`, `expiry`, `quantity`, `serial`, `item_id`, `invoice_no`, `store`, `wg`, `serial_no`) VALUES
('خدمة 1', '2025-06-12', 10000000, 1, 3, 1, 1, 0, '0'),
('صنف1', '2025-06-13', 18, 2, 1, 1, 1, 0, '0'),
('خدمة 3', '2025-06-16', 10000000, 3, 3, 1, 1, 0, '0'),
('دولاب مكتب ', '2025-06-25', 6, 4, 4, 1, 1, 0, '0');

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE IF NOT EXISTS `class` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`id`, `class_name`) VALUES
(11, 'class 1'),
(12, 'class 2');

-- --------------------------------------------------------

--
-- Table structure for table `clearing`
--

CREATE TABLE IF NOT EXISTS `clearing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reqno` int(11) NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT '0',
  `cdate` date DEFAULT NULL,
  `type` varchar(100) NOT NULL DEFAULT '-',
  `notes` varchar(300) NOT NULL DEFAULT '-',
  `voucher` int(11) NOT NULL DEFAULT '0',
  `typename` varchar(20) NOT NULL DEFAULT 'مصروفات تخليص',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `clearingitem`
--

CREATE TABLE IF NOT EXISTS `clearingitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '-',
  `price` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `clearingitem`
--

INSERT INTO `clearingitem` (`id`, `name`, `price`) VALUES
(1, 'جودة', 0),
(2, 'اذن تسليم', 0),
(3, 'موف مواني', 0),
(4, 'فاتورة المواني', 0);

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE IF NOT EXISTS `company` (
  `address` varchar(400) CHARACTER SET utf8 DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `TEL` varchar(50) DEFAULT NULL,
  `NAME` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `percent` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dollarprice` double NOT NULL DEFAULT '1',
  `dollarprice2` double NOT NULL DEFAULT '1',
  `tel2` varchar(30) NOT NULL DEFAULT '-',
  `tel3` varchar(30) NOT NULL DEFAULT '-',
  `location` varchar(50) NOT NULL DEFAULT '-',
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`address`, `EMAIL`, `TEL`, `NAME`, `percent`, `id`, `dollarprice`, `dollarprice2`, `tel2`, `tel3`, `location`) VALUES
('ولاية الجزيرة              مدني                 تلفونات 000000000   -  1111111111', '-', '-', 'qre', 0, 1, 1, 1, '-', '1000023568974', '-');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
  `schno` int(11) DEFAULT '1',
  `status` varchar(30) DEFAULT '1',
  `paycount` int(11) DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `desc1` varchar(10) NOT NULL DEFAULT 'سداد',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `cust_det`
--

INSERT INTO `cust_det` (`id`, `name`, `debit`, `credit`, `inv_no`, `notes`, `card`, `type`, `bank`, `date_bank`, `date`, `shift`, `user`, `schno`, `status`, `paycount`, `duedate`, `desc1`) VALUES
(1, '1', 0, 7500.2, '1', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-16', '3', '5', 1, '1', NULL, NULL, 'سداد'),
(2, '8', 0, 13500.2, '2', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-17', '3', '5', 1, '1', NULL, NULL, 'سداد'),
(3, '10', 0, 600000, '3', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-25', '3', '5', 1, '1', NULL, NULL, 'سداد'),
(4, '9', 0, 600000, '4', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-25', '3', '5', 1, '1', NULL, NULL, 'سداد');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=76 ;

--
-- Dumping data for table `cust_det2`
--

INSERT INTO `cust_det2` (`id`, `name`, `debit`, `credit`, `inv_no`, `notes`, `card`, `type`, `bank`, `date_bank`, `date`, `shift`, `user`, `schno`, `status`, `paycount`, `duedate`) VALUES
(64, '8', 0, 7500.2, '1', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-13', '3', '1', NULL, NULL, NULL, NULL),
(65, '1', 0, 7500.2, '1', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-13', '3', '1', NULL, NULL, NULL, NULL),
(66, '8', 0, 7500.2, '1', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-13', '3', '1', NULL, NULL, NULL, NULL),
(67, '1', 0, 8000, '1', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-16', '3', '1', NULL, NULL, NULL, NULL),
(68, '1', 0, 12200.2, '1', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-16', '3', '1', NULL, NULL, NULL, NULL),
(69, '5', 0, 7500.2, '1', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-16', '3', '1', NULL, NULL, NULL, NULL),
(70, '1', 0, 0, '1', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-16', '3', '1', NULL, NULL, NULL, NULL),
(71, '1', 0, 7500.2, '1', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-16', '3', '1', NULL, NULL, NULL, NULL),
(72, '1', 0, 45555, '3', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-25', '3', '1', NULL, NULL, NULL, NULL),
(73, '10', 0, 600000, '3', 'مبيعات', 0, NULL, NULL, NULL, '2025-06-25', '3', '1', NULL, NULL, NULL, NULL),
(74, '1', 0, 600000, '5', 'مبيعات', 0, NULL, NULL, NULL, '2025-07-03', '3', '1', NULL, NULL, NULL, NULL),
(75, '1', 0, 600000, '5', 'مبيعات', 0, NULL, NULL, NULL, '2025-07-03', '3', '1', NULL, NULL, NULL, NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `groupname`
--

CREATE TABLE IF NOT EXISTS `groupname` (
  `groupname` varchar(100) NOT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`groupname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groupname`
--

INSERT INTO `groupname` (`groupname`, `price`) VALUES
('', 60);

-- --------------------------------------------------------

--
-- Table structure for table `income`
--

CREATE TABLE IF NOT EXISTS `income` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial` varchar(3) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL,
  `sdg` varchar(20) DEFAULT NULL,
  `sdgtotal` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=72 ;

--
-- Dumping data for table `income`
--

INSERT INTO `income` (`id`, `serial`, `account`, `sdg`, `sdgtotal`) VALUES
(66, '1', 'الايرادات', '1.1638975E7', ' '),
(67, '', 'اجمالي الايرادات', ' ', '1.1638975E7'),
(68, '3', 'المصروفات', '15000.0', ' '),
(69, '4', 'تكلفة المشتريات', '2102.0', ' '),
(70, '', 'جملة المصروفات', ' ', '17102.0'),
(71, '', 'صافي الربح', ' ', '1.1621873E7');

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
  `item_supplier` varchar(100) NOT NULL DEFAULT '-',
  `item_class` varchar(100) NOT NULL DEFAULT '-',
  `item_unitp` varchar(50) NOT NULL DEFAULT '-',
  `item_units` varchar(50) NOT NULL DEFAULT '-',
  `item_packp` int(11) DEFAULT NULL,
  `item_packs` varchar(50) DEFAULT NULL,
  `item_avgcost` double DEFAULT '0',
  `item_lprice` double DEFAULT '0',
  `item_hcost` double DEFAULT '0',
  `item_profitr` int(11) DEFAULT '0',
  `item_secprice` double DEFAULT '0',
  `item_wprice` double DEFAULT '0',
  `item_source` varchar(50) DEFAULT '0',
  `item_store` varchar(50) DEFAULT '0',
  `item_max` double NOT NULL DEFAULT '1',
  `item_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_qnt` double DEFAULT NULL,
  `item_min` bigint(20) NOT NULL DEFAULT '0',
  `item_counter_no` int(11) NOT NULL DEFAULT '1',
  `wg` double NOT NULL DEFAULT '0',
  `paid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_name`, `item_scname`, `item_supplier`, `item_class`, `item_unitp`, `item_units`, `item_packp`, `item_packs`, `item_avgcost`, `item_lprice`, `item_hcost`, `item_profitr`, `item_secprice`, `item_wprice`, `item_source`, `item_store`, `item_max`, `item_id`, `item_qnt`, `item_min`, `item_counter_no`, `wg`, `paid`) VALUES
('صنف1', '', '-', 'class 1', 'جوال', '-', 0, 'منتج', 7500.2, 7500.2, 7500.2, 0, 7500.2, 0, '0', '', 1, 1, -2, 0, 1, 0, 0),
('خدمة 1', '', '-', 'class 1', 'عنصر', '-', 0, 'خدمة', 0, 0, 0, 0, 0, 0, '0', '', 2, 2, 0, 0, 1, 0, 0),
('خدمة 3', '', '-', 'class 1', 'جوال', '-', 0, 'خدمة', 0, 0, 0, 0, 0, 0, '0', '', 2, 3, -1, 0, 1, 0, 0),
('دولاب مكتب ', '', '-', 'c1', 'جوال', '-', 0, 'منتج', 50000, 50000, 50000, 0, 600000, 0, '0', '', 1, 4, -2, 0, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `journal`
--

CREATE TABLE IF NOT EXISTS `journal` (
  `ID` int(11) DEFAULT NULL,
  `JOURNAL_DATE` date NOT NULL,
  `JOURNAL_NO` decimal(6,0) NOT NULL,
  `JOURNAL_SUBMAIN_NO` decimal(6,0) NOT NULL,
  `JOURNAL_DOCNO` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `JOURNAL_DESC` varchar(200) CHARACTER SET utf8 NOT NULL,
  `JOURNAL_USER` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '-',
  `JOURNAL_DR` double DEFAULT NULL,
  `JOURNAL_CR` double DEFAULT NULL,
  `IDAUTO` int(11) NOT NULL AUTO_INCREMENT,
  `method` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `sale_inv` bigint(20) NOT NULL DEFAULT '0',
  `journal` int(11) NOT NULL DEFAULT '0',
  `stock` int(11) NOT NULL DEFAULT '0',
  `comid` int(11) NOT NULL DEFAULT '1',
  `costid` int(11) NOT NULL DEFAULT '1',
  `purchase_inv` int(11) NOT NULL DEFAULT '0',
  `remdate` date DEFAULT NULL,
  PRIMARY KEY (`IDAUTO`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `journal`
--

INSERT INTO `journal` (`ID`, `JOURNAL_DATE`, `JOURNAL_NO`, `JOURNAL_SUBMAIN_NO`, `JOURNAL_DOCNO`, `JOURNAL_DESC`, `JOURNAL_USER`, `JOURNAL_DR`, `JOURNAL_CR`, `IDAUTO`, `method`, `sale_inv`, `journal`, `stock`, `comid`, `costid`, `purchase_inv`, `remdate`) VALUES
(NULL, '2025-06-17', 32, 8, '1', 'قيمة مبيعات', '1', 13500.2, 0, 1, '0', 2, 0, 1, 1, 1, 0, NULL),
(NULL, '2025-06-17', 32, 2, '1', 'قيمة مبيعات', '1', 0, 13500.2, 2, 'كاش', 2, 0, 1, 1, 1, 0, NULL),
(NULL, '2025-06-25', 33, 9, '1', 'مشتريات', '1', 0, 400000, 3, '0', 0, 0, 0, 1, 1, 1, NULL),
(NULL, '2025-06-25', 33, 7, '1', 'مشتريات', '1', 400000, 0, 4, '0', 0, 0, 0, 1, 1, 1, NULL),
(NULL, '2025-06-25', 33, 10, '1', 'قيمة مبيعات', '1', 600000, 0, 5, '0', 3, 0, 1, 1, 1, 0, NULL),
(NULL, '2025-06-25', 33, 2, '1', 'قيمة مبيعات', '1', 0, 600000, 6, 'كاش', 3, 0, 1, 1, 1, 0, NULL),
(NULL, '2025-06-25', 34, 9, '1', 'قيمة مبيعات', '1', 600000, 0, 7, '0', 4, 0, 1, 1, 1, 0, NULL),
(NULL, '2025-06-25', 34, 2, '1', 'قيمة مبيعات', '1', 0, 600000, 8, 'كاش', 4, 0, 1, 1, 1, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `main`
--

CREATE TABLE IF NOT EXISTS `main` (
  `MAIN_NO` int(11) NOT NULL AUTO_INCREMENT,
  `MAIN_BAND_NO` int(11) DEFAULT NULL,
  `band_id` int(11) DEFAULT NULL,
  `MAIN_NAME` varchar(255) NOT NULL,
  `code` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`MAIN_NO`),
  KEY `subband_id` (`MAIN_BAND_NO`),
  KEY `band_id` (`band_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `main`
--

INSERT INTO `main` (`MAIN_NO`, `MAIN_BAND_NO`, `band_id`, `MAIN_NAME`, `code`) VALUES
(1, 2, NULL, 'البنوك', NULL),
(2, 2, NULL, 'الخزن', NULL),
(3, 2, NULL, 'العملاء', NULL),
(4, 9, NULL, 'المصروفات', NULL),
(5, 6, NULL, 'الايرادات', NULL),
(11, 2, NULL, 'العمال', NULL),
(12, 9, NULL, 'المنصرفات', NULL),
(13, 10, NULL, 'تكلفة المشتريات', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `operation`
--

CREATE TABLE IF NOT EXISTS `operation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reqno` int(11) NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT '0',
  `cdate` date DEFAULT NULL,
  `type` varchar(100) NOT NULL DEFAULT '-',
  `notes` varchar(300) NOT NULL DEFAULT '-',
  `voucher` int(11) NOT NULL DEFAULT '0',
  `typename` varchar(20) NOT NULL DEFAULT 'مصروفات تشغيل',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `operationitem`
--

CREATE TABLE IF NOT EXISTS `operationitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '-',
  `price` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `operationitem`
--

INSERT INTO `operationitem` (`id`, `name`, `price`) VALUES
(1, 'ترحيل', 0),
(2, 'تخزين', 0);

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
  `cudate` date NOT NULL,
  `amount` double NOT NULL,
  `desc` varchar(80) NOT NULL,
  `debit` double NOT NULL,
  `credit` double NOT NULL,
  `user` varchar(50) NOT NULL DEFAULT 'user',
  `shift` int(11) NOT NULL,
  `accid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `pr`
--

CREATE TABLE IF NOT EXISTS `pr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(100) NOT NULL DEFAULT '-',
  `qty` double NOT NULL DEFAULT '0',
  `qtyvalue` double NOT NULL DEFAULT '0',
  `cdate` date DEFAULT NULL,
  `notes` varchar(200) NOT NULL DEFAULT '-',
  `qtyrec` double NOT NULL DEFAULT '0',
  `qtyrecvalue` double NOT NULL DEFAULT '0',
  `supp` varchar(50) NOT NULL DEFAULT '-',
  `supp_id` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `pr`
--

INSERT INTO `pr` (`id`, `item`, `qty`, `qtyvalue`, `cdate`, `notes`, `qtyrec`, `qtyrecvalue`, `supp`, `supp_id`, `item_id`) VALUES
(1, 'item 1', 10, 10000, '2024-09-23', '', 6, 36, 'supp1', 1, 1);

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
-- Table structure for table `pur`
--

CREATE TABLE IF NOT EXISTS `pur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` date DEFAULT NULL,
  `supp_id` int(11) NOT NULL DEFAULT '0',
  `supp_name` varchar(100) NOT NULL DEFAULT '-',
  `desc1` varchar(100) NOT NULL DEFAULT '-',
  `qty` double NOT NULL DEFAULT '0',
  `price` double NOT NULL DEFAULT '0',
  `notes` varchar(100) NOT NULL DEFAULT '-',
  `method` varchar(50) NOT NULL DEFAULT '-',
  `opbnkk` varchar(50) NOT NULL DEFAULT '-',
  `other` varchar(50) NOT NULL DEFAULT '-',
  `date` varchar(100) NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`invoice_no`, `item_total_price`, `item_suplier`, `item_discount`, `item_exchange_rate`, `item_date`, `confirm`, `store`, `shift`) VALUES
(1, 400000, '9', 0, NULL, '2025-06-25', '0', 1, 0);

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
  `item_scname` varchar(60) NOT NULL DEFAULT '',
  `shift` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL DEFAULT '0',
  `wg` double NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pr` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `invoice_no` (`invoice_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `purchases_det`
--

INSERT INTO `purchases_det` (`item_name`, `item_qty`, `item_bouns`, `item_exp_date`, `item_pay_unit`, `item_number`, `item_total`, `item_sale_unit`, `item_sale_unit_price`, `sale_price`, `invoice_no`, `item_scname`, `shift`, `item_id`, `wg`, `id`, `pr`) VALUES
('دولاب مكتب ', 8, NULL, '2025-06-25', NULL, 400000, NULL, NULL, NULL, 50000, 1, '', 0, 4, 0, 1, 0);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
  `re_date` date NOT NULL DEFAULT '0000-00-00',
  `cid` int(11) NOT NULL DEFAULT '0',
  `desc1` varchar(10) NOT NULL DEFAULT 'راجع',
  KEY `refund_id` (`refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `item_name` varchar(500) DEFAULT NULL,
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
  `ispaid` int(11) NOT NULL DEFAULT '1',
  `desc1` varchar(10) NOT NULL DEFAULT 'مبيعات',
  `refund` int(11) NOT NULL DEFAULT '0',
  `discount` double NOT NULL DEFAULT '0',
  `shift` int(11) NOT NULL DEFAULT '0',
  `paidval` double NOT NULL DEFAULT '0',
  `stock` int(11) NOT NULL DEFAULT '0',
  `serial_no` varchar(200) NOT NULL DEFAULT '0',
  `note` varchar(500) NOT NULL DEFAULT '-',
  PRIMARY KEY (`tableid`),
  KEY `FK` (`FK`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `saledets`
--

INSERT INTO `saledets` (`FK`, `QTY`, `UP`, `TP`, `GS`, `BALANCE`, `BATCH`, `UC`, `TC`, `PROFIT`, `item_name`, `counter_no`, `user`, `id`, `flag`, `waiter`, `room`, `roomflag`, `h1`, `tableid`, `method`, `cno`, `wg`, `order1`, `ispaid`, `desc1`, `refund`, `discount`, `shift`, `paidval`, `stock`, `serial_no`, `note`) VALUES
(1, 1, 7500.2, 7500.2, '2025-06-16', -1, 2, 7500.2, 7500, 0.1999999999998181, 'صنف1', 1, '5', 1, 1, '-', '0', 1, 0, 1, '1', 1, 0, 0, 1, 'مبيعات', 0, 0, 3, 7500.2, 1, '0', '-'),
(2, 1, 6000, 6000, '2025-06-17', -1, 1, 6000, 0, 6000, 'خدمة 3', 1, '5', 3, 1, '-', '0', 1, 0, 2, '1', 8, 0, 0, 1, 'مبيعات', 0, 0, 3, 13500.2, 1, '0', '-'),
(2, 1, 7500.2, 7500.2, '2025-06-17', -2, 2, 7500.2, 7500, 0.1999999999998181, 'صنف1', 1, '5', 1, 1, '-', '0', 1, 0, 3, '1', 8, 0, 0, 1, 'مبيعات', 0, 0, 3, 13500.2, 1, '0', '-'),
(3, 1, 600000, 600000, '2025-06-25', -1, 4, 600000, 50000, 550000, 'دولاب مكتب ', 1, '5', 4, 1, '-', '0', 1, 0, 4, '1', 10, 0, 0, 1, 'مبيعات', 0, 0, 3, 600000, 1, '0', '-'),
(4, 1, 600000, 600000, '2025-06-25', -2, 4, 600000, 50000, 550000, 'دولاب مكتب ', 1, '5', 4, 1, '-', '0', 1, 0, 5, '1', 9, 0, 0, 1, 'مبيعات', 0, 0, 3, 600000, 1, '0', '-');

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
  `item_name` varchar(250) DEFAULT NULL,
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
  `serial_no` varchar(200) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tableid`),
  KEY `FK` (`FK`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `saledets2`
--

INSERT INTO `saledets2` (`FK`, `QTY`, `UP`, `TP`, `GS`, `BALANCE`, `BATCH`, `UC`, `TC`, `PROFIT`, `item_name`, `counter_no`, `user`, `id`, `flag`, `waiter`, `room`, `roomflag`, `h1`, `tableid`, `method`, `cno`, `wg`, `order1`, `serial_no`) VALUES
(1, 1, 7500.2, 7500.2, '2025-06-13', 0, 0, 7500.2, 0, 0, 'صنف1', 1, '1', 1, 1, '-', '0', 1, 0, 1, '1', 8, 0, 0, '0'),
(2, 1, 7500.2, 7500.2, '2025-06-13', 0, 0, 7500.2, 0, 0, 'صنف1', 1, '1', 1, 1, '-', '0', 1, 0, 2, '1', 1, 0, 0, '0'),
(3, 1, 7500.2, 7500.2, '2025-06-13', 0, 0, 7500.2, 0, 0, 'صنف1', 1, '1', 1, 1, '-', '0', 1, 0, 3, '1', 8, 0, 0, '0'),
(4, 1, 8000, 8000, '2025-06-16', 0, 0, 8000, 0, 0, 'خدمة 3', 1, '1', 3, 1, '-', '0', 1, 0, 4, '1', 1, 0, 0, '0'),
(5, 1, 4700, 4700, '2025-06-16', 0, 0, 4700, 0, 0, 'خدمة 3', 1, '1', 3, 1, '-', '0', 1, 0, 5, '1', 1, 0, 0, '0'),
(5, 1, 7500.2, 7500.2, '2025-06-16', 0, 0, 7500.2, 0, 0, 'صنف1', 1, '1', 1, 1, '-', '0', 1, 0, 6, '1', 1, 0, 0, '0'),
(6, 1, 7500.2, 7500.2, '2025-06-16', 0, 0, 7500.2, 0, 0, 'صنف1', 1, '1', 1, 1, '-', '0', 1, 0, 7, '1', 5, 0, 0, '0'),
(7, 1, 0, 0, '2025-06-16', 0, 0, 0, 0, 0, 'خدمة 3', 1, '1', 3, 1, '-', '0', 1, 0, 8, '1', 1, 0, 0, '0'),
(8, 1, 7500.2, 7500.2, '2025-06-16', 0, 0, 7500.2, 0, 0, 'صنف1', 1, '1', 1, 1, '-', '0', 1, 0, 9, '1', 1, 0, 0, '0'),
(9, 1, 45555, 45555, '2025-06-25', 0, 0, 45555, 0, 0, 'خدمة 3', 1, '1', 3, 1, '-', '0', 1, 0, 10, '1', 1, 0, 0, '0'),
(10, 1, 600000, 600000, '2025-06-25', 0, 0, 600000, 0, 0, 'دولاب مكتب ', 1, '1', 4, 1, '-', '0', 1, 0, 11, '1', 10, 0, 0, '0'),
(11, 1, 600000, 600000, '2025-07-03', 0, 0, 600000, 0, 0, 'دولاب مكتب ', 1, '1', 4, 1, '-', '0', 1, 0, 12, '1', 1, 0, 0, '0'),
(12, 1, 600000, 600000, '2025-07-03', 0, 0, 600000, 0, 0, 'دولاب مكتب ', 1, '1', 4, 1, '-', '0', 1, 0, 13, '1', 1, 0, 0, '0');

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
  `POSTEDBY` varchar(500) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DAT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flag` int(11) NOT NULL DEFAULT '0',
  `method` varchar(50) NOT NULL DEFAULT '-',
  `order1` int(11) NOT NULL DEFAULT '0',
  `refund` int(11) NOT NULL DEFAULT '0',
  `ispaid` int(11) NOT NULL DEFAULT '1',
  `cno` int(11) NOT NULL DEFAULT '0',
  `stock` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`DEALER`, `TOTAL`, `PAID`, `DEBIT`, `USR`, `SHIFT`, `CARD`, `MON`, `REV`, `GS`, `TC`, `PROFIT`, `DISC`, `PP`, `RR`, `FV`, `POSTED`, `BALANCE`, `POSTEDBY`, `id`, `DAT`, `flag`, `method`, `order1`, `refund`, `ispaid`, `cno`, `stock`) VALUES
(1, 7500.2, 7500.2, 0, '1', 3, NULL, NULL, NULL, '2025-06-16', NULL, 7500.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-06-16 13:25:36', 1, '1', 0, 0, 1, 1, 1),
(1, 13500.2, 13500.2, 0, '1', 3, NULL, NULL, NULL, '2025-06-17', NULL, 13500.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, '2025-06-17 04:57:43', 1, '1', 0, 0, 1, 8, 1),
(1, 600000, 600000, 0, '1', 3, NULL, NULL, NULL, '2025-06-25', NULL, 600000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, '2025-06-25 11:29:34', 1, '1', 0, 0, 1, 10, 1),
(1, 600000, 600000, 0, '1', 3, NULL, NULL, NULL, '2025-06-25', NULL, 600000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, '2025-06-25 11:49:33', 1, '1', 0, 0, 1, 9, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `sales2`
--

INSERT INTO `sales2` (`DEALER`, `TOTAL`, `PAID`, `DEBIT`, `USR`, `SHIFT`, `CARD`, `MON`, `REV`, `GS`, `TC`, `PROFIT`, `DISC`, `PP`, `RR`, `FV`, `POSTED`, `BALANCE`, `POSTEDBY`, `id`, `DAT`, `flag`, `method`, `order1`) VALUES
(1, 7500.2, 7500.2, 0, '1', 3, NULL, NULL, NULL, '2025-06-13', NULL, 7500.2, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, '2025-06-13 08:13:33', 1, '1', 0),
(1, 7500.2, 7500.2, 0, '1', 3, NULL, NULL, NULL, '2025-06-13', NULL, 7500.2, NULL, NULL, NULL, NULL, NULL, NULL, '', 2, '2025-06-13 08:15:12', 1, '1', 0),
(1, 7500.2, 7500.2, 0, '1', 3, NULL, NULL, NULL, '2025-06-13', NULL, 7500.2, NULL, NULL, NULL, NULL, NULL, NULL, '', 3, '2025-06-13 08:15:22', 1, '1', 0),
(1, 8000, 8000, 0, '1', 3, NULL, NULL, NULL, '2025-06-16', NULL, 8000, NULL, NULL, NULL, NULL, NULL, NULL, '', 4, '2025-06-16 12:03:37', 1, '1', 0),
(1, 12200.2, 12200.2, 0, '1', 3, NULL, NULL, NULL, '2025-06-16', NULL, 12200.2, NULL, NULL, NULL, NULL, NULL, NULL, '', 5, '2025-06-16 13:21:00', 1, '1', 0),
(1, 7500.2, 7500.2, 0, '1', 3, NULL, NULL, NULL, '2025-06-16', NULL, 7500.2, NULL, NULL, NULL, NULL, NULL, NULL, '', 6, '2025-06-16 13:22:29', 1, '1', 0),
(1, 0, 0, 0, '1', 3, NULL, NULL, NULL, '2025-06-16', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 7, '2025-06-16 13:23:22', 1, '1', 0),
(1, 7500.2, 7500.2, 0, '1', 3, NULL, NULL, NULL, '2025-06-16', NULL, 7500.2, NULL, NULL, NULL, NULL, NULL, NULL, '', 8, '2025-06-16 13:25:31', 1, '1', 0),
(1, 45555, 45555, 0, '1', 3, NULL, NULL, NULL, '2025-06-25', NULL, 45555, NULL, NULL, NULL, NULL, NULL, NULL, '', 9, '2025-06-25 11:26:10', 1, '1', 0),
(1, 600000, 600000, 0, '1', 3, NULL, NULL, NULL, '2025-06-25', NULL, 600000, NULL, NULL, NULL, NULL, NULL, NULL, '', 10, '2025-06-25 11:29:09', 1, '1', 0),
(1, 600000, 600000, 0, '1', 3, NULL, NULL, NULL, '2025-07-03', NULL, 600000, NULL, NULL, NULL, NULL, NULL, NULL, '', 11, '2025-07-03 10:37:01', 1, '1', 0),
(1, 600000, 600000, 0, '1', 3, NULL, NULL, NULL, '2025-07-03', NULL, 600000, NULL, NULL, NULL, NULL, NULL, NULL, '', 12, '2025-07-03 10:49:33', 1, '1', 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `shifts`
--

INSERT INTO `shifts` (`user`, `total`, `cash`, `dif`, `fr`, `finvoice`, `linvoice`, `edate`, `flag`, `stime`, `id`) VALUES
('1', 1170954700, NULL, NULL, 0, 1, 901, '2024-11-26 01:35:14', '1', '2024-10-10 13:13:35', 1),
('1', 27807406.84, NULL, NULL, 0, 902, 65, '2025-03-18 19:49:33', '1', '2024-11-25 17:35:16', 2),
('1', NULL, NULL, NULL, NULL, 66, NULL, '0000-00-00 00:00:00', '0', '2025-03-18 21:53:36', 3);

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
(1, 'مخزن 1'),
(2, 'مخزن 2');

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
-- Table structure for table `subband`
--

CREATE TABLE IF NOT EXISTS `subband` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `subbno` int(11) NOT NULL,
  `subbname` varchar(50) CHARACTER SET utf32 NOT NULL,
  `subb_band_no` decimal(6,0) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `subband`
--

INSERT INTO `subband` (`id`, `subbno`, `subbname`, `subb_band_no`) VALUES
(1, 1, 'الأصول الثابتة', 1),
(2, 2, 'الأصول المتداولة', 1),
(3, 3, 'الأصول غير الملموسة', 1),
(4, 4, 'الخصوم المتداولة', 2),
(5, 5, 'الخصوم طويلة الأجل', 2),
(6, 6, 'إيرادات المبيعات', 3),
(7, 7, 'إيرادات الخدمات', 3),
(8, 8, 'الإيرادات الأخرى', 3),
(9, 9, 'المصروفات التشغيلية', 4),
(10, 10, 'المصروفات غير التشغيلية', 4),
(11, 11, 'رأس المال', 5),
(12, 12, 'الأرباح المحتجزة', 5),
(13, 13, 'الأسهم', 5),
(14, 14, 'إحتياطات', 5);

-- --------------------------------------------------------

--
-- Table structure for table `submain`
--

CREATE TABLE IF NOT EXISTS `submain` (
  `SUBMAIN_NO` decimal(6,0) NOT NULL,
  `SUBMAIN_NAME` varchar(100) CHARACTER SET utf8 NOT NULL,
  `SUBMAIN_MAIN_NO` decimal(6,0) DEFAULT NULL,
  `SUBMAIN_STATUS` int(11) DEFAULT '0',
  `cust_rate` double NOT NULL DEFAULT '0',
  `tel` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '-',
  `address` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '-',
  `company` varchar(500) CHARACTER SET utf8 NOT NULL DEFAULT '-',
  `id` int(11) DEFAULT NULL,
  PRIMARY KEY (`SUBMAIN_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `submain`
--

INSERT INTO `submain` (`SUBMAIN_NO`, `SUBMAIN_NAME`, `SUBMAIN_MAIN_NO`, `SUBMAIN_STATUS`, `cust_rate`, `tel`, `address`, `company`, `id`) VALUES
(1, 'الخزينة', 2, 0, 0, '-', '-', '-', NULL),
(2, 'ايرادات المبيعات', 5, 0, 0, '-', '-', '-', NULL),
(3, 'الخزينة الرئيسية', 2, 0, 0, '-', '-', '-', NULL),
(4, 'بنك 1', 1, 0, 0, '-', '-', '-', NULL),
(5, 'بنك 2', 1, 0, 0, '-', '-', '-', NULL),
(6, 'المخزن', 2, 0, 0, '-', '-', '-', NULL),
(7, 'تكلفة المشتريات', 13, 0, 0, '-', '-', '-', NULL),
(8, 'عميل 1', 3, 0, 0, '', '', '', NULL),
(9, 'عميل 2', 3, 0, 0, '', '', '', NULL),
(10, 'هاشم صلاح', 3, 0, 0, '', '', '', NULL),
(11, 'بنك 12', 1, 0, 0, '-', '-', '-', NULL),
(12, 'saba', 3, 0, 0, '', '', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `supp`
--

CREATE TABLE IF NOT EXISTS `supp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '-',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `supp`
--

INSERT INTO `supp` (`id`, `name`) VALUES
(1, 'مورد 1'),
(2, 'محمـد صلاح'),
(3, 'ادريس');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `supp_name`, `supp_debit`, `supp_credit`, `address`, `balance`, `percent`) VALUES
(2, 'مورد1', 0, 0, '-', 0, 0),
(3, 'مورد', 0, 0, '-', 0, 0),
(4, 'مورد2', 0, 0, 'سلالاب', 0, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `supp_det`
--

INSERT INTO `supp_det` (`name`, `debit`, `credit`, `inv_no`, `id`, `notes`, `date`, `type`, `bank`, `date_bank`, `shift`, `user`) VALUES
('1', 15000, 0, '1', 1, NULL, '2025-01-12', NULL, NULL, NULL, NULL, NULL),
('1', 80000, 0, '6', 2, NULL, '2025-01-12', NULL, NULL, NULL, NULL, NULL);

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
(2025);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE IF NOT EXISTS `units` (
  `unit_name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `unit_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`unit_name`, `unit_id`) VALUES
('عنصر', 1),
('كرتونة', 2),
('باقة', 3),
('جالون', 4),
('كرستالة', 5),
('باكو', 6),
('كيس', 7),
('جردل', 8),
('صفيحة', 9),
('دستة', 10),
('وحدة', 11),
('كيلو', 12),
('طن', 13),
('جوال', 14);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `name` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `pass` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`name`, `pass`, `level1`, `id`, `LEVEL2`, `level3`, `level4`, `level5`, `level6`, `level7`, `level8`, `level9`, `level10`, `level11`, `level12`, `level13`, `level14`, `level15`, `level16`, `level17`, `level18`, `level19`, `level20`) VALUES
('1', '1', '1', 5, '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0', '0', '0', ''),
('user2', 'pass2', '0', 6, '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '');

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
(1, 2025),
(1, 2025),
(2, 2025),
(2, 2025),
(3, 2024),
(3, 2024),
(3, 2024),
(3, 2024),
(3, 2024),
(3, 2024),
(3, 2025),
(3, 2025),
(4, 2024),
(4, 2024),
(4, 2025),
(4, 2025),
(5, 2025),
(5, 2025),
(6, 2025),
(6, 2025),
(7, 2024),
(7, 2024),
(7, 2024),
(7, 2024),
(7, 2025),
(7, 2025),
(8, 2025),
(8, 2025),
(9, 2025),
(9, 2025),
(10, 2025),
(10, 2025),
(11, 2025),
(12, 2025),
(13, 2025),
(14, 2025),
(14, 2025),
(15, 2025),
(16, 2025),
(16, 2025),
(17, 2025),
(17, 2025),
(18, 2025),
(18, 2025),
(19, 2025),
(19, 2025),
(20, 2025),
(20, 2025),
(21, 2025),
(21, 2025),
(22, 2025),
(22, 2025),
(23, 2025),
(23, 2025),
(24, 2025),
(24, 2025),
(25, 2025),
(25, 2025),
(26, 2025),
(26, 2025),
(27, 2025),
(27, 2025),
(28, 2025),
(28, 2025),
(29, 2025),
(29, 2025),
(30, 2025),
(30, 2025),
(31, 2024),
(31, 2024),
(31, 2025),
(31, 2025),
(32, 2025),
(32, 2025),
(33, 2024),
(33, 2024),
(33, 2025),
(33, 2025),
(34, 2025),
(34, 2025);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `inveqdet`
--
ALTER TABLE `inveqdet`
  ADD CONSTRAINT `inveqdet_ibfk_1` FOREIGN KEY (`id`) REFERENCES `inveq` (`id`);

--
-- Constraints for table `saledets2`
--
ALTER TABLE `saledets2`
  ADD CONSTRAINT `saledets2_ibfk_1` FOREIGN KEY (`FK`) REFERENCES `sales2` (`id`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `delband` ON SCHEDULE AT '2017-04-28 23:31:00' ON COMPLETION PRESERVE DISABLE DO delete from band$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
