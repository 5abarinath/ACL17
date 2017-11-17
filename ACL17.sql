-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 17, 2017 at 10:34 AM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ACL17`
--

-- --------------------------------------------------------

--
-- Table structure for table `Bidders`
--

CREATE TABLE `Bidders` (
  `team_id` tinyint(3) UNSIGNED NOT NULL,
  `team_name` varchar(50) NOT NULL,
  `team_owner` varchar(50) NOT NULL,
  `team_logo` char(30) NOT NULL,
  `points_spent` int(10) UNSIGNED NOT NULL,
  `premium_left` mediumint(8) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Bidders`
--

INSERT INTO `Bidders` (`team_id`, `team_name`, `team_owner`, `team_logo`, `points_spent`, `premium_left`) VALUES
(1, 'Aman Honda Ryders', 'Team owner 1', '/images/download.jpg', 0, 150000),
(2, 'Ceratec Masters', 'Team owner 2', '/images/download.jpg', 0, 150000),
(3, 'Fitness Mantra', 'Team owner 3', '/images/download.jpg', 0, 150000),
(4, 'Maha Fast Champs', 'Team owner 4', '/images/download.jpg', 0, 150000),
(5, 'Premier Titans', 'Team owner 5', '/images/download.jpg', 0, 150000),
(6, 'Sun Shiners', 'Team owner 6', '/images/download.jpg', 0, 150000);

-- --------------------------------------------------------

--
-- Table structure for table `Bidding`
--

CREATE TABLE `Bidding` (
  `bid_id` mediumint(8) UNSIGNED NOT NULL,
  `team_id` tinyint(3) UNSIGNED NOT NULL,
  `bid_price` mediumint(8) UNSIGNED NOT NULL,
  `group_id` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Groups`
--

CREATE TABLE `Groups` (
  `group_id` tinyint(3) UNSIGNED NOT NULL,
  `group_name` varchar(8) NOT NULL,
  `group_desc` varchar(30) NOT NULL,
  `base_bid` mediumint(8) UNSIGNED NOT NULL,
  `max_bid` mediumint(8) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Groups`
--

INSERT INTO `Groups` (`group_id`, `group_name`, `group_desc`, `base_bid`, `max_bid`) VALUES
(1, 'SB-1', 'Senior Bowlers - 1', 50000, 75000),
(2, 'SBAT-1', 'Senior Batsmen - 1', 75000, 100000);

-- --------------------------------------------------------

--
-- Table structure for table `Players`
--

CREATE TABLE `Players` (
  `player_id` smallint(5) UNSIGNED NOT NULL,
  `group_id` int(11) NOT NULL,
  `player_fname` varchar(50) NOT NULL,
  `player_lname` varchar(50) NOT NULL,
  `player_image` varchar(100) NOT NULL,
  `team_id` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Players`
--

INSERT INTO `Players` (`player_id`, `group_id`, `player_fname`, `player_lname`, `player_image`, `team_id`, `price`) VALUES
(1, 1, 'Vishva', 'Iyer', 'images/player.png', 1, 50000),
(2, 1, 'Sabari', 'S.', 'images/player.png', 1, 56000),
(3, 2, 'Saif', 'Lakhani', 'images/player.png', 2, 100000),
(4, 1, 'Vishva2', 'Iyer', 'images/player.png', 0, 0),
(5, 1, 'Sabari2', 'S.', 'images/player.png', 0, 0),
(6, 1, 'Vishva3', 'Iyer', 'images/player.png', 0, 0),
(7, 1, 'Sabari3', 'S.', 'images/player.png', 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Bidders`
--
ALTER TABLE `Bidders`
  ADD PRIMARY KEY (`team_id`);

--
-- Indexes for table `Bidding`
--
ALTER TABLE `Bidding`
  ADD PRIMARY KEY (`bid_id`);

--
-- Indexes for table `Groups`
--
ALTER TABLE `Groups`
  ADD PRIMARY KEY (`group_id`);

--
-- Indexes for table `Players`
--
ALTER TABLE `Players`
  ADD PRIMARY KEY (`player_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Bidding`
--
ALTER TABLE `Bidding`
  MODIFY `bid_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Players`
--
ALTER TABLE `Players`
  MODIFY `player_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
