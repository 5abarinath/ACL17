-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 14, 2019 at 12:24 PM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.1.32

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
(1, 'Aman Honda Ryders', 'Team owner 1', '/images/teams/amanhonda.png', 0, 500000),
(2, 'Ceratec Masters', 'Team owner 2', '/images/teams/ceratec.png', 0, 500000),
(3, 'Fitness Mantra', 'Team owner 3', '/images/teams/fitness.png', 0, 500000),
(4, 'Maha Fast Champs', 'Team owner 4', '/images/teams/mahafast.png', 0, 500000),
(5, 'JLV Agro', 'Team owner 5', '/images/teams/jlvagro.png', 0, 500000),
(6, 'Sun Shiners', 'Team owner 6', '/images/teams/sun.png', 0, 500000);

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
  `group_name` varchar(50) NOT NULL,
  `group_desc` varchar(30) NOT NULL,
  `base_bid` mediumint(8) UNSIGNED NOT NULL,
  `max_bid` mediumint(8) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Groups`
--

INSERT INTO `Groups` (`group_id`, `group_name`, `group_desc`, `base_bid`, `max_bid`) VALUES
(1, 'JAR VC', 'Vice Captains', 140000, 140000),
(2, 'SBW - 1', 'Senior Bowlers', 90000, 115000),
(3, 'SBT - 4', 'Senior Batsmen - 4', 40000, 50000),
(4, 'SBT - 3', 'Senior Batsmen - 3', 90000, 115000),
(5, 'SBT - 2', 'Senior Batsmen - 2', 90000, 115000),
(6, 'SBT - 1', 'Senior Batsmen - 1', 65000, 80000),
(7, 'SAR - 2', 'Senior All Rounders - 2', 90000, 115000),
(8, 'SAR - 1', 'Senior All Rounders - 1', 65000, 80000),
(9, 'JBW - 2', 'Junior Bowlers - 2', 65000, 80000),
(10, 'JBW - 1', 'Junior Bowlers - 1', 90000, 115000),
(11, 'JBT - 2', 'Junior Batsmen - 2', 40000, 50000),
(12, 'JBT - 1', 'Junior Batsmen - 1', 65000, 80000),
(13, 'JAR - 2', 'Junior All Rounders - 2', 65000, 80000),
(14, 'JAR - 1', 'Junior All Rounders - 1', 40000, 50000),
(15, 'Null', 'Null', 0, 0);

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
  `team_id` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Players`
--

INSERT INTO `Players` (`player_id`, `group_id`, `player_fname`, `player_lname`, `player_image`, `team_id`, `price`) VALUES
(397, 8, 'Rajesh', 'Agarwal', 'images/players/Seniors/SAR 1/Rajesh Ramkumar Agarwal.jpg', 0, 0),
(398, 8, 'Ram', 'Jindal', 'images/players/Seniors/SAR 1/Ram Durgaprasad Jindal.png', 0, 0),
(399, 8, 'Vikas', 'Bansal', 'images/players/Seniors/SAR 1/Vikas Rambilas Bansal.png', 0, 0),
(400, 8, 'Rajesh', 'Bansal', 'images/players/Seniors/SAR 1/Rajesh Suresh Bansal.jpg', 0, 0),
(401, 8, 'Ajay', 'Agarwal', 'images/players/Seniors/SAR 1/Ajay Shyam Agarwal.png', 0, 0),
(402, 8, 'Deepak', 'Mittal', 'images/players/Seniors/SAR 1/Deepak  Madanlal Mittal.jpg', 0, 0),
(403, 11, 'Sagar', 'Agarwal', 'images/players/Juniors/JBT 2/Sagar Rameshchand Agarwal.jpg', 0, 0),
(404, 11, 'Devesh', 'Agarwal', 'images/players/Juniors/JBT 2/Devesh Deepak Agarwal.png', 0, 0),
(405, 11, 'Mayank', 'Garg', 'images/players/Juniors/JBT 2/Mayank Sunil Garg.jpg', 0, 0),
(406, 11, 'Anuj', 'Agarwal', 'images/players/Juniors/JBT 2/Anuj Balkrishan Agarwal.png', 0, 0),
(407, 11, 'Sagar', 'Mittal', 'images/players/Juniors/JBT 2/Sagar Sanjay Mittal.jpg', 0, 0),
(408, 11, 'Vivek', 'Agarwal', 'images/players/Juniors/JBT 2/Vivek (Lakhan) Vijay Agarwal.png', 0, 0),
(409, 2, 'Satpal', 'Mittal', 'images/players/Seniors/SBW 1/Satpal Bhagatram Mittal.png', 0, 0),
(410, 2, 'Amul', 'Chamaria', 'images/players/Seniors/SBW 1/Amul Rajendra Chamaria.png', 0, 0),
(411, 2, 'Dinesh', 'Agarwal', 'images/players/Seniors/SBW 1/Dinesh Radheshyam Agarwal.png', 0, 0),
(412, 2, 'Pawan', 'Mittal', 'images/players/Seniors/SBW 1/Pawan Naresh Mittal.jpg', 0, 0),
(413, 2, 'Amitabh', 'Agarwal', 'images/players/Seniors/SBW 1/Amitabh Agarwal.JPG', 0, 0),
(414, 2, 'Subhash', 'Agarwal', 'images/players/Seniors/SBW 1/Subhash Rameshwar Agarwal.jpg', 0, 0),
(415, 9, 'Pritesh', 'Garg', 'images/players/Juniors/JBW 2/Pritesh Rupesh Garg.jpg', 0, 0),
(416, 9, 'Yash', 'Mittal', 'images/players/Juniors/JBW 2/Yash Ashok Mittal.jpg', 0, 0),
(417, 9, 'Shubham', 'Garg', 'images/players/Juniors/JBW 2/Shubham Anand Garg.JPG', 0, 0),
(418, 9, 'Aman', 'Garg', 'images/players/Juniors/JBW 2/Aman Surendra Garg.jpg', 0, 0),
(419, 9, 'Hritik', 'Mittal', 'images/players/Juniors/JBW 2/Hritik Joginder Mittal.jpg', 0, 0),
(420, 9, 'Akshay', 'Agarwal', 'images/players/Juniors/JBW 2/Akshay Sumesh Agarwal.jpg', 0, 0),
(421, 13, 'Piyush', 'Agarwal', 'images/players/Juniors/JAR 2/Piyush Rajesh Agarwal.jpg', 0, 0),
(422, 13, 'Gourav', 'Bansal', 'images/players/Juniors/JAR 2/Gourav Pradeep Bansal.jpg', 0, 0),
(423, 13, 'Sunny', 'Gupta', 'images/players/Juniors/JAR 2/Sunny Subhash Gupta.png', 0, 0),
(424, 13, 'Vinay', 'Gupta', 'images/players/Juniors/JAR 2/Vinay Dindayal Gupta.jpg', 0, 0),
(425, 13, 'Ritesh', 'Agarwal', 'images/players/Juniors/JAR 2/Ritesh Laxminarayan Agarwal.jpg', 0, 0),
(426, 13, 'Tejas', 'Agarwal', 'images/players/Juniors/JAR 2/Tejas Satish Agarwal.jpg', 0, 0),
(427, 6, 'Dr.', 'Mittal', 'images/players/Seniors/SBT 1/Dr. Rajesh Deendayal Mittal.png', 0, 0),
(428, 6, 'Sanjay', 'Bansal', 'images/players/Seniors/SBT 1/Sanjay Ramkumar Bansal.jpg', 0, 0),
(429, 6, 'Vijay', 'Garg', 'images/players/Seniors/SBT 1/Vijay Mitrasen Garg.JPG', 0, 0),
(430, 6, 'Dilip', 'Gupta', 'images/players/Seniors/SBT 1/Dilip Satyanarayan Gupta.JPG', 0, 0),
(431, 6, 'Manish', 'Agarwal', 'images/players/Seniors/SBT 1/Manish Ramkumar Agarwal.png', 0, 0),
(432, 6, 'Sachin', 'Agarwal', 'images/players/Seniors/SBT 1/Sachin Ashok Agarwal.png', 0, 0),
(433, 7, 'Vinod', 'Gupta', 'images/players/Seniors/SAR 2/Vinod Vedprakash Gupta.png', 0, 0),
(434, 7, 'Vikas', 'Agarwal', 'images/players/Seniors/SAR 2/Vikas Vilayatiram Agarwal.jpg', 0, 0),
(435, 7, 'Vijay', 'Garg', 'images/players/Seniors/SAR 2/Vijay Roshanlal Garg.png', 0, 0),
(436, 7, 'Anand', 'Agarwal', 'images/players/Seniors/SAR 2/Anand Subhash Agarwal.png', 0, 0),
(437, 7, 'Sanjay', 'Agarwal', 'images/players/Seniors/SAR 2/Sanjay Ramgopal Agarwal.png', 0, 0),
(438, 7, 'Krishanlal', 'Bansal', 'images/players/Seniors/SAR 2/Krishanlal Jialal Bansal.jpg', 0, 0),
(439, 12, 'Sagar', 'Agarwal', 'images/players/Juniors/JBT 1/Sagar Nandlal Agarwal.png', 0, 0),
(440, 12, 'Sagar', 'Agarwal', 'images/players/Juniors/JBT 1/Sagar Mohan Agarwal.jpg', 0, 0),
(441, 12, 'Rishabh', 'Bansal', 'images/players/Juniors/JBT 1/Rishabh Bansal.jpg', 0, 0),
(442, 12, 'Akash', 'Agarwal', 'images/players/Juniors/JBT 1/Akash Nandlal Agarwal.jpg', 0, 0),
(443, 12, 'Nikhil', 'Mittal', 'images/players/Juniors/JBT 1/Nikhil Shyam Mittal.png', 0, 0),
(444, 12, 'Hiten', 'Agarwal', 'images/players/Juniors/JBT 1/Hiten Subhash Agarwal.png', 0, 0),
(445, 1, 'Pranava (Monty)', 'Gupta', 'images/players/Juniors/JAR Vice Captains/Pranava (Monty) Vinod Gupta.png', 0, 0),
(446, 1, 'Ritesh', 'Agarwal', 'images/players/Juniors/JAR Vice Captains/Ritesh Rajesh Agarwal.png', 0, 0),
(447, 1, 'Pranav', 'Gupta', 'images/players/Juniors/JAR Vice Captains/Pranav Dilip Gupta.jpg', 0, 0),
(448, 1, 'Karan', 'Garg', 'images/players/Juniors/JAR Vice Captains/Karan Vijay Garg.png', 0, 0),
(449, 1, 'Prateek', 'Gupta', 'images/players/Juniors/JAR Vice Captains/Prateek Vinod Gupta.png', 0, 0),
(450, 1, 'Chetan', 'Agarwal', 'images/players/Juniors/JAR Vice Captains/Chetan Satyaprakash Agarwal.jpg', 0, 0),
(451, 10, 'Siddhant', 'Jain', 'images/players/Juniors/JBW 1/Siddhant Sandeep Jain.png', 0, 0),
(452, 10, 'Chirag', 'Agarwal', 'images/players/Juniors/JBW 1/Chirag Pavan Agarwal.jpg', 0, 0),
(453, 10, 'Kapil', 'Agarwal', 'images/players/Juniors/JBW 1/Kapil Subhash Agarwal.png', 0, 0),
(454, 10, 'Devansh', 'Bansal', 'images/players/Juniors/JBW 1/Devansh Manish Bansal.jpg', 0, 0),
(455, 10, 'Rohit', 'Goyal', 'images/players/Juniors/JBW 1/Rohit Krishan Goyal.jpg', 0, 0),
(456, 10, 'Akshay', 'Agarwal', 'images/players/Juniors/JBW 1/Akshay Pavan Agarwal.jpg', 0, 0),
(457, 3, 'Yogesh', 'Agarwal', 'images/players/Seniors/SBT 4/Yogesh Shamlal Agarwal.jpg', 0, 0),
(458, 3, 'Surendra', 'Garg', 'images/players/Seniors/SBT 4/Surendra Garg.png', 0, 0),
(459, 3, 'Sandeep', 'Agarwal', 'images/players/Seniors/SBT 4/Sandeep Narendra Agarwal.jpg', 0, 0),
(460, 3, 'Sunil', 'Garg', 'images/players/Seniors/SBT 4/Sunil Garg.png', 0, 0),
(461, 3, 'Sanjay', 'Agarwal', 'images/players/Seniors/SBT 4/Sanjay Rameshwar Agarwal.jpg', 0, 0),
(462, 3, 'Pradeep', 'Bansal', 'images/players/Seniors/SBT 4/Pradeep Bansal.jpg', 0, 0),
(463, 14, 'Khush', 'Agarwal', 'images/players/Juniors/JAR 1/Khush Rajiv Agarwal.jpg', 0, 0),
(464, 14, 'Rohan', 'Goel', 'images/players/Juniors/JAR 1/Rohan Mahendra Goel.jpg', 0, 0),
(465, 14, 'Punit', 'Agarwal', 'images/players/Juniors/JAR 1/Punit Rajkumar Agarwal.jpeg', 0, 0),
(466, 14, 'Yash', 'Gupta', 'images/players/Juniors/JAR 1/Yash Sushil Gupta.jpg', 0, 0),
(467, 14, 'Nitish', 'Bansal', 'images/players/Juniors/JAR 1/Nitish Pradeep Bansal.jpg', 0, 0),
(468, 14, 'Rahul', 'Mittal', 'images/players/Juniors/JAR 1/Rahul Satpal Mittal.JPG', 0, 0),
(469, 4, 'Narendra', 'Agarwal', 'images/players/Seniors/SBT 3/Narendra Bhimsen Agarwal.jpg', 0, 0),
(470, 4, 'Vijendra', 'Bansal', 'images/players/Seniors/SBT 3/Vijendra Hariram Bansal.jpg', 0, 0),
(471, 4, 'Rajiv', 'Agarwal', 'images/players/Seniors/SBT 3/Rajiv Agarwal.png', 0, 0),
(472, 4, 'Mahendra', 'Goyal', 'images/players/Seniors/SBT 3/Mahendra Goyal.jpg', 0, 0),
(473, 4, 'Santosh', 'Agarwal', 'images/players/Seniors/SBT 3/Santosh Ramavtar Agarwal.jpg', 0, 0),
(474, 4, 'Anurag', 'Bansal', 'images/players/Seniors/SBT 3/Anurag Suresh Bansal.jpg', 0, 0),
(475, 5, 'Amit', 'Gupta', 'images/players/Seniors/SBT 2/Amit Shivnayaran Gupta.png', 0, 0),
(476, 5, 'Mohan', 'Gupta', 'images/players/Seniors/SBT 2/Mohan Pannalal Gupta.png', 0, 0),
(477, 5, 'Vijay', 'Agarwal', 'images/players/Seniors/SBT 2/Vijay S Agarwal.jpg', 0, 0),
(478, 5, 'Sanjay', 'Gupta', 'images/players/Seniors/SBT 2/Sanjay Pannalal Gupta.png', 0, 0),
(479, 5, 'Ashok', 'Mittal', 'images/players/Seniors/SBT 2/Ashok Ramchander Mittal.JPG', 0, 0),
(480, 5, 'Ashok', 'Goyal', 'images/players/Seniors/SBT 2/Ashok Raghuveer Goyal.jpg', 0, 0);

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
  MODIFY `bid_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;

--
-- AUTO_INCREMENT for table `Players`
--
ALTER TABLE `Players`
  MODIFY `player_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=481;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
