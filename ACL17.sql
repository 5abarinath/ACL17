-- phpMyAdmin SQL Dump
-- version 4.7.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 18, 2017 at 08:34 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.8

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
(1, 'JAR - 1', 'Junior All Rounders - 1', 120000, 140000),
(2, 'SAR - 2', 'Senior All Rounders - 2', 90000, 105000),
(3, 'SAS - 1', 'Senior Assets - 1', 40000, 50000),
(4, 'JBT - 1', 'Junior Batsmen - 1', 70000, 90000),
(5, 'SBW', 'Senior Bowlers', 70000, 90000),
(6, 'JBT - 2', 'Junior Batsmen - 2 ', 70000, 90000),
(7, 'JAR - 3', 'Junior All Rounders - 3', 90000, 105000),
(8, 'SBT - 1', 'Senior Batsmen', 70000, 90000),
(9, 'JBW', 'Junior Bowlers', 70000, 90000),
(10, 'SAR - 1', 'Senior All Rounders - 1', 90000, 105000),
(11, 'JAS', 'Junior Assets', 40000, 50000),
(12, 'SBT - 2', 'Senior Batsmen', 70000, 90000),
(13, 'JAR - 2', 'Junior All Rounders - 2', 90000, 105000),
(14, 'MA - 1', 'Mixed Assets - 1', 90000, 105000),
(15, 'SAR - 3', 'Senior All Rounders - 3', 90000, 105000);

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
(1, 1, 'Karan', 'Garg', 'images/players/Juniors/JAR1/1.png', 0, 0),
(2, 1, 'Nikhil', 'Agarwal', 'images/players/Juniors/JAR1/2.png', 0, 0),
(3, 1, 'Monty', 'Gupta', 'images/players/Juniors/JAR1/3.png', 0, 0),
(4, 1, 'Prateek', 'Gupta', 'images/players/Juniors/JAR1/4.png', 0, 0),
(5, 1, 'Yash', 'Agarwal', 'images/players/Juniors/JAR1/5.png', 0, 0),
(6, 1, 'Yash', 'Gupta', 'images/players/Juniors/JAR1/6.png', 0, 0),
(7, 2, 'Anand', 'Agarwal', 'images/players/Seniors/SAR2/1.png', 0, 0),
(8, 2, 'Anil', 'Agarwal', 'images/players/Seniors/SAR2/2.png', 0, 0),
(9, 2, 'Vijay', 'Garg', 'images/players/Seniors/SAR2/3.png', 0, 0),
(10, 2, 'Rajesh', 'Agarwal', 'images/players/Seniors/SAR2/4.png', 0, 0),
(11, 2, 'Vikas', 'Bansal', 'images/players/Seniors/SAR2/5.png', 0, 0),
(12, 3, 'Narendra', 'Agarwal', 'images/players/Seniors/SAS1/1.png', 0, 0),
(13, 3, 'Ravi', 'Agarwal', 'images/players/Seniors/SAS1/2.png', 0, 0),
(14, 3, 'Sunil', 'Garg', 'images/players/Seniors/SAS1/3.png', 0, 0),
(15, 3, 'Surendra', 'Garg', 'images/players/Seniors/SAS1/4.png', 0, 0),
(16, 3, 'Suresh', 'Mittal', 'images/players/Seniors/SAS1/5.png', 0, 0),
(17, 3, 'Suresh', 'Agarwal', 'images/players/Seniors/SAS1/6.png', 0, 0),
(18, 2, 'Anand', 'Mittal', 'images/players/Seniors/SAR2/6.png', 0, 0),
(19, 4, 'Akash', 'Agarwal', 'images/players/Juniors/JBT1/1.png', 0, 0),
(20, 4, 'Ankush', 'Agarwal', 'images/players/Juniors/JBT1/2.png', 0, 0),
(21, 4, 'Hiten', 'Agarwal', 'images/players/Juniors/JBT1/3.png', 0, 0),
(22, 4, 'Karan', 'Agarwal', 'images/players/Juniors/JBT1/4.png', 0, 0),
(23, 4, 'Rahul', 'Goyal', 'images/players/Juniors/JBT1/5.png', 0, 0),
(24, 4, 'Sagar', 'Agarwal', 'images/players/Juniors/JBT1/6.png', 0, 0),
(25, 5, 'Amul', 'Chamaria', 'images/players/Seniors/SBW/1.png', 0, 0),
(26, 5, 'Rajiv', 'Agarwal', 'images/players/Seniors/SBW/2.png', 0, 0),
(27, 5, 'Ravindra', 'Agarwal', 'images/players/Seniors/SBW/3.png', 0, 0),
(28, 5, 'Sanjay', 'Gupta', 'images/players/Seniors/SBW/4.png', 0, 0),
(29, 5, 'Subhash', 'Agarwal', 'images/players/Seniors/SBW/5.png', 0, 0),
(30, 5, 'Sunny', 'Mahipal', 'images/players/Seniors/SBW/6.png', 0, 0),
(31, 6, 'Anuj', 'Agarwal', 'images/players/Juniors/JBT2/1.png', 0, 0),
(32, 6, 'Khush', 'Agarwal', 'images/players/Juniors/JBT2/2.png', 0, 0),
(33, 6, 'Nikhil', 'Mittal', 'images/players/Juniors/JBT2/3.png', 0, 0),
(34, 6, 'Saideep', 'Agarwal', 'images/players/Juniors/JBT2/4.png', 0, 0),
(35, 6, 'Siddhant', 'Jain', 'images/players/Juniors/JBT2/5.png', 0, 0),
(36, 6, 'Lakhan', 'Agarwal', 'images/players/Juniors/JBT2/6.png', 0, 0),
(37, 7, 'Ankush', 'Agarwal', 'images/players/Juniors/JAR3/1.png', 0, 0),
(38, 7, 'Archit', 'Gupta', 'images/players/Juniors/JAR3/2.png', 0, 0),
(39, 7, 'Pratik', 'Agarwal', 'images/players/Juniors/JAR3/3.png', 0, 0),
(40, 7, 'Rahul', 'Mittal', 'images/players/Juniors/JAR3/4.png', 0, 0),
(41, 7, 'Ritesh', 'Agarwal', 'images/players/Juniors/JAR3/5.png', 0, 0),
(42, 7, 'Vinay', 'Gupta', 'images/players/Juniors/JAR3/6.png', 0, 0),
(43, 8, 'Sanjay', 'Goel', 'images/players/Seniors/SBT1/5.png', 0, 0),
(44, 8, 'Dr. Rajesh', 'Mittal', 'images/players/Seniors/SBT1/2.png', 0, 0),
(45, 8, 'Sandeep', 'Jain', 'images/players/Seniors/SBT1/3.png', 0, 0),
(46, 8, 'Sanjay', 'Bansal', 'images/players/Seniors/SBT1/4.png', 0, 0),
(47, 8, 'Ashok', 'Mittal', 'images/players/Seniors/SBT1/1.png', 0, 0),
(48, 8, 'Vijay', 'Garg', 'images/players/Seniors/SBT1/6.png', 0, 0),
(49, 9, 'Ishaan', 'Garg', 'images/players/Juniors/JBW/1.png', 0, 0),
(50, 9, 'Kapil', 'Agarwal', 'images/players/Juniors/JBW/2.png', 0, 0),
(51, 9, 'Rohit', 'Goyal', 'images/players/Juniors/JBW/3.png', 0, 0),
(52, 9, 'Sunny', 'Gupta', 'images/players/Juniors/JBW/4.png', 0, 0),
(53, 9, 'Vipul', 'Gupta', 'images/players/Juniors/JBW/5.png', 0, 0),
(54, 9, 'Yash', 'Mittal', 'images/players/Juniors/JBW/6.png', 0, 0),
(55, 10, 'Amul', 'Agarwal', 'images/players/Seniors/SAR1/1.png', 0, 0),
(56, 10, 'Kavit', 'Poddar', 'images/players/Seniors/SAR1/2.png', 0, 0),
(57, 10, 'Mukesh', 'Bansal', 'images/players/Seniors/SAR1/3.png', 0, 0),
(58, 10, 'Ram', 'Jindal', 'images/players/Seniors/SAR1/4.png', 0, 0),
(59, 10, 'Sanjay', 'Agarwal', 'images/players/Seniors/SAR1/5.png', 0, 0),
(60, 10, 'Vivek', 'Agarwal', 'images/players/Seniors/SAR1/6.png', 0, 0),
(61, 11, 'Aman', 'Agarwal', 'images/players/Juniors/JAS/1.png', 0, 0),
(62, 11, 'Pratik', 'Agarwal', 'images/players/Juniors/JAS/2.png', 0, 0),
(63, 11, 'Rituj', 'Agarwal', 'images/players/Juniors/JAS/3.png', 0, 0),
(64, 11, 'Pradeep', 'Agarwal', 'images/players/Juniors/JAS/4.png', 0, 0),
(65, 11, 'Shubham', 'Garg', 'images/players/Juniors/JAS/5.png', 0, 0),
(66, 11, 'Yash', 'Mittal', 'images/players/Juniors/JAS/6.png', 0, 0),
(67, 12, 'Amit', 'Gupta', 'images/players/Seniors/SBT2/1.png', 0, 0),
(68, 12, 'Mahendra', 'Goyal', 'images/players/Seniors/SBT2/2.png', 0, 0),
(69, 12, 'Mohan', 'Gupta', 'images/players/Seniors/SBT2/3.png', 0, 0),
(70, 12, 'Mukesh', 'Agarwal', 'images/players/Seniors/SBT2/4.png', 0, 0),
(71, 12, 'Sachan', 'Agarwal', 'images/players/Seniors/SBT2/5.png', 0, 0),
(72, 12, 'Yogesh', 'Agarwal', 'images/players/Seniors/SBT2/6.png', 0, 0),
(73, 13, 'Nitin', 'Mittal', 'images/players/Juniors/JAR2/1.png', 0, 0),
(74, 13, 'Pranav', 'Gupta', 'images/players/Juniors/JAR2/2.png', 0, 0),
(75, 13, 'Punit', 'Agarwal', 'images/players/Juniors/JAR2/3.png', 0, 0),
(76, 13, 'Ritesh', 'Agarwal', 'images/players/Juniors/JAR2/4.png', 0, 0),
(77, 13, 'Rohan', 'Goel', 'images/players/Juniors/JAR2/5.png', 0, 0),
(78, 13, 'Varun', 'Mittal', 'images/players/Juniors/JAR2/6.png', 0, 0),
(79, 14, 'Devesh', 'Agarwal', 'images/players/Mixed/MA1/1.png', 0, 0),
(80, 14, 'Hrithik', 'Mittal', 'images/players/Mixed/MA1/2.png', 0, 0),
(81, 14, 'Krishant', 'Agarwal', 'images/players/Mixed/MA1/3.png', 0, 0),
(82, 14, 'Mayank', 'Garg', 'images/players/Mixed/MA1/4.png', 0, 0),
(83, 14, 'Mohanlal', 'Agarwal', 'images/players/Mixed/MA1/5.png', 0, 0),
(84, 14, 'Pravin', 'Agarwal', 'images/players/Mixed/MA1/6.png', 0, 0),
(85, 15, 'Ajay', 'Agarwal', 'images/players/Seniors/SAR3/1.png', 0, 0),
(86, 15, 'Amithabh', 'Agarwal', 'images/players/Seniors/SAR3/2.png', 0, 0),
(87, 15, 'Dilip', 'Gupta', 'images/players/Seniors/SAR3/3.png', 0, 0),
(88, 15, 'Dinesh', 'Agarwal', 'images/players/Seniors/SAR3/4.png', 0, 0),
(89, 15, 'Satpal', 'Mittal', 'images/players/Seniors/SAR3/5.png', 0, 0),
(90, 15, 'Vinod', 'Gupta', 'images/players/Seniors/SAR3/6.png', 0, 0);

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
  MODIFY `bid_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=175;
--
-- AUTO_INCREMENT for table `Players`
--
ALTER TABLE `Players`
  MODIFY `player_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
