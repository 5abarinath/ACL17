-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 20, 2017 at 12:25 PM
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
(1, 'Aman Honda Ryders', 'Team owner 1', '/images/teams/amanhonda.png', 0, 150000),
(2, 'Ceratec Masters', 'Team owner 2', '/images/teams/ceratec.png', 0, 150000),
(3, 'Fitness Mantra', 'Team owner 3', '/images/teams/fitness.png', 0, 150000),
(4, 'Maha Fast Champs', 'Team owner 4', '/images/teams/mahafast.png', 0, 150000),
(5, 'JLV Agro', 'Team owner 5', '/images/teams/jlvagro.png', 0, 150000),
(6, 'Sun Shiners', 'Team owner 6', '/images/teams/sun.png', 0, 150000);

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

--
-- Dumping data for table `Bidding`
--

INSERT INTO `Bidding` (`bid_id`, `team_id`, `bid_price`, `group_id`) VALUES
(1, 1, 0, 1),
(2, 2, 0, 1),
(3, 3, 0, 1),
(4, 4, 0, 1),
(5, 5, 0, 1),
(6, 6, 0, 1),
(7, 1, 95000, 2),
(8, 2, 94000, 2),
(9, 3, 93000, 2),
(10, 4, 92000, 2),
(11, 5, 91000, 2),
(12, 6, 90000, 2),
(13, 1, 40000, 3),
(14, 2, 41000, 3),
(15, 3, 42000, 3),
(16, 4, 43000, 3),
(17, 5, 44000, 3),
(18, 6, 45000, 3),
(19, 1, 95000, 4),
(20, 2, 94000, 4),
(21, 3, 93000, 4),
(22, 4, 92000, 4),
(23, 5, 91000, 4),
(24, 6, 90000, 4),
(25, 1, 90000, 5),
(26, 2, 91000, 5),
(27, 3, 92000, 5),
(28, 4, 93000, 5),
(29, 5, 94000, 5),
(30, 6, 95000, 5),
(31, 1, 70000, 6),
(32, 2, 69000, 6),
(33, 3, 68000, 6),
(34, 4, 67000, 6),
(35, 5, 66000, 6),
(36, 6, 65000, 6),
(37, 1, 90000, 7),
(38, 2, 91000, 7),
(39, 3, 92000, 7),
(40, 4, 93000, 7),
(41, 5, 94000, 7),
(42, 6, 95000, 7),
(43, 1, 70000, 8),
(44, 2, 69000, 8),
(45, 3, 68000, 8),
(46, 4, 67000, 8),
(47, 5, 66000, 8),
(48, 6, 65000, 8),
(49, 1, 65000, 9),
(50, 2, 66000, 9),
(51, 3, 67000, 9),
(52, 4, 68000, 9),
(53, 5, 69000, 9),
(54, 6, 70000, 9),
(55, 1, 95000, 10),
(56, 2, 94000, 10),
(57, 3, 93000, 10),
(58, 4, 92000, 10),
(59, 5, 91000, 10),
(60, 6, 90000, 10),
(61, 1, 40000, 11),
(62, 2, 41000, 11),
(63, 3, 42000, 11),
(64, 4, 43000, 11),
(65, 5, 44000, 11),
(66, 6, 45000, 11),
(67, 1, 70000, 12),
(68, 2, 69000, 12),
(69, 3, 68000, 12),
(70, 4, 67000, 12),
(71, 5, 66000, 12),
(72, 6, 65000, 12),
(73, 1, 65000, 13),
(74, 2, 66000, 13),
(75, 3, 67000, 13),
(76, 4, 68000, 13),
(77, 5, 69000, 13),
(78, 6, 70000, 13),
(79, 1, 45000, 14),
(80, 2, 44000, 14),
(81, 3, 43000, 14),
(82, 4, 42000, 14),
(83, 5, 41000, 14),
(84, 6, 40000, 14),
(85, 1, 65000, 15),
(86, 2, 66000, 15),
(87, 3, 67000, 15),
(88, 4, 68000, 15),
(89, 5, 69000, 15),
(90, 6, 70000, 15);

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
(1, 'JAR - 1', 'Junior All Rounders - 1', 140000, 140000),
(2, 'SAR - 2', 'Senior All Rounders - 2', 90000, 115000),
(3, 'SAS - 1', 'Senior Assets - 1', 40000, 50000),
(4, 'JAR - 2', 'Junior All Rounders - 2', 90000, 115000),
(5, 'SAR - 3', 'Senior All Rounders - 3', 90000, 115000),
(6, 'JBT - 2', 'Junior Batsmen - 2 ', 65000, 80000),
(7, 'JAR - 3', 'Junior All Rounders - 3', 90000, 115000),
(8, 'SBT - 1', 'Senior Batsmen', 65000, 80000),
(9, 'JBW', 'Junior Bowlers', 65000, 80000),
(10, 'SAR - 1', 'Senior All Rounders - 1', 90000, 115000),
(11, 'JAS', 'Junior Assets', 40000, 50000),
(12, 'SBT - 2', 'Senior Batsmen', 65000, 80000),
(13, 'JBT - 1', 'Junior Batsmen - 1', 65000, 80000),
(14, 'MA - 1', 'Mixed Assets - 1', 40000, 50000),
(15, 'SBW', 'Senior Bowlers', 65000, 80000),
(16, 'Null', 'Null', 0, 0);

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
(1, 1, 'Karan', 'Garg', 'images/players/Juniors/JAR1/1.png', 1, 0),
(2, 1, 'Nikhil', 'Agarwal', 'images/players/Juniors/JAR1/2.png', 2, 0),
(3, 1, 'Monty', 'Gupta', 'images/players/Juniors/JAR1/3.png', 3, 0),
(4, 1, 'Prateek', 'Gupta', 'images/players/Juniors/JAR1/4.png', 4, 0),
(5, 1, 'Yash', 'Agarwal', 'images/players/Juniors/JAR1/5.png', 5, 0),
(6, 1, 'Yash', 'Gupta', 'images/players/Juniors/JAR1/6.png', 6, 0),
(7, 2, 'Anand', 'Agarwal', 'images/players/Seniors/SAR2/1.png', 1, 95000),
(8, 2, 'Anil', 'Agarwal', 'images/players/Seniors/SAR2/2.png', 2, 94000),
(9, 2, 'Vijay', 'Garg', 'images/players/Seniors/SAR2/3.png', 3, 93000),
(10, 2, 'Rajesh', 'Agarwal', 'images/players/Seniors/SAR2/4.png', 4, 92000),
(11, 2, 'Vikas', 'Bansal', 'images/players/Seniors/SAR2/5.png', 5, 91000),
(12, 3, 'Narendra', 'Agarwal', 'images/players/Seniors/SAS1/1.png', 1, 40000),
(13, 3, 'Ravi', 'Agarwal', 'images/players/Seniors/SAS1/2.png', 2, 41000),
(14, 3, 'Sunil', 'Garg', 'images/players/Seniors/SAS1/3.png', 3, 42000),
(15, 3, 'Surendra', 'Garg', 'images/players/Seniors/SAS1/4.png', 4, 43000),
(16, 3, 'Suresh', 'Mittal', 'images/players/Seniors/SAS1/5.png', 5, 44000),
(17, 3, 'Suresh', 'Agarwal', 'images/players/Seniors/SAS1/6.png', 6, 45000),
(18, 2, 'Anand', 'Mittal', 'images/players/Seniors/SAR2/6.png', 6, 90000),
(19, 13, 'Akash', 'Agarwal', 'images/players/Juniors/JBT1/1.png', 1, 65000),
(20, 13, 'Ankush', 'Agarwal', 'images/players/Juniors/JBT1/2.png', 2, 66000),
(21, 13, 'Hiten', 'Agarwal', 'images/players/Juniors/JBT1/3.png', 3, 67000),
(22, 13, 'Karan', 'Agarwal', 'images/players/Juniors/JBT1/4.png', 4, 68000),
(23, 13, 'Rahul', 'Goyal', 'images/players/Juniors/JBT1/5.png', 5, 69000),
(24, 13, 'Sagar', 'Agarwal', 'images/players/Juniors/JBT1/6.png', 6, 70000),
(25, 15, 'Amul', 'Chamaria', 'images/players/Seniors/SBW/1.png', 1, 65000),
(26, 15, 'Rajiv', 'Agarwal', 'images/players/Seniors/SBW/2.png', 2, 66000),
(27, 15, 'Ravindra', 'Agarwal', 'images/players/Seniors/SBW/3.png', 3, 67000),
(28, 15, 'Sanjay', 'Gupta', 'images/players/Seniors/SBW/4.png', 4, 68000),
(29, 15, 'Subhash', 'Agarwal', 'images/players/Seniors/SBW/5.png', 5, 69000),
(30, 15, 'Sunny', 'Mahipal', 'images/players/Seniors/SBW/6.png', 6, 70000),
(31, 6, 'Anuj', 'Agarwal', 'images/players/Juniors/JBT2/1.png', 1, 70000),
(32, 6, 'Khush', 'Agarwal', 'images/players/Juniors/JBT2/2.png', 2, 69000),
(33, 6, 'Nikhil', 'Mittal', 'images/players/Juniors/JBT2/3.png', 3, 68000),
(34, 6, 'Saideep', 'Agarwal', 'images/players/Juniors/JBT2/4.png', 4, 67000),
(35, 6, 'Siddhant', 'Jain', 'images/players/Juniors/JBT2/5.png', 5, 66000),
(36, 6, 'Lakhan', 'Agarwal', 'images/players/Juniors/JBT2/6.png', 6, 65000),
(37, 7, 'Ankush', 'Agarwal', 'images/players/Juniors/JAR3/1.png', 1, 90000),
(38, 7, 'Archit', 'Gupta', 'images/players/Juniors/JAR3/2.png', 2, 91000),
(39, 7, 'Pratik', 'Agarwal', 'images/players/Juniors/JAR3/3.png', 3, 92000),
(40, 7, 'Rahul', 'Mittal', 'images/players/Juniors/JAR3/4.png', 4, 93000),
(41, 7, 'Ritesh', 'Agarwal', 'images/players/Juniors/JAR3/5.png', 5, 94000),
(42, 7, 'Vinay', 'Gupta', 'images/players/Juniors/JAR3/6.png', 6, 95000),
(43, 8, 'Sanjay', 'Goel', 'images/players/Seniors/SBT1/5.png', 1, 70000),
(44, 8, 'Dr. Rajesh', 'Mittal', 'images/players/Seniors/SBT1/2.png', 2, 69000),
(45, 8, 'Sandeep', 'Jain', 'images/players/Seniors/SBT1/3.png', 3, 68000),
(46, 8, 'Sanjay', 'Bansal', 'images/players/Seniors/SBT1/4.png', 4, 67000),
(47, 8, 'Ashok', 'Mittal', 'images/players/Seniors/SBT1/1.png', 5, 66000),
(48, 8, 'Vijay', 'Garg', 'images/players/Seniors/SBT1/6.png', 6, 65000),
(49, 9, 'Ishaan', 'Garg', 'images/players/Juniors/JBW/1.png', 1, 65000),
(50, 9, 'Kapil', 'Agarwal', 'images/players/Juniors/JBW/2.png', 2, 66000),
(51, 9, 'Rohit', 'Goyal', 'images/players/Juniors/JBW/3.png', 3, 67000),
(52, 9, 'Sunny', 'Gupta', 'images/players/Juniors/JBW/4.png', 4, 68000),
(53, 9, 'Vipul', 'Gupta', 'images/players/Juniors/JBW/5.png', 5, 69000),
(54, 9, 'Yash', 'Mittal', 'images/players/Juniors/JBW/6.png', 6, 70000),
(55, 10, 'Amul', 'Agarwal', 'images/players/Seniors/SAR1/1.png', 1, 95000),
(56, 10, 'Kavit', 'Poddar', 'images/players/Seniors/SAR1/2.png', 2, 94000),
(57, 10, 'Mukesh', 'Bansal', 'images/players/Seniors/SAR1/3.png', 3, 93000),
(58, 10, 'Ram', 'Jindal', 'images/players/Seniors/SAR1/4.png', 4, 92000),
(59, 10, 'Sanjay', 'Agarwal', 'images/players/Seniors/SAR1/5.png', 5, 91000),
(60, 10, 'Vivek', 'Agarwal', 'images/players/Seniors/SAR1/6.png', 6, 90000),
(61, 11, 'Aman', 'Agarwal', 'images/players/Juniors/JAS/1.png', 1, 40000),
(62, 11, 'Pratik', 'Agarwal', 'images/players/Juniors/JAS/2.png', 2, 41000),
(63, 11, 'Rituj', 'Agarwal', 'images/players/Juniors/JAS/3.png', 3, 42000),
(64, 11, 'Pradeep', 'Agarwal', 'images/players/Juniors/JAS/4.png', 4, 43000),
(65, 11, 'Shubham', 'Garg', 'images/players/Juniors/JAS/5.png', 5, 44000),
(66, 11, 'Yash', 'Mittal', 'images/players/Juniors/JAS/6.png', 6, 45000),
(67, 12, 'Amit', 'Gupta', 'images/players/Seniors/SBT2/1.png', 1, 70000),
(68, 12, 'Mahendra', 'Goyal', 'images/players/Seniors/SBT2/2.png', 2, 69000),
(69, 12, 'Mohan', 'Gupta', 'images/players/Seniors/SBT2/3.png', 3, 68000),
(70, 12, 'Mukesh', 'Agarwal', 'images/players/Seniors/SBT2/4.png', 4, 67000),
(71, 12, 'Sachin', 'Agarwal', 'images/players/Seniors/SBT2/5.png', 5, 66000),
(72, 12, 'Yogesh', 'Agarwal', 'images/players/Seniors/SBT2/6.png', 6, 65000),
(73, 4, 'Nitin', 'Mittal', 'images/players/Juniors/JAR2/1.png', 1, 95000),
(74, 4, 'Pranav', 'Gupta', 'images/players/Juniors/JAR2/2.png', 2, 94000),
(75, 4, 'Punit', 'Agarwal', 'images/players/Juniors/JAR2/3.png', 3, 93000),
(76, 4, 'Ritesh', 'Agarwal', 'images/players/Juniors/JAR2/4.png', 4, 92000),
(77, 4, 'Rohan', 'Goel', 'images/players/Juniors/JAR2/5.png', 5, 91000),
(78, 4, 'Varun', 'Mittal', 'images/players/Juniors/JAR2/6.png', 6, 90000),
(79, 14, 'Devesh', 'Agarwal', 'images/players/Mixed/MA1/1.png', 1, 45000),
(80, 14, 'Hrithik', 'Mittal', 'images/players/Mixed/MA1/2.png', 2, 44000),
(81, 14, 'Krishant', 'Agarwal', 'images/players/Mixed/MA1/3.png', 3, 43000),
(82, 14, 'Mayank', 'Garg', 'images/players/Mixed/MA1/4.png', 4, 42000),
(83, 14, 'Mohanlal', 'Agarwal', 'images/players/Mixed/MA1/5.png', 5, 41000),
(84, 14, 'Pravin', 'Agarwal', 'images/players/Mixed/MA1/6.png', 6, 40000),
(85, 5, 'Ajay', 'Agarwal', 'images/players/Seniors/SAR3/1.png', 1, 90000),
(86, 5, 'Amithabh', 'Agarwal', 'images/players/Seniors/SAR3/2.png', 2, 91000),
(87, 5, 'Dilip', 'Gupta', 'images/players/Seniors/SAR3/3.png', 3, 92000),
(88, 5, 'Dinesh', 'Agarwal', 'images/players/Seniors/SAR3/4.png', 4, 93000),
(89, 5, 'Satpal', 'Mittal', 'images/players/Seniors/SAR3/5.png', 5, 94000),
(90, 5, 'Vinod', 'Gupta', 'images/players/Seniors/SAR3/6.png', 6, 95000);

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
  MODIFY `bid_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `Players`
--
ALTER TABLE `Players`
  MODIFY `player_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
