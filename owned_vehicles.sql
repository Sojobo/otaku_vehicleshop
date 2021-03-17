-- --------------------------------------------------------
-- Host:                         play.spaceturtl.es
-- Server version:               5.7.31-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table strp.owned_vehicles
DROP TABLE IF EXISTS `owned_vehicles`;
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `vehicle` longtext NOT NULL,
  `owner` varchar(60) NOT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'State of the vehicle',
  `garage_name` varchar(50) NOT NULL DEFAULT 'Garage_Centre',
  `houseid` int(11) NOT NULL DEFAULT '0',
  `pound` tinyint(1) NOT NULL DEFAULT '0',
  `vehiclename` varchar(50) DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `type` varchar(10) NOT NULL DEFAULT 'car',
  `job` varchar(50) DEFAULT NULL,
  `photo` varchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY (`plate`),
  KEY `vehsowned` (`owner`),
  KEY `carOwner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
