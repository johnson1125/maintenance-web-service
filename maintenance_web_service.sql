-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 23, 2024 at 12:26 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `maintenance_web_service`
--

-- --------------------------------------------------------

--
-- Table structure for table `maintenancerecords`
--

CREATE TABLE `maintenancerecords` (
  `maintenanceRecordID` varchar(50) NOT NULL,
  `startTime` datetime NOT NULL,
  `hallID` varchar(50) NOT NULL,
  `maintenanceID` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `maintenancerecords`
--

INSERT INTO `maintenancerecords` (`maintenanceRecordID`, `startTime`, `hallID`, `maintenanceID`) VALUES
('MTNRD-240913-0001', '2024-09-13 20:00:00', 'HALL-F-01', 'MTN-TM-EM-001'),
('MTNRD-240913-0002', '2024-09-13 17:00:00', 'HALL-P-02', 'MTN-C-RC-002'),
('MTNRD-240914-0001', '2024-09-14 10:00:00', 'HALL-P-01', 'MTN-TM-ES-002'),
('MTNRD-240914-0002', '2024-09-14 10:00:00', 'HALL-P-02', 'MTN-C-RC-002'),
('MTNRD-240914-0003', '2024-09-14 10:00:00', 'HALL-S-01', 'MTN-C-DP-003'),
('MTNRD-240915-0001', '2024-09-15 10:00:00', 'HALL-F-01', 'MTN-C-DP-001'),
('MTNRD-240915-0002', '2024-09-15 10:00:00', 'HALL-P-01', 'MTN-C-DP-002'),
('MTNRD-240915-0003', '2024-09-15 17:00:00', 'HALL-P-01', 'MTN-TM-EM-002'),
('MTNRD-240915-0004', '2024-09-15 10:00:00', 'HALL-S-01', 'MTN-C-DP-003'),
('MTNRD-240915-0005', '2024-09-15 17:45:00', 'HALL-S-01', 'MTN-TM-ES-003'),
('MTNRD-240916-0001', '2024-09-16 10:00:00', 'HALL-P-01', 'MTN-C-DP-002'),
('MTNRD-240916-0002', '2024-09-16 17:45:00', 'HALL-P-01', 'MTN-TM-EM-002'),
('MTNRD-240916-0003', '2024-09-16 10:00:00', 'HALL-S-01', 'MTN-TM-EM-003'),
('MTNRD-240917-0001', '2024-09-17 14:00:00', 'HALL-S-01', 'MTN-TM-EM-003'),
('MTNRD-240918-0001', '2024-09-18 10:00:00', 'HALL-P-02', 'MTN-C-DP-002'),
('MTNRD-240919-0001', '2024-09-19 10:00:00', 'HALL-P-01', 'MTN-C-DP-002'),
('MTNRD-240930-0001', '2024-09-30 10:00:00', 'HALL-P-01', 'MTN-C-DP-002'),
('MTNRD-240930-0002', '2024-09-30 12:00:00', 'HALL-P-02', 'MTN-TM-EM-002'),
('MTNRD-240930-0003', '2024-09-30 17:00:00', 'HALL-P-02', 'MTN-TM-ES-002'),
('MTNRD-241001-0001', '2024-10-01 10:00:00', 'HALL-P-02', 'MTN-C-DP-002'),
('MTNRD-241001-0002', '2024-10-01 18:00:00', 'HALL-P-02', 'MTN-TM-EM-002'),
('MTNRD-241001-0003', '2024-10-01 20:00:00', 'HALL-S-01', 'MTN-TM-EM-003'),
('MTNRD-241002-0001', '2024-10-02 10:00:00', 'HALL-S-01', 'MTN-C-RC-003'),
('MTNRD-241004-0001', '2024-10-04 12:00:00', 'HALL-F-01', 'MTN-C-DP-001'),
('MTNRD-241004-0002', '2024-10-04 19:00:00', 'HALL-F-01', 'MTN-TM-EM-001'),
('MTNRD-241005-0001', '2024-10-05 11:00:00', 'HALL-P-01', 'MTN-C-DP-002'),
('MTNRD-241005-0002', '2024-10-05 10:00:00', 'HALL-S-01', 'MTN-C-RC-003'),
('MTNRD-241005-0003', '2024-10-05 14:00:00', 'HALL-S-01', 'MTN-TM-EM-003'),
('MTNRD-241007-0001', '2024-10-07 12:00:00', 'HALL-F-01', 'MTN-C-DP-001'),
('MTNRD-241008-0001', '2024-10-08 10:00:00', 'HALL-S-01', 'MTN-TM-ES-003'),
('MTNRD-241008-0002', '2024-10-08 16:00:00', 'HALL-S-01', 'MTN-TM-EM-003');

-- --------------------------------------------------------

--
-- Table structure for table `maintenances`
--

CREATE TABLE `maintenances` (
  `maintenanceID` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `duration` time NOT NULL,
  `hallType` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `maintenances`
--

INSERT INTO `maintenances` (`maintenanceID`, `name`, `description`, `duration`, `hallType`) VALUES
('MTN-C-DP-001', 'DEEP CLEANING', 'Periodic deep cleaning of carpets, upholstery, and air ducts.\r\nDisinfection of high-touch surfaces.', '05:00:00', 'Family'),
('MTN-C-DP-002', 'DEEP CLEANING', 'Periodic deep cleaning of carpets, upholstery, and air ducts.\r\nDisinfection of high-touch surfaces.', '06:00:00', 'Premium'),
('MTN-C-DP-003', 'DEEP CLEANING', 'Periodic deep cleaning of carpets, upholstery, and air ducts.\r\nDisinfection of high-touch surfaces.', '07:00:00', 'Standard'),
('MTN-C-RC-001', 'REGULAR CLEANING', 'Daily cleaning of floors, restrooms, and common areas.\r\nCleaning and sanitization of equipment (e.g., seats, projectors, sound systems).', '01:00:00', 'Family'),
('MTN-C-RC-002', 'REGULAR CLEANING', 'Daily cleaning of floors, restrooms, and common areas.\r\nCleaning and sanitization of equipment (e.g., seats, projectors, sound systems).', '02:00:00', 'Premium'),
('MTN-C-RC-003', 'REGULAR CLEANING', 'Daily cleaning of floors, restrooms, and common areas.\r\nCleaning and sanitization of equipment (e.g., seats, projectors, sound systems).', '02:30:00', 'Standard'),
('MTN-TM-EM-001', 'EQUIPMENT MAINTENANCE', 'Regular servicing and calibration of projectors, sound systems, and other technical equipment.\r\nReplacement of worn-out or damaged parts.\r\nSoftware updates and troubleshooting.', '02:00:00', 'Family'),
('MTN-TM-EM-002', 'EQUIPMENT MAINTENANCE', 'Regular servicing and calibration of projectors, sound systems, and other technical equipment.\r\nReplacement of worn-out or damaged parts.\r\nSoftware updates and troubleshooting.', '03:00:00', 'Premium'),
('MTN-TM-EM-003', 'EQUIPMENT MAINTENANCE', 'Regular servicing and calibration of projectors, sound systems, and other technical equipment.\r\nReplacement of worn-out or damaged parts.\r\nSoftware updates and troubleshooting.', '03:30:00', 'Standard'),
('MTN-TM-ES-001', 'ELECTRICAL SYSTEMS MAINTENANCE', 'Inspection and maintenance of wiring, circuit breakers, and electrical outlets.\r\nTesting and repair of emergency lighting and power systems.', '02:00:00', 'Family'),
('MTN-TM-ES-002', 'ELECTRICAL SYSTEMS MAINTENANCE', 'Inspection and maintenance of wiring, circuit breakers, and electrical outlets.\r\nTesting and repair of emergency lighting and power systems.', '03:00:00', 'Premium'),
('MTN-TM-ES-003', 'ELECTRICAL SYSTEMS MAINTENANCE', 'Inspection and maintenance of wiring, circuit breakers, and electrical outlets.\r\nTesting and repair of emergency lighting and power systems.', '04:00:00', 'Standard');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `maintenancerecords`
--
ALTER TABLE `maintenancerecords`
  ADD PRIMARY KEY (`maintenanceRecordID`),
  ADD KEY `maintenanceIDFK` (`maintenanceID`);

--
-- Indexes for table `maintenances`
--
ALTER TABLE `maintenances`
  ADD PRIMARY KEY (`maintenanceID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `maintenancerecords`
--
ALTER TABLE `maintenancerecords`
  ADD CONSTRAINT `maintenanceIDFK` FOREIGN KEY (`maintenanceID`) REFERENCES `maintenances` (`maintenanceID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
