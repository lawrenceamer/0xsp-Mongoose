-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 15, 2019 at 11:21 AM
-- Server version: 5.6.44
-- PHP Version: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `secman_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `download_center`
--

CREATE TABLE `download_center` (
  `id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `download_center`
--
ALTER TABLE `download_center`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `download_center`
--
ALTER TABLE `download_center`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `cat_id` int(11) NOT NULL,
  `cat_name` varchar(255) NOT NULL,
  `cat_icon` varchar(255) NOT NULL,
  `os` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`cat_id`, `cat_name`, `cat_icon`, `os`) VALUES
(1, 'Kernel information', 'kernel.svg', 'Linux'),
(2, 'Cron jobs collected', 'cron.svg', 'Linux'),
(3, 'Exploit inspections', 'exploit.svg', 'Linux'),
(4, 'Vulnerable Packages', 'software.svg', 'Linux'),
(5, 'User information', 'user.svg', 'Linux'),
(6, 'Information disclosure', 'info.svg', 'Linux'),
(7, 'Network enumeration', 'network.svg', 'Linux'),
(8, 'SUID & Access issue', 'suid.svg', 'Linux'),
(9, 'System Information', 'sys.svg', 'windows'),
(10, 'Active Services', 'act.svg', 'windows'),
(11, 'Software & Process ', 'ps.svg', 'windows'),
(12, 'Windows Exploits', 'exploits.svg', 'windows'),
(13, 'User Information ', 'usr.svg', 'windows'),
(14, 'Network Enumeration ', 'net.svg', 'windows'),
(15, 'Access Check Permission', 'ACP.svg', 'windows'),
(16, 'Potential Files / Folders ', 'pfp.svg', 'windows');

-- --------------------------------------------------------

--
-- Table structure for table `outputs`
--

CREATE TABLE `outputs` (
  `id` int(11) NOT NULL,
  `output_body` longtext NOT NULL,
  `output_owner` varchar(255) NOT NULL,
  `output_category` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sys` varchar(250) NOT NULL,
  `report_name` varchar(255) NOT NULL,
  `random_val` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'admin', '0xsp');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indexes for table `outputs`
--
ALTER TABLE `outputs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `outputs`
--
ALTER TABLE `outputs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
