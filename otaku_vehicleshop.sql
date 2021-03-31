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

-- Dumping structure for table strp.vehicle_categories
DROP TABLE IF EXISTS `vehicle_categories`;
CREATE TABLE IF NOT EXISTS `vehicle_categories` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table strp.vehicle_categories: ~12 rows (approximately)
DELETE FROM `vehicle_categories`;
/*!40000 ALTER TABLE `vehicle_categories` DISABLE KEYS */;
INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
	('compacts', 'Compacts'),
	('coupes', 'Coupés'),
	('ltdedition', 'Limited Edition'),
	('motorcycles', 'Motorbikes'),
	('muscle', 'Muscle'),
	('offroad', 'Off Road'),
	('sedans', 'Sedans'),
	('sports', 'Sports'),
	('sportsclassics', 'Sports Classics'),
	('suvs', 'SUVs'),
	('vans', 'Vans'),
	('vips', 'Super');
/*!40000 ALTER TABLE `vehicle_categories` ENABLE KEYS */;

-- ALTER TABLE `owned_vehicles`
--  ADD COLUMN `vehiclename` varchar(60) NOT NULL;

-- If you already have owned_vehicles comment out the section below and uncomment the 2 lines above
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
-- End of owned_vehicles Section!

-- Dumping structure for table strp.vehicles
DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `hash` varchar(60) NOT NULL DEFAULT '',
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  `imglink` text,
  `instore` tinyint(1) unsigned DEFAULT '1',
  `trunksize` int(6) unsigned NOT NULL DEFAULT '0',
  `rarity` varchar(50) NOT NULL DEFAULT 'common',
  `stock` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`model`),
  KEY `rarity` (`rarity`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table strp.vehicles: ~428 rows (approximately)
DELETE FROM `vehicles`;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` (`name`, `model`, `hash`, `price`, `category`, `imglink`, `instore`, `trunksize`, `rarity`, `stock`) VALUES
	('Adder', 'adder', '-1216765807', 1000000, 'ltdedition', 'https://i.imgur.com/dPxjhuH.png', 1, 25000, 'common', 1);
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
