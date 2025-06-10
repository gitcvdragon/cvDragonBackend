-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 27, 2025 at 10:37 AM
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
-- Database: `cv_dragon`
--

-- --------------------------------------------------------

--
-- Table structure for table `appdownloads`
--

CREATE TABLE `appdownloads` (
  `appID` bigint(20) UNSIGNED NOT NULL,
  `referralCode` varchar(10) DEFAULT NULL,
  `ipAddress` varchar(50) DEFAULT NULL,
  `referer` varchar(200) DEFAULT NULL,
  `dateTime` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clprofiles`
--

CREATE TABLE `clprofiles` (
  `clid` bigint(20) UNSIGNED NOT NULL,
  `cvid` bigint(20) UNSIGNED NOT NULL,
  `id` bigint(20) UNSIGNED NOT NULL,
  `design` int(11) NOT NULL,
  `coverName` varchar(100) NOT NULL,
  `coverLetter` text NOT NULL,
  `dateCreated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `resource_carrer_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1 = Active, 0 = Inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `resource_carrer_id`, `title`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Bachelor of Technology (B.Tech / B.E.)', 1, '2025-05-16 08:17:25', '2025-05-16 08:17:25'),
(2, 2, 'Bachelor of Science (B.Sc.)', 1, '2025-05-16 08:17:25', '2025-05-16 08:17:25'),
(3, 3, 'Bachelor of Commerce (B.Com)', 1, '2025-05-16 08:19:11', '2025-05-16 08:19:11'),
(4, 4, 'Bachelor of Arts (B.A.)', 1, '2025-05-16 08:19:11', '2025-05-16 08:19:11');

-- --------------------------------------------------------

--
-- Table structure for table `create-cvprofile`
--

CREATE TABLE `create-cvprofile` (
  `cvid` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `profileName` varchar(100) DEFAULT NULL,
  `sections` varchar(255) DEFAULT NULL,
  `sectionOrder` varchar(255) DEFAULT NULL,
  `design` int(11) DEFAULT NULL,
  `font` int(11) DEFAULT NULL,
  `setting` int(11) DEFAULT NULL,
  `profilePicture` varchar(100) DEFAULT NULL,
  `intro` bigint(20) DEFAULT NULL,
  `basic_info_id` int(11) DEFAULT NULL,
  `contact_id` int(11) DEFAULT NULL,
  `preference_id` int(11) DEFAULT NULL,
  `isPublic` tinyint(4) DEFAULT NULL,
  `progressReport` tinyint(4) DEFAULT NULL,
  `dateUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(6) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `create-cvprofile`
--

INSERT INTO `create-cvprofile` (`cvid`, `id`, `profileName`, `sections`, `sectionOrder`, `design`, `font`, `setting`, `profilePicture`, `intro`, `basic_info_id`, `contact_id`, `preference_id`, `isPublic`, `progressReport`, `dateUpdated`, `status`) VALUES
(11138, 14889791841417, 'new', '[51100,51101,51102,51103,\"51104\",\"51106\",51107,51108,51109,51111,51114,\"51120\",51121,51122,\"51123\",\"51125\"]', '', 10006, 0, 0, '5937', 0, NULL, NULL, NULL, 0, 0, '2020-08-26 11:18:43', 0),
(14336, 14889791841417, 'new', '[\"51099\",51100,51101,51102,51103,\"51106\",\"51108\",51109,\"51110\",\"51111\",\"51114\",\"51115\",\"51118\",\"51119\",\"51120\",51121,\"51122\",\"51123\"]', '', 66, 0, 0, '8304', 0, NULL, NULL, NULL, 0, 0, '2021-02-05 06:44:11', 0),
(162816, 14889791841417, 'Profile 11', '[\"51099\",51100,51101,51102,51103,\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",51109,\"51111\",\"51114\",\"51116\",\"51118\",51121,\"51123\",\"51125\"]', '[\"51106\",\"51103\",\"51104\",\"51099\",\"51125\",\"51105\",\"51108\",\"51109\",\"51107\",\"51116\",\"51114\",\"51123\"]', 1, 0, 0, '124582', 983855, NULL, NULL, NULL, 0, 0, '2025-05-06 06:50:40', 1),
(353441, 14889791841417, 'Profile 2', '[\"51099\",51100,51101,51102,51103,51104,\"51105\",\"51106\",\"51107\",\"51108\",51109,\"51110\",\"51111\",\"51112\",\"51113\",\"51114\",\"51115\",\"51116\",\"51117\",\"51118\",\"51119\",\"51120\",51121,\"51122\",\"51123\",\"51125\"]', '', 0, 0, 3, '', 913388, NULL, NULL, NULL, 0, 0, '2025-05-26 09:25:59', 1);

-- --------------------------------------------------------

--
-- Table structure for table `create-cvprofilesection`
--

CREATE TABLE `create-cvprofilesection` (
  `psid` int(11) NOT NULL,
  `cvid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `section` int(11) DEFAULT NULL,
  `subsection` text DEFAULT NULL,
  `showName` varchar(255) DEFAULT NULL,
  `dateCreated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `create-cvprofilesection`
--

INSERT INTO `create-cvprofilesection` (`psid`, `cvid`, `id`, `section`, `subsection`, `showName`, `dateCreated`, `status`) VALUES
(5819394, 353440, 1748065614627, 51118, '[\"434193\",\"434194\",\"434195\",\"434199\",\"434200\"]', 'Soft Skills', '2025-05-26 09:49:15', 0),
(5819395, 353440, 1748065614627, 51122, '[\"33951\",\"33953\",\"33954\",\"33955\",\"33956\",\"33957\",\"33958\",\"33959\",\"33960\",\"33961\",\"33962\"]', 'Academic Projects', '2025-05-26 09:49:15', 0),
(5819396, 353440, 1748065614627, 51099, '[\"38334\",\"38335\"]', 'Position of Responsibility', '2025-05-26 09:49:15', 0),
(5819397, 353440, 1748065614627, 51105, '[\"4\",\"5\"]', 'Work Projects', '2025-05-26 09:49:15', 0),
(5819398, 353440, 1748065614627, 51111, '[\"5\",\"6\"]', 'Technical Skills', '2025-05-26 09:49:15', 0),
(5819400, 353440, 1748065614627, 51213, '[\"1\"]', 'social links', '2025-05-26 09:49:15', 0),
(5819401, 353441, 1748065614627, 51213, '[\"4\"]', 'social links', '2025-05-24 07:55:11', 1),
(5819402, 353441, 1748065614627, 51118, '[\"434193\",\"434194\",\"434195\"]', 'Soft Skills', '2025-05-24 08:20:14', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-academic-projects`
--

CREATE TABLE `cv-academic-projects` (
  `academicid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-academic-projects`
--

INSERT INTO `cv-academic-projects` (`academicid`, `id`, `title`, `description`, `created`, `status`) VALUES
(14976, 14889791841417, 'digital marketing', 'this is the description', '2022-09-10 08:22:01', 1),
(33962, 1748065614627, 'Laravel Developer', '3 years Laravel experience', '2025-05-24 13:22:09', 1),
(33961, 1748065614627, 'Laravel Developer', '3 years Laravel experience', '2025-05-24 13:22:07', 1),
(33959, 1748065614627, 'Laravel Developer', NULL, '2025-05-24 13:21:09', 1),
(33960, 1748065614627, 'Laravel Developer', NULL, '2025-05-24 13:22:00', 1),
(33957, 1748065614627, 'Laravel Developer', NULL, '2025-05-24 13:17:28', 1),
(33958, 1748065614627, 'Laravel Developer', NULL, '2025-05-24 13:18:07', 1),
(33956, 1748065614627, 'Laravel Developer', '3 years Laravel experience', '2025-05-24 13:17:10', 1),
(33955, 1748065614627, 'Laravel Developer', '3 years Laravel experience', '2025-05-24 13:16:32', 1),
(33951, 1748065614627, 'Laravel Developer', '3 years Laravel experience', '2025-05-24 06:29:28', 1),
(33954, 1748065614627, 'Lorem', 'Lorem description', '2025-05-24 06:33:43', 1),
(33953, 1748065614627, 'Node.js Developer', '5 years Laravel experience', '2025-05-24 06:33:02', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-achievements`
--

CREATE TABLE `cv-achievements` (
  `achieveid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `achievement` varchar(255) DEFAULT NULL,
  `year` year(4) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-achievements`
--

INSERT INTO `cv-achievements` (`achieveid`, `id`, `achievement`, `year`, `description`, `created`, `status`) VALUES
(4408, 14889791841417, 'Awarded the best athlete', '2019', 'state level ', '2022-05-03 19:43:40', 1),
(4410, 14889791841417, 'Won 5th prize in Business plan completion.', '2019', 'organized by some body ', '2020-09-16 12:51:47', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-association`
--

CREATE TABLE `cv-association` (
  `associationid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `dateJoining` date DEFAULT NULL,
  `dateLeaving` date DEFAULT NULL,
  `present` tinyint(4) DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cv-basic-info`
--

CREATE TABLE `cv-basic-info` (
  `basicinfoid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `cvFullName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `verified` tinyint(4) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `dateBirth` date DEFAULT NULL,
  `maritalStatus` varchar(20) DEFAULT NULL,
  `dateCreated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `cv-basic-info`
--

INSERT INTO `cv-basic-info` (`basicinfoid`, `id`, `cvFullName`, `verified`, `nationality`, `gender`, `dateBirth`, `maritalStatus`, `dateCreated`, `status`) VALUES
(2, 14889791841417, 'cvDragon', 1, 'Indian', 'Male', '1992-05-13', 'Unmarried', '2025-05-06 06:38:02', 1),
(14, 1748065614627, 'Teethi dhar', NULL, 'Indian', 'FeMale', '1996-07-15', 'Married', '2025-05-24 05:48:29', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-certification`
--

CREATE TABLE `cv-certification` (
  `certificateid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `certificate` varchar(250) DEFAULT NULL,
  `authority` varchar(150) DEFAULT NULL,
  `year` year(4) DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-certification`
--

INSERT INTO `cv-certification` (`certificateid`, `id`, `certificate`, `authority`, `year`, `refID`, `created`, `status`) VALUES
(6574, 14889791841417, 'Digital Marketing Online Winter Training', 'Microsoft', '2021', NULL, '2022-01-19 19:34:56', 1),
(25094, 14889791841417, 'Digital Marketing Fundamentals', '', '2021', NULL, '2022-02-03 11:16:47', 1),
(25096, 14889791841417, 'AutoCAD Training Certification', '', '2022', NULL, '2022-02-03 11:17:35', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-co-curricular-activities`
--

CREATE TABLE `cv-co-curricular-activities` (
  `activityid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cv-contact`
--

CREATE TABLE `cv-contact` (
  `contactid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `phoneNumber` varchar(50) DEFAULT NULL,
  `emailAddress` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `fullAddress` text DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-contact`
--

INSERT INTO `cv-contact` (`contactid`, `id`, `phoneNumber`, `emailAddress`, `location`, `fullAddress`, `created`, `status`) VALUES
(1, 14889791841417, '9163942424', 'cherag.bachhawat@lifeinmba.com', 'Kolkata, WB', '<div>Vivek Vihar&nbsp;</div><div><br></div>', '2025-05-06 06:38:02', 1),
(2, 14889791841419, '7278340780', 'dhar.teethi@gmail.com', 'Agarpara', 'kolkata', '2025-05-23 10:33:24', 1),
(4, 1748065614627, '6290489884', 'dhar.teethi@gmail.com', 'Agarpara', 'kolkata', '2025-05-24 06:00:02', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-education`
--

CREATE TABLE `cv-education` (
  `eduid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `category` varchar(10) DEFAULT NULL,
  `institute` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `university` varchar(100) DEFAULT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `grade` varchar(50) DEFAULT NULL,
  `score` varchar(50) DEFAULT NULL,
  `year` varchar(4) DEFAULT NULL,
  `visibility` tinyint(4) DEFAULT 1,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(1) DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-education`
--

INSERT INTO `cv-education` (`eduid`, `id`, `category`, `institute`, `location`, `university`, `specialization`, `grade`, `score`, `year`, `visibility`, `refID`, `created`, `status`) VALUES
(188, 14889791841417, 'classX', 'St Aloysius School', 'Kolkata', 'Autonomous', '', 'CGPA', '8', '2002', 1, NULL, '2023-01-15 16:52:09', 1),
(189, 14889791841417, 'classXII', 'North Point School', 'Kolkata', 'ISC', 'XII Specialization (Science)', '', '', '2004', 1, NULL, '2022-11-07 06:17:03', 1),
(190, 14889791841417, 'graduation', 'Bhawanipur Education Society', 'Kolkata', 'Calcutta University', 'Commerce', '%', '50', '2007', 1, NULL, '2023-01-15 16:49:57', 1),
(262760, 14889791841417, 'diploma', ' AbC', 'Aambaliyasan, Gujarat', 'AURO University', 'B Ed (Accounts)', '%', '76', ' 201', 1, NULL, '2022-11-07 06:16:59', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-images`
--

CREATE TABLE `cv-images` (
  `imageid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-images`
--

INSERT INTO `cv-images` (`imageid`, `id`, `image`, `created`, `status`) VALUES
(5984, 14889791841417, '159861870452.jpeg', '2021-01-10 05:08:46', 0),
(6288, 14889791841417, '159971004629.jpeg', '2021-01-10 05:08:45', 0),
(8304, 14889791841417, '1607613744148.jpg', '2021-01-10 05:10:05', 0),
(9341, 14889791841417, '1610255396537.jpg', '2021-12-04 18:06:38', 0),
(10000, 14889791841417, '1611435041786.jpg', '2021-01-30 08:35:04', 0),
(11611, 14889791841417, '1613547235291.jpg', '2021-02-25 19:47:20', 0),
(12667, 14889791841417, '1614955709420.jpg', '2021-04-02 07:31:13', 0),
(12835, 14889791841417, '1615364598260.jpg', '2021-03-11 07:00:20', 0),
(12976, 14889791841417, '1615657197485.jpg', '2021-12-18 18:28:49', 0),
(13136, 14889791841417, '1615901135817.jpg', '2021-04-02 06:56:25', 0),
(27011, 14889791841417, '1627767899906.jpg', '2022-02-09 05:11:28', 0),
(44805, 14889791841417, '1638641047169.jpg', '2021-12-18 18:28:42', 0),
(45504, 14889791841417, '1639308156864.jpg', '2021-12-13 17:51:17', 0),
(46107, 14889791841417, '1639852508107.jpg', '2022-02-07 10:31:00', 0),
(48155, 14889791841417, '1641835883492.jpg', '2022-02-07 10:30:47', 0),
(51995, 14889791841417, '1644229830505.jpg', '2022-02-07 12:24:07', 0),
(51996, 14889791841417, '1644229939588.jpg', '2022-02-07 12:24:09', 0),
(51997, 14889791841417, '1644230108274.jpg', '2022-02-09 05:12:54', 0),
(52130, 14889791841417, '1644314449578.jpg', '2022-02-09 05:10:48', 0),
(52237, 14889791841417, '1644383565125.jpg', '2022-02-09 10:40:04', 0),
(52238, 14889791841417, '1644383605094.jpg', '2022-02-09 08:52:14', 0),
(52266, 14889791841417, '1644397470061.jpg', '2022-02-09 10:19:49', 0),
(52267, 14889791841417, '1644397561377.jpg', '2022-02-09 09:08:10', 0),
(52291, 14889791841417, '1644403227944.jpg', '2022-02-09 13:06:34', 0),
(52292, 14889791841417, '1644403256517.jpg', '2022-02-09 13:06:29', 0),
(52293, 14889791841417, '1644403298029.jpg', '2022-02-09 13:06:33', 0),
(52294, 14889791841417, '1644403338857.jpg', '2022-02-18 05:18:10', 0),
(52297, 14889791841417, '1644403449720.jpg', '2022-02-09 10:44:11', 1),
(52298, 14889791841417, '1644403491463.jpg', '2022-02-09 13:14:19', 0),
(53387, 14889791841417, '1645161511973.jpg', '2023-07-16 20:50:19', 0),
(53388, 14889791841417, '1645161530187.jpg', '2022-06-04 19:26:02', 0),
(54195, 14889791841417, '1645783431140.jpg', '2022-06-04 19:26:00', 0),
(55138, 14889791841417, '164673361960.jpeg', '2023-07-16 20:50:22', 0),
(61854, 14889791841417, '1651607140351.jpg', '2022-05-13 06:32:54', 0),
(124582, 14889791841417, '1687528425019.jpg', '2023-07-16 20:44:42', 0);

-- --------------------------------------------------------

--
-- Table structure for table `cv-interests`
--

CREATE TABLE `cv-interests` (
  `interestid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `interest` varchar(150) DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-interests`
--

INSERT INTO `cv-interests` (`interestid`, `id`, `interest`, `refID`, `created`, `status`) VALUES
(112, 14889791841417, 'Listening to music', NULL, '2021-01-02 11:59:56', 1),
(14707, 14889791841417, 'Bowling', NULL, '2021-01-02 12:00:56', 1),
(17764, 14889791841417, 'Travelling', NULL, '2021-02-02 12:46:34', 1),
(20047, 14889791841417, 'Hunting', NULL, '2021-02-25 13:15:55', 1),
(20048, 14889791841417, 'Camping', NULL, '2021-02-25 13:15:55', 1),
(20049, 14889791841417, 'Kayaking', NULL, '2021-02-25 13:15:55', 1),
(20050, 14889791841417, 'Music', NULL, '2021-02-25 13:15:55', 1),
(20051, 14889791841417, 'Knitting', NULL, '2021-02-25 13:15:56', 1),
(20052, 14889791841417, 'Archery', NULL, '2021-02-25 13:17:35', 1),
(20053, 14889791841417, 'Learn New Things', NULL, '2021-02-25 13:17:35', 1),
(20054, 14889791841417, 'Gardening', NULL, '2021-02-25 13:17:36', 1),
(20096, 14889791841417, 'Reading', NULL, '2021-02-25 19:53:04', 1),
(20976, 14889791841417, 'Yoga', NULL, '2021-03-05 19:55:26', 1),
(20977, 14889791841417, 'Canoeing', NULL, '2021-03-05 19:55:27', 1),
(21018, 14889791841417, 'gh', NULL, '2021-03-06 08:56:36', 1),
(21238, 14889791841417, 'Antiquities', NULL, '2021-03-09 08:29:35', 1),
(21253, 14889791841417, 'Astronomy', NULL, '2021-03-09 12:37:46', 1),
(21255, 14889791841417, 'Calligraphy', NULL, '2021-03-09 12:37:47', 1),
(21762, 14889791841417, 'Cycling', NULL, '2021-03-15 19:28:06', 1),
(187732, 14889791841417, 'wbc', NULL, '2023-01-18 20:49:33', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-internship`
--

CREATE TABLE `cv-internship` (
  `internshipid` int(11) NOT NULL,
  `workid` int(11) DEFAULT NULL,
  `organization` varchar(50) DEFAULT NULL,
  `id` bigint(20) NOT NULL,
  `title` varchar(250) DEFAULT NULL,
  `designation` varchar(50) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-internship`
--

INSERT INTO `cv-internship` (`internshipid`, `workid`, `organization`, `id`, `title`, `designation`, `duration`, `location`, `description`, `refID`, `created`, `status`) VALUES
(80, 0, 'Linc Pen & Plastics Ltd.', 14889791841417, 'Study the distribution system of Linc and to understand the purchasing pattern of customers', 'Summer Trainee', '2 Months', 'Rohtak', '<ol>\n<li>Conducted a survey via questionnaire in Burdwan town to identify consumers preferences related to pen. </li>\n<li>Interacted with consumers to understand the consumer insights of premium range pen brands in Kolkata</li>\n</ol>\n', NULL, '2022-09-10 08:23:35', 1),
(21867, 0, 'Aakash Institute', 14889791841417, '', 'Business Strategy', '2 Months', 'Akbarpur, UP', 'Gi', NULL, '2022-09-10 08:22:35', 1),
(21868, 0, 'Aakash Institute', 14889791841417, 'hi', 'u', '2 Months', 'Ajaigarh, MP', '', NULL, '2022-09-10 08:21:35', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-introduction`
--

CREATE TABLE `cv-introduction` (
  `introid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `cv-introduction`
--

INSERT INTO `cv-introduction` (`introid`, `id`, `introduction`, `title`, `created`, `status`) VALUES
(7, 1748065614627, 'Laravel developer with 3 years of experience..', 'Laravel developer', '2025-05-24 06:18:12', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-languages`
--

CREATE TABLE `cv-languages` (
  `langid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `language` varchar(50) DEFAULT NULL,
  `readLanguage` tinyint(4) DEFAULT NULL,
  `writeLanguage` tinyint(4) DEFAULT NULL,
  `speakLanguage` tinyint(4) DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-languages`
--

INSERT INTO `cv-languages` (`langid`, `id`, `language`, `readLanguage`, `writeLanguage`, `speakLanguage`, `refID`, `created`, `status`) VALUES
(23518, 14889791841417, 'Manipuri', 0, 0, 1, NULL, '2021-06-10 09:41:00', 1),
(33340, 14889791841417, 'Bengali', 1, 1, 1, NULL, '2021-05-07 20:01:49', 1),
(39046, 14889791841417, 'Arabic', 1, 0, 1, NULL, '2021-06-09 12:49:30', 1),
(111695, 14889791841417, 'English', 1, 1, 1, NULL, '2022-02-03 11:24:58', 1),
(131002, 14889791841417, 'Finnish', 1, 1, 0, NULL, '2022-05-31 09:28:32', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-patent`
--

CREATE TABLE `cv-patent` (
  `patentid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `patentOffice` varchar(200) DEFAULT NULL,
  `patentStatus` varchar(10) DEFAULT NULL,
  `patentApplication` varchar(100) DEFAULT NULL,
  `patentDate` varchar(10) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cv-poa`
--

CREATE TABLE `cv-poa` (
  `poaid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-poa`
--

INSERT INTO `cv-poa` (`poaid`, `id`, `title`, `description`, `refID`, `created`, `status`) VALUES
(601, 14889791841417, 'Creative Head', 'of the company and the other hand ', NULL, '2025-05-19 08:15:55', 1),
(38335, 1748065614627, 'App Developer', '13 years Laravel experience', NULL, '2025-05-24 07:28:18', 1),
(38334, 1748065614627, 'Laravel Developer', '3 years Laravel experience', NULL, '2025-05-24 06:35:10', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-preference`
--

CREATE TABLE `cv-preference` (
  `prefid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `passport` tinyint(1) DEFAULT NULL,
  `passportDetails` varchar(100) DEFAULT NULL,
  `recommendations` tinyint(1) DEFAULT NULL,
  `preferredLocation` varchar(50) DEFAULT NULL,
  `canRelocate` tinyint(4) DEFAULT NULL,
  `noticePeriod` varchar(20) DEFAULT NULL,
  `canJoin` tinyint(4) DEFAULT NULL,
  `expectedCTC` varchar(100) DEFAULT NULL,
  `isNegotiate` tinyint(4) DEFAULT NULL,
  `declaration` tinyint(1) DEFAULT NULL,
  `signature` varchar(200) DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-preference`
--

INSERT INTO `cv-preference` (`prefid`, `id`, `passport`, `passportDetails`, `recommendations`, `preferredLocation`, `canRelocate`, `noticePeriod`, `canJoin`, `expectedCTC`, `isNegotiate`, `declaration`, `signature`, `refID`, `created`, `status`) VALUES
(1, 14889791841417, 0, '', 0, 'kolkata', 1, '', 0, '55 Laca', 0, 0, 'https://cvdragon.com/public/resources/documentUpload/171819604441.svg', NULL, '2025-02-19 10:41:08', 1),
(325750, 1748065614627, NULL, 'lorem', NULL, 'kolkata', 1, '15 Days', 1, '30000', 1, 1, 't.dhar', NULL, '2025-05-24 06:14:30', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-presentations`
--

CREATE TABLE `cv-presentations` (
  `activityid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-presentations`
--

INSERT INTO `cv-presentations` (`activityid`, `id`, `title`, `description`, `refID`, `created`, `status`) VALUES
(7232, 14889791841417, 'Mentor', 'Cherag Bachhawat', NULL, '2023-08-11 20:12:26', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-project`
--

CREATE TABLE `cv-project` (
  `projectid` int(11) NOT NULL,
  `workid` int(11) DEFAULT NULL,
  `organization` varchar(150) DEFAULT NULL,
  `id` bigint(20) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `designation` varchar(50) DEFAULT NULL,
  `duration` varchar(20) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-project`
--

INSERT INTO `cv-project` (`projectid`, `workid`, `organization`, `id`, `title`, `designation`, `duration`, `location`, `description`, `refID`, `created`, `status`) VALUES
(1, NULL, 'abc', 14889791841419, 'Laravel Developer', 'backend developer', '3 months', NULL, '3 years Laravel experience', NULL, '2025-05-23 11:37:28', 1),
(2, NULL, 'xyz', 14889791841419, 'PHP Developer', NULL, '5 months', NULL, '5 years PHP experience', NULL, '2025-05-23 11:37:28', 1),
(4, NULL, 'cvDragon 3', 1748065614627, 'Resume Builder App for backend', 'Backend Developer 3', '8 Months', 'kolkata', 'nothing new to say', NULL, '2025-05-24 07:23:04', 1),
(5, NULL, 'cvDragon', 1748065614627, 'Ecommerce project App', 'Backend Developer', '12 Months', 'Kolkata', 'loremm', NULL, '2025-05-24 06:43:11', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-publications`
--

CREATE TABLE `cv-publications` (
  `publishid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `publisher` varchar(200) DEFAULT NULL,
  `publishDate` varchar(10) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-publications`
--

INSERT INTO `cv-publications` (`publishid`, `id`, `title`, `category`, `publisher`, `publishDate`, `description`, `refID`, `created`, `status`) VALUES
(1, 14889791841417, 'You can search B-Schools | Universities | Courses', 'Bulletin', 'Times of India', '2016-03-02', '<div>Enter details about your writings that have been published in any journal, magazine, newspaper or have been included in any conference proceedings Enter details about your writings that have been published in any journal, magazine, newspaper or have been included in any conference proceedings&nbsp;</div>', NULL, '2019-06-27 00:40:45', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-skills`
--

CREATE TABLE `cv-skills` (
  `skillid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `skill` varchar(100) DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-skills`
--

INSERT INTO `cv-skills` (`skillid`, `id`, `skill`, `refID`, `created`, `status`) VALUES
(434198, 1748065614627, 'HTML', NULL, '2025-05-24 08:07:49', 1),
(434108, 14889791841417, 'Organizational', NULL, '2025-05-06 06:42:14', 1),
(434197, 1748065614627, 'HTML', NULL, '2025-05-24 08:05:10', 0),
(434196, 1748065614627, 'laravel', NULL, '2025-05-24 08:20:14', 0),
(434195, 1748065614627, 'Node js', NULL, '2025-05-24 06:27:24', 1),
(434193, 1748065614627, 'laravel', NULL, '2025-05-24 06:26:28', 1),
(434194, 1748065614627, 'php', NULL, '2025-05-24 06:27:07', 1),
(434199, 1748065614627, 'HTML', NULL, '2025-05-24 13:23:10', 1),
(434200, 1748065614627, 'HTML', NULL, '2025-05-24 13:23:31', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-technical`
--

CREATE TABLE `cv-technical` (
  `technicalid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `technical` varchar(250) DEFAULT NULL,
  `level` varchar(100) DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-technical`
--

INSERT INTO `cv-technical` (`technicalid`, `id`, `technical`, `level`, `refID`, `created`, `status`) VALUES
(5, 1748065614627, 'Cooking', NULL, NULL, '2025-05-24 06:46:23', 1),
(6, 1748065614627, 'time managment', NULL, NULL, '2025-05-24 06:47:02', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-trainings`
--

CREATE TABLE `cv-trainings` (
  `trainingid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `training` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(1) NOT NULL DEFAULT 1 COMMENT '1=active, 0=inactive'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-trainings`
--

INSERT INTO `cv-trainings` (`trainingid`, `id`, `training`, `description`, `number`, `refID`, `created`, `status`) VALUES
(1510, 14889791841417, 'Profile Building Workshops', '', 52, NULL, '2022-11-03 14:16:26', 1),
(1511, 14889791841417, 'LinkedIn Profile Building', '', 20, NULL, '2022-11-03 14:16:35', 1),
(1512, 14889791841417, 'Digital Interviews - How to Crack', '', 30, NULL, '2022-11-03 14:16:45', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cv-volunteer`
--

CREATE TABLE `cv-volunteer` (
  `volunteerid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `organization` varchar(50) NOT NULL,
  `cause` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL,
  `dateJoining` date DEFAULT NULL,
  `dateLeaving` date DEFAULT NULL,
  `present` tinyint(4) NOT NULL,
  `description` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  `proofRead` tinyint(4) NOT NULL,
  `proofReadDate` date NOT NULL,
  `masterID` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `refID` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-volunteer`
--

INSERT INTO `cv-volunteer` (`volunteerid`, `id`, `organization`, `cause`, `role`, `dateJoining`, `dateLeaving`, `present`, `description`, `created`, `proofRead`, `proofReadDate`, `masterID`, `status`, `refID`) VALUES
(334, 14889791841417, 'volunteers', 'abc', 'abf', '2020-01-05', '0000-00-00', 0, '<div></div>', '2025-05-15 09:15:42', 0, '0000-00-00', 0, 1, 1609824953840);

-- --------------------------------------------------------

--
-- Table structure for table `cv-work`
--

CREATE TABLE `cv-work` (
  `workid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `organization` varchar(200) NOT NULL,
  `designation` varchar(200) NOT NULL,
  `location` varchar(100) NOT NULL,
  `dateJoined` date NOT NULL,
  `dateResigned` date DEFAULT NULL,
  `currentWorking` smallint(1) NOT NULL,
  `workProfile` text NOT NULL,
  `refID` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cv-work`
--

INSERT INTO `cv-work` (`workid`, `id`, `organization`, `designation`, `location`, `dateJoined`, `dateResigned`, `currentWorking`, `workProfile`, `refID`, `created`, `status`) VALUES
(270, 14889791841417, 'cvDragon', 'Entrepreneur', 'Kolkata', '2018-05-02', '2021-01-07', 1, '<div><br></div><ul><li>Set direction and establish the desired image for the business</li><li>Seek new directons and ways to improve the growth of the company</li><li>Responsibility of the overall marketing plan for the busines</li><li>Responsibility of the final decision on strategic and sometimes operational matte beautifulsoup</li><li>Oversee financial records and take action such as securing a new line of credit to handle unforeseen events</li><li>Responsibility of the final decision on strategic and sometimes operational matters</li><li>Responsibility of the overall marketing plan for the busines</li><li>versee financial records and take action such as securing a new line of credit to handle unforeseen events</li><li>Responsibility of the final decision on strategic and sometimes operational matters</li><li>Responsibility of the overall marketing plan for the business</li></ul>', NULL, '2022-03-30 13:22:20', 1),
(8957, 14889791841417, 'Asian Paints Ltd', 'Academic', 'Kolkata, WB', '1922-04-24', '2025-06-19', 0, '<div></div><ul><li>Manage orientation, training and relocation for new faculties</li><li>Provide guidance to students on academic goals and educational issues</li></ul>', NULL, '2022-03-30 13:27:03', 1),
(9028, 14889791841417, 'Asian Paints Ltd', 'Assistant Manager - Marketing', 'Kolkata, WB', '2020-09-22', '2021-10-30', 0, '<div></div><ul><li>Maintained high-end marketing deals with market</li><li>Satisfied  market needs and monitor the techniques of marketing</li></ul>', NULL, '2022-02-25 12:24:34', 1),
(13065, 14889791841417, 'Adani Ports & Special Economic Zone Ltd', 'Account Executive', 'Aduthurai, TN', '1922-05-04', '2002-04-26', 0, 'Hshhs', NULL, '2022-03-30 13:30:29', 1),
(14422, 14889791841417, 'Asian Paints Ltd', 'Accountant', 'Ambagarh Chowki, Chhattisgarh', '2022-03-10', '2022-03-31', 0, '<div></div><ul><li>Performed reconciliations of accounts, statements for the firm</li><li>Prepared the financial reports on period wise basis</li><li>Computation of taxes, tax returns, maintain financial records</li><li>Prepared budget forecasts, and reduce the uncertainties for the period</li><li>Ensured timely and effective bank payments to overpay taxations</li><li>Managed all the financial transactions</li></ul>', NULL, '2022-04-15 18:23:42', 1),
(14448, 14889791841417, 'Asian Paints Ltd', 'Account Executive', 'Ahmedabad Cantonment, Gujarat', '2000-03-01', '2022-03-30', 1, '<div></div><ul><li>Negotiate agreements and keep records of sales and data</li><li>Present products to prospective clients</li><li>Provide professional aftersales support to maximize customer loyalty</li><li>Remain in regular contact with your clients to understand and meet their needs</li></ul>', NULL, '2022-03-30 13:44:03', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cvdragonappconfignew`
--

CREATE TABLE `cvdragonappconfignew` (
  `configid` int(11) NOT NULL,
  `configkey` varchar(100) NOT NULL,
  `changesBeforeUpdate` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `configvalue` tinyint(4) NOT NULL,
  `configvalueios` tinyint(4) NOT NULL,
  `parameter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sendData` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `cvdragonappconfignew`
--

INSERT INTO `cvdragonappconfignew` (`configid`, `configkey`, `changesBeforeUpdate`, `version`, `configvalue`, `configvalueios`, `parameter`, `sendData`) VALUES
(1, 'FREE_SUBSCRIPTION', 'depricated', 5, 1, 1, '', 1),
(2, 'HOME_PAGE_NOTIFICATION', 'Display Notifications on Home Screen', 5, 1, 1, '', 1),
(3, 'HOME_PAGE_SUBSCRIPTION', 'depricated', 5, 1, 1, '', 1),
(4, 'SIDE_MENU_SERVICES', 'depricated', 5, 1, 1, '', 1),
(5, 'HOME_PAGE_SERVICES', 'Display Service Block on Home Screen', 5, 0, 0, '', 1),
(6, 'DOWNLOAD_POPUP_CONTACT', 'hide the download icon in preview for iOS', 5, 0, 0, '{ \n\"usage\": [3,2], \n\"show\": [1,2,3]\n}', 1),
(7, 'SIDE_MENU_SUBSCRIPTION', 'depricated', 5, 1, 1, '', 1),
(8, 'PHONE_LOGIN', 'Login via Mobile Number', 5, 1, 1, '', 1),
(13, 'WORKSHOPS', 'YES', 5, 1, 1, '', 1),
(14, 'FEED_KNOWLEDGE', 'depricated', 5, 1, 1, '', 1),
(15, 'FEED_JOBS', 'depricated', 5, 1, 1, '', 1),
(16, 'FEED_RESOURCES', 'depricated', 5, 0, 0, '', 1),
(17, 'FEED_SHOWCASE', 'Not in Use - to be Deleted', 5, 0, 0, '', 1),
(18, 'FEED_MYCONNECTIONS', 'Not in Use - to be Deleted', 5, 0, 0, '', 1),
(19, 'FEED_MYINSTITUTE', 'Not in Use - to be Deleted', 5, 0, 0, '', 1),
(20, 'OPTION_DELETE_ACCOUNT', 'Show option to delete account', 5, 1, 1, '', 1),
(21, 'FEATURE_THEME_MODE', 'to be deleted', 5, 1, 1, '', 1),
(22, 'FEATURE_WIZARD', 'Show the Wizard in the Beginning', 5, 1, 1, '', 1),
(23, 'SIDE_MENU_CURRENT_PROFILES', 'depricated', 5, 0, 0, '', 1),
(26, 'CV_BG_GRAPHICS_TOGGLE', 'CV Creation Feature', 6, 1, 1, '{ \r\n\"usage\": [3,2,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 1),
(27, 'CV_COLOR_CHANGE', 'CV Creation Feature', 6, 1, 1, '{ \r\n\"usage\": [3,1,2,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 1),
(28, 'CV_DOB_FORMAT_CHANGE', 'CV Creation Feature', 6, 1, 1, '{ \r\n\"usage\": [1,2,3,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 1),
(29, 'CV_FONT_SIZE_CHANGE', 'CV Creation Feature', 6, 1, 1, '{ \r\n\"usage\": [1,2,3,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 1),
(30, 'CV_FONT_STYLE_CHANGE', 'CV Creation Feature', 6, 1, 1, '{ \n\"usage\": [3,1,2,4,10], \n\"show\": [1,2,3,4,10]\n}', 1),
(31, 'CV_IMAGE_TOGGLE', 'CV Creation Feature', 6, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10]\n}', 1),
(32, 'CV_QRCODE', 'replaced with QRCODE_OPTION_SHOW', 6, 0, 0, '{ \r\n\"usage\": [3,2,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 1),
(33, 'CV_SECTION_DELETE', 'CV Creation Feature', 6, 1, 1, '{ \r\n\"usage\": [1,2,3,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 1),
(34, 'CV_SECTION_RENAME', 'CV Creation Feature', 6, 1, 1, '{ \r\n\"usage\": [3,2,4], \r\n\"show\": [1,2,3,4,10]\r\n}', 1),
(35, 'CV_SECTION_REORDER', 'replaced with REORDERDESIGN', 6, 1, 1, '{ \r\n\"usage\": [3,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 1),
(36, 'DOWNLOAD_POPUP_CONTACT', 'hide the download icon in preview for iOS', 6, 0, 0, '', 1),
(37, 'FEATURE_MY_CONNECTIONS', 'replaced with MYCONNECTIONS', 6, 0, 0, '{ \r\n\"usage\": [3,2,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 0),
(38, 'FEATURE_MY_INSTITUTE', 'replaced with MYINSTITUTE', 6, 0, 0, '', 0),
(39, 'FEATURE_PROOFREAD', 'replaced with PROOFREAD', 6, 0, 0, '{ \r\n\"usage\": [3,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 0),
(40, 'FEATURE_PROOFREAD2', 'replaced with PROOFREAD2', 6, 0, 0, '{ \r\n\"usage\": [3,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 0),
(41, 'FEATURE_RECOMMENDATIONS', 'replaced with RECOMMENDATIONS', 6, 0, 0, '{ \r\n\"usage\": [3,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 0),
(42, 'FEATURE_SHOWCASE', 'replaced with SHOWCASE', 6, 0, 0, '{ \r\n\"usage\": [3,2,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 0),
(43, 'FEATURE_WIZARD', 'Show the Wizard in the Beginning', 6, 1, 1, '', 1),
(44, 'FEATURE_MY_DOCUMENTS', '', 6, 1, 1, '{ \r\n\"usage\": [3,2,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 1),
(45, 'HOME_PAGE_ARTICLES', 'Display Article block on Home Screen', 6, 1, 1, '', 1),
(46, 'HOME_PAGE_CV_DESIGN_LIST', 'Map of all the designs to be shown in the home page', 6, 1, 1, '[96,1,94,98,11,97,13]', 1),
(47, 'HOME_PAGE_DESIGNS', 'Display Design block on Home Screen', 6, 1, 1, '', 1),
(48, 'HOME_PAGE_FAQS', 'Display FAQs block on Homes Screen', 6, 1, 1, '', 1),
(49, 'HOME_PAGE_FREE_SUBSCRIPTION', 'replaced with FREE_SUBSCRIPTION', 6, 1, 0, '', 1),
(50, 'HOME_PAGE_ICONS', 'Display Icons on Home Screen', 6, 1, 1, '', 1),
(51, 'HOME_PAGE_JOBS', 'Display Jobs Block on Home Screen', 6, 1, 1, '', 1),
(52, 'HOME_PAGE_NOTIFICATION', 'Display Notifications on Home Screen', 6, 1, 1, '', 1),
(53, 'HOME_PAGE_ORDER', 'Map of all Features on Home Screen to be Provided Category wise', 6, 1, 1, '{ \r\n\"1\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\",\r\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_MOTTO\"  \r\n],\r\n\"2\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_MOTTO\"   \r\n],\r\n\"3\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_MOTTO\"   \r\n],\r\n\"4\": [ \r\n\"HOME_PAGE_ICONS\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_MOTTO\"   \r\n],  \r\n\"10\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\", \r\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_MOTTO\"   \r\n]\r\n}', 1),
(54, 'HOME_PAGE_SERVICES', 'Display Service Block on Home Screen', 6, 1, 1, '', 1),
(55, 'HOME_PAGE_TIPS', 'Display Tips Block on Home Screen', 6, 1, 1, '', 1),
(56, 'HOME_PAGE_WORKSHOPS', 'Display Workshop Block on Home Screen', 6, 0, 0, '', 1),
(57, 'OPTION_DELETE_ACCOUNT', 'Show option to delete account', 6, 1, 1, '{\"heading\" : \"Are we a problem trying to be a solution?\", \"selectables\" : [\"Don\'t mind, my life is bad...\", \"That was not about me\", \"I was a has-been\"]}', 1),
(58, 'PHONE_LOGIN', 'Login via Mobile Number', 6, 1, 1, '', 1),
(59, 'USER_NOTIFICATION_SETTINGS', 'Hide/Display the notifications in the User Settings Page', 6, 1, 1, '', 1),
(60, 'USER_SERVICES', 'replaced with SIDE_MENU_SERVICES', 6, 1, 1, '{ \r\n\"usage\": [1,2,3,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 1),
(61, 'USER_SUBSCRIPTION', 'replaced with SIDE_MENU_SUBSCRIPTION', 6, 1, 1, '{ \r\n\"usage\": [1,2,3,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 1),
(62, 'USER_CATEGORY', 'Define the User Categories in the system', 6, 1, 1, '{ \n\"1\": \"FREE\", \n\"2\": \"PREMIUM\",\n\"3\": \"👑 PRO\",\n\"4\": \"💗 LIFETIME ACCESS\",\n\"10\": \"🍮 ADMIN\"\n}', 1),
(63, 'USER_DESIGN_ACCESS', 'Define the Designs accessed by the user', 6, 1, 1, '{\r\n\"1\": [0],\r\n\"3\": [0,1,2,3,5],\r\n\"2\": [0,1,2,3],\r\n\"4\": [0,1,2,3,5],\r\n\"10\": [0,1,2,3,5]\r\n}', 1),
(64, 'USER_SUBSCRIPTION_VALIDATION', 'Check the validation of the subscription of the category', 6, 1, 1, '{\"2\": \"Subscription\", \"3\": \"Subscription\", \"4\": \"Subscription\"}', 1),
(65, 'USER_PROFILE_LIMIT', 'Limit the profile creation of a user', 6, 1, 1, '{ \"1\": 2, \"2\": 5, \"3\": 100 , \"4\": 100 , \"10\": 100 }', 1),
(66, 'USER_SUBSCRIPTION_THRESHOLD', 'Subscription Limit days', 6, 1, 1, '{ \"1\": 0, \"2\": 30, \"3\": 15, \"4\": 30 }', 1),
(67, 'CV_PAGE_BREAK_ADD', 'Add Page Break Feature in the application', 6, 1, 1, '{ \r\n\"usage\": [3,2,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 1),
(68, 'CV_WORK_PERIOD_FORMAT', 'Change WOrk Format Duration', 6, 1, 1, '{ \r\n\"usage\": [1,2,3,4,10], \r\n\"show\": [1,2,3,4,10]\r\n}', 1),
(69, 'USER_CATEGORY_UPGRADE', 'Show Upgrade Feature', 6, 1, 1, '[1,2]', 1),
(70, 'USER_FALLBACK_CATEGORY', 'Revert back to the old category once the subscription has expired', 6, 1, 1, '{\"3\": \"1\", \"2\": \"1\", \"4\": \"1\"}', 1),
(71, 'HOME_PAGE_MOTTO', 'Define the content on the Home Screen', 6, 1, 1, 'One - Stop Solution 🤍\nFor all your \nCareer Needs!', 1),
(72, 'CV_INSTITUTE_LOGO_TOGGLE', 'Keep/Remove your institute Logo', 6, 1, 1, '', 1),
(73, 'USER_CATEGORY_DEFAULT', 'Default Category to be used', 6, 1, 1, '1', 1),
(74, 'SERVERTIME_THRESHOLD', 'YES', 6, 1, 1, '300', 1),
(75, 'OPTION_REFERRAL_CODE', 'YES', 6, 0, 0, '', 1),
(76, 'RESOURCE_APP_LIVE', 'GIVE USER ACCESS TO THE APPLICATION', 6, 1, 1, 'The Server is Not Available', 1),
(77, 'RESOURCE_APP_RATING', 'user can give feedback', 6, 1, 1, '{\"max_rating\" : 5, \"1\" : {\"heading\" : \"Describe why are we one big pain\", \"selectables\" : [\"Who knows why my life is bad...\", \"You shouldn\'t get mad because the writer meant to write something funny\"]}, \"2\" : {\"heading\" : \"Describe why are we a pain\", \"selectables\" : [\"Who knows why my life is bad...\", \"You shouldn\'t get mad because the writer meant to write something funny\"]}, \"3\" : {\"heading\" : \"Describe why are we bad\", \"selectables\" : [\"Who knows why my life is bad...\", \"You shouldn\'t get mad because the writer meant to write something funny\"]}, \"4\" : {\"heading\" : \"Describe why did you think that we are\", \"selectables\" : [\"Who knows why my life is bad...\", \"You shouldn\'t get mad because the writer meant to write something funny\"]}, \"5\" : {\"heading\" : \"Describe why don\'t you see a doctor\", \"selectables\" : [\"Who knows why my life is good...\", \"You shouldn\'t get mad because the writer meant to write something funny\"]}}', 1),
(78, 'CV_BG_GRAPHICS_TOGGLE', 'CV Creation Feature', 7, 1, 1, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(79, 'CV_COLOR_CHANGE', 'CV Creation Feature', 7, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(80, 'CV_DOB_FORMAT_CHANGE', 'CV Creation Feature', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(81, 'CV_FONT_SIZE_CHANGE', 'CV Creation Feature', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(82, 'CV_FONT_STYLE_CHANGE', 'CV Creation Feature', 7, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(83, 'CV_IMAGE_TOGGLE', 'CV Creation Feature', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(84, 'CV_INSTITUTE_LOGO_TOGGLE', 'Keep/Remove your institute Logo', 7, 1, 1, '', 1),
(85, 'CV_PAGE_BREAK_ADD', 'Add Page Break Feature in the application', 7, 1, 1, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(86, 'CV_QRCODE', 'replaced with QRCODE_OPTION_SHOW', 7, 0, 0, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(87, 'CV_SECTION_DELETE', 'CV Creation Feature', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(88, 'CV_SECTION_RENAME', 'CV Creation Feature', 7, 1, 1, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(89, 'CV_SECTION_REORDER', 'replaced with REORDERDESIGN', 7, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(90, 'CV_WORK_PERIOD_FORMAT', 'Change WOrk Format Duration', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(91, 'DOWNLOAD_POPUP_CONTACT', 'hide the download icon in preview for iOS', 7, 0, 0, '', 1),
(92, 'FEATURE_MY_CONNECTIONS', 'replaced with MYCONNECTIONS', 7, 0, 0, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(93, 'FEATURE_MY_DOCUMENTS', '', 7, 1, 1, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(94, 'FEATURE_MY_INSTITUTE', 'replaced with MYINSTITUTE', 7, 1, 1, '', 0),
(95, 'FEATURE_PROOFREAD', 'replaced with PROOFREAD', 7, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(96, 'FEATURE_PROOFREAD2', 'replaced with PROOFREAD2', 7, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(97, 'FEATURE_RECOMMENDATIONS', 'replaced with RECOMMENDATIONS', 7, 0, 0, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(98, 'FEATURE_SHOWCASE', 'replaced with SHOWCASE', 7, 0, 0, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(99, 'FEATURE_WIZARD', 'Show the Wizard in the Beginning', 7, 1, 1, '', 1),
(100, 'HOME_PAGE_ARTICLES', 'Display Article block on Home Screen', 7, 1, 1, '', 1),
(101, 'HOME_PAGE_CV_DESIGN_LIST', 'Map of all the designs to be shown in the home page', 7, 1, 1, '[96,1,94,98,11,97,13]', 1),
(102, 'HOME_PAGE_DESIGNS', 'Display Design block on Home Screen', 7, 1, 1, '', 1),
(103, 'HOME_PAGE_FAQS', 'Display FAQs block on Homes Screen', 7, 1, 1, '', 1),
(104, 'HOME_PAGE_FREE_SUBSCRIPTION', 'replaced with FREE_SUBSCRIPTION', 7, 1, 0, '', 1),
(105, 'HOME_PAGE_ICONS', 'Display Icons on Home Screen', 7, 1, 1, '', 1),
(106, 'HOME_PAGE_JOBS', 'Display Jobs Block on Home Screen', 7, 1, 1, '', 1),
(107, 'HOME_PAGE_MOTTO', 'Define the content on the Home Screen', 7, 1, 1, 'One - Stop Solution 🤍\nFor all your \nCareer Needs!', 1),
(108, 'HOME_PAGE_NOTIFICATION', 'Display Notifications on Home Screen', 7, 1, 1, '', 1),
(109, 'HOME_PAGE_ORDER', 'Map of all Features on Home Screen to be Provided Category wise', 7, 1, 1, '{ \n\"1\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"2\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"3\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"4\": [ \n\"HOME_PAGE_ICONS\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_MOTTO\"   \n],  \n\"0\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"10\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_MOTTO\"   \n]\n}', 1),
(110, 'HOME_PAGE_SERVICES', 'Display Service Block on Home Screen', 7, 1, 1, '', 1),
(111, 'HOME_PAGE_TIPS', 'Display Tips Block on Home Screen', 7, 1, 1, '', 1),
(112, 'HOME_PAGE_WORKSHOPS', 'Display Workshop Block on Home Screen', 7, 0, 0, '', 1),
(113, 'OPTION_DELETE_ACCOUNT', 'Show option to delete account', 7, 1, 1, '{\"heading\" : \"Are we a problem trying to be a solution?\", \"selectables\" : [\"Don\'t mind, my life is bad...\", \"That was not about me\", \"I was a has-been\"]}', 1),
(114, 'OPTION_REFERRAL_CODE', 'YES', 7, 0, 0, '', 1),
(115, 'PHONE_LOGIN', 'Login via Mobile Number', 7, 1, 1, '', 1),
(116, 'RESOURCE_APP_LIVE', 'GIVE USER ACCESS TO THE APPLICATION', 7, 0, 0, '{\"image\": \"https://cvdragon.com/public/img/campaignsFiles/RAD2022.jpg\", \"message\": \"Server is currently under maintainance\"}', 1),
(117, 'RESOURCE_APP_RATING', 'user can give feedback', 7, 1, 1, '{\"max_rating\" : 5, \"1\" : {\"heading\" : \"Describe why are we one big pain\", \"selectables\" : [\"Who knows why my life is bad...\", \"You shouldn\'t get mad because the writer meant to write something funny\"]}, \"2\" : {\"heading\" : \"Describe why are we a pain\", \"selectables\" : [\"Who knows why my life is bad...\", \"You shouldn\'t get mad because the writer meant to write something funny\"]}, \"3\" : {\"heading\" : \"Describe why are we bad\", \"selectables\" : [\"Who knows why my life is bad...\", \"You shouldn\'t get mad because the writer meant to write something funny\"]}, \"4\" : {\"heading\" : \"Describe why did you think that we are\", \"selectables\" : [\"Who knows why my life is bad...\", \"You shouldn\'t get mad because the writer meant to write something funny\"]}, \"5\" : {\"heading\" : \"Describe why don\'t you see a doctor\", \"selectables\" : [\"Who knows why my life is good...\", \"You shouldn\'t get mad because the writer meant to write something funny\"]}}', 1),
(118, 'SERVERTIME_THRESHOLD', 'YES', 7, 1, 1, '300', 1),
(119, 'USER_ACCESS_DIGITALCV', 'LIMIT THE OPTION FOR GUEST USER', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(120, 'USER_ACCESS_FAVOURITES', 'LIMIT THE OPTION FOR GUEST USER', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(121, 'USER_ACCESS_FEED', 'LIMIT THE OPTION FOR GUEST USER', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(122, 'USER_ACCESS_HELP', 'LIMIT THE OPTION FOR GUEST USER', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(123, 'USER_ACCESS_LOGOUT', 'LIMIT THE OPTION FOR GUEST USER', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(124, 'USER_ACCESS_MYRESUMES', 'LIMIT THE OPTION FOR GUEST USER', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(125, 'USER_ACCESS_MYSUBSCRIPTION', 'LIMIT THE OPTION FOR GUEST USER', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(126, 'USER_ACCESS_RESYNC', 'LIMIT THE OPTION FOR GUEST USER', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(127, 'USER_ACCESS_SETTINGS', 'LIMIT THE OPTION FOR GUEST USER', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(128, 'USER_ACCESS_WORKSHOPS', 'LIMIT THE OPTION FOR GUEST USER', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(129, 'USER_CATEGORY', 'Define the User Categories in the system', 7, 1, 1, '{ \n\"1\": \"FREE\", \n\"2\": \"PREMIUM\",\n\"3\": \"👑 PRO\",\n\"4\": \"💗 LIFETIME ACCESS\",\n\"10\": \"🍮 ADMIN\",\n\"0\": \"🕰️ GUEST\"\n}', 1),
(130, 'USER_CATEGORY_DEFAULT', 'Default Category to be used', 7, 1, 1, '1', 1),
(131, 'USER_CATEGORY_UPGRADE', 'Show Upgrade Feature', 7, 1, 1, '[1,2,0]', 1),
(132, 'USER_DESIGN_ACCESS', 'Define the Designs accessed by the user', 7, 1, 1, '{\n\"1\": [0],\n\"3\": [0,1,2,3,5],\n\"2\": [0,1,2,3],\n\"4\": [0,1,2,3,5],\n\"10\": [0,1,2,3,5],\n\"0\": [0]\n}', 1),
(133, 'USER_FALLBACK_CATEGORY', 'Revert back to the old category once the subscription has expired', 7, 1, 1, '{\"3\": \"1\", \"2\": \"1\", \"4\": \"1\", \"0\": \"1\"}', 1),
(134, 'USER_NOTIFICATION_SETTINGS', 'Hide/Display the notifications in the User Settings Page', 7, 1, 1, '', 1),
(135, 'USER_PROFILE_LIMIT', 'Limit the profile creation of a user', 7, 1, 1, '{\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\", \"2\":\"upgrade\", \"3\":\"upgrade\", \"4\":\"upgrade\", \"10\":\"upgrade\"}, \"limits\": {\"3\": 100, \"1\": 2, \"2\": 5, \"4\": 100, \"10\": 100, \"0\": 2}}', 1),
(136, 'USER_SERVICES', 'replaced with SIDE_MENU_SERVICES', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(137, 'USER_SUBSCRIPTION', 'replaced with SIDE_MENU_SUBSCRIPTION', 7, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(138, 'USER_SUBSCRIPTION_THRESHOLD', 'Subscription Limit days', 7, 1, 1, '{ \"1\": 0, \"2\": 30, \"3\": 15, \"4\": 30 }', 1),
(139, 'USER_SUBSCRIPTION_VALIDATION', 'Check the validation of the subscription of the category', 7, 1, 1, '{\"2\": \"Subscription\", \"3\": \"Subscription\", \"4\": \"Subscription\"}', 1),
(140, 'RESOURCE_WHATSAPP', 'Show WhatsApp number of cvDragon', 7, 1, 1, '919883124674', 1),
(141, 'RESOURCE_TEL', 'Show Phone number of cvDragon', 7, 1, 1, '9883124674', 1),
(142, 'RESOURCE_EMAIL', 'Show email of cvDragon', 7, 1, 1, 'cvdragon@lifeinmba.com', 1),
(143, 'ACTION_LOGOUT_INTERRUPTION', 'YES', 7, 1, 1, '{\"0\": {\"route\": \"login\", \"buttonText\": \"Connect\", \"heading\" : \"Are you sure that you want to log out? All your data will be lost unless you connect!\"}}', 1),
(144, 'CV_SECTION_ADD', 'CV Creation Feature', 7, 1, 1, '{ \r\n\"usage\": [1,2,3,4,10,0], \r\n\"show\": [1,2,3,4,10,0], \r\n\"usage_restriction_route\": {} \r\n}', 1),
(145, 'CV_BG_GRAPHICS_TOGGLE', 'CV Creation Feature', 8, 1, 1, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(146, 'CV_COLOR_CHANGE', 'CV Creation Feature', 8, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(147, 'CV_DOB_FORMAT_CHANGE', 'CV Creation Feature', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(148, 'CV_FONT_SIZE_CHANGE', 'CV Creation Feature', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(149, 'CV_FONT_STYLE_CHANGE', 'CV Creation Feature', 8, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(150, 'CV_IMAGE_TOGGLE', 'CV Creation Feature', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(151, 'CV_INSTITUTE_LOGO_TOGGLE', 'Keep/Remove your institute Logo', 8, 1, 1, '', 1),
(152, 'CV_PAGE_BREAK_ADD', 'Add Page Break Feature in the application', 8, 1, 1, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(153, 'CV_QRCODE', 'replaced with QRCODE_OPTION_SHOW', 8, 0, 0, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(154, 'CV_SECTION_DELETE', 'CV Creation Feature', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(155, 'CV_SECTION_RENAME', 'CV Creation Feature', 8, 1, 1, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(156, 'CV_SECTION_REORDER', 'replaced with REORDERDESIGN', 8, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(157, 'CV_WORK_PERIOD_FORMAT', 'Change WOrk Format Duration', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(158, 'DOWNLOAD_POPUP_CONTACT', 'hide the download icon in preview for iOS', 8, 0, 0, '', 1),
(159, 'FEATURE_MY_CONNECTIONS', 'replaced with MYCONNECTIONS', 8, 0, 0, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(160, 'FEATURE_MY_DOCUMENTS', '', 8, 1, 1, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(161, 'FEATURE_MY_INSTITUTE', 'replaced with MYINSTITUTE', 8, 1, 1, '', 0),
(162, 'FEATURE_PROOFREAD', 'replaced with PROOFREAD', 8, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(163, 'FEATURE_PROOFREAD2', 'replaced with PROOFREAD2', 8, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(164, 'FEATURE_RECOMMENDATIONS', 'replaced with RECOMMENDATIONS', 8, 0, 0, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(165, 'FEATURE_SHOWCASE', 'replaced with SHOWCASE', 8, 0, 0, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(166, 'FEATURE_WIZARD', 'Show the Wizard in the Beginning', 8, 1, 0, '', 1),
(167, 'HOME_PAGE_ARTICLES', 'Display Article block on Home Screen', 8, 1, 1, '', 1),
(168, 'HOME_PAGE_CV_DESIGN_LIST', 'Map of all the designs to be shown in the home page', 8, 1, 1, '[96,1,94,98,11,97,13]', 1),
(169, 'HOME_PAGE_DESIGNS', 'Display Design block on Home Screen', 8, 1, 1, '', 1),
(170, 'HOME_PAGE_FAQS', 'Display FAQs block on Homes Screen', 8, 1, 1, '', 1),
(171, 'HOME_PAGE_FREE_SUBSCRIPTION', 'replaced with FREE_SUBSCRIPTION', 8, 1, 0, '', 1),
(172, 'HOME_PAGE_ICONS', 'Display Icons on Home Screen', 8, 1, 1, '', 1),
(173, 'HOME_PAGE_JOBS', 'Display Jobs Block on Home Screen', 8, 1, 1, '', 1),
(174, 'HOME_PAGE_MOTTO', 'Define the content on the Home Screen', 8, 1, 1, 'One - Stop Solution 🤍\nFor all your \nCareer Needs!', 1),
(175, 'HOME_PAGE_NOTIFICATION', 'Display Notifications on Home Screen', 8, 1, 1, '', 1),
(176, 'HOME_PAGE_ORDER', 'Map of all Features on Home Screen to be Provided Category wise', 8, 1, 1, '{ \r\n\"1\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\",\r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_FEEDBACK\",\r\n\"HOME_PAGE_MOTTO\"  \r\n],\r\n\"2\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_FEEDBACK\",\r\n\"HOME_PAGE_MOTTO\"   \r\n],\r\n\"3\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_FEEDBACK\",\r\n\"HOME_PAGE_MOTTO\"   \r\n],\r\n\"4\": [ \r\n\"HOME_PAGE_ICONS\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_FEEDBACK\",\r\n\"HOME_PAGE_MOTTO\"   \r\n],  \r\n\"0\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\",\r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_FEEDBACK\",\r\n\"HOME_PAGE_MOTTO\"  \r\n],\r\n\"10\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\", \r\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_FEEDBACK\",\r\n\"HOME_PAGE_MOTTO\"   \r\n]\r\n}', 1),
(177, 'HOME_PAGE_SERVICES', 'Display Service Block on Home Screen', 8, 1, 1, '', 1),
(178, 'HOME_PAGE_TIPS', 'Display Tips Block on Home Screen', 8, 1, 1, '', 1),
(179, 'HOME_PAGE_WORKSHOPS', 'Display Workshop Block on Home Screen', 8, 0, 0, '', 1),
(180, 'OPTION_DELETE_ACCOUNT', 'Show option to delete account', 8, 1, 1, '{\"heading\" : \"Sad to see you want to delete your account, Kindly let us know the reason(s)\", \"selectables\" : [\"Did not liked the application\", \"Had difficulty in creating CV\", \"Need more Professional Designs\", \"It is very slow and hard to navigate\", \"It is too buggy and not working properly\", \"I was Just exploring the application\"]}', 1),
(181, 'OPTION_REFERRAL_CODE', 'YES', 8, 0, 0, '', 1),
(182, 'PHONE_LOGIN', 'Login via Mobile Number', 8, 1, 1, '', 1),
(183, 'RESOURCE_APP_LIVE', 'GIVE USER ACCESS TO THE APPLICATION', 8, 0, 0, '{\"image\": \"https://cvdragon.com/public/img/campaignsFiles/RAD2022.jpg\", \"message\": \"Server is currently under maintainance\"}', 1),
(184, 'RESOURCE_APP_RATING', 'user can give feedback', 8, 1, 1, '{\r\n   \"max_rating\":5,\r\n   \"1\":{\r\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\r\n      \"selectables\":[\r\n         \"App is not easily navigable\",\r\n         \"Need more Professional Resume Designs\",\r\n         \"Need more Features\",\r\n         \"Add more Free Designs\",\r\n         \"CV Creation can be simplified\",\r\n         \"Subscription charges are high \"\r\n      ],\r\n      \"buttons\":[\r\n         {\r\n            \"name\":\"Contact Us\",\r\n            \"link\":\"https://wa.me/919883124674\"\r\n         }\r\n      ]\r\n   },\r\n   \"2\":{\r\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\r\n      \"selectables\":[\r\n         \"App is not easily navigable\",\r\n         \"Need more Professional Resume Designs\",\r\n         \"Need more Features\",\r\n         \"Add more Free Designs\",\r\n         \"CV Creation can be simplified\",\r\n         \"Subscription charges are high \"\r\n      ],\r\n      \"buttons\":[\r\n         {\r\n            \"name\":\"Contact Us\",\r\n            \"link\":\"https://wa.me/919883124674\"\r\n         }\r\n      ]\r\n   },\r\n   \"3\":{\r\n      \"heading\":\"Thank you for your rating! Help us Improve! What could be better?\",\r\n      \"selectables\":[\r\n         \"App is not easily navigable\",\r\n         \"Need more Professional Resume Designs\",\r\n         \"Need more Features\",\r\n         \"Add more Free Designs\",\r\n         \"CV Creation can be simplified\",\r\n         \"Subscription charges are high \"\r\n      ],\r\n      \"buttons\":[\r\n         {\r\n            \"name\":\"Contact Us\",\r\n            \"link\":\"https://wa.me/919883124674\"\r\n         }\r\n      ]\r\n   },\r\n   \"4\":{\r\n      \"heading\":\"Thank you for your rating! What can we improve to expect a 5-star rating from you?\",\r\n      \"selectables\":[\r\n         \"App is not easily navigable\",\r\n         \"Need more Professional Resume Designs\",\r\n         \"Need more Features\",\r\n         \"Add more Free Designs\",\r\n         \"CV Creation can be simplified\",\r\n         \"Subscription charges are high \"\r\n      ],\r\n      \"buttons\":[\r\n         {\r\n            \"name\":\"Contact Us\",\r\n            \"link\":\"https://wa.me/919883124674\"\r\n         }\r\n      ]\r\n   },\r\n   \"5\":{\r\n      \"heading\":\"Thank you for rating us 5 stars! What did you like the most about the app?\",\r\n      \"selectables\":[\r\n         \"Application Interface\",\r\n         \"Professional Resume Designs\",\r\n         \"Simple CV Creation Process\",\r\n         \"A Lot of features\",\r\n         \"Application is Super easy to Navigate\"\r\n      ],\r\n      \"buttons\":[\r\n         {\r\n            \"name\":\"Rate on App Store\",\r\n            \"link\":\"https://cvdragon.com/application\"\r\n         }\r\n      ]\r\n   }\r\n}', 1),
(185, 'SERVERTIME_THRESHOLD', 'YES', 8, 1, 1, '300', 1),
(186, 'USER_ACCESS_DIGITALCV', 'LIMIT THE OPTION FOR GUEST USER', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(187, 'USER_ACCESS_FAVOURITES', 'LIMIT THE OPTION FOR GUEST USER', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(188, 'USER_ACCESS_FEED', 'LIMIT THE OPTION FOR GUEST USER', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(189, 'USER_ACCESS_HELP', 'LIMIT THE OPTION FOR GUEST USER', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(190, 'USER_ACCESS_LOGOUT', 'LIMIT THE OPTION FOR GUEST USER', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(191, 'USER_ACCESS_MYRESUMES', 'LIMIT THE OPTION FOR GUEST USER', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(192, 'USER_ACCESS_MYSUBSCRIPTION', 'LIMIT THE OPTION FOR GUEST USER', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(193, 'USER_ACCESS_RESYNC', 'LIMIT THE OPTION FOR GUEST USER', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(194, 'USER_ACCESS_SETTINGS', 'LIMIT THE OPTION FOR GUEST USER', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(195, 'USER_ACCESS_WORKSHOPS', 'LIMIT THE OPTION FOR GUEST USER', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(196, 'USER_CATEGORY', 'Define the User Categories in the system', 8, 1, 1, '{ \n\"1\": \"FREE\", \n\"2\": \"PREMIUM\",\n\"3\": \"👑 PRO\",\n\"4\": \"💗 LIFETIME ACCESS\",\n\"10\": \"🍮 ADMIN\",\n\"0\": \"🕰️ GUEST\"\n}', 1),
(197, 'USER_CATEGORY_DEFAULT', 'Default Category to be used', 8, 1, 1, '1', 1),
(198, 'USER_CATEGORY_UPGRADE', 'Show Upgrade Feature', 8, 1, 1, '[1,2,0]', 1),
(199, 'USER_DESIGN_ACCESS', 'Define the Designs accessed by the user', 8, 1, 1, '{\n\"1\": [0],\n\"3\": [0,1,2,3,5],\n\"2\": [0,1,2,3],\n\"4\": [0,1,2,3,5],\n\"10\": [0,1,2,3,5],\n\"0\": [0]\n}', 1),
(200, 'USER_FALLBACK_CATEGORY', 'Revert back to the old category once the subscription has expired', 8, 1, 1, '{\"3\": \"1\", \"2\": \"1\", \"4\": \"1\", \"0\": \"1\"}', 1),
(201, 'USER_NOTIFICATION_SETTINGS', 'Hide/Display the notifications in the User Settings Page', 8, 1, 1, '', 1),
(202, 'USER_PROFILE_LIMIT', 'Limit the profile creation of a user', 8, 1, 1, '{\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\", \"2\":\"upgrade\", \"3\":\"upgrade\", \"4\":\"upgrade\", \"10\":\"upgrade\"}, \"limits\": {\"3\": 100, \"1\": 2, \"2\": 5, \"4\": 100, \"10\": 100, \"0\": 2}}', 1),
(203, 'USER_SERVICES', 'replaced with SIDE_MENU_SERVICES', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(204, 'USER_SUBSCRIPTION', 'replaced with SIDE_MENU_SUBSCRIPTION', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(205, 'USER_SUBSCRIPTION_THRESHOLD', 'Subscription Limit days', 8, 1, 1, '{ \"1\": 0, \"2\": 30, \"3\": 15, \"4\": 30 }', 1),
(206, 'USER_SUBSCRIPTION_VALIDATION', 'Check the validation of the subscription of the category', 8, 1, 1, '{\"2\": \"Subscription\", \"3\": \"Subscription\", \"4\": \"Subscription\"}', 1),
(207, 'RESOURCE_WHATSAPP', 'Show WhatsApp number of cvDragon', 8, 1, 1, '919883124674', 1),
(208, 'RESOURCE_TEL', 'Show Phone number of cvDragon', 8, 1, 1, '9883124674', 1),
(209, 'RESOURCE_EMAIL', 'Show email of cvDragon', 8, 1, 1, 'cvdragon@lifeinmba.com', 1),
(210, 'ACTION_LOGOUT_INTERRUPTION', 'YES', 8, 1, 1, '{\"0\": {\"route\": \"login\", \"buttonText\": \"Connect\", \"heading\" : \"Are you sure that you want to log out? All your data will be lost unless you connect!\"}}', 1),
(211, 'CV_SECTION_ADD', 'CV Creation Feature', 8, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(212, 'RESOURCE_SOCIAL_LOGIN', 'Allow social login', 8, 1, 1, '', 1),
(213, 'HOME_PAGE_FEEDBACK', 'Display Feedback Option', 8, 0, 0, '', 1),
(214, 'HOME_PAGE_TUTORIALS', 'Display Tutorials on Home Screen', 8, 0, 0, '', 1),
(215, 'CV_BG_GRAPHICS_TOGGLE', 'CV Creation Feature', 9, 1, 1, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(216, 'CV_COLOR_CHANGE', 'CV Creation Feature', 9, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(217, 'CV_DOB_FORMAT_CHANGE', 'CV Creation Feature', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(218, 'CV_FONT_SIZE_CHANGE', 'CV Creation Feature', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(219, 'CV_FONT_STYLE_CHANGE', 'CV Creation Feature', 9, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(220, 'CV_IMAGE_TOGGLE', 'CV Creation Feature', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(221, 'CV_INSTITUTE_LOGO_TOGGLE', 'Keep/Remove your institute Logo', 9, 1, 1, '', 1),
(222, 'CV_PAGE_BREAK_ADD', 'Add Page Break Feature in the application', 9, 1, 1, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(223, 'CV_QRCODE', 'replaced with QRCODE_OPTION_SHOW', 9, 0, 0, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(224, 'CV_SECTION_DELETE', 'CV Creation Feature', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(225, 'CV_SECTION_RENAME', 'CV Creation Feature', 9, 1, 1, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(226, 'CV_SECTION_REORDER', 'replaced with REORDERDESIGN', 9, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(227, 'CV_WORK_PERIOD_FORMAT', 'Change WOrk Format Duration', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(228, 'DOWNLOAD_POPUP_CONTACT', 'hide the download icon in preview for iOS', 9, 0, 0, '', 1),
(229, 'FEATURE_MY_CONNECTIONS', 'replaced with MYCONNECTIONS', 9, 0, 0, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(230, 'FEATURE_MY_DOCUMENTS', '', 9, 1, 1, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(231, 'FEATURE_MY_INSTITUTE', 'replaced with MYINSTITUTE', 9, 1, 1, '', 0),
(232, 'FEATURE_PROOFREAD', 'replaced with PROOFREAD', 9, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(233, 'FEATURE_PROOFREAD2', 'replaced with PROOFREAD2', 9, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(234, 'FEATURE_RECOMMENDATIONS', 'replaced with RECOMMENDATIONS', 9, 0, 0, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(235, 'FEATURE_SHOWCASE', 'replaced with SHOWCASE', 9, 0, 0, '{ \n\"usage\": [3,2,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(236, 'FEATURE_WIZARD', 'Show the Wizard in the Beginning', 9, 1, 0, '', 1),
(237, 'HOME_PAGE_ARTICLES', 'Display Article block on Home Screen', 9, 1, 1, '', 1),
(238, 'HOME_PAGE_CV_DESIGN_LIST', 'Map of all the designs to be shown in the home page', 9, 1, 1, '[96,1,94,98,11,97,13]', 1),
(239, 'HOME_PAGE_DESIGNS', 'Display Design block on Home Screen', 9, 1, 1, '', 1),
(240, 'HOME_PAGE_FAQS', 'Display FAQs block on Homes Screen', 9, 1, 1, '', 1),
(241, 'HOME_PAGE_FREE_SUBSCRIPTION', 'replaced with FREE_SUBSCRIPTION', 9, 1, 0, '', 1),
(242, 'HOME_PAGE_ICONS', 'Display Icons on Home Screen', 9, 1, 1, '', 1),
(243, 'HOME_PAGE_JOBS', 'Display Jobs Block on Home Screen', 9, 1, 1, '', 1),
(244, 'HOME_PAGE_MOTTO', 'Define the content on the Home Screen', 9, 1, 1, 'Welcome to cvDragon ♥️\n\nLet\'s create a\nPerfect CV ✌️', 1),
(245, 'HOME_PAGE_NOTIFICATION', 'Display Notifications on Home Screen', 9, 1, 1, '', 1),
(246, 'HOME_PAGE_ORDER', 'Map of all Features on Home Screen to be Provided Category wise', 9, 1, 1, '{ \n\"1\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"2\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"3\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"4\": [ \n\"HOME_PAGE_ICONS\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],  \n\"0\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"10\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n]\n}', 1),
(247, 'HOME_PAGE_SERVICES', 'Display Service Block on Home Screen', 9, 1, 1, '', 1),
(248, 'HOME_PAGE_TIPS', 'Display Tips Block on Home Screen', 9, 1, 1, '', 1),
(249, 'HOME_PAGE_WORKSHOPS', 'Display Workshop Block on Home Screen', 9, 0, 0, '', 1),
(250, 'OPTION_DELETE_ACCOUNT', 'Show option to delete account', 9, 1, 1, '{\"heading\" : \"Sad to see you want to delete your account, Kindly let us know the reason(s)\", \"selectables\" : [\"Did not liked the application\", \"Had difficulty in creating CV\", \"Need more Professional Designs\", \"It is very slow and hard to navigate\", \"It is too buggy and not working properly\", \"I was Just exploring the application\"]}', 1),
(251, 'OPTION_REFERRAL_CODE', 'YES', 9, 0, 0, '', 1),
(252, 'PHONE_LOGIN', 'Login via Mobile Number', 9, 1, 1, '', 1),
(253, 'RESOURCE_APP_LIVE', 'GIVE USER ACCESS TO THE APPLICATION', 9, 0, 0, '{\"image\": \"https://cvdragon.com/public/img/campaignsFiles/RAD2022.jpg\", \"message\": \"Server is currently under maintainance\"}', 1),
(254, 'RESOURCE_APP_RATING', 'user can give feedback', 9, 1, 1, '{\n   \"max_rating\":5,\n   \"1\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"2\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"3\":{\n      \"heading\":\"Thank you for your rating! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"4\":{\n      \"heading\":\"Thank you for your rating! What can we improve to expect a 5-star rating from you?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"5\":{\n      \"heading\":\"Thank you for rating us 5 stars! What did you like the most about the app?\",\n      \"selectables\":[\n         \"Application Interface\",\n         \"Professional Resume Designs\",\n         \"Simple CV Creation Process\",\n         \"A Lot of features\",\n         \"Application is Super easy to Navigate\"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Rate on App Store\",\n            \"link\":\"https://cvdragon.com/application\"\n         }\n      ]\n   }\n}', 1),
(255, 'SERVERTIME_THRESHOLD', 'YES', 9, 1, 1, '300', 1),
(256, 'USER_ACCESS_DIGITALCV', 'LIMIT THE OPTION FOR GUEST USER', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(257, 'USER_ACCESS_FAVOURITES', 'LIMIT THE OPTION FOR GUEST USER', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(258, 'USER_ACCESS_FEED', 'LIMIT THE OPTION FOR GUEST USER', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(259, 'USER_ACCESS_HELP', 'LIMIT THE OPTION FOR GUEST USER', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(260, 'USER_ACCESS_LOGOUT', 'LIMIT THE OPTION FOR GUEST USER', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(261, 'USER_ACCESS_MYRESUMES', 'LIMIT THE OPTION FOR GUEST USER', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(262, 'USER_ACCESS_MYSUBSCRIPTION', 'LIMIT THE OPTION FOR GUEST USER', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(263, 'USER_ACCESS_RESYNC', 'LIMIT THE OPTION FOR GUEST USER', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1);
INSERT INTO `cvdragonappconfignew` (`configid`, `configkey`, `changesBeforeUpdate`, `version`, `configvalue`, `configvalueios`, `parameter`, `sendData`) VALUES
(264, 'USER_ACCESS_SETTINGS', 'LIMIT THE OPTION FOR GUEST USER', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(265, 'USER_ACCESS_WORKSHOPS', 'LIMIT THE OPTION FOR GUEST USER', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(266, 'USER_CATEGORY', 'Define the User Categories in the system', 9, 1, 1, '{ \n\"1\": \"FREE\", \n\"2\": \"PREMIUM\",\n\"3\": \"👑 PRO\",\n\"4\": \"💗 LIFETIME ACCESS\",\n\"10\": \"🍮 ADMIN\",\n\"0\": \"🕰️ GUEST\"\n}', 1),
(267, 'USER_CATEGORY_DEFAULT', 'Default Category to be used', 9, 1, 1, '1', 1),
(268, 'USER_CATEGORY_UPGRADE', 'Show Upgrade Feature', 9, 1, 1, '[1,2,0]', 1),
(269, 'USER_DESIGN_ACCESS', 'Define the Designs accessed by the user', 9, 1, 1, '{\r\n\"1\": [0],\r\n\"3\": [0,1,2,3,5],\r\n\"2\": [0,1,2,3],\r\n\"4\": [0,1,2,3,5],\r\n\"10\": [0,1,2,3,5],\r\n\"0\": [0]\r\n}', 1),
(270, 'USER_FALLBACK_CATEGORY', 'Revert back to the old category once the subscription has expired', 9, 1, 1, '{\"3\": \"1\", \"2\": \"1\", \"4\": \"1\", \"0\": \"1\"}', 1),
(271, 'USER_NOTIFICATION_SETTINGS', 'Hide/Display the notifications in the User Settings Page', 9, 1, 1, '', 1),
(272, 'USER_PROFILE_LIMIT', 'Limit the profile creation of a user', 9, 1, 1, '{\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\", \"2\":\"upgrade\", \"3\":\"upgrade\", \"4\":\"upgrade\", \"10\":\"upgrade\"}, \"limits\": {\"3\": 100, \"1\": 2, \"2\": 5, \"4\": 100, \"10\": 100, \"0\": 2}}', 1),
(273, 'USER_SERVICES', 'replaced with SIDE_MENU_SERVICES', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(274, 'USER_SUBSCRIPTION', 'replaced with SIDE_MENU_SUBSCRIPTION', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(275, 'USER_SUBSCRIPTION_THRESHOLD', 'Subscription Limit days', 9, 1, 1, '{ \"1\": 0, \"2\": 30, \"3\": 15, \"4\": 30 }', 1),
(276, 'USER_SUBSCRIPTION_VALIDATION', 'Check the validation of the subscription of the category', 9, 1, 1, '{\"2\": \"Subscription\", \"3\": \"Subscription\", \"4\": \"Subscription\"}', 1),
(277, 'RESOURCE_WHATSAPP', 'Show WhatsApp number of cvDragon', 9, 1, 1, '919883124674', 1),
(278, 'RESOURCE_TEL', 'Show Phone number of cvDragon', 9, 1, 1, '9883124674', 1),
(279, 'RESOURCE_EMAIL', 'Show email of cvDragon', 9, 1, 1, 'cvdragon@lifeinmba.com', 1),
(280, 'ACTION_LOGOUT_INTERRUPTION', 'YES', 9, 1, 1, '{\"0\": {\"route\": \"login\", \"buttonText\": \"Connect\", \"heading\" : \"Are you sure that you want to log out? All your data will be lost unless you connect!\"}}', 1),
(281, 'CV_SECTION_ADD', 'CV Creation Feature', 9, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0], \n\"show\": [1,2,3,4,10,0], \n\"usage_restriction_route\": {} \n}', 1),
(282, 'RESOURCE_SOCIAL_LOGIN', 'Allow social login', 9, 1, 1, '', 1),
(283, 'HOME_PAGE_FEEDBACK', 'Display Feedback Option', 9, 1, 1, '', 1),
(284, 'HOME_PAGE_TUTORIALS', 'Display Tutorials on Home Screen', 9, 0, 0, '', 1),
(285, 'CV_BG_GRAPHICS_TOGGLE', 'CV Creation Feature', 10, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(286, 'CV_COLOR_CHANGE', 'CV Creation Feature', 10, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(287, 'CV_DOB_FORMAT_CHANGE', 'CV Creation Feature', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(288, 'CV_FONT_SIZE_CHANGE', 'CV Creation Feature', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(289, 'CV_FONT_STYLE_CHANGE', 'CV Creation Feature', 10, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(290, 'CV_IMAGE_TOGGLE', 'CV Creation Feature', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(291, 'CV_INSTITUTE_LOGO_TOGGLE', 'Keep/Remove your institute Logo', 10, 1, 1, '', 1),
(292, 'CV_PAGE_BREAK_ADD', 'Add Page Break Feature in the application', 10, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(293, 'CV_QRCODE', 'replaced with QRCODE_OPTION_SHOW', 10, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(294, 'CV_SECTION_DELETE', 'CV Creation Feature', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(295, 'CV_SECTION_RENAME', 'CV Creation Feature', 10, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(296, 'CV_SECTION_REORDER', 'replaced with REORDERDESIGN', 10, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(297, 'CV_WORK_PERIOD_FORMAT', 'Change WOrk Format Duration', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(298, 'DOWNLOAD_POPUP_CONTACT', 'hide the download icon in preview for iOS', 10, 0, 0, '', 1),
(299, 'FEATURE_MY_CONNECTIONS', 'replaced with MYCONNECTIONS', 10, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(300, 'FEATURE_MY_DOCUMENTS', '', 10, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(301, 'FEATURE_MY_INSTITUTE', 'replaced with MYINSTITUTE', 10, 1, 1, '', 0),
(302, 'FEATURE_PROOFREAD', 'replaced with PROOFREAD', 10, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(303, 'FEATURE_PROOFREAD2', 'replaced with PROOFREAD2', 10, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(304, 'USER_ACCESS_RECOMMENDATIONS', 'replaced with RECOMMENDATIONS', 10, 0, 0, '{ \r\n\"usage\": [3,4,10], \r\n\"show\": [1,2,3,4,10,5,6,0], \r\n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\", \"5\":\"upgrade\", \"6\":\"upgrade\"} \r\n}', 1),
(305, 'FEATURE_SHOWCASE', 'replaced with SHOWCASE', 10, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(306, 'FEATURE_WIZARD', 'Show the Wizard in the Beginning', 10, 1, 0, '', 1),
(307, 'HOME_PAGE_ARTICLES', 'Display Article block on Home Screen', 10, 1, 1, '', 1),
(308, 'HOME_PAGE_CV_DESIGN_LIST', 'Map of all the designs to be shown in the home page', 10, 1, 1, '[96,1,94,98,11,97,13]', 1),
(309, 'HOME_PAGE_DESIGNS', 'Display Design block on Home Screen', 10, 1, 1, '', 1),
(310, 'HOME_PAGE_FAQS', 'Display FAQs block on Homes Screen', 10, 1, 1, '', 1),
(311, 'HOME_PAGE_FREE_SUBSCRIPTION', 'replaced with FREE_SUBSCRIPTION', 10, 1, 0, '', 1),
(312, 'HOME_PAGE_ICONS', 'Display Icons on Home Screen', 10, 1, 1, '', 1),
(313, 'HOME_PAGE_JOBS', 'Display Jobs Block on Home Screen', 10, 1, 1, '', 1),
(314, 'HOME_PAGE_MOTTO', 'Define the content on the Home Screen', 10, 1, 1, 'Welcome to cvDragon ♥️\n\nLet\'s create a\nPerfect CV ✌️', 1),
(315, 'HOME_PAGE_NOTIFICATION', 'Display Notifications on Home Screen', 10, 1, 1, '', 1),
(316, 'HOME_PAGE_ORDER', 'Map of all Features on Home Screen to be Provided Category wise', 10, 1, 1, '{ \r\n\"1\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\",\r\n\"HOME_PAGE_RECOMMENDATIONS\",\r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_FEEDBACK\",\r\n\"HOME_PAGE_MOTTO\"  \r\n],\r\n\"2\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\",\r\n\"HOME_PAGE_RECOMMENDATIONS\",\r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_FEEDBACK\",\r\n\"HOME_PAGE_MOTTO\"   \r\n],\r\n\"3\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\",\r\n\"HOME_PAGE_RECOMMENDATIONS\",\r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_FEEDBACK\",\r\n\"HOME_PAGE_MOTTO\"   \r\n],\r\n\"4\": [ \r\n\"HOME_PAGE_ICONS\",\r\n\"HOME_PAGE_RECOMMENDATIONS\",\r\n\"HOME_PAGE_DESIGNS\",\r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_FEEDBACK\",\r\n\"HOME_PAGE_MOTTO\"   \r\n],  \r\n\"5\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\",\r\n\"HOME_PAGE_RECOMMENDATIONS\",\r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_FEEDBACK\",\r\n\"HOME_PAGE_MOTTO\"  \r\n],  \r\n\"6\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\",\r\n\"HOME_PAGE_RECOMMENDATIONS\",\r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_FEEDBACK\",\r\n\"HOME_PAGE_MOTTO\"  \r\n],\r\n\"0\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\",\r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_MOTTO\"  \r\n],\r\n\"10\": [ \r\n\"HOME_PAGE_NOTIFICATION\", \r\n\"HOME_PAGE_ICONS\",\r\n\"HOME_PAGE_RECOMMENDATIONS\",\r\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \r\n\"HOME_PAGE_TUTORIALS\", \r\n\"HOME_PAGE_DESIGNS\", \r\n\"HOME_PAGE_WORKSHOPS\", \r\n\"HOME_PAGE_JOBS\", \r\n\"HOME_PAGE_TIPS\", \r\n\"HOME_PAGE_FAQS\", \r\n\"HOME_PAGE_SERVICES\", \r\n\"HOME_PAGE_ARTICLES\",\r\n\"HOME_PAGE_FEEDBACK\",\r\n\"HOME_PAGE_MOTTO\"   \r\n]\r\n}', 1),
(317, 'HOME_PAGE_SERVICES', 'Display Service Block on Home Screen', 10, 1, 1, '', 1),
(318, 'HOME_PAGE_TIPS', 'Display Tips Block on Home Screen', 10, 1, 1, '', 1),
(319, 'HOME_PAGE_WORKSHOPS', 'Display Workshop Block on Home Screen', 10, 1, 1, '', 1),
(320, 'OPTION_DELETE_ACCOUNT', 'Show option to delete account', 10, 1, 1, '{\"heading\" : \"Sad to see you want to delete your account, Kindly let us know the reason(s)\", \"selectables\" : [\"Did not liked the application\", \"Had difficulty in creating CV\", \"Need more Professional Designs\", \"It is very slow and hard to navigate\", \"It is too buggy and not working properly\", \"I was Just exploring the application\"]}', 1),
(321, 'OPTION_REFERRAL_CODE', 'YES', 10, 0, 0, '', 1),
(322, 'PHONE_LOGIN', 'Login via Mobile Number', 10, 1, 1, '', 1),
(323, 'RESOURCE_APP_LIVE', 'GIVE USER ACCESS TO THE APPLICATION', 10, 0, 0, '{\"image\": \"https://cvdragon.com/public/img/campaignsFiles/RAD2022.jpg\", \"message\": \"Server is currently under maintainance\"}', 1),
(324, 'RESOURCE_APP_RATING', 'user can give feedback', 10, 1, 1, '{\n   \"max_rating\":5,\n   \"1\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"2\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"3\":{\n      \"heading\":\"Thank you for your rating! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"4\":{\n      \"heading\":\"Thank you for your rating! What can we improve to expect a 5-star rating from you?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"5\":{\n      \"heading\":\"Thank you for rating us 5 stars! What did you like the most about the app?\",\n      \"selectables\":[\n         \"Application Interface\",\n         \"Professional Resume Designs\",\n         \"Simple CV Creation Process\",\n         \"A Lot of features\",\n         \"Application is Super easy to Navigate\"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Rate on App Store\",\n            \"link\":\"https://cvdragon.com/application\"\n         }\n      ]\n   }\n}', 1),
(325, 'SERVERTIME_THRESHOLD', 'YES', 10, 1, 1, '300', 1),
(326, 'USER_ACCESS_DIGITALCV', 'LIMIT THE OPTION FOR GUEST USER', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(327, 'USER_ACCESS_FAVOURITES', 'LIMIT THE OPTION FOR GUEST USER', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(328, 'USER_ACCESS_FEED', 'LIMIT THE OPTION FOR GUEST USER', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(329, 'USER_ACCESS_HELP', 'LIMIT THE OPTION FOR GUEST USER', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(330, 'USER_ACCESS_LOGOUT', 'LIMIT THE OPTION FOR GUEST USER', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(331, 'USER_ACCESS_MYRESUMES', 'LIMIT THE OPTION FOR GUEST USER', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(332, 'USER_ACCESS_MYSUBSCRIPTION', 'LIMIT THE OPTION FOR GUEST USER', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(333, 'USER_ACCESS_RESYNC', 'LIMIT THE OPTION FOR GUEST USER', 10, 1, 1, '{ \r\n\"usage\": [1,2,3,4,10,5,6,0], \r\n\"show\": [1,2,3,4,10,0,5,6]\r\n}', 1),
(334, 'USER_ACCESS_SETTINGS', 'LIMIT THE OPTION FOR GUEST USER', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(335, 'USER_ACCESS_WORKSHOPS', 'LIMIT THE OPTION FOR GUEST USER', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(336, 'USER_CATEGORY', 'Define the User Categories in the system', 10, 1, 1, '{ \n\"1\": \"FREE\", \n\"2\": \"PREMIUM\",\n\"3\": \"👑 PRO\",\n\"4\": \"💗 LIFETIME ACCESS\",\n\"10\": \"🍮 ADMIN\",\n\"0\": \"🕰️ GUEST\",\n\"5\": \"📚 STUDENT\",\n\"6\": \"💫 SUBSCRIPTION EXPIRED\"\n}', 1),
(337, 'USER_CATEGORY_DEFAULT', 'Default Category to be used', 10, 1, 1, '1', 1),
(338, 'USER_CATEGORY_UPGRADE', 'Show Upgrade Feature', 10, 1, 1, '[1,2,5,6,0]', 1),
(339, 'USER_DESIGN_ACCESS', 'Define the Designs accessed by the user', 10, 1, 1, '{\r\n   \"1\":{\r\n      \"show\":[\r\n         0,\r\n         1,\r\n         2,\r\n         3,\r\n         4,\r\n         5\r\n      ],\r\n      \"usage\":[\r\n         0,\r\n         4\r\n      ]\r\n   },\r\n   \"3\":{\r\n      \"show\":[\r\n         0,\r\n         1,\r\n         2,\r\n         3,\r\n         4,\r\n         5\r\n      ],\r\n      \"usage\":[\r\n         0,\r\n         1,\r\n         2,\r\n         3,\r\n         4,\r\n         5\r\n      ]\r\n   },\r\n   \"2\":{\r\n      \"show\":[\r\n         0,\r\n         1,\r\n         2,\r\n         3,\r\n         4,\r\n         5\r\n      ],\r\n      \"usage\":[\r\n         0,\r\n         1,\r\n         2,\r\n         3,\r\n         4\r\n      ]\r\n   },\r\n   \"4\":{\r\n      \"show\":[\r\n         0,\r\n         1,\r\n         2,\r\n         3,\r\n         4,\r\n         5\r\n      ],\r\n      \"usage\":[\r\n         0,\r\n         1,\r\n         2,\r\n         3,\r\n         4,\r\n         5\r\n      ]\r\n   },\r\n   \"10\":{\r\n      \"show\":[\r\n         0,\r\n         1,\r\n         2,\r\n         3,\r\n         4,\r\n         5\r\n      ],\r\n      \"usage\":[\r\n         0,\r\n         1,\r\n         2,\r\n         3,\r\n         4,\r\n         5\r\n      ]\r\n   },\r\n   \"5\":{\r\n      \"show\":[\r\n         0,\r\n         1,\r\n         2,\r\n         3,\r\n         4,\r\n         5\r\n      ],\r\n      \"usage\":[\r\n         0,\r\n         4\r\n      ]\r\n   },\r\n   \"6\":{\r\n      \"show\":[\r\n         1,\r\n         2,\r\n         3,\r\n         4,\r\n         5\r\n      ],\r\n      \"usage\":[\r\n      ]\r\n   },\r\n   \"0\":{\r\n      \"show\":[\r\n         0,\r\n         1,\r\n         2,\r\n         3,\r\n         5\r\n      ],\r\n      \"usage\":[\r\n         0\r\n      ]\r\n   }\r\n}', 1),
(340, 'USER_FALLBACK_CATEGORY', 'Revert back to the old category once the subscription has expired', 10, 1, 1, '{\"3\": \"6\", \"2\": \"6\", \"4\": \"1\", \"0\": \"1\", \"5\": \"1\"}\r\n', 1),
(341, 'USER_NOTIFICATION_SETTINGS', 'Hide/Display the notifications in the User Settings Page', 10, 1, 1, '', 1),
(342, 'USER_PROFILE_LIMIT', 'Limit the profile creation of a user', 10, 1, 1, '{\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\", \"2\":\"upgrade\", \"3\":\"upgrade\", \"4\":\"upgrade\", \"10\":\"upgrade\", \"5\":\"upgrade\", \"6\":\"upgrade\"}, \"limits\": {\"3\": 100, \"1\": 2, \"2\": 5, \"4\": 100, \"10\": 100, \"0\": 2, \"5\": 5, \"6\": 5}}', 1),
(343, 'USER_SERVICES', 'replaced with SIDE_MENU_SERVICES', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(344, 'USER_SUBSCRIPTION', 'replaced with SIDE_MENU_SUBSCRIPTION', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(345, 'USER_SUBSCRIPTION_THRESHOLD', 'Subscription Limit days', 10, 1, 1, '{ \"1\": 0, \"2\": 30, \"3\": 15, \"4\": 30, \"5\": 0, \"6\": 0 }', 1),
(346, 'USER_SUBSCRIPTION_VALIDATION', 'Check the validation of the subscription of the category', 10, 1, 1, '{\"2\": \"Subscription\", \"3\": \"Subscription\", \"4\": \"Subscription\"}', 1),
(347, 'RESOURCE_WHATSAPP', 'Show WhatsApp number of cvDragon', 10, 1, 1, '919883124674', 1),
(348, 'RESOURCE_TEL', 'Show Phone number of cvDragon', 10, 1, 1, '9883124674', 1),
(349, 'RESOURCE_EMAIL', 'Show email of cvDragon', 10, 1, 1, 'cvdragon@lifeinmba.com', 1),
(350, 'ACTION_LOGOUT_INTERRUPTION', 'YES', 10, 1, 1, '{\"0\": {\"route\": \"login\", \"buttonText\": \"Connect\", \"heading\" : \"Are you sure that you want to log out? All your data will be lost unless you connect!\"}}', 1),
(351, 'CV_SECTION_ADD', 'CV Creation Feature', 10, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(352, 'RESOURCE_SOCIAL_LOGIN', 'Allow social login', 10, 1, 1, '', 1),
(353, 'HOME_PAGE_FEEDBACK', 'Display Feedback Option', 10, 1, 1, '', 1),
(354, 'HOME_PAGE_TUTORIALS', 'Display Tutorials on Home Screen', 10, 1, 1, '', 1),
(355, 'HOME_PAGE_RECOMMENDATIONS', 'Display Recommendations on Home Screen', 10, 0, 0, '', 1),
(356, 'FEATURE_MY_CONNECTIONS', 'replaced with MYCONNECTIONS', 11, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(357, 'FEATURE_SHOWCASE', 'replaced with SHOWCASE', 11, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(358, 'OPTION_REFERRAL_CODE', 'YES', 11, 0, 0, '', 1),
(359, 'RESOURCE_APP_LIVE', 'GIVE USER ACCESS TO THE APPLICATION', 11, 0, 0, '{\"image\": \"https://cvdragon.com/public/img/campaignsFiles/RAD2022.jpg\", \"message\": \"Server is currently under maintainance\"}', 1),
(360, 'DOWNLOAD_POPUP_CONTACT', 'hide the download icon in preview for iOS', 11, 0, 0, '', 1),
(361, 'USER_ACCESS_RECOMMENDATIONS', 'replaced with RECOMMENDATIONS', 11, 0, 0, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,5,6,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\", \"5\":\"upgrade\", \"6\":\"upgrade\"} \n}', 1),
(362, 'FEATURE_WIZARD', 'Show the Wizard in the Beginning', 11, 1, 0, '', 1),
(363, 'HOME_PAGE_FREE_SUBSCRIPTION', 'replaced with FREE_SUBSCRIPTION', 11, 1, 1, '', 1),
(364, 'HOME_PAGE_NOTIFICATION', 'Display Notifications on Home Screen', 11, 1, 1, '', 1),
(365, 'HOME_PAGE_SERVICES', 'Display Service Block on Home Screen', 11, 1, 1, '', 1),
(366, 'USER_SERVICES', 'replaced with SIDE_MENU_SERVICES', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(367, 'USER_SUBSCRIPTION', 'replaced with SIDE_MENU_SUBSCRIPTION', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(368, 'HOME_PAGE_RECOMMENDATIONS', 'Display Recommendations on Home Screen', 11, 1, 1, '', 1),
(369, 'CV_BG_GRAPHICS_TOGGLE', 'CV Creation Feature', 11, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(370, 'CV_COLOR_CHANGE', 'CV Creation Feature', 11, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(371, 'CV_DOB_FORMAT_CHANGE', 'CV Creation Feature', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(372, 'CV_FONT_SIZE_CHANGE', 'CV Creation Feature', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(373, 'CV_FONT_STYLE_CHANGE', 'CV Creation Feature', 11, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(374, 'CV_IMAGE_TOGGLE', 'CV Creation Feature', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(375, 'CV_INSTITUTE_LOGO_TOGGLE', 'Keep/Remove your institute Logo', 11, 1, 1, '', 1),
(376, 'CV_PAGE_BREAK_ADD', 'Add Page Break Feature in the application', 11, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(377, 'CV_SECTION_DELETE', 'CV Creation Feature', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(378, 'CV_SECTION_RENAME', 'CV Creation Feature', 11, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(379, 'CV_SECTION_REORDER', 'replaced with REORDERDESIGN', 11, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(380, 'CV_WORK_PERIOD_FORMAT', 'Change WOrk Format Duration', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(381, 'FEATURE_MY_DOCUMENTS', '', 11, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(382, 'FEATURE_MY_INSTITUTE', 'replaced with MYINSTITUTE', 11, 1, 1, '', 0),
(383, 'FEATURE_PROOFREAD', 'replaced with PROOFREAD', 11, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(384, 'FEATURE_PROOFREAD2', 'replaced with PROOFREAD2', 11, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(385, 'HOME_PAGE_ARTICLES', 'Display Article block on Home Screen', 11, 1, 1, '', 1),
(386, 'HOME_PAGE_CV_DESIGN_LIST', 'Map of all the designs to be shown in the home page', 11, 1, 1, '[96,1,94,98,11,97,13]', 1),
(387, 'HOME_PAGE_DESIGNS', 'Display Design block on Home Screen', 11, 1, 1, '', 1),
(388, 'HOME_PAGE_FAQS', 'Display FAQs block on Homes Screen', 11, 1, 1, '', 1),
(389, 'HOME_PAGE_ICONS', 'Display Icons on Home Screen', 11, 1, 1, '', 1),
(390, 'HOME_PAGE_JOBS', 'Display Jobs Block on Home Screen', 11, 1, 1, '', 1),
(391, 'HOME_PAGE_MOTTO', 'Define the content on the Home Screen', 11, 1, 1, 'Welcome to cvDragon ♥️\n\nLet\'s create a\nPerfect CV ✌️', 1),
(392, 'HOME_PAGE_ORDER', 'Map of all Features on Home Screen to be Provided Category wise', 11, 1, 1, '{ \n\"1\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"2\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"3\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"4\": [ \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],  \n\"5\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],  \n\"6\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"0\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"10\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n]\n}', 1),
(393, 'HOME_PAGE_TIPS', 'Display Tips Block on Home Screen', 11, 1, 1, '', 1),
(394, 'HOME_PAGE_WORKSHOPS', 'Display Workshop Block on Home Screen', 11, 1, 1, '', 1),
(395, 'OPTION_DELETE_ACCOUNT', 'Show option to delete account', 11, 1, 1, '{\"heading\" : \"Sad to see you want to delete your account, Kindly let us know the reason(s)\", \"selectables\" : [\"Did not liked the application\", \"Had difficulty in creating CV\", \"Need more Professional Designs\", \"It is very slow and hard to navigate\", \"It is too buggy and not working properly\", \"I was Just exploring the application\"]}', 1),
(396, 'PHONE_LOGIN', 'Login via Mobile Number', 11, 1, 1, '', 1),
(397, 'RESOURCE_APP_RATING', 'user can give feedback', 11, 1, 1, '{\n   \"max_rating\":5,\n   \"1\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"2\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"3\":{\n      \"heading\":\"Thank you for your rating! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"4\":{\n      \"heading\":\"Thank you for your rating! What can we improve to expect a 5-star rating from you?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"5\":{\n      \"heading\":\"Thank you for rating us 5 stars! What did you like the most about the app?\",\n      \"selectables\":[\n         \"Application Interface\",\n         \"Professional Resume Designs\",\n         \"Simple CV Creation Process\",\n         \"A Lot of features\",\n         \"Application is Super easy to Navigate\"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Rate on App Store\",\n            \"link\":\"https://cvdragon.com/application\"\n         }\n      ]\n   }\n}', 1),
(398, 'SERVERTIME_THRESHOLD', 'YES', 11, 1, 1, '300', 1),
(399, 'USER_ACCESS_DIGITALCV', 'LIMIT THE OPTION FOR GUEST USER', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(400, 'USER_ACCESS_FAVOURITES', 'LIMIT THE OPTION FOR GUEST USER', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(401, 'USER_ACCESS_FEED', 'LIMIT THE OPTION FOR GUEST USER', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(402, 'USER_ACCESS_HELP', 'LIMIT THE OPTION FOR GUEST USER', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(403, 'USER_ACCESS_LOGOUT', 'LIMIT THE OPTION FOR GUEST USER', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(404, 'USER_ACCESS_MYRESUMES', 'LIMIT THE OPTION FOR GUEST USER', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(405, 'USER_ACCESS_MYSUBSCRIPTION', 'LIMIT THE OPTION FOR GUEST USER', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(406, 'USER_ACCESS_RESYNC', 'LIMIT THE OPTION FOR GUEST USER', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6,0], \n\"show\": [1,2,3,4,10,0,5,6]\n}', 1),
(407, 'USER_ACCESS_SETTINGS', 'LIMIT THE OPTION FOR GUEST USER', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(408, 'USER_ACCESS_WORKSHOPS', 'LIMIT THE OPTION FOR GUEST USER', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(409, 'USER_CATEGORY', 'Define the User Categories in the system', 11, 1, 1, '{ \n\"1\": \"FREE\", \n\"2\": \"PREMIUM\",\n\"3\": \"👑 PRO\",\n\"4\": \"💗 LIFETIME ACCESS\",\n\"10\": \"🍮 ADMIN\",\n\"0\": \"🕰️ GUEST\",\n\"5\": \"📚 STUDENT\",\n\"6\": \"💫 SUBSCRIPTION EXPIRED\"\n}', 1),
(410, 'USER_CATEGORY_DEFAULT', 'Default Category to be used', 11, 1, 1, '1', 1),
(411, 'USER_CATEGORY_UPGRADE', 'Show Upgrade Feature', 11, 1, 1, '[1,2,5,6,0]', 1),
(412, 'USER_DESIGN_ACCESS', 'Define the Designs accessed by the user', 11, 1, 1, '{\n   \"1\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         4\n      ]\n   },\n   \"3\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"2\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4\n      ]\n   },\n   \"4\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"10\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"5\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         4\n      ]\n   },\n   \"6\":{\n      \"show\":[\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n      ]\n   },\n   \"0\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         5\n      ],\n      \"usage\":[\n         0\n      ]\n   }\n}', 1),
(413, 'USER_FALLBACK_CATEGORY', 'Revert back to the old category once the subscription has expired', 11, 1, 1, '{\"3\": \"6\", \"2\": \"6\", \"4\": \"1\", \"0\": \"1\", \"5\": \"1\"}\n', 1),
(414, 'USER_NOTIFICATION_SETTINGS', 'Hide/Display the notifications in the User Settings Page', 11, 1, 1, '', 1),
(415, 'USER_PROFILE_LIMIT', 'Limit the profile creation of a user', 11, 1, 1, '{\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\", \"2\":\"upgrade\", \"3\":\"upgrade\", \"4\":\"upgrade\", \"10\":\"upgrade\", \"5\":\"upgrade\", \"6\":\"upgrade\"}, \"limits\": {\"3\": 100, \"1\": 2, \"2\": 5, \"4\": 100, \"10\": 100, \"0\": 2, \"5\": 5, \"6\": 5}}', 1),
(416, 'USER_SUBSCRIPTION_THRESHOLD', 'Subscription Limit days', 11, 1, 1, '{ \"1\": 0, \"2\": 30, \"3\": 15, \"4\": 30, \"5\": 0, \"6\": 0 }', 1),
(417, 'USER_SUBSCRIPTION_VALIDATION', 'Check the validation of the subscription of the category', 11, 1, 1, '{\"2\": \"Subscription\", \"3\": \"Subscription\", \"4\": \"Subscription\"}', 1),
(418, 'RESOURCE_WHATSAPP', 'Show WhatsApp number of cvDragon', 11, 1, 1, '919883124674', 1),
(419, 'RESOURCE_TEL', 'Show Phone number of cvDragon', 11, 1, 1, '9883124674', 1),
(420, 'RESOURCE_EMAIL', 'Show email of cvDragon', 11, 1, 1, 'cvdragon@lifeinmba.com', 1),
(421, 'ACTION_LOGOUT_INTERRUPTION', 'YES', 11, 1, 1, '{\"0\": {\"route\": \"login\", \"buttonText\": \"Connect\", \"heading\" : \"Are you sure that you want to log out? All your data will be lost unless you connect!\"}}', 1),
(422, 'CV_SECTION_ADD', 'CV Creation Feature', 11, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(423, 'RESOURCE_SOCIAL_LOGIN', 'Allow social login', 11, 1, 1, '', 1),
(424, 'HOME_PAGE_FEEDBACK', 'Display Feedback Option', 11, 1, 1, '', 1),
(425, 'HOME_PAGE_TUTORIALS', 'Display Tutorials on Home Screen', 11, 1, 1, '', 1),
(426, 'CV_QRCODE', 'replaced with QRCODE_OPTION_SHOW', 11, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(427, 'OPTION_PLATFORM_STORE_PURCHASE', 'To set Payment Option for iOS (o for RazorPay and 1 for InApp)', 11, 0, 1, '', 1),
(428, 'OPTION_PLATFORM_STORE_PURCHASE', 'To set Payment Option for iOS (o for RazorPay and 1 for InApp)', 10, 0, 1, '', 1),
(429, 'FEATURE_MY_CONNECTIONS', 'replaced with MYCONNECTIONS', 12, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(430, 'FEATURE_SHOWCASE', 'replaced with SHOWCASE', 12, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(431, 'OPTION_REFERRAL_CODE', 'YES', 12, 0, 0, '', 1),
(432, 'RESOURCE_APP_LIVE', 'GIVE USER ACCESS TO THE APPLICATION', 12, 0, 0, '{\"image\": \"https://cvdragon.com/public/img/campaignsFiles/RAD2022.jpg\", \"message\": \"Server is currently under maintainance\"}', 1),
(433, 'DOWNLOAD_POPUP_CONTACT', 'hide the download icon in preview for iOS', 12, 0, 0, '', 1),
(434, 'USER_ACCESS_RECOMMENDATIONS', 'replaced with RECOMMENDATIONS', 12, 0, 0, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,5,6,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\", \"5\":\"upgrade\", \"6\":\"upgrade\"} \n}', 1),
(435, 'FEATURE_WIZARD', 'Show the Wizard in the Beginning', 12, 0, 0, '', 1),
(436, 'HOME_PAGE_FREE_SUBSCRIPTION', 'replaced with FREE_SUBSCRIPTION', 12, 1, 1, '', 1),
(437, 'HOME_PAGE_NOTIFICATION', 'Display Notifications on Home Screen', 12, 1, 1, '', 1),
(438, 'HOME_PAGE_SERVICES', 'Display Service Block on Home Screen', 12, 1, 1, '', 1),
(439, 'USER_SERVICES', 'replaced with SIDE_MENU_SERVICES', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(440, 'USER_SUBSCRIPTION', 'replaced with SIDE_MENU_SUBSCRIPTION', 12, 1, 0, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(441, 'HOME_PAGE_RECOMMENDATIONS', 'Display Recommendations on Home Screen', 12, 1, 1, '', 1),
(442, 'CV_BG_GRAPHICS_TOGGLE', 'CV Creation Feature', 12, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(443, 'CV_COLOR_CHANGE', 'CV Creation Feature', 12, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(444, 'CV_DOB_FORMAT_CHANGE', 'CV Creation Feature', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(445, 'CV_FONT_SIZE_CHANGE', 'CV Creation Feature', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(446, 'CV_FONT_STYLE_CHANGE', 'CV Creation Feature', 12, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(447, 'CV_IMAGE_TOGGLE', 'CV Creation Feature', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(448, 'CV_INSTITUTE_LOGO_TOGGLE', 'Keep/Remove your institute Logo', 12, 1, 1, '', 1),
(449, 'CV_PAGE_BREAK_ADD', 'Add Page Break Feature in the application', 12, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(450, 'CV_SECTION_DELETE', 'CV Creation Feature', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(451, 'CV_SECTION_RENAME', 'CV Creation Feature', 12, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(452, 'CV_SECTION_REORDER', 'replaced with REORDERDESIGN', 12, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(453, 'CV_WORK_PERIOD_FORMAT', 'Change WOrk Format Duration', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(454, 'FEATURE_MY_DOCUMENTS', '', 12, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(455, 'FEATURE_MY_INSTITUTE', 'replaced with MYINSTITUTE', 12, 1, 1, '', 0),
(456, 'FEATURE_PROOFREAD', 'replaced with PROOFREAD', 12, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(457, 'FEATURE_PROOFREAD2', 'replaced with PROOFREAD2', 12, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(458, 'HOME_PAGE_ARTICLES', 'Display Article block on Home Screen', 12, 1, 1, '', 1),
(459, 'HOME_PAGE_CV_DESIGN_LIST', 'Map of all the designs to be shown in the home page', 12, 1, 1, '[96,1,94,98,11,97,13]', 1),
(460, 'HOME_PAGE_DESIGNS', 'Display Design block on Home Screen', 12, 1, 1, '', 1),
(461, 'HOME_PAGE_FAQS', 'Display FAQs block on Homes Screen', 12, 1, 1, '', 1),
(462, 'HOME_PAGE_ICONS', 'Display Icons on Home Screen', 12, 1, 1, '', 1),
(463, 'HOME_PAGE_JOBS', 'Display Jobs Block on Home Screen', 12, 1, 1, '', 1),
(464, 'HOME_PAGE_MOTTO', 'Define the content on the Home Screen', 12, 1, 1, 'Welcome to cvDragon ♥️\n\nLet\'s create a\nPerfect CV ✌️', 1),
(465, 'HOME_PAGE_ORDER', 'Map of all Features on Home Screen to be Provided Category wise', 12, 1, 1, '{ \n\"1\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"2\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"3\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"4\": [ \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],  \n\"5\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],  \n\"6\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"0\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"10\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n]\n}', 1),
(466, 'HOME_PAGE_TIPS', 'Display Tips Block on Home Screen', 12, 1, 1, '', 1),
(467, 'HOME_PAGE_WORKSHOPS', 'Display Workshop Block on Home Screen', 12, 1, 1, '', 1),
(468, 'OPTION_DELETE_ACCOUNT', 'Show option to delete account', 12, 1, 1, '{\"heading\" : \"Sad to see you want to delete your account, Kindly let us know the reason(s)\", \"selectables\" : [\"Did not liked the application\", \"Had difficulty in creating CV\", \"Need more Professional Designs\", \"It is very slow and hard to navigate\", \"It is too buggy and not working properly\", \"I was Just exploring the application\"]}', 1),
(469, 'PHONE_LOGIN', 'Login via Mobile Number', 12, 1, 1, '', 1);
INSERT INTO `cvdragonappconfignew` (`configid`, `configkey`, `changesBeforeUpdate`, `version`, `configvalue`, `configvalueios`, `parameter`, `sendData`) VALUES
(470, 'RESOURCE_APP_RATING', 'user can give feedback', 12, 1, 1, '{\n   \"max_rating\":5,\n   \"1\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"2\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"3\":{\n      \"heading\":\"Thank you for your rating! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"4\":{\n      \"heading\":\"Thank you for your rating! What can we improve to expect a 5-star rating from you?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"5\":{\n      \"heading\":\"Thank you for rating us 5 stars! What did you like the most about the app?\",\n      \"selectables\":[\n         \"Application Interface\",\n         \"Professional Resume Designs\",\n         \"Simple CV Creation Process\",\n         \"A Lot of features\",\n         \"Application is Super easy to Navigate\"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Rate on App Store\",\n            \"link\":\"https://cvdragon.com/application\"\n         }\n      ]\n   }\n}', 1),
(471, 'SERVERTIME_THRESHOLD', 'YES', 12, 1, 1, '300', 1),
(472, 'USER_ACCESS_DIGITALCV', 'LIMIT THE OPTION FOR GUEST USER', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(473, 'USER_ACCESS_FAVOURITES', 'LIMIT THE OPTION FOR GUEST USER', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(474, 'USER_ACCESS_FEED', 'LIMIT THE OPTION FOR GUEST USER', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(475, 'USER_ACCESS_HELP', 'LIMIT THE OPTION FOR GUEST USER', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(476, 'USER_ACCESS_LOGOUT', 'LIMIT THE OPTION FOR GUEST USER', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(477, 'USER_ACCESS_MYRESUMES', 'LIMIT THE OPTION FOR GUEST USER', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(478, 'USER_ACCESS_MYSUBSCRIPTION', 'LIMIT THE OPTION FOR GUEST USER', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(479, 'USER_ACCESS_RESYNC', 'LIMIT THE OPTION FOR GUEST USER', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6,0], \n\"show\": [1,2,3,4,10,0,5,6]\n}', 1),
(480, 'USER_ACCESS_SETTINGS', 'LIMIT THE OPTION FOR GUEST USER', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(481, 'USER_ACCESS_WORKSHOPS', 'LIMIT THE OPTION FOR GUEST USER', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(482, 'USER_CATEGORY', 'Define the User Categories in the system', 12, 1, 1, '{ \n\"1\": \"FREE\", \n\"2\": \"PREMIUM\",\n\"3\": \"👑 PRO\",\n\"4\": \"💗 LIFETIME ACCESS\",\n\"10\": \"🍮 ADMIN\",\n\"0\": \"🕰️ GUEST\",\n\"5\": \"📚 STUDENT\",\n\"6\": \"💫 SUBSCRIPTION EXPIRED\"\n}', 1),
(483, 'USER_CATEGORY_DEFAULT', 'Default Category to be used', 12, 1, 1, '1', 1),
(484, 'USER_CATEGORY_UPGRADE', 'Show Upgrade Feature', 12, 1, 1, '[1,2,5,6,0]', 1),
(485, 'USER_DESIGN_ACCESS', 'Define the Designs accessed by the user', 12, 1, 1, '{\n   \"1\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         4\n      ]\n   },\n   \"3\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"2\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4\n      ]\n   },\n   \"4\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"10\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"5\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         4\n      ]\n   },\n   \"6\":{\n      \"show\":[\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n      ]\n   },\n   \"0\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         5\n      ],\n      \"usage\":[\n         0\n      ]\n   }\n}', 1),
(486, 'USER_FALLBACK_CATEGORY', 'Revert back to the old category once the subscription has expired', 12, 1, 1, '{\"3\": \"6\", \"2\": \"6\", \"4\": \"1\", \"0\": \"1\", \"5\": \"1\"}\n', 1),
(487, 'USER_NOTIFICATION_SETTINGS', 'Hide/Display the notifications in the User Settings Page', 12, 1, 1, '', 1),
(488, 'USER_PROFILE_LIMIT', 'Limit the profile creation of a user', 12, 1, 1, '{\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\", \"2\":\"upgrade\", \"3\":\"upgrade\", \"4\":\"upgrade\", \"10\":\"upgrade\", \"5\":\"upgrade\", \"6\":\"upgrade\"}, \"limits\": {\"3\": 100, \"1\": 2, \"2\": 5, \"4\": 100, \"10\": 100, \"0\": 2, \"5\": 5, \"6\": 5}}', 1),
(489, 'USER_SUBSCRIPTION_THRESHOLD', 'Subscription Limit days', 12, 1, 1, '{ \"1\": 0, \"2\": 30, \"3\": 15, \"4\": 30, \"5\": 0, \"6\": 0 }', 1),
(490, 'USER_SUBSCRIPTION_VALIDATION', 'Check the validation of the subscription of the category', 12, 1, 1, '{\"2\": \"Subscription\", \"3\": \"Subscription\", \"4\": \"Subscription\"}', 1),
(491, 'RESOURCE_WHATSAPP', 'Show WhatsApp number of cvDragon', 12, 1, 1, '9.20E+11', 1),
(492, 'RESOURCE_TEL', 'Show Phone number of cvDragon', 12, 1, 1, '9883124674', 1),
(493, 'RESOURCE_EMAIL', 'Show email of cvDragon', 12, 1, 1, 'cvdragon@lifeinmba.com', 1),
(494, 'ACTION_LOGOUT_INTERRUPTION', 'YES', 12, 1, 1, '{\"0\": {\"route\": \"login\", \"buttonText\": \"Connect\", \"heading\" : \"Are you sure that you want to log out? All your data will be lost unless you connect!\"}}', 1),
(495, 'CV_SECTION_ADD', 'CV Creation Feature', 12, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(496, 'RESOURCE_SOCIAL_LOGIN', 'Allow social login', 12, 1, 1, '', 1),
(497, 'HOME_PAGE_FEEDBACK', 'Display Feedback Option', 12, 1, 1, '', 1),
(498, 'HOME_PAGE_TUTORIALS', 'Display Tutorials on Home Screen', 12, 1, 1, '', 1),
(499, 'CV_QRCODE', 'replaced with QRCODE_OPTION_SHOW', 12, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(500, 'OPTION_PLATFORM_STORE_PURCHASE', 'To set Payment Option for iOS (o for RazorPay and 1 for InApp)', 12, 0, 1, '', 1),
(501, 'EULA', 'Terms & Conditions', 12, 1, 1, '{\r\n	\"version\": \"1.0.0\",\r\n	\"terms\": \"Please read the End-User License Agreement carefully before clicking the Accept Button and using cvDragon Resume Builder. You can read: https://cvdragon.com/terms\"\r\n}', 1),
(502, 'FEATURE_MY_CONNECTIONS', 'replaced with MYCONNECTIONS', 13, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(503, 'FEATURE_SHOWCASE', 'replaced with SHOWCASE', 13, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(504, 'OPTION_REFERRAL_CODE', 'YES', 13, 0, 0, '', 1),
(505, 'RESOURCE_APP_LIVE', 'GIVE USER ACCESS TO THE APPLICATION', 13, 0, 0, '{\"image\": \"https://cvdragon.com/public/img/campaignsFiles/RAD2022.jpg\", \"message\": \"Server is currently under maintainance\"}', 1),
(506, 'DOWNLOAD_POPUP_CONTACT', 'hide the download icon in preview for iOS', 13, 0, 0, '', 1),
(507, 'USER_ACCESS_RECOMMENDATIONS', 'replaced with RECOMMENDATIONS', 13, 0, 0, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,5,6,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\", \"5\":\"upgrade\", \"6\":\"upgrade\"} \n}', 1),
(508, 'FEATURE_WIZARD', 'Show the Wizard in the Beginning', 13, 0, 0, '', 1),
(509, 'HOME_PAGE_FREE_SUBSCRIPTION', 'replaced with FREE_SUBSCRIPTION', 13, 1, 1, '', 1),
(510, 'HOME_PAGE_NOTIFICATION', 'Display Notifications on Home Screen', 13, 1, 1, '', 1),
(511, 'HOME_PAGE_SERVICES', 'Display Service Block on Home Screen', 13, 1, 1, '', 1),
(512, 'USER_SERVICES', 'replaced with SIDE_MENU_SERVICES', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(513, 'USER_SUBSCRIPTION', 'replaced with SIDE_MENU_SUBSCRIPTION', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(514, 'HOME_PAGE_RECOMMENDATIONS', 'Display Recommendations on Home Screen', 13, 1, 1, '', 1),
(515, 'CV_BG_GRAPHICS_TOGGLE', 'CV Creation Feature', 13, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(516, 'CV_COLOR_CHANGE', 'CV Creation Feature', 13, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(517, 'CV_DOB_FORMAT_CHANGE', 'CV Creation Feature', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(518, 'CV_FONT_SIZE_CHANGE', 'CV Creation Feature', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(519, 'CV_FONT_STYLE_CHANGE', 'CV Creation Feature', 13, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(520, 'CV_IMAGE_TOGGLE', 'CV Creation Feature', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(521, 'CV_INSTITUTE_LOGO_TOGGLE', 'Keep/Remove your institute Logo', 13, 1, 1, '', 1),
(522, 'CV_PAGE_BREAK_ADD', 'Add Page Break Feature in the application', 13, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(523, 'CV_SECTION_DELETE', 'CV Creation Feature', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(524, 'CV_SECTION_RENAME', 'CV Creation Feature', 13, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(525, 'CV_SECTION_REORDER', 'replaced with REORDERDESIGN', 13, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(526, 'CV_WORK_PERIOD_FORMAT', 'Change WOrk Format Duration', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(527, 'FEATURE_MY_DOCUMENTS', '', 13, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(528, 'FEATURE_MY_INSTITUTE', 'replaced with MYINSTITUTE', 13, 1, 1, '', 0),
(529, 'FEATURE_PROOFREAD', 'replaced with PROOFREAD', 13, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(530, 'FEATURE_PROOFREAD2', 'replaced with PROOFREAD2', 13, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(531, 'HOME_PAGE_ARTICLES', 'Display Article block on Home Screen', 13, 1, 1, '', 1),
(532, 'HOME_PAGE_CV_DESIGN_LIST', 'Map of all the designs to be shown in the home page', 13, 1, 1, '[96,1,94,98,11,97,13]', 1),
(533, 'HOME_PAGE_DESIGNS', 'Display Design block on Home Screen', 13, 1, 1, '', 1),
(534, 'HOME_PAGE_FAQS', 'Display FAQs block on Homes Screen', 13, 1, 1, '', 1),
(535, 'HOME_PAGE_ICONS', 'Display Icons on Home Screen', 13, 1, 1, '', 1),
(536, 'HOME_PAGE_JOBS', 'Display Jobs Block on Home Screen', 13, 1, 1, '', 1),
(537, 'HOME_PAGE_MOTTO', 'Define the content on the Home Screen', 13, 1, 1, 'Welcome to cvDragon ♥️\n\nLet\'s create a\nPerfect CV ✌️', 1),
(538, 'HOME_PAGE_ORDER', 'Map of all Features on Home Screen to be Provided Category wise', 13, 1, 1, '{ \n\"1\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"2\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"3\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"4\": [ \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],  \n\"5\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],  \n\"6\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"0\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"10\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n]\n}', 1),
(539, 'HOME_PAGE_TIPS', 'Display Tips Block on Home Screen', 13, 1, 1, '', 1),
(540, 'HOME_PAGE_WORKSHOPS', 'Display Workshop Block on Home Screen', 13, 1, 1, '', 1),
(541, 'OPTION_DELETE_ACCOUNT', 'Show option to delete account', 13, 1, 1, '{\"heading\" : \"Sad to see you want to delete your account, Kindly let us know the reason(s)\", \"selectables\" : [\"Did not liked the application\", \"Had difficulty in creating CV\", \"Need more Professional Designs\", \"It is very slow and hard to navigate\", \"It is too buggy and not working properly\", \"I was Just exploring the application\"]}', 1),
(542, 'PHONE_LOGIN', 'Login via Mobile Number', 13, 1, 1, '', 1),
(543, 'RESOURCE_APP_RATING', 'user can give feedback', 13, 1, 1, '{\n   \"max_rating\":5,\n   \"1\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"2\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"3\":{\n      \"heading\":\"Thank you for your rating! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"4\":{\n      \"heading\":\"Thank you for your rating! What can we improve to expect a 5-star rating from you?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"5\":{\n      \"heading\":\"Thank you for rating us 5 stars! What did you like the most about the app?\",\n      \"selectables\":[\n         \"Application Interface\",\n         \"Professional Resume Designs\",\n         \"Simple CV Creation Process\",\n         \"A Lot of features\",\n         \"Application is Super easy to Navigate\"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Rate on App Store\",\n            \"link\":\"https://cvdragon.com/application\"\n         }\n      ]\n   }\n}', 1),
(544, 'SERVERTIME_THRESHOLD', 'YES', 13, 1, 1, '300', 1),
(545, 'USER_ACCESS_DIGITALCV', 'LIMIT THE OPTION FOR GUEST USER', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(546, 'USER_ACCESS_FAVOURITES', 'LIMIT THE OPTION FOR GUEST USER', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(547, 'USER_ACCESS_FEED', 'LIMIT THE OPTION FOR GUEST USER', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(548, 'USER_ACCESS_HELP', 'LIMIT THE OPTION FOR GUEST USER', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(549, 'USER_ACCESS_LOGOUT', 'LIMIT THE OPTION FOR GUEST USER', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(550, 'USER_ACCESS_MYRESUMES', 'LIMIT THE OPTION FOR GUEST USER', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(551, 'USER_ACCESS_MYSUBSCRIPTION', 'LIMIT THE OPTION FOR GUEST USER', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(552, 'USER_ACCESS_RESYNC', 'LIMIT THE OPTION FOR GUEST USER', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6,0], \n\"show\": [1,2,3,4,10,0,5,6]\n}', 1),
(553, 'USER_ACCESS_SETTINGS', 'LIMIT THE OPTION FOR GUEST USER', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(554, 'USER_ACCESS_WORKSHOPS', 'LIMIT THE OPTION FOR GUEST USER', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(555, 'USER_CATEGORY', 'Define the User Categories in the system', 13, 1, 1, '{ \n\"1\": \"FREE\", \n\"2\": \"PREMIUM\",\n\"3\": \"👑 PRO\",\n\"4\": \"💗 LIFETIME ACCESS\",\n\"10\": \"🍮 ADMIN\",\n\"0\": \"🕰️ GUEST\",\n\"5\": \"📚 STUDENT\",\n\"6\": \"💫 SUBSCRIPTION EXPIRED\"\n}', 1),
(556, 'USER_CATEGORY_DEFAULT', 'Default Category to be used', 13, 1, 1, '1', 1),
(557, 'USER_CATEGORY_UPGRADE', 'Show Upgrade Feature', 13, 1, 1, '[1,2,5,6,0]', 1),
(558, 'USER_DESIGN_ACCESS', 'Define the Designs accessed by the user', 13, 1, 1, '{\n   \"1\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         4\n      ]\n   },\n   \"3\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"2\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4\n      ]\n   },\n   \"4\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"10\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"5\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         4\n      ]\n   },\n   \"6\":{\n      \"show\":[\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n      ]\n   },\n   \"0\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         5\n      ],\n      \"usage\":[\n         0\n      ]\n   }\n}', 1),
(559, 'USER_FALLBACK_CATEGORY', 'Revert back to the old category once the subscription has expired', 13, 1, 1, '{\"3\": \"6\", \"2\": \"6\", \"4\": \"1\", \"0\": \"1\", \"5\": \"1\"}\n', 1),
(560, 'USER_NOTIFICATION_SETTINGS', 'Hide/Display the notifications in the User Settings Page', 13, 1, 1, '', 1),
(561, 'USER_PROFILE_LIMIT', 'Limit the profile creation of a user', 13, 1, 1, '{\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\", \"2\":\"upgrade\", \"3\":\"upgrade\", \"4\":\"upgrade\", \"10\":\"upgrade\", \"5\":\"upgrade\", \"6\":\"upgrade\"}, \"limits\": {\"3\": 100, \"1\": 2, \"2\": 5, \"4\": 100, \"10\": 100, \"0\": 2, \"5\": 5, \"6\": 5}}', 1),
(562, 'USER_SUBSCRIPTION_THRESHOLD', 'Subscription Limit days', 13, 1, 1, '{ \"1\": 0, \"2\": 30, \"3\": 15, \"4\": 30, \"5\": 0, \"6\": 0 }', 1),
(563, 'USER_SUBSCRIPTION_VALIDATION', 'Check the validation of the subscription of the category', 13, 1, 1, '{\"2\": \"Subscription\", \"3\": \"Subscription\", \"4\": \"Subscription\"}', 1),
(564, 'RESOURCE_WHATSAPP', 'Show WhatsApp number of cvDragon', 13, 1, 1, '9.20E+11', 1),
(565, 'RESOURCE_TEL', 'Show Phone number of cvDragon', 13, 1, 1, '9883124674', 1),
(566, 'RESOURCE_EMAIL', 'Show email of cvDragon', 13, 1, 1, 'cvdragon@lifeinmba.com', 1),
(567, 'ACTION_LOGOUT_INTERRUPTION', 'YES', 13, 1, 1, '{\"0\": {\"route\": \"login\", \"buttonText\": \"Connect\", \"heading\" : \"Are you sure that you want to log out? All your data will be lost unless you connect!\"}}', 1),
(568, 'CV_SECTION_ADD', 'CV Creation Feature', 13, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(569, 'RESOURCE_SOCIAL_LOGIN', 'Allow social login', 13, 1, 1, '', 1),
(570, 'HOME_PAGE_FEEDBACK', 'Display Feedback Option', 13, 1, 1, '', 1),
(571, 'HOME_PAGE_TUTORIALS', 'Display Tutorials on Home Screen', 13, 1, 1, '', 1),
(572, 'CV_QRCODE', 'replaced with QRCODE_OPTION_SHOW', 13, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(573, 'OPTION_PLATFORM_STORE_PURCHASE', 'To set Payment Option for iOS (o for RazorPay and 1 for InApp)', 13, 0, 1, '', 1),
(574, 'EULA', 'Terms & Conditions', 13, 0, 0, '{\"version\":\"1.0.0\",\"terms\":\"Please read the End-User License Agreement before clicking the Accept Button and using cvDragon Resume Builder. You can read: https://cvdragon.com/terms\"}', 1),
(575, 'ACTION_LOGOUT_INTERRUPTION', 'YES', 15, 1, 1, '{\"0\": {\"route\": \"login\", \"buttonText\": \"Connect\", \"heading\" : \"Are you sure that you want to log out? All your data will be lost unless you connect!\"}}', 1),
(576, 'CV_BG_GRAPHICS_TOGGLE', 'CV Creation Feature', 15, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(577, 'CV_COLOR_CHANGE', 'CV Creation Feature', 15, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(578, 'CV_DOB_FORMAT_CHANGE', 'CV Creation Feature', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(579, 'CV_FONT_SIZE_CHANGE', 'CV Creation Feature', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(580, 'CV_FONT_STYLE_CHANGE', 'CV Creation Feature', 15, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(581, 'CV_IMAGE_TOGGLE', 'CV Creation Feature', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(582, 'CV_INSTITUTE_LOGO_TOGGLE', 'Keep/Remove your institute Logo', 15, 1, 1, '', 1),
(583, 'CV_PAGE_BREAK_ADD', 'Add Page Break Feature in the application', 15, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(584, 'CV_QRCODE', 'replaced with QRCODE_OPTION_SHOW', 15, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(585, 'CV_SECTION_ADD', 'CV Creation Feature', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(586, 'CV_SECTION_DELETE', 'CV Creation Feature', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(587, 'CV_SECTION_RENAME', 'CV Creation Feature', 15, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(588, 'CV_SECTION_REORDER', 'replaced with REORDERDESIGN', 15, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(589, 'CV_WORK_PERIOD_FORMAT', 'Change WOrk Format Duration', 15, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(590, 'DOWNLOAD_POPUP_CONTACT', 'hide the download icon in preview for iOS', 15, 0, 0, '', 1),
(591, 'EULA', 'Terms & Conditions', 15, 0, 1, '{\"version\":\"1.0.0\",\"terms\":\"Please read the End-User License Agreement before clicking the Accept Button and using cvDragon Resume Builder. You can read: https://cvdragon.com/terms\"}', 1),
(592, 'FEATURE_MY_CONNECTIONS', 'replaced with MYCONNECTIONS', 15, 1, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(593, 'FEATURE_MY_DOCUMENTS', '', 15, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(594, 'FEATURE_MY_INSTITUTE', 'replaced with MYINSTITUTE', 15, 1, 1, '', 0),
(595, 'FEATURE_PROOFREAD', 'replaced with PROOFREAD', 15, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(596, 'FEATURE_PROOFREAD2', 'replaced with PROOFREAD2', 15, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(597, 'FEATURE_SHOWCASE', 'replaced with SHOWCASE', 15, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(598, 'FEATURE_WIZARD', 'Show the Wizard in the Beginning', 15, 1, 1, '', 1),
(599, 'HOME_PAGE_ARTICLES', 'Display Article block on Home Screen', 15, 1, 1, '', 1),
(600, 'HOME_PAGE_CV_DESIGN_LIST', 'Map of all the designs to be shown in the home page', 15, 1, 1, '[96,1,94,98,11,97,13]', 1),
(601, 'HOME_PAGE_DESIGNS', 'Display Design block on Home Screen', 15, 1, 1, '', 1),
(602, 'HOME_PAGE_FAQS', 'Display FAQs block on Homes Screen', 15, 1, 1, '', 1),
(603, 'HOME_PAGE_FEEDBACK', 'Display Feedback Option', 15, 1, 1, '', 1),
(604, 'HOME_PAGE_FREE_SUBSCRIPTION', 'replaced with FREE_SUBSCRIPTION', 15, 0, 0, '', 1),
(605, 'HOME_PAGE_ICONS', 'Display Icons on Home Screen', 15, 1, 1, '', 1),
(606, 'HOME_PAGE_JOBS', 'Display Jobs Block on Home Screen', 15, 1, 1, '', 1),
(607, 'HOME_PAGE_MOTTO', 'Define the content on the Home Screen', 15, 1, 1, 'Welcome to cvDragon ♥️\n\nLets build a\nPerfect CV ✌️', 1),
(608, 'HOME_PAGE_NOTIFICATION', 'Display Notifications on Home Screen', 15, 1, 1, '', 1),
(609, 'HOME_PAGE_ORDER', 'Map of all Features on Home Screen to be Provided Category wise', 15, 1, 1, '{ \n\"1\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"2\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"3\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"4\": [ \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],  \n\"5\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],  \n\"6\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"0\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"10\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n]\n}', 1),
(610, 'HOME_PAGE_RECOMMENDATIONS', 'Display Recommendations on Home Screen', 15, 1, 1, '', 1),
(611, 'HOME_PAGE_SERVICES', 'Display Service Block on Home Screen', 15, 1, 1, '', 1),
(612, 'HOME_PAGE_TIPS', 'Display Tips Block on Home Screen', 15, 1, 1, '', 1),
(613, 'HOME_PAGE_TUTORIALS', 'Display Tutorials on Home Screen', 15, 1, 1, '', 1),
(614, 'HOME_PAGE_WORKSHOPS', 'Display Workshop Block on Home Screen', 15, 0, 0, '', 1),
(615, 'OPTION_DELETE_ACCOUNT', 'Show option to delete account', 15, 1, 1, '{\"heading\" : \"Sad to see you want to delete your account, Kindly let us know the reason(s)\", \"selectables\" : [\"Did not liked the application\", \"Had difficulty in creating CV\", \"Need more Professional Designs\", \"It is very slow and hard to navigate\", \"It is too buggy and not working properly\", \"I was Just exploring the application\"]}', 1),
(616, 'OPTION_PLATFORM_STORE_PURCHASE', 'To set Payment Option for iOS (o for RazorPay and 1 for InApp)', 15, 0, 0, '', 1),
(617, 'OPTION_REFERRAL_CODE', 'YES', 15, 0, 0, '', 1),
(618, 'PHONE_LOGIN', 'Login via Mobile Number', 15, 1, 1, '', 1),
(619, 'RESOURCE_APP_LIVE', 'GIVE USER ACCESS TO THE APPLICATION', 15, 0, 0, '{\"image\": \"https://cvdragon.com/public/img/campaignsFiles/RAD2022.jpg\", \"message\": \"Server is currently under maintainance\"}', 1),
(620, 'RESOURCE_APP_RATING', 'user can give feedback', 15, 1, 1, '{\n   \"max_rating\":5,\n   \"1\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"2\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"3\":{\n      \"heading\":\"Thank you for your rating! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"4\":{\n      \"heading\":\"Thank you for your rating! What can we improve to expect a 5-star rating from you?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"5\":{\n      \"heading\":\"Thank you for rating us 5 stars! What did you like the most about the app?\",\n      \"selectables\":[\n         \"Application Interface\",\n         \"Professional Resume Designs\",\n         \"Simple CV Creation Process\",\n         \"A Lot of features\",\n         \"Application is Super easy to Navigate\"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Rate on App Store\",\n            \"link\":\"https://cvdragon.com/application\"\n         }\n      ]\n   }\n}', 1),
(621, 'RESOURCE_EMAIL', 'Show email of cvDragon', 15, 1, 1, 'info@cvdragon.com', 1),
(622, 'RESOURCE_SOCIAL_LOGIN', 'Allow social login', 15, 1, 1, '', 1),
(623, 'RESOURCE_TEL', 'Show Phone number of cvDragon', 15, 1, 1, '9883124674', 1),
(624, 'RESOURCE_WHATSAPP', 'Show WhatsApp number of cvDragon', 15, 1, 1, '919883124674', 1),
(625, 'SERVERTIME_THRESHOLD', 'YES', 15, 1, 1, '300', 1),
(626, 'USER_ACCESS_DIGITALCV', 'LIMIT THE OPTION FOR GUEST USER', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(627, 'USER_ACCESS_FAVOURITES', 'LIMIT THE OPTION FOR GUEST USER', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(628, 'USER_ACCESS_FEED', 'LIMIT THE OPTION FOR GUEST USER', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(629, 'USER_ACCESS_HELP', 'LIMIT THE OPTION FOR GUEST USER', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(630, 'USER_ACCESS_LOGOUT', 'LIMIT THE OPTION FOR GUEST USER', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(631, 'USER_ACCESS_MYRESUMES', 'LIMIT THE OPTION FOR GUEST USER', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(632, 'USER_ACCESS_MYSUBSCRIPTION', 'LIMIT THE OPTION FOR GUEST USER', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(633, 'USER_ACCESS_RECOMMENDATIONS', 'replaced with RECOMMENDATIONS', 15, 0, 0, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,5,6,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\", \"5\":\"upgrade\", \"6\":\"upgrade\"} \n}', 1),
(634, 'USER_ACCESS_RESYNC', 'LIMIT THE OPTION FOR GUEST USER', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6,0], \n\"show\": [1,2,3,4,10,0,5,6]\n}', 1),
(635, 'USER_ACCESS_SETTINGS', 'LIMIT THE OPTION FOR GUEST USER', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(636, 'USER_ACCESS_WORKSHOPS', 'LIMIT THE OPTION FOR GUEST USER', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(637, 'USER_CATEGORY', 'Define the User Categories in the system', 15, 1, 1, '{ \n\"1\": \"FREE\", \n\"2\": \"PREMIUM\",\n\"3\": \"👑 PRO\",\n\"4\": \"💗 LIFETIME ACCESS\",\n\"10\": \"🍮 ADMIN\",\n\"0\": \"🕰️ GUEST\",\n\"5\": \"📚 STUDENT\",\n\"6\": \"💫 FREE USER\"\n}', 1),
(638, 'USER_CATEGORY_DEFAULT', 'Default Category to be used', 15, 1, 1, '1', 1),
(639, 'USER_CATEGORY_UPGRADE', 'Show Upgrade Feature', 15, 1, 1, '[1,2,5,6,0]', 1),
(640, 'USER_DESIGN_ACCESS', 'Define the Designs accessed by the user', 15, 1, 1, '{\n   \"1\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         4\n      ]\n   },\n   \"3\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"2\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4\n      ]\n   },\n   \"4\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"10\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"5\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         4\n      ]\n   },\n   \"6\":{\n      \"show\":[\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n      ]\n   },\n   \"0\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         5\n      ],\n      \"usage\":[\n         0\n      ]\n   }\n}', 1),
(641, 'USER_FALLBACK_CATEGORY', 'Revert back to the old category once the subscription has expired', 15, 1, 1, '{\"3\": \"6\", \"2\": \"6\", \"4\": \"1\", \"0\": \"1\", \"5\": \"1\"}\n', 1),
(642, 'USER_NOTIFICATION_SETTINGS', 'Hide/Display the notifications in the User Settings Page', 15, 1, 1, '', 1),
(643, 'USER_PROFILE_LIMIT', 'Limit the profile creation of a user', 15, 1, 1, '{\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\", \"2\":\"upgrade\", \"3\":\"upgrade\", \"4\":\"upgrade\", \"10\":\"upgrade\", \"5\":\"upgrade\", \"6\":\"upgrade\"}, \"limits\": {\"3\": 100, \"1\": 2, \"2\": 5, \"4\": 100, \"10\": 100, \"0\": 2, \"5\": 5, \"6\": 5}}', 1),
(644, 'USER_SERVICES', 'replaced with SIDE_MENU_SERVICES', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(645, 'USER_SUBSCRIPTION', 'replaced with SIDE_MENU_SUBSCRIPTION', 15, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(646, 'USER_SUBSCRIPTION_THRESHOLD', 'Subscription Limit days', 15, 1, 1, '{ \"1\": 0, \"2\": 30, \"3\": 15, \"4\": 30, \"5\": 0, \"6\": 0 }', 1),
(647, 'USER_SUBSCRIPTION_VALIDATION', 'Check the validation of the subscription of the category', 15, 1, 1, '{\"2\": \"Subscription\", \"3\": \"Subscription\", \"4\": \"Subscription\"}', 1),
(648, 'ACTION_LOGOUT_INTERRUPTION', 'YES', 18, 1, 1, '{\"0\": {\"route\": \"login\", \"buttonText\": \"Connect\", \"heading\" : \"Are you sure that you want to log out? All your data will be lost unless you connect!\"}}', 1),
(649, 'CV_BG_GRAPHICS_TOGGLE', 'CV Creation Feature', 18, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(650, 'CV_COLOR_CHANGE', 'CV Creation Feature', 18, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(651, 'CV_DOB_FORMAT_CHANGE', 'CV Creation Feature', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(652, 'CV_FONT_SIZE_CHANGE', 'CV Creation Feature', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(653, 'CV_FONT_STYLE_CHANGE', 'CV Creation Feature', 18, 1, 1, '{ \n\"usage\": [3,1,2,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(654, 'CV_IMAGE_TOGGLE', 'CV Creation Feature', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(655, 'CV_INSTITUTE_LOGO_TOGGLE', 'Keep/Remove your institute Logo', 18, 1, 1, '', 1),
(656, 'CV_PAGE_BREAK_ADD', 'Add Page Break Feature in the application', 18, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(657, 'CV_QRCODE', 'replaced with QRCODE_OPTION_SHOW', 18, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(658, 'CV_SECTION_ADD', 'CV Creation Feature', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(659, 'CV_SECTION_DELETE', 'CV Creation Feature', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(660, 'CV_SECTION_RENAME', 'CV Creation Feature', 18, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(661, 'CV_SECTION_REORDER', 'replaced with REORDERDESIGN', 18, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(662, 'CV_WORK_PERIOD_FORMAT', 'Change WOrk Format Duration', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(663, 'DOWNLOAD_POPUP_CONTACT', 'hide the download icon in preview for iOS', 18, 0, 0, '', 1),
(664, 'EULA', 'Terms & Conditions', 18, 0, 1, '{\"version\":\"1.0.0\",\"terms\":\"Please read the End-User License Agreement before clicking the Accept Button and using cvDragon Resume Builder. You can read: https://cvdragon.com/terms\"}', 1),
(665, 'FEATURE_MY_CONNECTIONS', 'replaced with MYCONNECTIONS', 18, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(666, 'FEATURE_MY_DOCUMENTS', '', 18, 1, 1, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1);
INSERT INTO `cvdragonappconfignew` (`configid`, `configkey`, `changesBeforeUpdate`, `version`, `configvalue`, `configvalueios`, `parameter`, `sendData`) VALUES
(667, 'FEATURE_MY_INSTITUTE', 'replaced with MYINSTITUTE', 18, 1, 1, '', 0),
(668, 'FEATURE_PROOFREAD', 'replaced with PROOFREAD', 18, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(669, 'FEATURE_PROOFREAD2', 'replaced with PROOFREAD2', 18, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\"} \n}', 1),
(670, 'FEATURE_SHOWCASE', 'replaced with SHOWCASE', 18, 0, 0, '{ \n\"usage\": [3,2,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\"} \n}', 0),
(671, 'FEATURE_WIZARD', 'Show the Wizard in the Beginning', 18, 1, 1, '', 1),
(672, 'HOME_PAGE_ARTICLES', 'Display Article block on Home Screen', 18, 1, 1, '', 1),
(673, 'HOME_PAGE_CV_DESIGN_LIST', 'Map of all the designs to be shown in the home page', 18, 1, 1, '[96,1,94,98,11,97,13]', 1),
(674, 'HOME_PAGE_DESIGNS', 'Display Design block on Home Screen', 18, 1, 1, '', 1),
(675, 'HOME_PAGE_FAQS', 'Display FAQs block on Homes Screen', 18, 1, 1, '', 1),
(676, 'HOME_PAGE_FEEDBACK', 'Display Feedback Option', 18, 1, 1, '', 1),
(677, 'HOME_PAGE_FREE_SUBSCRIPTION', 'replaced with FREE_SUBSCRIPTION', 18, 1, 1, '', 1),
(678, 'HOME_PAGE_ICONS', 'Display Icons on Home Screen', 18, 1, 1, '', 1),
(679, 'HOME_PAGE_JOBS', 'Display Jobs Block on Home Screen', 18, 1, 1, '', 1),
(680, 'HOME_PAGE_MOTTO', 'Define the content on the Home Screen', 18, 1, 1, 'Never Stop doing your Best !!', 1),
(681, 'HOME_PAGE_NOTIFICATION', 'Display Notifications on Home Screen', 18, 1, 1, '', 1),
(682, 'HOME_PAGE_ORDER', 'Map of all Features on Home Screen to be Provided Category wise', 18, 1, 1, '{ \n\"1\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"2\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"3\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],\n\"4\": [ \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_DESIGNS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n],  \n\"5\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],  \n\"6\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"0\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_MOTTO\"  \n],\n\"10\": [ \n\"HOME_PAGE_NOTIFICATION\", \n\"HOME_PAGE_ICONS\",\n\"HOME_PAGE_RECOMMENDATIONS\",\n\"HOME_PAGE_FREE_SUBSCRIPTION\", \n\"HOME_PAGE_TUTORIALS\", \n\"HOME_PAGE_DESIGNS\", \n\"HOME_PAGE_WORKSHOPS\", \n\"HOME_PAGE_JOBS\", \n\"HOME_PAGE_TIPS\", \n\"HOME_PAGE_FAQS\", \n\"HOME_PAGE_SERVICES\", \n\"HOME_PAGE_ARTICLES\",\n\"HOME_PAGE_FEEDBACK\",\n\"HOME_PAGE_MOTTO\"   \n]\n}', 1),
(683, 'HOME_PAGE_RECOMMENDATIONS', 'Display Recommendations on Home Screen', 18, 1, 1, '', 1),
(684, 'HOME_PAGE_SERVICES', 'Display Service Block on Home Screen', 18, 1, 1, '', 1),
(685, 'HOME_PAGE_TIPS', 'Display Tips Block on Home Screen', 18, 1, 1, '', 1),
(686, 'HOME_PAGE_TUTORIALS', 'Display Tutorials on Home Screen', 18, 1, 1, '', 1),
(687, 'HOME_PAGE_WORKSHOPS', 'Display Workshop Block on Home Screen', 18, 0, 0, '', 1),
(688, 'OPTION_DELETE_ACCOUNT', 'Show option to delete account', 18, 1, 1, '{\"heading\" : \"Sad to see you want to delete your account, Kindly let us know the reason(s)\", \"selectables\" : [\"Did not liked the application\", \"Had difficulty in creating CV\", \"Need more Professional Designs\", \"It is very slow and hard to navigate\", \"It is too buggy and not working properly\", \"I was Just exploring the application\"]}', 1),
(689, 'OPTION_PLATFORM_STORE_PURCHASE', 'To set Payment Option for iOS (o for RazorPay and 1 for InApp)', 18, 0, 1, '', 1),
(690, 'OPTION_REFERRAL_CODE', 'YES', 18, 0, 0, '', 1),
(691, 'PHONE_LOGIN', 'Login via Mobile Number', 18, 1, 1, '', 1),
(692, 'RESOURCE_APP_LIVE', 'GIVE USER ACCESS TO THE APPLICATION', 18, 0, 0, '{\"image\": \"https://cvdragon.com/public/img/campaignsFiles/RAD2022.jpg\", \"message\": \"Server is currently under maintainance\"}', 1),
(693, 'RESOURCE_APP_RATING', 'user can give feedback', 18, 1, 1, '{\n   \"max_rating\":5,\n   \"1\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"2\":{\n      \"heading\":\"We are sorry to hear that you were not satisfied with the app! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"3\":{\n      \"heading\":\"Thank you for your rating! Help us Improve! What could be better?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"4\":{\n      \"heading\":\"Thank you for your rating! What can we improve to expect a 5-star rating from you?\",\n      \"selectables\":[\n         \"App is not easily navigable\",\n         \"Need more Professional Resume Designs\",\n         \"Need more Features\",\n         \"Add more Free Designs\",\n         \"CV Creation can be simplified\",\n         \"Subscription charges are high \"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Contact Us\",\n            \"link\":\"https://wa.me/919883124674\"\n         }\n      ]\n   },\n   \"5\":{\n      \"heading\":\"Thank you for rating us 5 stars! What did you like the most about the app?\",\n      \"selectables\":[\n         \"Application Interface\",\n         \"Professional Resume Designs\",\n         \"Simple CV Creation Process\",\n         \"A Lot of features\",\n         \"Application is Super easy to Navigate\"\n      ],\n      \"buttons\":[\n         {\n            \"name\":\"Rate on App Store\",\n            \"link\":\"https://cvdragon.com/application\"\n         }\n      ]\n   }\n}', 1),
(694, 'RESOURCE_EMAIL', 'Show email of cvDragon', 18, 1, 1, 'cvdragon@lifeinmba.com', 1),
(695, 'RESOURCE_SOCIAL_LOGIN', 'Allow social login', 18, 1, 1, '', 1),
(696, 'RESOURCE_TEL', 'Show Phone number of cvDragon', 18, 1, 1, '9883124674', 1),
(697, 'RESOURCE_WHATSAPP', 'Show WhatsApp number of cvDragon', 18, 1, 1, '919883124674', 1),
(698, 'SERVERTIME_THRESHOLD', 'YES', 18, 1, 1, '300', 1),
(699, 'USER_ACCESS_DIGITALCV', 'LIMIT THE OPTION FOR GUEST USER', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(700, 'USER_ACCESS_FAVOURITES', 'LIMIT THE OPTION FOR GUEST USER', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(701, 'USER_ACCESS_FEED', 'LIMIT THE OPTION FOR GUEST USER', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(702, 'USER_ACCESS_HELP', 'LIMIT THE OPTION FOR GUEST USER', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(703, 'USER_ACCESS_LOGOUT', 'LIMIT THE OPTION FOR GUEST USER', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(704, 'USER_ACCESS_MYRESUMES', 'LIMIT THE OPTION FOR GUEST USER', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(705, 'USER_ACCESS_MYSUBSCRIPTION', 'LIMIT THE OPTION FOR GUEST USER', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(706, 'USER_ACCESS_RECOMMENDATIONS', 'replaced with RECOMMENDATIONS', 18, 1, 1, '{ \n\"usage\": [3,4,10], \n\"show\": [1,2,3,4,10,5,6,0], \n\"usage_restriction_route\": {\"1\": \"upgrade\", \"2\": \"upgrade\", \"0\":\"upgrade\", \"5\":\"upgrade\", \"6\":\"upgrade\"} \n}', 1),
(707, 'USER_ACCESS_RESYNC', 'LIMIT THE OPTION FOR GUEST USER', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6,0], \n\"show\": [1,2,3,4,10,0,5,6]\n}', 1),
(708, 'USER_ACCESS_SETTINGS', 'LIMIT THE OPTION FOR GUEST USER', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(709, 'USER_ACCESS_WORKSHOPS', 'LIMIT THE OPTION FOR GUEST USER', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {\"0\": \"login\"} \n}', 1),
(710, 'USER_CATEGORY', 'Define the User Categories in the system', 18, 1, 1, '{ \n\"1\": \"FREE\", \n\"2\": \"PREMIUM\",\n\"3\": \"👑 PRO\",\n\"4\": \"💗 LIFETIME ACCESS\",\n\"10\": \"🍮 ADMIN\",\n\"0\": \"🕰️ GUEST\",\n\"5\": \"📚 STUDENT\",\n\"6\": \"💫 FREE USER\"\n}', 1),
(711, 'USER_CATEGORY_DEFAULT', 'Default Category to be used', 18, 1, 1, '1', 1),
(712, 'USER_CATEGORY_UPGRADE', 'Show Upgrade Feature', 18, 1, 1, '[1,2,5,6,0]', 1),
(713, 'USER_DESIGN_ACCESS', 'Define the Designs accessed by the user', 18, 1, 1, '{\n   \"1\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         4\n      ]\n   },\n   \"3\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"2\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4\n      ]\n   },\n   \"4\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"10\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ]\n   },\n   \"5\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n         0,\n         4\n      ]\n   },\n   \"6\":{\n      \"show\":[\n         1,\n         2,\n         3,\n         4,\n         5\n      ],\n      \"usage\":[\n      ]\n   },\n   \"0\":{\n      \"show\":[\n         0,\n         1,\n         2,\n         3,\n         5\n      ],\n      \"usage\":[\n         0\n      ]\n   }\n}', 1),
(714, 'USER_FALLBACK_CATEGORY', 'Revert back to the old category once the subscription has expired', 18, 1, 1, '{\"3\": \"6\", \"2\": \"6\", \"4\": \"1\", \"0\": \"1\", \"5\": \"1\"}\n', 1),
(715, 'USER_NOTIFICATION_SETTINGS', 'Hide/Display the notifications in the User Settings Page', 18, 1, 1, '', 1),
(716, 'USER_PROFILE_LIMIT', 'Limit the profile creation of a user', 18, 1, 1, '{\"usage_restriction_route\": {\"1\": \"upgrade\", \"0\":\"upgrade\", \"2\":\"upgrade\", \"3\":\"upgrade\", \"4\":\"upgrade\", \"10\":\"upgrade\", \"5\":\"upgrade\", \"6\":\"upgrade\"}, \"limits\": {\"3\": 100, \"1\": 2, \"2\": 5, \"4\": 100, \"10\": 100, \"0\": 2, \"5\": 5, \"6\": 5}}', 1),
(717, 'USER_SERVICES', 'replaced with SIDE_MENU_SERVICES', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(718, 'USER_SUBSCRIPTION', 'replaced with SIDE_MENU_SUBSCRIPTION', 18, 1, 1, '{ \n\"usage\": [1,2,3,4,10,0,5,6], \n\"show\": [1,2,3,4,10,0,5,6], \n\"usage_restriction_route\": {} \n}', 1),
(719, 'USER_SUBSCRIPTION_THRESHOLD', 'Subscription Limit days', 18, 1, 1, '{ \"1\": 0, \"2\": 30, \"3\": 15, \"4\": 30, \"5\": 0, \"6\": 0 }', 1),
(720, 'USER_SUBSCRIPTION_VALIDATION', 'Check the validation of the subscription of the category', 18, 1, 1, '{\"2\": \"Subscription\", \"3\": \"Subscription\", \"4\": \"Subscription\"}', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cvprofiles`
--

CREATE TABLE `cvprofiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `profileName` varchar(100) NOT NULL,
  `sections` varchar(255) DEFAULT NULL,
  `sectionOrder` varchar(255) DEFAULT NULL,
  `design` int(11) DEFAULT NULL,
  `font` int(11) DEFAULT NULL,
  `setting` int(11) DEFAULT NULL,
  `profilePicture` varchar(100) DEFAULT NULL,
  `intro` bigint(20) DEFAULT NULL,
  `isPublic` tinyint(4) DEFAULT NULL,
  `progressReport` tinyint(4) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cvsections`
--

CREATE TABLE `cvsections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `section` int(11) NOT NULL,
  `sectionid` int(11) NOT NULL,
  `contentAdded` int(10) UNSIGNED NOT NULL,
  `contentStatus` int(11) NOT NULL,
  `dateCreated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(6) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cv_social_links`
--

CREATE TABLE `cv_social_links` (
  `socialid` int(10) UNSIGNED NOT NULL,
  `id` bigint(11) NOT NULL,
  `link_name` varchar(150) NOT NULL,
  `link` varchar(150) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cv_social_links`
--

INSERT INTO `cv_social_links` (`socialid`, `id`, `link_name`, `link`, `status`, `created_at`, `updated_at`) VALUES
(1, 1748065614627, 'fb', 'https://www.facebook.com/', 1, NULL, NULL),
(2, 1748065614627, 'linkedin', 'https://www.linkedin.com/', 0, NULL, NULL),
(3, 1748065614627, 'linkedin', 'https://www.linkedin.com/', 0, NULL, NULL),
(4, 1748065614627, 'fb', 'https://www.facebook.com/', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `help-chat`
--

CREATE TABLE `help-chat` (
  `chatID` int(11) NOT NULL,
  `senderID` bigint(20) NOT NULL,
  `receiverID` bigint(20) NOT NULL,
  `chat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` int(11) NOT NULL,
  `isResolved` tinyint(4) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` timestamp NOT NULL DEFAULT current_timestamp(),
  `adminID` bigint(20) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `help-chat`
--

INSERT INTO `help-chat` (`chatID`, `senderID`, `receiverID`, `chat`, `type`, `isResolved`, `dateCreated`, `dateUpdated`, `adminID`, `status`) VALUES
(4689, 14889791841417, 1, 'how to update CV? ', 1, 1, '2021-04-30 22:58:42', '2021-04-30 17:28:42', 0, 1),
(4757, 14889791841417, 1, '?? ', 1, 1, '2021-05-05 15:45:02', '2021-05-05 10:15:02', 0, 1),
(4773, 14889791841417, 1, 'how to download CV? ', 1, 1, '2021-05-07 23:26:13', '2021-05-07 17:56:13', 0, 1),
(4805, 14889791841417, 1, 'ok', 1, 1, '2021-05-09 03:09:10', '2021-05-08 21:39:10', 0, 1),
(5521, 14889791841417, 1, 'test', 1, 1, '2021-06-02 09:31:32', '2021-06-02 04:01:32', 0, 1),
(5774, 14889791841417, 1, 'hello ', 1, 1, '2021-06-09 18:25:46', '2021-06-09 12:55:46', 0, 1),
(5863, 14889791841417, 1, 'hello', 1, 1, '2021-06-13 13:38:04', '2021-06-13 08:08:04', 0, 1),
(5868, 14889791841417, 1, 'hi', 1, 1, '2021-06-14 02:32:31', '2021-06-13 21:02:31', 0, 1),
(6126, 14889791841417, 1, '{\"fileName\":\"cvDragon session - 27(B) 20210529_222201.jpg\",\"link\":\"https://cvdragon.com/public/resources/documentUpload/162451796332.jpg\",\"message\":\"\"}', 2, 1, '2021-06-24 12:29:23', '2021-06-24 06:59:23', 0, 1),
(6127, 14889791841417, 1, 'https://youtu.be/otnmWxZqftg', 1, 1, '2021-06-24 12:33:01', '2021-06-24 07:03:01', 0, 1),
(6128, 14889791841417, 1, '{\"fileName\":\"DACOE 2020 LinkedIn ud83dude0e 20190822_141738.jpg\",\"link\":\"https://cvdragon.com/public/resources/documentUpload/162451825135.jpg\",\"message\":\"LinkedIn Session\"}', 2, 1, '2021-06-24 12:34:11', '2021-06-24 07:04:11', 0, 1),
(6129, 14889791841417, 1, '{\"fileName\":\"1600253574.pdf\",\"link\":\"https://cvdragon.com/public/resources/documentUpload/162451827942.pdf\",\"message\":\"Pdf\"}', 2, 1, '2021-06-24 12:34:39', '2021-06-24 07:04:39', 0, 1),
(6240, 14889791841417, 1, 'hi', 1, 1, '2021-07-01 02:26:12', '2021-06-30 20:56:12', 0, 1),
(7291, 14889791841417, 1, 'hi', 1, 1, '2021-08-13 23:42:36', '2021-08-13 18:12:36', 0, 1),
(7307, 14889791841417, 1, 'hi', 1, 1, '2021-08-14 01:47:23', '2021-08-13 20:17:23', 0, 1),
(7308, 14889791841417, 1, 'hello', 1, 1, '2021-08-14 01:47:51', '2021-08-13 20:17:51', 0, 1),
(7309, 14889791841417, 1, 'hi', 1, 1, '2021-08-14 01:52:34', '2021-08-13 20:22:34', 0, 1),
(7310, 14889791841417, 1, 'ki', 1, 1, '2021-08-14 01:53:42', '2021-08-13 20:23:42', 0, 1),
(7311, 14889791841417, 1, 'i', 1, 1, '2021-08-14 01:53:48', '2021-08-13 20:23:48', 0, 1),
(7312, 14889791841417, 1, 'y', 1, 1, '2021-08-14 01:54:10', '2021-08-13 20:24:10', 0, 1),
(7313, 14889791841417, 1, 'hi', 1, 1, '2021-08-14 01:54:23', '2021-08-13 20:24:23', 0, 1),
(7314, 14889791841417, 1, 'i', 1, 1, '2021-08-14 01:54:28', '2021-08-13 20:24:28', 0, 1),
(7316, 14889791841417, 1, 'hi', 1, 1, '2021-08-14 09:41:13', '2021-08-14 04:11:13', 0, 1),
(7934, 14889791841417, 1, 'hi', 1, 1, '2021-09-02 14:05:58', '2021-09-02 08:35:58', 0, 1),
(9472, 14889791841417, 1, 'hi', 1, 1, '2021-11-01 15:17:37', '2021-11-06 08:21:15', 0, 1),
(9473, 14889791841417, 1, 'yy', 1, 1, '2021-11-01 15:17:49', '2021-11-06 08:21:13', 0, 1),
(9717, 14889791841417, 1, 'hi', 1, 1, '2021-11-19 12:18:55', '2021-11-19 06:48:55', 0, 1),
(11418, 14889791841417, 1, '{\"fileName\":\"IMG-20220401-WA0005.jpg\",\"link\":\"https://cvdragon.com/public/resources/documentUpload/164887334436.jpg\",\"message\":\"Check this \"}', 2, 1, '2022-04-02 09:52:24', '2022-04-02 04:22:24', 0, 1),
(11419, 14889791841417, 1, 'check', 1, 1, '2022-04-02 09:52:39', '2022-04-02 04:22:39', 0, 1),
(11900, 14889791841417, 1, 'hi', 1, 1, '2022-05-16 16:25:57', '2022-05-16 10:55:57', 0, 1),
(12811, 14889791841417, 1, 'hi', 1, 1, '2022-06-27 17:57:07', '2022-06-27 12:27:07', 0, 1),
(13842, 14889791841417, 1, 'type your query', 1, 1, '2022-09-10 13:55:55', '2022-09-10 08:25:55', 0, 1),
(14334, 14889791841417, 1, 'hi', 1, 1, '2022-11-03 20:55:51', '2022-11-03 15:25:51', 0, 1),
(14335, 14889791841417, 1, 'ii', 1, 1, '2022-11-03 21:08:27', '2022-11-03 15:38:27', 0, 1),
(14336, 14889791841417, 1, 'ii', 1, 1, '2022-11-03 21:08:59', '2022-11-03 15:38:59', 0, 1),
(14337, 14889791841417, 1, 'ji', 1, 1, '2022-11-03 21:12:36', '2022-11-03 15:42:36', 0, 1),
(14444, 14889791841417, 1, '.', 1, 1, '2022-11-16 21:42:31', '2022-11-16 16:12:31', 0, 1),
(14836, 14889791841417, 1, 'hi', 1, 1, '2023-01-05 11:36:08', '2023-01-05 06:06:08', 0, 1),
(14837, 14889791841417, 1, 'ji', 1, 1, '2023-01-05 11:38:39', '2023-01-05 06:08:39', 0, 1),
(14838, 14889791841417, 1, 'ki', 1, 1, '2023-01-05 11:43:58', '2023-01-05 06:13:58', 0, 1),
(14839, 14889791841417, 1, 'ii', 1, 1, '2023-01-05 11:44:27', '2023-01-05 06:14:27', 0, 1),
(14840, 14889791841417, 1, 'ii', 1, 1, '2023-01-05 11:45:33', '2023-01-05 06:15:33', 0, 1),
(14841, 14889791841417, 1, 'ii', 1, 1, '2023-01-05 11:46:23', '2023-01-05 06:16:23', 0, 1),
(14842, 14889791841417, 1, 'ii', 1, 1, '2023-01-05 12:06:11', '2023-01-05 06:36:11', 0, 1),
(14843, 14889791841417, 1, 'ii', 1, 1, '2023-01-05 12:07:19', '2023-01-05 06:37:19', 0, 1),
(14844, 14889791841417, 1, 'ii', 1, 1, '2023-01-05 12:10:46', '2023-01-05 06:40:46', 0, 1),
(14845, 14889791841417, 1, 'hi', 1, 1, '2023-01-05 12:33:28', '2023-01-05 07:03:28', 0, 1),
(14846, 14889791841417, 1, 'ii', 1, 1, '2023-01-05 14:16:33', '2023-01-05 08:46:33', 0, 1),
(14863, 14889791841417, 1, 'hii', 1, 1, '2023-01-05 17:57:11', '2023-01-05 12:27:11', 0, 1),
(14941, 14889791841417, 1, 'hi', 1, 1, '2023-01-12 20:47:02', '2023-01-12 15:17:02', 0, 1),
(14948, 14889791841417, 1, 'hello', 1, 1, '2023-01-12 20:53:32', '2023-01-12 15:23:32', 0, 1),
(14988, 14889791841417, 1, 'hello', 1, 1, '2023-01-14 15:47:46', '2023-01-14 10:17:46', 0, 1),
(14989, 14889791841417, 1, 'hi', 1, 1, '2023-01-14 15:55:52', '2023-01-14 10:25:52', 0, 1),
(14990, 14889791841417, 1, 'ji', 1, 1, '2023-01-14 16:03:47', '2023-01-14 10:33:47', 0, 1),
(15206, 14889791841417, 1, 'hi', 1, 1, '2023-01-25 16:15:19', '2023-01-25 10:45:19', 0, 1),
(15293, 14889791841417, 1, 'hello', 1, 0, '2023-02-08 18:07:51', '2023-02-08 12:37:51', 0, 1),
(15295, 14889791841417, 1, 'hello', 1, 0, '2023-02-08 18:11:33', '2023-02-08 12:41:33', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `help-faq`
--

CREATE TABLE `help-faq` (
  `faqID` int(11) NOT NULL,
  `faq` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `app` int(11) NOT NULL,
  `web` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `help-faq`
--

INSERT INTO `help-faq` (`faqID`, `faq`, `answer`, `app`, `web`, `status`) VALUES
(1, 'Your Home Screen', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/homePage.jpg\">', 1, 0, 1),
(2, 'View Sections added in your Profile', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/addSections.jpg\">', 1, 0, 1),
(3, 'View your Created Profiles', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/createdProfile.jpg\">', 1, 0, 1),
(4, 'Side Menu', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/sideMenu.jpg\">', 1, 0, 1),
(5, 'Resume Preview Page', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/resumePreview.jpg\">', 1, 0, 1),
(6, 'Advance Settings in Preview Page', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/advanceOptions.jpg\">', 1, 0, 1),
(7, 'Choose Color for your resume', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/resumeColors.jpg\">', 1, 0, 1),
(8, 'Knowledge Center', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/kcHome.jpg\">', 1, 0, 1),
(9, 'Default Section Form', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/sectionDefault.jpg\">', 1, 0, 1),
(10, 'General Section Data Page', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/sectionDatabase.jpg\">', 1, 0, 1),
(11, 'General Section Form', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/sectionGeneral.jpg\">', 1, 0, 1),
(12, 'Your Subscription Page', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/subscription.jpg\">', 1, 0, 1),
(13, 'View All Resume Designs', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/resumeDesigns.jpg\">', 1, 0, 1),
(14, 'Your Public Profile', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/publicProfile.jpg\">', 1, 0, 1),
(15, 'Add a Section in your current Profile', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/addSections.jpg\">', 1, 0, 1),
(16, 'Create a New Profile\r\n', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/createProfile.jpg\">', 1, 0, 1),
(17, 'Set Profile Image in your CV', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/setProfileImage.jpg\">', 1, 0, 1),
(18, 'My Created Resumes - Download', '<img src=\"https://cvdragon.com/public/img/kc/support-faqs/myResumes.jpg\">', 1, 0, 1),
(19, 'What to write in Career Objective?', 'Career Objective - A Pitch to showcase yourself. To showcase what you have for the Recruiter in terms of skills', 1, 0, 0),
(20, 'What is Current Profile?', 'Current Profile is your current position, either it will be Course (Specialization) or the designation in the company you are working', 1, 0, 0),
(21, 'How to Create a Resume?', 'Follow 3 Steps: Fill in the sections > Select the Design > Make Changes as required\n<br>Once done, let us know will help you with the rest of the CV Creation process', 1, 0, 0),
(22, 'How to choose a Design?', 'Most of the Designs are optimised for every profile, Select and Preview', 1, 0, 0),
(23, 'How to add a Profile Image?', 'Go to Profile Image Section > Swipe right to upload image > Click select as Image for CV', 1, 0, 0),
(24, 'What is Position of Responsibility?', 'Any positions you hold which is important to mention in your resume\n<br>\nPosition of responsibility is those positions you hold in your college like President of a Coding Club / Marketing Club', 1, 0, 0),
(25, 'How to download a CV?', 'You need a subscription to download your CV', 1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `help-videos`
--

CREATE TABLE `help-videos` (
  `videoID` int(11) NOT NULL,
  `heading` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `link` varchar(200) NOT NULL,
  `dateCreated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `web` tinyint(4) NOT NULL,
  `app` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `help-videos`
--

INSERT INTO `help-videos` (`videoID`, `heading`, `link`, `dateCreated`, `web`, `app`, `status`) VALUES
(1, 'Create a Resume ', 'https://www.youtube.com/watch?v=ZVYiJOMx-Ek&t=33s', '2020-09-30 16:53:25', 0, 0, 0),
(2, 'Create Multiple Profiles at cvDragon ', 'https://www.youtube.com/watch?v=26XPzowqtwo&t=3s', '2020-09-30 16:53:25', 0, 0, 0),
(3, 'Create your Digital Profile at cvDragon ', 'https://www.youtube.com/watch?v=z84tLqAgYYE', '2020-09-30 16:53:25', 0, 0, 0),
(4, 'How to activate Subscription ', 'https://www.youtube.com/watch?v=X9FlOOiOmvw', '2020-09-30 16:53:25', 0, 0, 0),
(5, 'How to add Profile Title ', 'https://www.youtube.com/watch?v=Y2kKGAiIxVw', '2020-09-30 16:53:25', 0, 0, 0),
(6, 'How to add/remove Declaration ', 'https://www.youtube.com/watch?v=H_eEmpjllfg', '2020-09-30 16:53:25', 0, 0, 0),
(7, 'How to delete your created profiles ', 'https://www.youtube.com/watch?v=89A766HUCG0', '2020-09-30 16:53:25', 0, 0, 0),
(8, 'How to register at cvDragon ', 'https://www.youtube.com/watch?v=zABubQFUnZY', '2020-09-30 16:53:25', 0, 0, 0),
(9, 'How to select your profile ', 'https://www.youtube.com/watch?v=oonpcLiJ4k4', '2020-09-30 16:53:25', 0, 0, 0),
(10, 'How to view your Institute Design ', 'https://www.youtube.com/watch?v=bdyn0pjB7oU', '2020-09-30 16:53:25', 0, 0, 0),
(11, 'How to change colours of a resume design template', 'https://youtu.be/1FhUOCvDohA', '2020-09-30 16:52:50', 0, 1, 1),
(12, 'What are key phrases and how to use them', 'https://youtu.be/EZYikwUH6EQ', '2020-09-30 16:52:50', 0, 1, 1),
(13, 'How to download / Share your resume', 'https://youtu.be/GAVwFCRjz7w', '2020-09-30 16:52:50', 0, 1, 1),
(14, 'How to hide your digital profile', 'https://youtu.be/GxVJ84luYtM', '2020-09-30 16:52:50', 0, 1, 1),
(15, 'How to add more sections to your resume', 'https://youtu.be/iijgwZsk15Y', '2020-09-30 16:52:50', 0, 1, 1),
(16, 'How to hide your phone number / email address in your digital resume', 'https://youtu.be/-IYYhWOPz88', '2020-09-30 16:52:50', 0, 1, 1),
(17, 'How to delete sections in a resume', 'https://youtu.be/PrI1fUN4sPo', '2020-09-30 16:52:50', 0, 1, 1),
(18, 'How to delete a section in your resume', 'https://youtu.be/PrI1fUN4sPo', '2020-09-30 16:52:50', 0, 1, 1),
(19, 'How to increase font size of your resume', 'https://youtu.be/sb85mBtlqsM', '2020-09-30 16:52:50', 0, 1, 1),
(20, 'How to hide your institution logo', 'https://youtu.be/TtrAhTt-PfI', '2020-09-30 16:52:50', 0, 1, 1),
(21, 'How to access all your resumes', 'https://youtu.be/TTucd_2SQ3w', '2020-09-30 16:52:50', 0, 1, 1),
(22, 'How to add declaration in your resume', 'https://youtu.be/X2JZ_wko8y8', '2020-09-30 16:52:50', 0, 1, 1),
(23, 'How to resync your data', 'https://youtu.be/YSyGVbhNF-0', '2020-09-30 16:52:50', 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `interests`
--

CREATE TABLE `interests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `specialization_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1 = Active, 0 = Inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `interests`
--

INSERT INTO `interests` (`id`, `specialization_id`, `title`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Flutter', 1, '2025-05-16 09:59:36', '2025-05-16 09:59:36'),
(2, 2, 'React Native', 1, '2025-05-16 09:59:36', '2025-05-16 09:59:36'),
(3, 3, 'Swift (iOS)', 1, '2025-05-16 10:00:07', '2025-05-16 10:00:07'),
(4, 4, 'Android SDK', 1, '2025-05-16 10:00:07', '2025-05-16 10:00:07');

-- --------------------------------------------------------

--
-- Table structure for table `master_cv_sections`
--

CREATE TABLE `master_cv_sections` (
  `id` int(11) UNSIGNED NOT NULL,
  `heading` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `ordering` tinyint(4) DEFAULT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Status: 1 = active, 0 = inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_cv_sections`
--

INSERT INTO `master_cv_sections` (`id`, `heading`, `description`, `icon`, `color`, `ordering`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Personal Information', NULL, NULL, 'blue', 1, 1, '2025-05-17 05:24:24', '2025-05-17 05:24:24'),
(2, 'Experiences', NULL, NULL, 'blue', 2, 1, '2025-05-17 05:24:24', '2025-05-17 05:24:24'),
(3, 'Education Background', NULL, NULL, 'blur', 3, 1, '2025-05-19 04:50:33', '2025-05-19 04:50:33'),
(4, 'Skills & Achievements', NULL, NULL, 'blue', 4, 1, '2025-05-19 04:50:33', '2025-05-19 04:50:33'),
(5, 'Other Sections', NULL, NULL, 'blue', 5, 1, '2025-05-19 04:50:33', '2025-05-19 04:50:33');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2025_05_07_075701_create_user_otps_table', 1),
(6, '2025_05_14_104107_create_resource_links_table', 1),
(9, '2025_05_14_104302_create_resource_profilesettings_table', 1),
(10, '2025_05_14_104333_create_resource_public_designs_table', 1),
(11, '2025_05_14_105942_create_resource_redirects_table', 2),
(12, '2025_05_14_110204_create_resource_sections_table', 3),
(13, '2025_05_14_110449_create_resource_security_keys_table', 4),
(15, '2025_05_14_111234_create_user_documents_table', 5),
(16, '2025_05_14_111641_create_user_feedback_table', 6),
(17, '2025_05_14_111906_create_user_subscriptions_table', 7),
(18, '2025_05_14_112201_create_user_voucher_details_table', 8),
(19, '2025_05_14_112411_create_notifications_table', 9),
(20, '2025_05_09_104947_create_create_cvprofiles_table', 10),
(21, '2025_05_09_102158_create_user_categories_table', 11),
(22, '2025_05_10_092129_create_cv_contact_table', 11),
(23, '2025_05_10_093123_create_cv_preferences_table', 11),
(24, '2025_05_10_093304_create_cv_basic_info_table', 11),
(26, '2025_05_10_094603_create_cv_education_table', 11),
(27, '2025_05_10_094959_create_cvprofiles_table', 11),
(28, '2025_05_10_095328_create_cvprofilesection_table', 11),
(29, '2025_05_10_095527_create_cvsections_table', 11),
(30, '2025_05_12_051947_create_appdownloads_table', 11),
(31, '2025_05_12_052302_create_create_clprofile_table', 11),
(32, '2025_05_12_052431_create_create_clprofiles_table', 11),
(34, '2025_05_13_051013_create_cvdragon_app_config_new_table', 11),
(36, '2025_05_13_083725_create_create-cvprofilesection_new_table', 12),
(37, '2025_05_13_084356_create_resource-section_new_table', 12),
(39, '2025_05_13_093108_create_section_dependent_questions_table', 12),
(40, '2025_05_13_112218_create_cv_skills_table', 12),
(41, '2025_05_12_053005_create_create_cvprofilesection_table', 13),
(42, '2025_05_14_114049_create_cv_academic_projects_table', 14),
(45, '2025_05_14_115045_create_cv_certifications_table', 17),
(47, '2025_05_14_115713_create_cv_images_table', 19),
(48, '2025_05_14_115931_create_cv_interests_table', 20),
(50, '2025_05_14_120947_create_cv_languages_table', 22),
(51, '2025_05_14_121403_create_cv_patents_table', 23),
(52, '2025_05_14_121604_create_cv_poas_table', 24),
(54, '2025_05_14_121919_create_cv_projects_table', 26),
(56, '2025_05_14_122205_create_cv_technicals_table', 28),
(57, '2025_05_14_122437_create_cv_trainings_table', 29),
(59, '2025_05_14_122948_create_cv_works_table', 31),
(60, '2025_05_14_123415_create_help_chats_table', 32),
(61, '2025_05_14_123542_create_help_faqs_table', 33),
(62, '2025_05_14_123649_create_help_videos_table', 34),
(63, '2025_05_14_123854_create_cv_publications_table', 35),
(64, '2025_05_10_091404_create_user-basic_table', 36),
(65, '2025_05_10_094959_create_create-cvprofilesection_table', 37),
(66, '2025_05_16_074239_create_resource_carrers_table', 38),
(67, '2025_05_16_081144_create_courses_table', 39),
(69, '2025_05_16_082023_create_specializations_table', 40),
(73, '2025_05_13_112218_create_cv-skills_table', 41),
(75, '2025_05_16_095152_create_skills_table', 42),
(76, '2025_05_16_095200_create_technical_skills_table', 42),
(77, '2025_05_16_095213_create_interests_table', 42),
(78, '2025_05_16_095222_create_languages_table', 42),
(81, '2025_05_14_115713_create_cv-images_table', 45),
(83, '2025_05_14_120947_create_cv-languages_table', 46),
(84, '2025_05_14_115931_create_cv-interests_table', 47),
(85, '2025_05_14_122205_create_cv-technical_table', 48),
(86, '2025_05_13_081848_create_master_cv_sections_table', 49),
(87, '2025_05_13_084356_create_resource-section_table', 50),
(94, '2025_05_17_065307_create_resource_profile_design_categories_table', 52),
(95, '2025_05_14_104140_create_resource-profiledesign_table', 53),
(96, '2025_05_14_104239_create_resource_profilefonts_table', 54),
(97, '2025_05_17_072328_create_resource_profile_colors_table', 55),
(98, '2025_05_10_093827_create_cv_introduction_table', 56),
(100, '2025_05_14_114049_create_cv-academic-projects_table', 58),
(101, '2025_05_14_121604_create_cv-poa_table', 59),
(102, '2025_05_14_115442_create_cv_co_curricular_activities_table', 60),
(103, '2025_05_14_121759_create_cv_presentations_table', 61),
(104, '2025_05_14_120730_create_cv_internships_table', 62),
(106, '2025_05_14_123854_create_cv-publications_table', 64),
(107, '2025_05_13_091256_create_section_questions_table', 65),
(108, '2025_05_14_114429_create_cv_achievements_table', 66),
(109, '2025_05_14_114702_create_cv_associations_table', 67),
(110, '2025_05_14_122720_create_cv_volunteers_table', 68),
(111, '2025_05_14_121919_create_cv-project_table', 69),
(112, '2025_05_14_122437_create_cv-trainings_table', 70),
(114, '2025_05_10_093304_create_cv-basic-info_table', 71),
(115, '2025_05_14_122052_create_cv_social_links_table', 72),
(116, '2025_05_09_104947_create_create-cvprofile_table', 73),
(118, '2014_10_12_000000_create_users_table', 74);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `heading` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `displayImage` varchar(150) NOT NULL,
  `insideImage` varchar(100) NOT NULL,
  `showNote` varchar(250) NOT NULL,
  `thankNote` varchar(150) NOT NULL,
  `type` varchar(20) NOT NULL,
  `link` varchar(100) NOT NULL,
  `linkHeading` varchar(100) NOT NULL,
  `formDisplay` tinyint(4) NOT NULL,
  `notificationCategory` varchar(50) NOT NULL,
  `version` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `offerregistration`
--

CREATE TABLE `offerregistration` (
  `offerID` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `offerCategory` int(11) NOT NULL,
  `offerDetails` varchar(20) NOT NULL,
  `offerName` varchar(100) NOT NULL,
  `offerEmail` varchar(100) NOT NULL,
  `offerLocation` varchar(100) NOT NULL,
  `offerPhone` varchar(100) NOT NULL,
  `offerData1` varchar(100) NOT NULL,
  `offerData2` varchar(100) NOT NULL,
  `offerDocument` varchar(100) NOT NULL,
  `offerDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `offerReferral` varchar(50) NOT NULL,
  `activation` tinyint(4) NOT NULL,
  `submission` tinyint(4) NOT NULL,
  `approved` tinyint(4) NOT NULL,
  `subscriptionDays` int(11) NOT NULL,
  `emailSent` int(11) NOT NULL,
  `promotion` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resource-links`
--

CREATE TABLE `resource-links` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `linkOrder` int(11) NOT NULL,
  `linkHeading` varchar(200) NOT NULL,
  `linkDetails` varchar(200) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resource-profiledesign`
--

CREATE TABLE `resource-profiledesign` (
  `designid` int(11) NOT NULL,
  `resource_profile_design_categorie_id` int(11) DEFAULT NULL,
  `designName` varchar(100) NOT NULL,
  `lastUpdated` date NOT NULL,
  `content` text NOT NULL,
  `designPrice` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `format` tinyint(4) NOT NULL DEFAULT 1,
  `isPrivate` tinyint(4) NOT NULL,
  `sections` varchar(255) NOT NULL,
  `version` varchar(10) NOT NULL DEFAULT '[6,7]',
  `sectionOrder` varchar(255) NOT NULL,
  `sectionDefault` varchar(255) NOT NULL,
  `sectionColumn` tinyint(11) NOT NULL,
  `isDownload` tinyint(11) NOT NULL,
  `author` varchar(100) NOT NULL,
  `rating` float NOT NULL,
  `downloadTimes` int(11) NOT NULL,
  `web` tinyint(4) NOT NULL,
  `app` tinyint(4) NOT NULL,
  `heading` varchar(10) NOT NULL,
  `color1` varchar(10) NOT NULL,
  `color2` varchar(10) NOT NULL,
  `color3` varchar(10) NOT NULL,
  `color4` varchar(10) NOT NULL,
  `basevalue` float NOT NULL,
  `headText` float NOT NULL,
  `timeLine` float NOT NULL,
  `timeLineSmall` float NOT NULL,
  `timeSubLine` float NOT NULL,
  `headLine` float NOT NULL,
  `subLine` float NOT NULL,
  `baseLine` float NOT NULL,
  `introLine` float NOT NULL,
  `nameLine` float NOT NULL,
  `nameHeight` float NOT NULL,
  `introHeight` float NOT NULL,
  `headLineHeight` float NOT NULL,
  `headerLineHeight` float NOT NULL,
  `GenLine` float NOT NULL,
  `logo` varchar(30) NOT NULL,
  `template` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource-profiledesign`
--

INSERT INTO `resource-profiledesign` (`designid`, `resource_profile_design_categorie_id`, `designName`, `lastUpdated`, `content`, `designPrice`, `category`, `format`, `isPrivate`, `sections`, `version`, `sectionOrder`, `sectionDefault`, `sectionColumn`, `isDownload`, `author`, `rating`, `downloadTimes`, `web`, `app`, `heading`, `color1`, `color2`, `color3`, `color4`, `basevalue`, `headText`, `timeLine`, `timeLineSmall`, `timeSubLine`, `headLine`, `subLine`, `baseLine`, `introLine`, `nameLine`, `nameHeight`, `introHeight`, `headLineHeight`, `headerLineHeight`, `GenLine`, `logo`, `template`, `status`) VALUES
(0, 1, 'Opportunist', '2024-12-12', 'Content', 0, '0', 1, 0, '0', '[6,7]', '[[\"51100\",\"51101\",\"51111\",\"51118\",\"51119\",\"51120\"],[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51114\",\"51110\",\"51122\",\"51113\",\"51116\",\"51117\",\"51123\",\"51125\",\"51121\"]]', '[]', 0, 1, 'Limtechs', 4.7, 2410, 1, 1, '', '', '', '', '', 1.7, 0.8, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.55, 1.25, 0.8, 0.8, 0.65, 0.65, 0.85, '1.jpg', '1', 1),
(1, 1, 'Opportunist', '2024-12-12', 'Content', 299, '1', 1, 0, '0', '[6,7]', '[[\"51100\",\"51101\",\"51111\",\"51118\",\"51119\",\"51120\"],[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51107\",\"51114\",\"51110\",\"51122\",\"51113\",\"51116\",\"51117\",\"51123\",\"51125\",\"51112\",\"51121\"]]', '[]', 0, 1, 'Limtechs', 4.7, 45408, 1, 1, '', '', '', '', '', 1.7, 0.8, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.6, 1.3, 0.8, 0.85, 0.65, 0.65, 1, '1.jpg', '1', 1),
(2, 1, 'Time Line', '2021-06-05', 'Content', 299, '1', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51114\",\"51112\",\"51113\",\"51116\",\"51117\",\"51122\",\"51125\",\"51119\",\"51120\",\"51123\",\"51100\",\"51121\"]]', '', 0, 0, 'Limtechs', 4.5, 9381, 1, 0, '', '', '', '', '', 1.8, 0.9, 0.8, 0.575, 0.375, 0.7, 0.6, 0.6, 0.7, 1.4, 0, 0.95, 0.8, 0.65, 0.9, '2.jpg', '2', 1),
(3, 1, 'Basic', '2021-06-05', 'Content', 0, '0', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51114\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51122\",\"51125\",\"51112\",\"51113\",\"51116\",\"51117\",\"51123\"]]', '', 0, 0, 'Limtechs', 4.7, 144505, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.5, 0.375, 0.675, 0.6, 0.525, 0.7, 1.25, 0, 0.8, 0.75, 0.65, 0.75, '3.jpg', '3', 1),
(4, 1, 'Simply Waves', '2021-06-05', 'Content', 299, '2', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51114\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51122\",\"51125\",\"51112\",\"51113\",\"51116\",\"51117\",\"51123\"]]', '[]', 0, 1, 'Limtechs', 4.7, 20703, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.56, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.8, '4.jpg', '4', 1),
(5, 2, 'Simply Creative', '2021-06-05', 'Content', 299, '2', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51114\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51122\",\"51125\",\"51112\",\"51113\",\"51116\",\"51117\",\"51123\"]]', '', 0, 1, 'Limtechs', 4.7, 23565, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.56, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.8, '5.jpg', '5', 1),
(6, 2, 'Global', '2021-06-05', 'Content', 0, '0', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51114\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51122\",\"51125\",\"51112\",\"51113\",\"51116\",\"51117\",\"51123\"]]', '', 0, 1, 'Limtechs', 4.7, 55201, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.56, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.8, '6.jpg', '6', 1),
(7, 2, 'Industrial', '2021-06-05', 'Content', 299, '3', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51114\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51122\",\"51125\",\"51112\",\"51113\",\"51116\",\"51117\",\"51123\"]]', '', 0, 1, 'Limtechs', 4.25, 34421, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.56, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.8, '7.jpg', '7', 1),
(8, 2, 'Casual', '2021-06-05', 'Content', 299, '3', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51114\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51122\",\"51125\",\"51112\",\"51113\",\"51116\",\"51117\",\"51123\"]]', '', 0, 1, 'Limtechs', 4.66, 38174, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.56, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.8, '8.jpg', '8', 1),
(9, 2, 'Waves', '2021-06-05', 'Content', 299, '2', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51114\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51122\",\"51125\",\"51112\",\"51113\",\"51116\",\"51117\",\"51123\"]]', '', 0, 1, 'Limtechs', 4.8, 43413, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.56, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.8, '9.jpg', '9', 1),
(10, NULL, 'Creative', '2021-06-05', 'Content', 299, '2', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51114\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51122\",\"51125\",\"51112\",\"51113\",\"51116\",\"51117\",\"51123\"]]', '', 0, 1, 'Limtechs', 4.12, 5185, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.56, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.8, '10.jpg', '10', 1),
(11, NULL, 'Positive', '2024-12-12', 'Content', 299, '1', 1, 0, '2', '[6,7]', '[[\"51100\",\"51120\",\"51101\",\"51108\",\"51110\",\"51111\",\"51118\",\"51119\"],[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51109\",\"51107\",\"51106\",\"51114\",\"51112\",\"51113\",\"51117\",\"51116\",\"51122\",\"51125\",\"51123\",\"51121\"]]', '[]', 2, 1, 'Limtechs', 4.8, 64165, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.35, 0.375, 0.675, 0.6, 0.525, 0.6, 0.9, 0.55, 0.9, 0.65, 0.65, 0.8, '11.jpg', '11', 1),
(12, NULL, 'Single Page', '2021-09-27', 'Content', 0, '0', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51104\",\"51105\",\"51109\",\"51106\",\"51107\",\"51110\",\"51112\",\"51113\",\"51116\",\"51117\",\"51122\",\"51125\",\"51114\",\"51119\",\"51118\",\"51111\",\"51120\",\"51123\",\"51121\"]]', '', 0, 1, 'Limtechs', 4.9, 129058, 1, 1, '', '', '', '', '', 1.8, 0.55, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.6, 0.65, 0.8, '12.jpg', '12', 1),
(13, NULL, 'To the Point', '2021-06-05', '', 299, '2', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51104\",\"51105\",\"51107\",\"51108\",\"51109\",\"51106\",\"51112\",\"51113\",\"51116\",\"51117\",\"51122\",\"51110\",\"51114\",\"51125\",\"51123\"]]', '[]', 0, 1, '', 0, 13940, 1, 1, '', '', '', '', '', 1.8, 0.55, 0.6, 0.5, 0.375, 0.7, 0.6, 0.5, 0.525, 1.1, 0.85, 0.8, 0.8, 0.65, 0.7, '13.jpg', '13', 1),
(14, NULL, 'Optimistic', '2024-12-12', 'Content', 299, '1', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\",\"51101\",\"51121\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51107\",\"51108\",\"51109\",\"51106\",\"51122\",\"51110\",\"51112\",\"51114\",\"51116\",\"51117\",\"51125\",\"51113\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 4.8, 20986, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.6, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.8, '14.jpg', '14', 1),
(15, NULL, 'Futuristic', '2024-12-12', 'COntent', 299, '1', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\",\"51101\",\"51121\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51122\",\"51107\",\"51108\",\"51109\",\"51110\",\"51114\",\"51112\",\"51113\",\"51125\",\"51116\",\"51117\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.8, 128292, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.6, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.8, '15.jpg', '15', 1),
(16, NULL, 'Modern', '2024-12-12', 'Content', 299, '1', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\",\"51121\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51107\",\"51108\",\"51109\",\"51106\",\"51110\",\"51122\",\"51122\",\"51113\",\"51125\",\"51114\",\"51116\",\"51117\",\"51123\"]]', '', 0, 1, 'LifeinMBA', 4.88, 57919, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.6, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.8, '16.jpg', '16', 1),
(17, NULL, 'Cool', '2024-12-12', 'Content', 299, '1', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51110\",\"51107\",\"51112\",\"51113\",\"51114\",\"51116\",\"51117\",\"51122\",\"51125\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.9, 44261, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.6, 0.5, 0.54, 1.2, 1, 0.9, 0.9, 0.55, 0.8, '17.jpg', '17', 1),
(18, NULL, 'Fresh New Design', '2024-12-12', '', 299, '1', 1, 0, '0', '[6,7]', '[[\"51111\",\"51123\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51114\",\"51112\",\"51113\",\"51116\",\"51117\",\"51122\",\"51125\"]]', '', 0, 1, 'cvDragon', 4.8, 7494, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.6, 0.5, 0.525, 1.2, 1, 0.875, 0.9, 0.55, 0.8, '18.jpg', '18', 1),
(19, NULL, 'Straight to the point', '2021-06-05', 'content', 0, '0', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51111\",\"51114\",\"51112\",\"51113\",\"51117\",\"51116\",\"51122\",\"51125\",\"51123\"]]', '[]', 0, 1, 'LifeinMBA', 4.6, 19426, 1, 1, '', '', '', '', '', 1.8, 0.5, 0.6, 0.4, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '19.jpg', '19', 1),
(20, NULL, 'Color It', '2024-12-12', 'content', 299, '3', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51114\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51122\",\"51125\",\"51112\",\"51113\",\"51116\",\"51117\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.9, 5744, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.56, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.8, '20.jpg', '20', 1),
(22, NULL, 'Traditional', '2021-06-05', 'Content', 0, '0', 1, 0, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 4.9, 22166, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.75, 0.575, 0.375, 0.75, 0.6, 0.55, 0.6, 1.2, 0, 0.9, 0.65, 0.6, 0.8, '22.jpg', '22', 1),
(23, NULL, 'Europe Approved Design', '2021-06-05', 'Content', 299, '5', 1, 0, '0', '[6,7]', '[[\"51100\",\"51101\",\"51111\",\"51118\",\"51119\",\"51120\",\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51107\",\"51114\",\"51110\",\"51122\",\"51113\",\"51116\",\"51117\",\"51123\",\"51125\",\"51112\",\"51121\"]]', '', 0, 1, 'cvDragon', 0, 3050, 1, 1, '', '', '', '', '', 1.8, 0.7, 0.6, 0.5, 0.375, 0.55, 0.55, 0.5, 0.525, 1, 0.85, 0.8, 0.6, 0.6, 0.9, '23.jpg', '23', 1),
(25, NULL, 'Smart Style', '2021-06-05', '', 299, '2', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51114\",\"51112\",\"51113\",\"51117\",\"51116\",\"51122\",\"51125\",\"51123\",\"51111\",\"51118\",\"51119\",\"51120\",\"51121\"]]', '[]', 0, 1, 'cvDragon', 0, 1178, 1, 1, '', '', '', '', '', 1.8, 0.9, 0.45, 0.5, 0.375, 0.6, 0.6, 0.5, 0.6, 1.8, 0, 0.8, 0.8, 0.65, 0.9, '25.jpg', '25', 1),
(30, NULL, 'Simple Two', '2024-12-12', 'Content', 299, '2', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51110\",\"51119\",\"51120\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51122\",\"51113\",\"51122\",\"51125\",\"51114\",\"51116\",\"51117\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.8, 5056, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.65, 0.55, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.9, '30.jpg', '30', 1),
(31, NULL, 'Straight Design', '2024-12-12', 'content', 299, '2', 1, 0, '0', '[6,7]', '[[\"51099\",\"51100\",\"51101\",\"51102\",\"51103\",\"51106\"],[\"51108\",\"51109\",\"51111\",\"51114\",\"51118\",\"51119\",\"51120\",\"51121\",\"51122\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 4.7, 3093, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.6, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.9, '31.jpg', '31', 1),
(34, NULL, 'Brave Look', '2024-12-12', '', 299, '2', 1, 0, '0', '[6,7]', '[[\"51109\",\"51118\",\"51111\",\"51110\",\"51120\",\"51119\"],[\"51099\",\"51108\",\"51104\",\"51122\",\"51106\",\"51107\",\"51117\",\"51112\",\"51113\",\"51114\",\"51125\",\"51115\",\"51116\",\"51123\",\"51121\"]]', '', 0, 1, '', 4.2, 45745, 1, 1, '', '', '', '', '', 1.8, 0.9, 0.8, 0.5, 0.375, 0.6, 0.6, 0.5, 0.6, 1.8, 0, 0.8, 0.8, 0.65, 0.9, '34.jpg', '34', 1),
(35, NULL, 'Fresh 2 Column', '2024-12-12', 'Content', 299, '1', 1, 0, '0', '[6,7]', '[[\"51118\",\"51111\",\"51120\",\"51119\",\"51100\"],[\"51099\",\"51104\",\"51105\",\"51109\",\"51108\",\"51122\",\"51106\",\"51107\",\"51117\",\"51114\",\"51115\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\",\"51121\"]]', '[]', 0, 1, 'cvDragon', 4.8, 13537, 1, 1, '', '', '', '', '', 1.8, 0.9, 0.8, 0.5, 0.375, 0.6, 0.6, 0.5, 0.6, 1.4, 0, 0.8, 0.8, 0.65, 0.9, '35.jpg', '35', 1),
(36, NULL, 'Bold Looks', '2024-12-12', 'Content', 299, '2', 1, 0, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 4.8, 45899, 1, 1, '', '', '', '', '', 1.8, 0.9, 0.8, 0.5, 0.375, 0.6, 0.6, 0.5, 0.6, 1.2, 0, 0.8, 0.8, 0.65, 0.9, '36.jpg', '36', 1),
(45, NULL, 'Technical Design', '2021-06-05', 'CONTENT', 299, '2', 1, 0, '0', '[6,7]', '[[\"51109\",\"51104\",\"51099\",\"51106\",\"51122\",\"51114\",\"51111\",\"51110\",\"51125\",\"51113\",\"51112\",\"51117\",\"51116\",\"51123\"]]', '[]', 0, 1, 'cvD', 4.7, 45744, 1, 1, '#022A5E', '#000C29', '#A4E2E8', '#D6EAF8', '', 1.8, 0.5, 0.6, 0.4, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '45.jpg', '45', 1),
(46, NULL, 'Cool Design', '2021-06-05', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51108\",\"51109\",\"51104\",\"51106\",\"51110\",\"51107\",\"51125\",\"51116\",\"51117\"],[\"51111\",\"51118\",\"51115\",\"51099\",\"51122\",\"51105\",\"51112\",\"51113\",\"51114\",\"51120\",\"51119\",\"51123\",\"51121\"]]', '', 0, 0, 'cvD', 4.7, 48098, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.6, 0.9, 0.55, 0.75, 0.8, 0.6, 0.75, '46.jpg', '46', 1),
(47, NULL, 'Bold Looks', '2021-06-05', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '', '', 0, 0, 'cvD', 4.7, 7768, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.6, 0.9, 0.55, 0.75, 0.8, 0.6, 0.75, '47.jpg', '47', 1),
(48, NULL, 'Cool Bold', '2021-08-01', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51107\",\"51106\",\"51108\",\"51109\",\"51110\",\"51114\",\"51112\",\"51113\",\"51116\",\"51117\",\"51122\",\"51125\",\"51123\"]]', '', 0, 1, 'cvD', 4.7, 9902, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.6, 0.9, 0.55, 0.75, 0.8, 0.6, 0.75, '48.jpg', '48', 1),
(49, NULL, 'Content', '2021-06-05', 'CONTENT', 299, '2', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51114\",\"51112\",\"51113\",\"51117\",\"51116\",\"51122\",\"51125\",\"51123\",\"51111\",\"51118\",\"51119\",\"51120\"]]', '', 0, 1, 'cvD', 4.7, 5527, 1, 1, '', '', '', '', '', 1.9, 0.85, 0.45, 0.4, 0.375, 0.65, 0.6, 0.55, 0.6, 0.9, 0.55, 0.75, 0.8, 0.6, 0.75, '49.jpg', '49', 1),
(50, NULL, 'Interactive Design', '2024-12-12', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51104\",\"51108\",\"51109\",\"51107\",\"51112\",\"51125\",\"51114\",\"51110\"],[\"51111\",\"51118\",\"51120\",\"51119\",\"51115\",\"51099\",\"51105\",\"51106\",\"51113\",\"51122\",\"51116\",\"51117\",\"51123\",\"51121\",\"51100\"]]', '[]', 0, 1, 'cvD', 4.7, 7320, 1, 1, '', '', '', '', '', 1.9, 0.85, 0.45, 0.5, 0.375, 0.65, 0.6, 0.6, 0.6, 0.9, 0.55, 0.75, 0.8, 0.6, 0.75, '50.jpg', '50', 1),
(51, NULL, 'New Design Added', '2024-12-12', 'Pure Black Colors', 299, '2', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51110\",\"51119\",\"51120\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51107\",\"51114\",\"51112\",\"51113\",\"51122\",\"51125\",\"51116\",\"51117\",\"51123\"]]', '', 0, 1, 'Admin Panel', 1, 45466, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.55, 0.9, 0.55, 0.8, 0.65, 0.6, 0.85, '51.jpg', '51', 1),
(52, NULL, 'New Design 1', '2021-06-05', 'CONTENT', 299, '2', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51104\",\"51105\",\"51107\",\"51106\",\"51108\",\"51109\",\"51110\",\"51114\",\"51112\",\"51113\",\"51116\",\"51117\",\"51122\",\"51125\",\"51123\",\"51100\"]]', '', 0, 1, 'cvD', 4.7, 5057, 1, 1, '', '', '', '', '', 1.9, 0.85, 0.45, 0.5, 0.375, 0.65, 0.6, 0.55, 0.6, 0.9, 0.55, 0.75, 0.8, 0.6, 0.75, '52.jpg', '52', 1),
(53, NULL, 'New Design 2', '2024-12-12', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51107\",\"51106\",\"51108\",\"51109\",\"51110\",\"51114\",\"51112\",\"51113\",\"51116\",\"51117\",\"51122\",\"51125\",\"51123\",\"51121\"]]', '', 0, 1, 'cvD', 4.7, 8610, 1, 1, '', '', '', '', '', 1.9, 0.85, 0.45, 0.4, 0.375, 0.65, 0.6, 0.55, 0.6, 0.9, 0.55, 0.55, 0.8, 0.6, 0.75, '53.jpg', '53', 1),
(54, NULL, 'New Design 3', '2021-06-05', 'CONTENT', 299, '2', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51104\",\"51105\",\"51107\",\"51106\",\"51108\",\"51109\",\"51112\",\"51113\",\"51110\",\"51114\",\"51116\",\"51117\",\"51122\",\"51125\",\"51123\"]]', '', 0, 1, 'cvD', 4.7, 5483, 1, 1, '', '', '', '', '', 1.9, 0.65, 0.65, 0.55, 0.45, 0.65, 0.6, 0.55, 0.65, 0.9, 0.55, 0.8, 0.8, 0.6, 0.75, '54.jpg', '54', 1),
(55, NULL, 'New Design 4', '2022-01-12', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51107\",\"51106\",\"51108\",\"51109\",\"51110\",\"51114\",\"51112\",\"51113\",\"51116\",\"51117\",\"51122\",\"51125\",\"51123\"]]', '', 0, 1, 'cvD', 4.7, 9292, 1, 1, '', '', '', '', '', 1.9, 0.85, 0.45, 0.4, 0.375, 0.65, 0.6, 0.55, 0.6, 0.9, 0.55, 0.55, 0.8, 0.6, 0.75, '55.jpg', '55', 1),
(56, NULL, 'Bold Looks 2', '2021-06-05', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51104\",\"51106\",\"51108\",\"51109\",\"51107\",\"51125\",\"51116\",\"51117\"],[\"51111\",\"51118\",\"51115\",\"51099\",\"51110\",\"51105\",\"51112\",\"51113\",\"51114\",\"51122\",\"51120\",\"51119\",\"51123\"]]', '', 0, 0, 'cvD', 4.7, 6110, 1, 1, '', '', '', '', '', 1.7, 0.85, 0.55, 0.4, 0.375, 0.65, 0.6, 0.6, 0.6, 0.9, 0.55, 0.75, 0.8, 0.6, 0.8, '56.jpg', '56', 1),
(57, NULL, 'New Design 5', '2024-12-12', 'CONTENT', 299, '2', 1, 0, '0', '[6,7]', '[[\"51110\",\"51111\",\"51118\",\"51119\",\"51120\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51107\",\"51106\",\"51108\",\"51109\",\"51114\",\"51112\",\"51113\",\"51117\",\"51116\",\"51122\",\"51125\",\"51123\"]]', '', 0, 1, 'cvD', 4.7, 6223, 1, 1, '', '', '', '', '', 1.9, 0.85, 0.5, 0.45, 0.4, 0.65, 0.6, 0.55, 0.6, 0.9, 0.55, 0.75, 0.8, 0.6, 0.75, '57.jpg', '57', 1),
(58, NULL, 'New Design 6', '2021-06-05', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51104\",\"51105\",\"51107\",\"51106\",\"51108\",\"51109\",\"51112\",\"51113\",\"51110\",\"51114\",\"51116\",\"51117\",\"51122\",\"51125\",\"51123\"]]', '', 0, 1, 'cvD', 4.7, 6926, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.6, 0.5, 0.65, 0.66, 0.6, 0.7, 1.5, 1.5, 0.85, 0.8, 0.55, 0.8, '58.jpg', '58', 1),
(59, NULL, 'New Design 7', '2024-12-12', 'CONTENT', 299, '2', 1, 0, '0', '[6,7]', '', '', 0, 1, 'cvD', 4.7, 4422, 1, 0, '', '', '', '', '', 1.8, 0.85, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.55, 1, 0.85, 0.8, 0.8, 0.75, 0.85, '59.jpg', '59', 1),
(60, NULL, '3 Columns', '2021-06-05', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '', '', 0, 1, 'cvD', 4.7, 5349, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.4, 0.5, 0.65, 0.55, 0.45, 0.55, 1, 0.75, 0.65, 0.65, 0.65, 0.7, '60.jpg', '60', 1),
(61, NULL, 'Simple and Effective', '2024-12-12', 'CONTENT', 299, '2', 1, 0, '0', '[6,7]', '[[\"51115\",\"51114\",\"51099\",\"51104\",\"51106\",\"51107\",\"51109\",\"51108\",\"51110\",\"51112\",\"51113\",\"51116\",\"51117\",\"51125\",\"51123\",\"51122\"],[\"51111\",\"51118\",\"51119\",\"51120\",\"51121\"]]', '', 0, 1, 'cvD', 4.7, 46815, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.5, 0.4, 0.375, 0.65, 0.6, 0.5, 0.6, 0.9, 0.55, 0.8, 0.65, 0.6, 0.75, '61.jpg', '61', 1),
(62, NULL, 'Brochure', '2021-06-07', 'CONTENT', 299, '5', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\"],[\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51122\",\"51106\",\"51107\",\"51117\",\"51114\",\"51115\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\"]]', '', 0, 1, 'cvD', 4.7, 5250, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.375, 0.65, 0.6, 0.5, 0.55, 1.5, 1.2, 0.8, 0.65, 0.6, 0.9, '62.jpg', '62', 1),
(63, NULL, 'Modernize', '2021-02-01', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51104\",\"51106\",\"51108\",\"51109\",\"51107\",\"51125\",\"51116\",\"5111\"],[\"51111\",\"51118\",\"51115\",\"51099\",\"51110\",\"51105\",\"51112\",\"51113\",\"51114\",\"51122\",\"51120\",\"51119\",\"51123\",\"51121\"]]', '[]', 0, 1, 'cvD', 4.7, 6555, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.4, 0.375, 0.65, 0.6, 0.5, 0.6, 0.9, 0.55, 0.75, 0.8, 0.6, 0.8, '63.jpg', '63', 1),
(64, NULL, 'new Design 64', '2021-01-26', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\"],[\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51122\",\"51106\",\"51107\",\"51117\",\"51114\",\"51115\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\"]]', '', 0, 1, 'cvD', 4.7, 449166, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.375, 0.65, 0.6, 0.5, 0.55, 1.2, 0.9, 0.8, 0.65, 0.6, 0.9, '64.jpg', '64', 1),
(65, NULL, 'New Design 65', '2024-12-12', 'CONTENT', 299, '2', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\"],[\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51122\",\"51106\",\"51107\",\"51117\",\"51114\",\"51115\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\"]]', '', 0, 1, 'cvD', 4.7, 45966, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.375, 0.65, 0.6, 0.5, 0.55, 1.5, 0.9, 0.8, 0.65, 0.6, 0.9, '65.jpg', '65', 1),
(66, NULL, 'New Design 66', '2024-12-12', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51115\",\"51114\",\"51099\",\"51104\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51112\",\"51113\",\"51116\",\"51117\",\"51125\",\"51123\",\"51122\"],[\"51111\",\"51118\",\"51119\",\"51120\",\"51100\",\"51121\"]]', '[]', 0, 1, 'cvD', 4.7, 46862, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.375, 0.65, 0.6, 0.5, 0.55, 1.2, 0.9, 0.8, 0.75, 0.75, 0.9, '66.jpg', '66', 1),
(67, NULL, 'Brochure 2', '2024-12-12', 'CONTENT', 299, '5', 1, 0, '0', '[6,7]', '[[\"51115\",\"51114\",\"51099\",\"51104\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51112\",\"51113\",\"51116\",\"51117\",\"51125\",\"51123\",\"51122\"],[\"51111\",\"51118\",\"51119\",\"51120\"]]', '', 0, 0, 'cvD', 4.7, 5594, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.375, 0.65, 0.6, 0.5, 0.7, 1.9, 1, 0.9, 0.75, 0.75, 0.9, '67.jpg', '67', 1),
(68, NULL, 'New Design 68', '2024-12-12', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\"],[\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51122\",\"51106\",\"51107\",\"51117\",\"51114\",\"51115\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\"]]', '', 0, 1, 'cvD', 4.7, 6520, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.375, 0.65, 0.6, 0.5, 0.55, 0.9, 0.9, 0.8, 0.65, 0.6, 0.9, '68.jpg', '68', 1),
(69, NULL, 'New Design 69', '2024-12-12', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\"],[\"51099\",\"51114\",\"51104\",\"51105\",\"51108\",\"51109\",\"51122\",\"51106\",\"51107\",\"51117\",\"51115\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\"]]', '', 0, 1, 'cvD', 4.7, 7006, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.375, 0.65, 0.6, 0.5, 0.55, 0.9, 0.9, 0.8, 0.65, 0.6, 0.9, '69.jpg', '69', 1),
(70, NULL, 'New Design 70', '2024-12-12', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '', '', 0, 1, 'cvD', 4.7, 4422, 1, 0, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.375, 0.65, 0.6, 0.5, 0.55, 0.9, 0.9, 0.8, 0.65, 0.6, 0.55, '70.jpg', '70', 0),
(71, NULL, 'New Design 71', '2024-12-12', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51107\",\"51108\",\"51109\",\"51106\",\"51122\",\"51110\",\"51112\",\"51114\",\"51116\",\"51117\",\"51125\",\"51113\",\"51123\"]]', '', 0, 1, 'cvD', 4.7, 7122, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.375, 0.65, 0.6, 0.5, 0.55, 0.9, 0.9, 0.8, 0.65, 0.6, 0.8, '71.jpg', '71', 1),
(84, NULL, 'Display', '2024-12-12', '', 299, '2', 1, 0, '0', '[6,7]', '[[\"51111\",\"51123\",\"51118\",\"51119\",\"51120\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51114\",\"51112\",\"51113\",\"51116\",\"51117\",\"51122\",\"51125\"]]', '', 0, 1, 'cvDragon', 4.8, 5920, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.6, 0.5, 0.525, 2, 1, 0.875, 0.9, 0.55, 0.85, '84.jpg', '84', 1),
(86, NULL, 'Classic Resume', '2024-12-12', '', 299, '2', 1, 0, '0', '[6,7]', '[[\"51115\",\"51114\",\"51099\",\"51104\",\"51106\",\"51107\",\"51108\",\"51109\",\"51110\",\"51112\",\"51113\",\"51116\",\"51117\",\"51125\",\"51123\",\"51122\"],[\"51111\",\"51118\",\"51119\",\"51120\",\"51121\"]]', '', 0, 1, 'cvDragon', 4.8, 45560, 1, 1, '', '', '', '', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.6, 0.5, 0.525, 2, 1, 0.875, 0.9, 0.7, 0.85, '86.jpg', '86', 1),
(90, NULL, '', '2021-06-05', 'Content', 299, '1', 1, 0, '0', '[6,7]', '', '', 0, 1, 'Limtechs', 4.7, 2410, 1, 1, '', '', '', '', '', 1.7, 0.8, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.55, 1.25, 0.8, 0.8, 0.65, 0.65, 0.85, '90.jpg', '', 0),
(91, NULL, 'New Design ', '2021-07-07', 'CONTENT', 299, '2', 1, 0, '0', '[6,7]', '[[\"51115\",\"51099\",\"51104\",\"51105\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvD', 4.7, 48943, 1, 1, '', '', '', '', '', 1.8, 0.65, 0.55, 0.55, 0.375, 0.65, 0.6, 0.55, 0.65, 1.2, 0.9, 0.8, 0.75, 0.75, 0.9, '91.jpg', '91', 1),
(92, NULL, 'Condensed', '2020-09-24', 'CONTENT', 299, '1', 1, 0, '0', '[6,7]', '[[\"51104\",\"51106\",\"51108\",\"51107\",\"51125\",\"51116\",\"51117\"],[\"51111\",\"51118\",\"51120\",\"51105\",\"51112\",\"51113\",\"51114\",\"51123\",\"51121\",\"51119\",\"51115\",\"51099\",\"51110\"]]', '[]', 0, 0, 'cvD', 4.7, 5949, 1, 1, '', '', '', '', '', 1.7, 0.85, 0.55, 0.4, 0.375, 0.65, 0.6, 0.6, 0.6, 0.9, 0.55, 0.75, 0.8, 0.6, 0.8, '92.jpg', '92', 1),
(93, NULL, 'TimeLine Journey', '2020-09-24', 'Content', 299, '3', 1, 0, '0', '[6,7]', '', '', 0, 0, 'Limtechs', 4.7, 2410, 1, 0, '', '', '', '', '', 1.7, 0.8, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.55, 1.25, 0.8, 0.8, 0.65, 0.65, 0.85, '93.jpg', '93', 1),
(94, NULL, 'Condensed Content', '2021-12-15', 'CONTENT', 299, '5', 1, 0, '0', '[6,7]', '[[\"51104\",\"51106\",\"51109\",\"51107\",\"51125\",\"51116\",\"51117\"],[\"51111\",\"51118\",\"51115\",\"51099\",\"51110\",\"51105\",\"51112\",\"51113\",\"51114\",\"51122\",\"51120\",\"51119\",\"51123\"]]', '', 0, 0, 'cvD', 4.8, 10316, 1, 1, '', '', '', '', '', 1.7, 0.85, 0.55, 0.4, 0.375, 0.65, 0.6, 0.6, 0.6, 0.9, 0.55, 0.85, 0.8, 0.6, 0.8, '94.jpg', '94', 1),
(96, NULL, 'Modern New Look', '2021-09-24', 'Content', 299, '5', 3, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51120\",\"51110\",\"51119\",\"51100\",\"51121\"],[\"51104\",\"51106\",\"51109\",\"51108\",\"51105\",\"51107\",\"51125\",\"51116\",\"51114\",\"51112\",\"51122\",\"51113\",\"51115\",\"51099\",\"51117\",\"51123\"]]', '[]', 0, 0, 'Limtechs', 4.7, 58737, 1, 1, '', '', '', '', '', 1.7, 0.8, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.55, 1.25, 0.8, 2, 0.65, 0.65, 1, '96.jpg', '96', 1),
(97, NULL, 'Functional Look', '2021-12-15', 'Content', 299, '5', 3, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\",\"51100\",\"51121\"],[\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51115\",\"51122\",\"51107\",\"51114\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\",\"51117\"]]', '[]', 0, 0, 'Limtechs', 4.7, 14240, 1, 1, '', '', '', '', '', 1.5, 0.8, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.55, 1.25, 0.8, 0.8, 0.65, 0.65, 1, '97.jpg', '97', 1),
(98, NULL, 'New Look', '2021-12-21', 'Content', 299, '5', 1, 0, '0', '[6,7]', '[[\"51101\",\"51111\",\"51118\",\"51120\",\"51119\",\"51100\",\"51121\"],[\"51099\",\"51104\",\"51106\",\"51109\",\"51108\",\"51105\",\"51115\",\"51107\",\"51114\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51123\",\"51125\"]]', '[]', 0, 0, 'Limtechs', 4.7, 20266, 1, 1, '', '', '', '', '', 1.5, 0.8, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.55, 1.25, 0.8, 0.8, 0.65, 0.65, 1, '98.jpg', '98', 1),
(99, NULL, 'New Look Dynamic', '2021-12-21', 'Content', 299, '5', 1, 0, '0', '[6,7]', '[[\"51115\",\"51108\",\"51104\",\"51109\",\"51106\",\"51105\",\"51099\",\"51107\",\"51110\",\"51112\",\"51113\",\"51114\",\"51116\",\"51117\",\"51122\",\"51123\",\"51125\"],[\"51101\",\"51118\",\"51119\",\"51120\",\"51100\",\"51121\"]]', '[]', 0, 0, 'Limtechs', 4.7, 9271, 1, 1, '', '', '', '', '', 1.7, 0.85, 0.55, 0.45, 0.4, 0.7, 0.6, 0.5, 0.55, 1.2, 1, 0.9, 0.55, 0.9, 0.8, '99.jpg', '99', 1),
(100, NULL, 'Professional Design', '2022-01-02', 'Content', 299, '5', 1, 0, '0', '[6,7]', '[[\"51111\",\"51118\",\"51104\",\"51106\",\"51109\",\"51108\",\"51099\",\"51105\",\"51116\",\"51113\",\"51107\",\"51114\",\"51112\",\"51117\"],[\"51101\",\"51119\",\"51120\",\"51122\",\"51123\",\"51125\",\"51100\",\"51121\"]]', '[]', 0, 0, 'Limtechs', 4.7, 7073, 1, 1, '', '', '', '', '', 1.8, 0.8, 0.55, 0.4, 0.375, 0.6, 0.54, 0.55, 0.65, 1, 1, 0.8, 0.5, 0.65, 0.8, '100.jpg', '100', 1),
(101, NULL, 'Professional Upgrade', '2022-07-31', 'Content', 299, '5', 1, 0, '0', '[7]', '[[\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51115\",\"51122\",\"51107\",\"51114\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\",\"51117\"],[\"51111\",\"51118\",\"51119\",\"51120\",\"51100\",\"51121\"]]', '[]', 0, 0, 'Limtechs', 4.7, 8446, 1, 1, '', '', '', '', '', 1.8, 0.8, 0.55, 0.4, 0.375, 0.6, 0.54, 0.55, 0.65, 1, 1, 0.8, 0.5, 0.65, 0.8, '101.jpg', '101', 1),
(102, NULL, 'Upgrade Design', '2022-01-01', 'Content', 299, '5', 1, 0, '0', '[7]', '[[\"51111\",\"51118\",\"51119\",\"51120\",\"51100\",\"51121\"],[\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51115\",\"51122\",\"51107\",\"51114\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\",\"51117\"]]', '[]', 0, 0, 'Limtechs', 4.7, 8055, 1, 1, '', '', '', '', '', 1.8, 0.8, 0.55, 0.4, 0.375, 0.6, 0.54, 0.55, 0.65, 1, 1, 0.8, 0.5, 0.65, 0.8, '102.jpg', '102', 1),
(103, NULL, 'Professional Format', '2022-07-31', 'Content', 299, '5', 1, 0, '0', '[7]', '[[\"51111\",\"51118\",\"51119\",\"51120\",\"51100\",\"51121\"],[\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51115\",\"51122\",\"51107\",\"51114\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\",\"51117\"]]', '[]', 0, 0, 'Limtechs', 4.7, 8447, 1, 1, '', '', '', '', '', 1.5, 0.8, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.55, 1.25, 0.8, 0.8, 0.65, 0.65, 1, '103.jpg', '103', 1),
(104, NULL, 'Professional Upgraded Design', '2022-07-31', 'Content', 299, '5', 1, 0, '0', '[7]', '[[\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51115\",\"51122\",\"51107\",\"51114\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\",\"51117\"],[\"51111\",\"51118\",\"51119\",\"51120\",\"51100\",\"51121\"]]', '[]', 0, 0, 'Limtechs', 4.7, 7820, 1, 1, '', '', '', '', '', 1.8, 0.8, 0.55, 0.4, 0.375, 0.6, 0.54, 0.55, 0.65, 1, 1, 0.8, 0.5, 0.65, 0.8, '104.jpg', '104', 1),
(105, NULL, 'Upgraded Design Format', '2022-01-01', 'Content', 299, '5', 1, 0, '0', '[7]', '[[\"51111\",\"51118\",\"51108\",\"51119\",\"51120\"],[\"51099\",\"51104\",\"51105\",\"51106\",\"51109\",\"51115\",\"51122\",\"51107\",\"51114\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\",\"51117\",\"51101\",\"51100\",\"51121\"]]', '[]', 0, 0, 'Limtechs', 4.7, 7830, 1, 1, '', '', '', '', '', 1.8, 0.8, 0.55, 0.4, 0.375, 0.6, 0.54, 0.55, 0.65, 1, 1, 0.8, 0.5, 0.65, 0.8, '105.jpg', '105', 1),
(106, NULL, 'Professional Format Template', '2022-07-31', 'Content', 299, '5', 1, 0, '0', '[7]', '[[\"51111\",\"51118\",\"51119\",\"51120\",\"51100\",\"51121\"],[\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51115\",\"51122\",\"51107\",\"51114\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\",\"51117\"]]', '[]', 0, 0, 'Limtechs', 4.7, 4441, 1, 1, '', '', '', '', '', 1.5, 0.8, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.55, 1.25, 0.8, 0.8, 0.65, 0.65, 1, '106.jpg', '106', 1),
(107, NULL, 'Design Format New', '2024-11-11', 'Content', 299, '5', 1, 0, '0', '[7]', '[[\"51111\",\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51107\",\"51110\",\"51112\",\"51113\",\"51114\",\"51116\",\"51117\",\"51123\",\"51125\",\"51122\",\"51119\",\"51118\",\"51120\",\"51121\"]]', '[]', 0, 0, 'Limtechs', 4.7, 8534, 1, 1, '', '', '', '', '', 1.8, 0.8, 0.55, 0.4, 0.375, 0.6, 0.54, 0.55, 0.65, 1, 1, 0.8, 0.5, 0.65, 0.8, '107.jpg', '107', 1),
(108, NULL, 'Format Template Professional ', '2021-12-21', 'Content', 299, '5', 1, 0, '0', '[7]', '[[\"51111\",\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51107\",\"51110\",\"51112\",\"51113\",\"51114\",\"51116\",\"51117\",\"51123\",\"51125\",\"51122\",\"51119\",\"51118\",\"51120\",\"51121\"]]', '[]', 0, 0, 'Limtechs', 4.7, 4584, 1, 1, '', '', '', '', '', 1.5, 0.8, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.55, 1.25, 0.8, 0.8, 0.65, 0.65, 1, '108.jpg', '108', 1),
(109, NULL, 'Professional Template', '2021-12-21', 'Content', 299, '5', 1, 1, '0', '[7]', '[[\"51111\",\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51107\",\"51110\",\"51112\",\"51113\",\"51114\",\"51116\",\"51117\",\"51123\",\"51125\",\"51122\",\"51119\",\"51118\",\"51120\",\"51121\"]]', '[]', 0, 0, 'Limtechs', 4.7, 0, 1, 0, '', '', '', '', '', 1.5, 0.8, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.55, 1.25, 0.8, 0.8, 0.65, 0.65, 1, '109.jpg', '109', 1),
(9997, NULL, 'cvDragon Dev1', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\",\"51100\",\"51121\"],[\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51115\",\"51122\",\"51107\",\"51114\",\"51125\",\"51110\",\"51113\",\"51116\",\"51123\",\"51112\",\"51117\"]]', '[]', 0, 1, 'cvDragon', 4.9, 3433, 1, 0, '', '', '', '', '', 1.8, 0.85, 0.55, 0.4, 0.375, 0.675, 0.6, 0.55, 0.9, 1.2, 0.8, 0.9, 0.65, 0.6, 0.8, '9997', '9997', 1),
(9998, NULL, 'cvDragon Dev2', '2021-06-05', 'Content', 299, '5', 1, 0, '0', '[6,7]', '[[\"51100\",\"51101\",\"51111\",\"51118\",\"51119\",\"51120\"],[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51106\",\"51108\",\"51109\",\"51107\",\"51114\",\"51110\",\"51122\",\"51113\",\"51116\",\"51117\",\"51123\",\"51125\",\"51112\",\"51121\"]]', '[]', 0, 1, 'Limtechs', 4.7, 176, 1, 0, '', '', '', '', '', 1.7, 0.8, 0.55, 0.4, 0.375, 0.65, 0.6, 0.55, 0.6, 1.3, 0.8, 0.85, 0.65, 0.65, 1, '9998', '9998', 1),
(9999, NULL, 'cvDragon', '2021-06-05', 'Content', 299, '1', 1, 0, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 4.9, 3433, 1, 0, '', '', '', '', '', 1.8, 0.85, 0.55, 0.4, 0.375, 0.675, 0.6, 0.55, 0.9, 1.2, 0.8, 0.9, 0.65, 0.6, 0.8, '9999', '9999', 0),
(10001, NULL, 'VJIM Hyderabad, India', '2021-06-05', 'This design is specially designed and crafted for Vignana Jyothi Institute of Management', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '', '#ebe4f2', '#CDBCE0', '', 1.8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.65, 0, 'VIJM-HYDERABAD.jpg', '10001', 0),
(10002, NULL, 'Praxis - Kolkata', '2021-06-05', 'This design is specially designed and crafted for Vignana Jyothi Institute of Management', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, '', 0, 0, 1, 1, '#000', '', '#CCC', '#999', '', 1.8, 0.55, 0.6, 0.5, 0.375, 0.7, 0.6, 0.5, 0.525, 0.9, 0.85, 0.8, 0.8, 0.65, 0.7, 'PRAXIS-KOLKATA.gif', '10002', 1),
(10005, NULL, 'BIBS, Kolkata', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 0, 'cvDragon', 0, 0, 1, 1, '#283655', '#1E1F26', '#283655', '#D0E1F9', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'BIBS.png', '10005', 1),
(10006, NULL, 'R. C. Patel Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 8176, 1, 1, '#EDB83D', '#000C29', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'RCPIT.png', '10027', 1),
(10007, NULL, 'Aravali Institute of Management, Jodhpur', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#E50115', '#63087F', '#F9F9FF', '#FFE', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'ARAVALI-JODHPUR.jpg', '10007', 1),
(10008, NULL, 'RPS INSTITUTION', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 1, 1, 1, '#1B59A2', '#000C29', '#F9F9FF', '#EBEBEB', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'RPS-INSTITUTIONS.jpg', '10008', 1),
(10009, NULL, 'Rajarambapu Institute of Technology', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 26, 1, 1, '#1B59A2', '#000C29', '#F9F9FF', '#EBEBEB', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'RIT-INDIA.png', '10009', 1),
(10010, NULL, 'GRD - Institute of Management & Technology', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1B59A2', '#000C29', '#F9F9FF', '#EBEBEB', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'GRD-IMT-DEHRADUN.png', '10010', 1),
(10011, NULL, 'DY PATIL GROUP', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#800000', '#800000', '#f9f9ff', '#ebebeb', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'DYPATIL.png', '10011', 1),
(10012, NULL, 'SSVPS Bapusaheb Shivajirao Deore College of Engineering, Dhule', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#006', '#3F48CC', '#F9F9FF', '#EBEBEB', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'SSVPS-DHULE.png', '10012', 1),
(10013, NULL, 'Gangamai college of Engineering, Nagoan', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#0E246E', '#0E246E', '#F9F9FF', '#EBEBEB', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'GCE-NAGOAN.png', '10013', 1),
(10014, NULL, 'SSBTs COLLEGE OF ENGINEERING & TECHNOLOGY, BAMBHORI', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#9ca221', '#e04417', '#f9f9ff', '#ebebeb', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'SSCOET-JALGAON.png', '10014', 1),
(10015, NULL, 'SHRI GULABRAO DEOKAR COLLEGE OF ENGINEERING, JALGAON', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#106190', '#0A4764', '#F9F9FF', '#EBEBEB', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'SGDCOE-JALGAON.png', '10015', 1),
(10016, NULL, 'Government College of Engineering, Jalgaon', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#F2AB75', '#53322B', '#F9F9FF', '#EBEBEB', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'GCOE-JALGAON.jpg', '10016', 1),
(10017, NULL, 'RCPET - IMRD, SHIRPUR', '2021-06-05', 'CONTENT', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.89, 25, 1, 1, '#EDB83D', '#000C29', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'RCPET-SHIRPUR.jpeg', '10006', 1),
(10018, NULL, 'BP Poddar Institute of Management & Technology, Kolkata', '2021-06-05', 'This design is specially designed and crafted for BP Poddar Institute', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#283655', '#1E1F26', '#283655', '#D0E1F9', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.6, 0.5, 0.525, 1.2, 1, 0.875, 0.9, 0.55, 0.8, 'BP_PODDAR_KOLKATA.png', '10018', 1),
(10019, NULL, 'GWECA - GOVERNMENT WOMEN ENGINEERING COLLEGE, AJMER', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#291D95', '#000C29', '#EAAB65', '#EFEFEF', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'GWECA-AJMER.png', '10019', 1),
(10020, NULL, 'Sidhaganga Institute of Technology - MBA Department, Tumkur', '2024-06-02', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51104\",\"51105\",\"51108\",\"51109\",\"51112\",\"51106\",\"51107\",\"51110\",\"51099\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.7, 963, 1, 1, '#342e67', '#333', '#ECECEC', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.875, 0.9, 0.55, 0.8, 'SIT-TUMAKURU.png', '10020', 1),
(10021, NULL, 'TGP COLLEGE OF ENGINEERING & TECHNOLOGY TGPCET NAGPUR', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 4, 1, 1, '#03C', '#000C29', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'TGPCET.gif', '10006', 1),
(10022, NULL, 'HK Institute of Management Studies and Research - HKIMSR, Mumbai', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 2, 1, 1, '#283655', '#1E1F26', '#283655', '#D0E1F9', '', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.6, 0.5, 0.525, 1, 1, 0.875, 0.9, 0.55, 0.8, 'HKIMSR-MUMBAI.png', '10022', 1),
(10023, NULL, 'SVERI, College of Engineering, Pandharpur', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 7, 1, 1, '#A0A1AF', '#000C29', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'SVERI-PANDHARPUR.jpg', '10006', 1),
(10024, NULL, 'NIT Jalandhar', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#0B0E07', '#000C29', '#edebea', '#DBEDFB', '', 1.8, 0.575, 0.555, 0.4, 0.375, 0.5, 0.55, 0.45, 0.5, 1, 0.85, 0.8, 0.65, 0.65, 0.8, 'NIT-JALANDHAR.png', '10024', 1),
(10025, NULL, 'SNJB\'s ', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#A2494D', '#000C29', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'SNJB-NASHIK.png', '10025', 1),
(10026, NULL, 'CSMSS CHH. SHAHU COLLEGE OF ENGINEERING - AURANGABAD', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#632324', '#000C29', '#F9F9FF', '#EEE', '', 1.8, 0.5, 0.6, 0.4, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'CHHSCE-AURANGABAD.jpg', '10026', 1),
(10027, NULL, 'Deogiri Institute of Engineering and Management Studies - DIEMS, Aurangabad', '2022-04-25', 'Content', 299, '4', 2, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 12895, 1, 1, '#342e67', '#333', '#4fc8f7', '#edebea', '#000000', 1.8, 0.55, 0.6, 0.5, 0.375, 0.7, 0.65, 0.5, 0.525, 0.9, 0.85, 0.8, 0.8, 0.65, 0.8, 'DIEMS-AURANGABAD.png', '10027', 1),
(10028, NULL, 'Shreeyash College of Engineering & Technology - Aurangabad', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#fc3737', '#000C29', '#EEE', '#CCC', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'SHRYEEYASH-AURANGABAD.jpg', '10028', 1),
(10029, NULL, 'Veer Narmad South Gujarat University - VNSGU Surat', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 9, 1, 1, '#823118', '#000', '#544C7F', '#CCC', '', 1.8, 0.85, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 1, 0.875, 0.9, 0.55, 0.8, 'VNSGU-AHMEDABAD.png', '10029', 1),
(10030, NULL, 'Don Bosco Institute of Technology - DBIT, Mumbai', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#010101', '#000C29', '#23383C', '#DBEAF1', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'dbit-mumbai.png', '10030', 1),
(10031, NULL, 'Indian Institute of Management (IIM) Rohtak', '2021-06-05', 'COntent', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '', '#CCC', '#999', '', 1.8, 0.55, 0.6, 0.5, 0.375, 0.7, 0.5, 0.5, 0.525, 0.9, 0.85, 0.8, 0.8, 0.65, 0.7, 'IIM-ROHTAK.png', '10031', 1),
(10032, NULL, 'ABHA Gaikwad-Patil College of Engineering - Nagpur', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#025AB0', '#000C29', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'ABHA-NAGPUR.png', '10032', 1),
(10033, NULL, 'Vishwakarma Institute of Information Technology, Pune', '2021-06-05', 'Content', 299, '4', 2, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.8, 4497, 1, 1, '#1F5895', '#000C29', '#EEE', '#CCC', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.5, 0.6, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10507.png', '10033', 1),
(10034, NULL, 'Amity University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 4.8, 42, 1, 1, '#01458E', '#000C29', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'AMITY-UNIVERSITY.png', '10034', 1),
(10035, NULL, 'IIT KHARAGPUR', '2021-06-05', 'CONTENT', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvD', 4.7, 44451, 1, 1, '#022A5E', '#000C29', '#A4E2E8', '#D6EAF8', '', 1.8, 0.5, 0.6, 0.4, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'IIT-KGP.png', '10035', 1),
(10036, NULL, 'Indian Institute of Plantation Management - Bengaluru', '2021-06-05', 'C', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 4.8, 40146, 1, 1, '#000', '', '#ECECEC', '#999', '', 1.8, 0.55, 0.6, 0.5, 0.375, 0.7, 0.5, 0.5, 0.525, 0.9, 0.85, 0.8, 0.8, 0.65, 0.7, 'IIPM-Bangalore.png', '10036', 1),
(10037, NULL, 'Nagpur Institute of Technology - Nagpur', '2021-06-05', 'C', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.8, 4412, 1, 1, '#000000', '#000c29', '#000000', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'nit.jpg', '10006', 1),
(10038, NULL, 'Dr. Daulatrao Aher College of Engineering - Karad', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.9, 1111, 1, 1, '#01458e', '#000c29', '#f9f9ff', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'dacoe.jpg', '10006', 1),
(10039, NULL, 'Gharda Institute Of Technology - Dabhil', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 4.8, 4444, 1, 1, '#000000', '#000C29', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'GIT-LOGO.jpg', '10039', 1),
(10042, NULL, 'The Neotia University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 4.9, 446, 1, 1, '#000000', '#191919', '#d6d6d6', '#e5e5e5', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'TNU-KOLKATA.png', '10042', 1),
(10043, NULL, 'Neotia Institute of Technology Management and Science', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 4.8, 452, 1, 1, '#000', '#191919', '#000000', '#e5e5e5', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'NITMAS-KOLKATA.png', '10043', 1),
(10044, NULL, 'Government Engineering College - Bilaspur', '2021-06-05', 'content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 4.9, 21, 1, 1, '#101046', '#000C29', '#F9F9FF', '#ECECEC', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.75, 0.8, 'GEC-BILASPUR.png', '10044', 1),
(10045, NULL, 'FORE School of Management, New Delhi', '2021-06-05', 'content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 4.9, 0, 1, 1, '#101046', '#000C29', '#F9F9FF', '#ECECEC', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.65, 0.85, 0.9, '10045.png', '10045', 1);
INSERT INTO `resource-profiledesign` (`designid`, `resource_profile_design_categorie_id`, `designName`, `lastUpdated`, `content`, `designPrice`, `category`, `format`, `isPrivate`, `sections`, `version`, `sectionOrder`, `sectionDefault`, `sectionColumn`, `isDownload`, `author`, `rating`, `downloadTimes`, `web`, `app`, `heading`, `color1`, `color2`, `color3`, `color4`, `basevalue`, `headText`, `timeLine`, `timeLineSmall`, `timeSubLine`, `headLine`, `subLine`, `baseLine`, `introLine`, `nameLine`, `nameHeight`, `introHeight`, `headLineHeight`, `headerLineHeight`, `GenLine`, `logo`, `template`, `status`) VALUES
(10046, NULL, 'FORE School of Management (Executive), New Delhi', '2021-06-05', 'content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 4.9, 0, 1, 1, '#0093dd', '#0093dd', '#F9F9FF', '#ECECEC', '', 1.75, 0.5, 0.6, 0.5, 0.375, 0.65, 0.55, 0.5, 0.6, 1, 0.85, 0.8, 0.65, 0.85, 0.9, '10046.png', '10046', 1),
(10047, NULL, 'SVPM, COLLEGE OF ENGINEERING', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 2, 1, 1, '#666666', '#333333', '#f9f9ff', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10047.png', '10006', 1),
(10048, NULL, 'Lovely Professional University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#ef7f1a', '#000C29', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10048.png', '10048', 1),
(10049, NULL, 'Banasthali University - Jaipur', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 2, 1, 1, '#373a56', '#68748d', '#f9f9ff', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10049.png', '10006', 1),
(10050, NULL, 'St Xavier\'s Kolkata', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#207ba2', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10050.jpg', '10050', 1),
(10051, NULL, 'UEM - University of Engineering & Management - Jaipur', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#131425', '#f70d0e', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10051.png', '10051', 1),
(10052, NULL, 'The Bhawanipur Education Society College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10052.png', '10052', 1),
(10053, NULL, 'Dr. Akhilesh Das Gupta Institute of Technology and Management', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10053.jpg', '10053', 1),
(10054, NULL, 'BHUBANESWAR ENGINEERING COLLEGE (BEC) - BHUBANESWAR', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10054.jpg', '10054', 1),
(10055, NULL, 'BAPATLA ENGINEERING COLLEGE (BEC) - BAPATLA, AP', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10055.png', '10055', 1),
(10056, NULL, 'ARMIET - Sapgaon', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#e84e2c', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10056.png', '10056', 1),
(10100, NULL, 'Shri Ramswaroop College Of Engineering and Management', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#EDB83D', '#000C29', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10100.jpg', '10006', 1),
(10101, NULL, 'sreenidhi insititute of science and technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10101.jpg', '10006', 1),
(10103, NULL, 'Shri Sant Gajanan Maharaj College of engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10103.jpg', '10006', 1),
(10104, NULL, 'IMS ENGINEERING COLLEGE', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10104.jpg', '10006', 1),
(10105, NULL, 'Sri Sai Ram Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10105.png', '10006', 1),
(10106, NULL, 'Rajarajeshwari colleage of engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10106.png', '10006', 1),
(10107, NULL, 'KKR & KSR INSTITUTE OF TECHNOLOGY AND SCIENCES', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10107.jpg', '10006', 1),
(10108, NULL, 'SDM institute of technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10108.png', '10006', 1),
(10109, NULL, 'ADI SHANKARA INSTITUTE OF ENGINEERING AND TECHNOLOGY', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10109.png', '10006', 1),
(10110, NULL, 'NMAM Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10110.png', '10006', 1),
(10111, NULL, 'Guru Nanak Dev Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10111.jpg', '10006', 1),
(10112, NULL, 'University Institute of Engineering and Technology, Kurukshetra University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10112.jpg', '10006', 1),
(10113, NULL, 'N K Orchid College of Engineering & Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10113.png', '10006', 1),
(10114, NULL, 'SCMS School of Engineering & Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10114.png', '10006', 1),
(10115, NULL, 'ADITYA COLLEGE OF ENGINEERING AND TECHNOLOGY', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10115.png', '10006', 1),
(10116, NULL, 'Aligarh Muslim University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10116.png', '10006', 1),
(10117, NULL, 'Appasaheb Birnale College Of Pharmacy', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10117.jpg', '10006', 1),
(10118, NULL, 'University of Delhi', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10118.png', '10006', 1),
(10119, NULL, 'amrat Ashok Technological Institute', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10119.jpg', '10006', 1),
(10120, NULL, 'Siddhartha Institute of Technology & Sciences(SITS)', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10120.jpg', '10006', 1),
(10121, NULL, 'Sri Sarada College for Women', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10121.png', '10006', 1),
(10122, NULL, 'St. Joseph\'s College of Engineering and Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10122.png', '10006', 1),
(10123, NULL, 'Techno India University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10123.png', '10006', 1),
(10124, NULL, 'Vellore Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 19, 1, 1, '#000000', '#000000', '#f9f9ff', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10124.png', '10006', 1),
(10125, NULL, 'AISSMS College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10125.jpeg', '10006', 1),
(10126, NULL, 'Anna university', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10126.png', '10006', 1),
(10127, NULL, 'Arya College of Engineering & I.T.', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10127.jpg', '10006', 1),
(10129, NULL, 'IIMT COLLEGE OF ENGINEERING', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10129.jpg', '10006', 1),
(10130, NULL, 'Indus University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10130.png', '10006', 1),
(10131, NULL, 'JSS Academy of Technical Education', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10131.jpg', '10006', 1),
(10132, NULL, 'KIET GROUP OF INSTITUTIONS', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10132.jpeg', '10006', 1),
(10133, NULL, 'NIT Durgapur', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10133.png', '10006', 1),
(10134, NULL, 'Rajiv Gandhi Government Engineering College Nagrota Bagwan', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10134.png', '10006', 1),
(10136, NULL, 'Silver Oak College of Engineering and Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10136.png', '10006', 1),
(10137, NULL, 'St Joseph Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10137.png', '10006', 1),
(10138, NULL, 'SVKM\'s Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10138.png', '10006', 1),
(10139, NULL, 'SYMBIOSIS CENTRE FOR MANAGEMENT STUDIES', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10139.png', '10006', 1),
(10140, NULL, 'Vignana Bharathi Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10140.jpg', '10006', 1),
(10141, NULL, 'Yashawantrao Chavan Institute of Science', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10141.png', '10006', 1),
(10142, NULL, 'Amrutvahini College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10142.jpeg', '10006', 1),
(10143, NULL, 'ASC Degree College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10143.png', '10006', 1),
(10144, NULL, 'Babu Banarasi Das Northern India Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10144.jpg', '10006', 1),
(10145, NULL, 'Dayananda Sagar College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10145.png', '10006', 1),
(10146, NULL, 'Gulzar Group of Institutes', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10146.png', '10006', 1),
(10148, NULL, 'Karunya Institute of Technology and Sciences (Deemed to be University)', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10148.jpg', '10006', 1),
(10149, NULL, 'M. A. M collage of engineering and technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10149.jpg', '10006', 1),
(10150, NULL, 'Maharaja Agrasen Institute of Management Studies', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10150.jpg', '10006', 1),
(10151, NULL, 'Manipal Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10151.png', '10006', 1),
(10153, NULL, 'PANIMALAR INSTITUTE OF TECHNOLOGY (PIT)', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10153.png', '10006', 1),
(10154, NULL, 'Priyadarshini College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10154.png', '10006', 1),
(10155, NULL, 'PSIT College Of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10155.jpg', '10006', 1),
(10157, NULL, 'Rajkiya Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10157.jpg', '10006', 1),
(10158, NULL, 'R.V.R. & J.C.College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10158.jpg', '10006', 1),
(10159, NULL, 'Shri Shivaji Institute of Engineering and Management Studies', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10159.png', '10006', 1),
(10160, NULL, 'Sipna College Of Engineering And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10160.jpg', '10006', 1),
(10161, NULL, 'SV College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10161.jpg', '10006', 1),
(10162, NULL, 'Vivekanand Education Society\'s Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10162.jpeg', '10006', 1),
(10163, NULL, 'Yenepoya Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10163.png', '10006', 1),
(10164, NULL, 'ARTS, COMMERCE& SCIENCE COLLEGE', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10164.png', '10006', 1),
(10165, NULL, 'Birla Institute of Technology and Science', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10165.png', '10006', 1),
(10166, NULL, 'BK BIRLA INSTITUTE OF ENGINEERING AND TECHNOLOGY', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10166.png', '10006', 1),
(10167, NULL, 'Chandigarh University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10167.jpg', '10006', 1),
(10168, NULL, 'CMR Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10168.png', '10006', 1),
(10169, NULL, 'College of Engineering & Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10169.jpg', '10006', 1),
(10170, NULL, 'DOON BUSINESS SCHOOL OF INSTITUTIONS', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10170.png', '10006', 1),
(10171, NULL, 'Government Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10171.png', '10006', 1),
(10173, NULL, 'HINDUSTHAN COLLEGE OF ENGINEERING AND TECHNOLOGY', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10173.png', '10006', 1),
(10174, NULL, 'Indian Institute of Technology (BHU)', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10174.png', '10006', 1),
(10176, NULL, 'Karavali Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10176.jpg', '10006', 1),
(10177, NULL, 'LBS Institute Of Technology for Women Poojappura', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10177.jfif', '10006', 1),
(10179, NULL, 'Manav Rachna International Institute Of Research And Studies', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10179.png', '10006', 1),
(10180, NULL, 'Marri Laxman Reddy Institute of Technology and Management', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10180.jpg', '10006', 1),
(10181, NULL, 'Mehr Chand Mahajan DAV College for Women', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10181.jpg', '10006', 1),
(10182, NULL, 'Nalanda College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10182.jpg', '10006', 1),
(10183, NULL, 'Pranveer Singh Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10183.jpg', '10006', 1),
(10184, NULL, 'Rajagiri school of engineering and technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10184.jpg', '10006', 1),
(10185, NULL, 'Rajalakshmi Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000000', '#000000', '#f9f9ff', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10185.png', '10006', 1),
(10186, NULL, 'Sant Longowal Institute of Engineering and Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10186.png', '10006', 1),
(10187, NULL, 'Sardar Vallabhbhai National Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10187.png', '10006', 1),
(10188, NULL, 'Saveetha School of Law', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10188.png', '10006', 1),
(10189, NULL, 'Sethu Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10189.jpg', '10006', 1),
(10191, NULL, 'Shri Shankarlal Sundarbai Shasun Jain College for Women', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10191.png', '10006', 1),
(10192, NULL, 'Sri Kanyaka Parameswari Arts and Science College for Women', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10192.jpg', '10006', 1),
(10193, NULL, 'Sri Krishna Chaitanya College Of Pharmacy', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10193.jpg', '10006', 1),
(10196, NULL, 'Vidya Vikas Institute Of Engineering And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000000', '#000000', '#f9f9ff', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10196.jpg', '10006', 1),
(10197, NULL, 'Visvesvaraya National Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10197.png', '10006', 1),
(10199, NULL, 'Alliance University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10199.png', '10006', 1),
(10200, NULL, 'Ambedkar Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10200.jpg', '10006', 1),
(10203, NULL, 'Babasaheb Bhimrao Ambedkar University (A Central University),', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10203.png', '10006', 1),
(10204, NULL, 'Bharat Institute of Technology (BIT)', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10204.png', '10006', 1),
(10206, NULL, 'Chettinad College of Engineering & Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10206.jpg', '10006', 1),
(10207, NULL, 'C.M.P. Degree College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10207.jpg', '10006', 1);
INSERT INTO `resource-profiledesign` (`designid`, `resource_profile_design_categorie_id`, `designName`, `lastUpdated`, `content`, `designPrice`, `category`, `format`, `isPrivate`, `sections`, `version`, `sectionOrder`, `sectionDefault`, `sectionColumn`, `isDownload`, `author`, `rating`, `downloadTimes`, `web`, `app`, `heading`, `color1`, `color2`, `color3`, `color4`, `basevalue`, `headText`, `timeLine`, `timeLineSmall`, `timeSubLine`, `headLine`, `subLine`, `baseLine`, `introLine`, `nameLine`, `nameHeight`, `introHeight`, `headLineHeight`, `headerLineHeight`, `GenLine`, `logo`, `template`, `status`) VALUES
(10209, NULL, 'Dhanalakshmi College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10209.png', '10006', 1),
(10210, NULL, 'Geetanjali Institute of Technical Studies (GITS)', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10210.png', '10006', 1),
(10211, NULL, 'G. H. Raisoni College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10211.png', '10006', 1),
(10213, NULL, 'Gandhi Institute of Technology and Management', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10213.jpg', '10006', 1),
(10214, NULL, 'GL Bajaj Institute of Technology and Management', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10214.jpg', '10006', 1),
(10215, NULL, 'Guru Nanak Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10215.png', '10006', 1),
(10216, NULL, 'ICAR-National Academy of Agricultural Research Management', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10216.png', '10006', 1),
(10217, NULL, 'The ICFAI University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10217.png', '10006', 1),
(10218, NULL, 'Indira College of Commerce & Science (ICCS)', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10218.jpg', '10006', 1),
(10219, NULL, 'Indrayani institute of pharmaceutical education and research', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10219.jpeg', '10006', 1),
(10220, NULL, 'INSTITUTE OF TECHNOLOGY & MANAGEMENT', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10220.png', '10006', 1),
(10221, NULL, 'Jeppiaar Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10221.png', '10006', 1),
(10222, NULL, 'KCG College of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10222.jpg', '10006', 1),
(10223, NULL, 'KLE Society\'s Degree College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10223.png', '10006', 1),
(10224, NULL, 'Microteck college of management and technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10224.png', '10006', 1),
(10225, NULL, 'NIIT UNIVERSITY', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10225.png', '10006', 1),
(10226, NULL, 'NMIMS Mumbai', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10226.jpg', '10006', 1),
(10227, NULL, 'NSS College of Engineering,', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10227.png', '10006', 1),
(10228, NULL, 'PES University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10228.png', '10006', 1),
(10229, NULL, 'Pillai College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10229.png', '10006', 1),
(10231, NULL, 'QIS College of Engineering and Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10231.jpg', '10006', 1),
(10232, NULL, 'REVA UNIVERSITY', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10232.png', '10006', 1),
(10233, NULL, 'Sri Sairam Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10233.png', '10006', 1),
(10234, NULL, 'SASTRA Deemed to be University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10234.png', '10006', 1),
(10235, NULL, 'Sathyabama Institute of Science and Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10235.png', '10006', 1),
(10236, NULL, 'Sinhgad Group - Pune', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10236.jpg', '10006', 1),
(10237, NULL, 'Sona College of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10237.png', '10006', 1),
(10241, NULL, 'TIET - Thapar Institute of Engineering And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10241.png', '10006', 1),
(10242, NULL, 'Tontadarya College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10242.jpg', '10006', 1),
(10243, NULL, 'ABES Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10243.png', '10006', 1),
(10245, NULL, 'Amrita school of engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10245.png', '10006', 1),
(10248, NULL, 'ATHARVA COLLEGE OF ENGINEERING', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10248.png', '10006', 1),
(10249, NULL, 'Banaras Hindu University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10249.jpg', '10006', 1),
(10250, NULL, 'Bhagwanti Education Centre Degree College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10250.jpg', '10006', 1),
(10251, NULL, 'Bundelkhand Institute Of Engineering and Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10251.jpg', '10006', 1),
(10253, NULL, 'BMS College for Women', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10253.png', '10006', 1),
(10254, NULL, 'BUNDELKHAND INSTITUTE OF ENGINEERING & TECHNOLOGY', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10254.png', '10006', 1),
(10256, NULL, 'Chitkara University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10256.jpg', '10006', 1),
(10257, NULL, 'Cochin University of Science and Technolog', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10257.png', '10006', 1),
(10259, NULL, 'Dr. M.G.R. Educational And Research Institute', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10259.png', '10006', 1),
(10260, NULL, 'Eswar college of engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10260.jpg', '10006', 1),
(10261, NULL, 'Federal Institute of Science And Technology (FISAT)?', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10261.png', '10006', 1),
(10262, NULL, 'Future Institute of Engineering and Management', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10262.jpg', '10006', 1),
(10264, NULL, 'Galgotias University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10264.png', '10006', 1),
(10267, NULL, 'HIERANK BUSINESS SCHOOL', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10267.jpg', '10006', 1),
(10269, NULL, 'Hooghly Engineering & Technology College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10269.jpg', '10006', 1),
(10270, NULL, 'IPS Academy Institute of Business Management and Research', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10270.png', '10006', 1),
(10271, NULL, 'IIHMR', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10271.png', '10006', 1),
(10272, NULL, 'Institute of Innovation in Technology & Management (IITM)', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10272.jpg', '10006', 1),
(10273, NULL, 'Invertis University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10273.png', '10006', 1),
(10274, NULL, 'JAGADAMBHA COLLEGE OF ENGINEERING AND TECHNOLOGY', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10274.png', '10006', 1),
(10275, NULL, 'Janki Devi Memorial College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10275.png', '10006', 1),
(10276, NULL, 'JAWAHARLAL NEHRU NATIONAL COLLEGE OF ENGINEERING', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10276.jpg', '10006', 1),
(10277, NULL, 'Jaypee University Of Engineering And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10277.png', '10006', 1),
(10278, NULL, 'JECRC University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10278.png', '10006', 1),
(10279, NULL, 'Seth Jai Parkash Mukand Lal Institute Of Engineering And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10279.jpg', '10006', 1),
(10280, NULL, 'JAYWANTRAO SAWANT COLLEGE OF ENGINEERING', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10280.jpg', '10006', 1),
(10281, NULL, 'K. K. Wagh Institute Of Engineering Education And Research', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10281.png', '10006', 1),
(10282, NULL, 'K. S. Rangasamy College of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10282.jpg', '10006', 1),
(10284, NULL, 'Kamla Nehru Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10284.png', '10006', 1),
(10286, NULL, 'Karpagam College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10286.png', '10006', 1),
(10287, NULL, 'Kavikulguru Institute Of Technology And Science', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10287.jpg', '10006', 1),
(10288, NULL, 'Kishinchand Chellaram College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10288.png', '10006', 1),
(10290, NULL, 'Kingston School of Management & Science', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10290.jpg', '10006', 1),
(10291, NULL, 'KONGU ENGINEERING COLLEGE', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10291.jpg', '10006', 1),
(10292, NULL, 'Kristu Jayanti College of Law', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10292.png', '10006', 1),
(10293, NULL, 'Lalbhai Dalpatbhai College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10293.png', '10006', 1),
(10294, NULL, 'LNCT Group of Colleges', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10294.jpg', '10006', 1),
(10298, NULL, 'Loyola College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10298.png', '10006', 1),
(10299, NULL, 'L S M Government P G College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10299.jpg', '10006', 1),
(10300, NULL, 'Maharani Laxmi Bai Govt. College Of Excellence', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10300.jfif', '10006', 1),
(10301, NULL, 'Madan Mohan Malaviya University Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10301.jpg', '10006', 1),
(10302, NULL, 'Maharshi Dayanand University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10302.jpg', '10006', 1),
(10303, NULL, 'Mahatma Gandhi Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10303.png', '10006', 1),
(10304, NULL, 'Malla Reddy Institute of Engineering & Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10304.png', '10006', 1),
(10305, NULL, 'Maulana Azad College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10305.png', '10006', 1),
(10306, NULL, 'MEA Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10306.png', '10006', 1),
(10307, NULL, 'Meenakshi College Of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10307.png', '10006', 1),
(10308, NULL, 'Meerut Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10308.png', '10006', 1),
(10309, NULL, 'MES College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10309.jpg', '10006', 1),
(10310, NULL, 'Motilal Nehru National Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10310.png', '10006', 1),
(10311, NULL, 'MS Ramaiah College of Arts Science & Commerce', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10311.jpg', '10006', 1),
(10312, NULL, 'Muthayammal College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10312.png', '10006', 1),
(10313, NULL, 'MIT Muzaffarpur', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10313.jpg', '10006', 1),
(10314, NULL, 'Nalla Malla Reddy Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10314.jpg', '10006', 1),
(10315, NULL, 'Narayana Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10315.jpg', '10006', 1),
(10316, NULL, 'Nirmala Memorial Foundation College of Commerce & Science', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10316.png', '10006', 1),
(10317, NULL, 'Osmania University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10317.png', '10006', 1),
(10319, NULL, 'Poona college of pharmacy', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10319.png', '10006', 1),
(10320, NULL, 'Presidency University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10320.png', '10006', 1),
(10321, NULL, 'SCTR\'S Pune Institute of Computer Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10321.jpg', '10006', 1),
(10323, NULL, 'Rajdhani College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10323.jpg', '10006', 1),
(10325, NULL, 'Ravindra College of Engineering for Women', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10325.jpg', '10006', 1),
(10327, NULL, 'Roda Mistry College of Social Work and Research Center', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10327.jpg', '10006', 1),
(10328, NULL, 'Sambhram Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10328.jpg', '10006', 1),
(10330, NULL, 'Seethalakshmi Ramaswami College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10330.png', '10006', 1),
(10331, NULL, 'Shri Guru Sandipani Institute Of Technology & Science', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10331.jpg', '10006', 1),
(10332, NULL, 'Shri Shankaracharya Institute of Engineering and Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10332.png', '10006', 1),
(10334, NULL, 'Siliguri Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10334.jpg', '10006', 1),
(10335, NULL, 'SJR PU College for Women', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10335.png', '10006', 1),
(10336, NULL, 'Swami Keshvanand Institute of Technology, Management & Gramothan (SKIT)', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10336.jpeg', '10006', 1);
INSERT INTO `resource-profiledesign` (`designid`, `resource_profile_design_categorie_id`, `designName`, `lastUpdated`, `content`, `designPrice`, `category`, `format`, `isPrivate`, `sections`, `version`, `sectionOrder`, `sectionDefault`, `sectionColumn`, `isDownload`, `author`, `rating`, `downloadTimes`, `web`, `app`, `heading`, `color1`, `color2`, `color3`, `color4`, `basevalue`, `headText`, `timeLine`, `timeLineSmall`, `timeSubLine`, `headLine`, `subLine`, `baseLine`, `introLine`, `nameLine`, `nameHeight`, `introHeight`, `headLineHeight`, `headerLineHeight`, `GenLine`, `logo`, `template`, `status`) VALUES
(10337, NULL, 'Sreenidhi Institute of Science & Technology - SNIST', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10337.jpg', '10006', 1),
(10339, NULL, 'SRI GURU TEGH BAHADUR INSTITUTE OF MANAGEMENT AND INFORMATION TECHNOLOGY', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10339.jpg', '10006', 1),
(10340, NULL, 'Sri krishna arts and science college', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10340.png', '10006', 1),
(10341, NULL, 'Sri Sathya Sai College for Women', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10341.jpg', '10006', 1),
(10342, NULL, 'Srinivas Institute Of Technology(S.I.T.)', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10342.png', '10006', 1),
(10343, NULL, 'SRKR Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10343.jpg', '10006', 1),
(10344, NULL, 'Shri Shankaracharya Institute Of Professional Management And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10344.jpg', '10006', 1),
(10345, NULL, 'SSPM\'s College of Engineering,', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10345.png', '10006', 1),
(10346, NULL, 'Stella Maris College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10346.jpg', '10006', 1),
(10347, NULL, 'SWAMI KESHVANAND INSTITUTE OF TECHNOLOGY, MANAGEMENT AND GRAMOTHAN - [SKIT],', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10347.jpg', '10006', 1),
(10348, NULL, 'Terna Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10348.png', '10006', 1),
(10349, NULL, 'UKF College of Engineering and Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10349.jpg', '10006', 1),
(10350, NULL, 'Uttar Pradesh Textile Technology Institute', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10350.png', '10006', 1),
(10351, NULL, 'Vardhaman College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10351.png', '10006', 1),
(10352, NULL, 'Vels Institute of Science, Technology & Advanced Studies (VISTAS)', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10352.jpg', '10006', 1),
(10353, NULL, 'Vidyavardhaka College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10353.png', '10006', 1),
(10354, NULL, 'Vimal Jyothi Engineering College,', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10354.jpg', '10006', 1),
(10356, NULL, 'Yadavrao Tasgaonkar Institute of Engineering and Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10356.png', '10006', 1),
(10357, NULL, 'Yash Institute Of B Pharmacy', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10357.png', '10006', 1),
(10358, NULL, 'Sree Balaji Dental College & Hospital', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10358.png', '10006', 1),
(10359, NULL, 'Srinivasa Ramanujan Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10359.png', '10006', 1),
(10360, NULL, 'A. P. Shah Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10360.png', '10006', 1),
(10362, NULL, 'Anjalai Ammal Mahalingam Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10362.jpg', '10006', 1),
(10363, NULL, 'Aayojan', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10363.png', '10006', 1),
(10365, NULL, 'Abhinav college', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10365.png', '10006', 1),
(10367, NULL, 'Adamas University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10367.jpg', '10006', 1),
(10368, NULL, 'Dr. Akhilesh Das Gupta Institute of Technology & Management', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10368.jpg', '10006', 1),
(10370, NULL, 'Agni College of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000000', '#000000', '#f9f9ff', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10370.png', '10370', 1),
(10371, NULL, 'Ahmedabad Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10371.jpg', '10006', 1),
(10374, NULL, 'Ajeenkya DY Patil University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10374.png', '10006', 1),
(10375, NULL, 'ASTER INSTITUTIONS', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10375.png', '10006', 1),
(10376, NULL, 'AKS University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10376.png', '10006', 1),
(10377, NULL, 'Am jain college', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10377.jpg', '10006', 1),
(10378, NULL, 'Amal Jyothi College of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10378.png', '10006', 1),
(10379, NULL, 'Amarnath girls degree college', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10379.jpg', '10006', 1),
(10380, NULL, 'Anand Niketan College Anandwan Warora', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10380.png', '10006', 1),
(10381, NULL, 'VEMU INSTITUTE OF TECHNOLOGY', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'VEMU.jpg', '10006', 1),
(10382, NULL, 'Gopalan College of Engineering and Management, Bangalore', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'GECM.jpg', '10006', 1),
(10383, NULL, 'Sardar Vallabhbhai Patel Institute of Technology (SVIT) - Vasad', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10383.png', '10006', 1),
(10384, NULL, 'Test of Enginerring', '2021-06-05', '', 299, '4', 1, 0, '0', '[6,7]', '', '', 0, 0, '', 0, 0, 1, 0, '#000000', '#000c29', '#000c29', '#000c29', '#000c29', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'Simulator Screen Shot - iPhone', '100067', 0),
(10385, NULL, 'Test Institute', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 4444, 1, 0, '#1d1502', '#000c29', '#f9f9ff', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.85, 0.55, 1, 0.8, 'cvdragonLogo.png', '100067', 0),
(10386, NULL, 'Testing again', '2021-06-05', '', 299, '4', 1, 0, '0', '[6,7]', '', '', 0, 0, '', 0, 0, 1, 0, '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.65, 0, 'guidance.png', '100067', 0),
(10387, NULL, 'SRM Valliammai Engineering College', '2021-06-05', '', 299, '4', 1, 0, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 0, '', 0, 0, 0, 0, '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.65, 0, 'SRM.png', '10006', 0),
(10388, NULL, 'Shri Ramswaroop memorial group of professional college', '2021-06-05', '', 299, '4', 1, 0, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 0, '', 0, 0, 0, 0, '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.65, 0, '20201230_102437.png', '10006', 0),
(10389, NULL, 'Pakur Polytechnic', '2021-06-05', '', 299, '4', 1, 0, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 0, '', 0, 0, 0, 0, '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.65, 0, 'download.png', '10006', 0),
(10390, NULL, 'SRM Institute of Science and Technology', '2021-06-05', '', 299, '4', 1, 0, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 0, '', 0, 0, 0, 0, '', '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.65, 0, 'SRM 2.0.png', '10006', 0),
(10400, NULL, 'Dr. D. Y. Patil Institute of Pharmaceutical Sciences & Research (DYPVP)', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 2, 1, 1, '#983432', '#000c29', '#f9f9ff', '#edebea', '#000000', 1.85, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10400.jpg', '10006', 1),
(10401, NULL, 'Metas Adventist College', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 16, 1, 1, '#895110', '#000c29', '#f9f9ff', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10401.png', '10006', 1),
(10402, NULL, 'Kalinga Institute of Industrial Technology - KIIT', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 0, 1, 1, '#292929', '#000c29', '#025a11', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'kiit.png', '10006', 1),
(10403, NULL, 'KIIT - School of Management', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '', '', 0, 1, '', 0, 0, 1, 1, '#000000', '#003d0c', '#dedede', '#e5e5e5', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'KSOM-KIIT-logo.png', '10042', 1),
(10404, NULL, 'OM Engineering College - OEC', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 1, 1, 1, '#47a8b0', '#000c29', '#f9f9ff', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'om.png', '10006', 1),
(10405, NULL, 'Chhotu Ram Rural Institute of Technology - CRRIT', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 0, 1, 1, '#5a5169', '#007f06', '#ffffff', '#edebea', '#df807d', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'cslogo.png', '10006', 1),
(10406, NULL, 'East West College Of Engineering - EWCE', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 0, 1, 1, '#ddd387', '#6b7fac', '#fffafa', '#e8e8e8', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'east.png', '10006', 1),
(10407, NULL, 'Mayurbhanj School Of Engineering- MSE', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 0, 1, 1, '#2c65a2', '#4c43d0', '#ffffff', '#edebea', '#d12e4a', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'm.png', '10006', 1),
(10408, NULL, 'Geeta Engineering College - GEC', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 0, 1, 1, '#086400', '#293539', '#fff5f5', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'GEC.png', '10006', 1),
(10409, NULL, 'Jhulelal institute of technology -JIT', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 0, 1, 1, '#083477', '#c0a459', '#ffffff', '#edebea', '#a2180e', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'JEC.png', '10006', 1),
(10410, NULL, 'Shri Balasaheb Tirpude College of Hotel Management & Catering Technology ', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 0, 1, 1, '#ef822a', '#000000', '#f9f6f6', '#e2ecec', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'TIHM.png', '10006', 1),
(10411, NULL, 'Hirasugar Institute of technology Nidasoshi - HIT', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 0, 1, 1, '#e8f07a', '#c10b05', '#fffafa', '#adabbd', '#f8f6ff', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'HH.png', '10006', 1),
(10412, NULL, 'Chhotubhai Gopalbhai Patel Institute of Technology -  CGPIT', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 0, 1, 1, '#330066', '#999933', '#ffffff', '#edebea', '#330066', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'chotu.png', '10006', 1),
(10413, NULL, 'Emerald Advanced Institute of Management Studies - EAIMS', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 0, 1, 1, '#0a46cb', '#c0cda2', '#fffafa', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'EME.png', '10006', 1),
(10414, NULL, 'Thadomal Shahani engineering college', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 0, 1, 1, '#010bd4', '#ffffff', '#f0ebeb', '#edebea', '#010bd4', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'TSE.png', '10006', 1),
(10415, NULL, 'Vidya Pratishthan Kamalnayan Bajaj Institute of Engineering and Technology - VPKBIET', '2021-06-05', '', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 0, 1, 1, '#000000', '#000000', '#fafafa', '#f2f2f2', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'csv.png', '10006', 1),
(10416, NULL, 'Pavai Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000001', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10416.jpeg', '10006', 1),
(10417, NULL, 'GATES Institute of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000002', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10417.jpeg', '10006', 1),
(10418, NULL, 'Knowledge Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000003', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10418.jpeg', '10006', 1),
(10419, NULL, 'J C Bose University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000004', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10419.png', '10006', 1),
(10420, NULL, 'Adiya Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000005', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10420.jpeg', '10006', 1),
(10421, NULL, 'Megha Institute Of Engineering And Technology For Womens', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000006', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10421.png', '10006', 1),
(10422, NULL, 'Nandha Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000007', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10422.jpeg', '10006', 1),
(10423, NULL, 'Maharaja Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000008', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10423.png', '10006', 1),
(10424, NULL, 'SKN Sinhgad Institute of Technology and Science', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000009', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10424.jpeg', '10006', 1),
(10425, NULL, 'RBVRR Women\'s College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000010', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10425.jpeg', '10006', 1),
(10426, NULL, 'Marwadi University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000011', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10426.png', '10006', 1),
(10427, NULL, 'JDT Islam politechnic College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000012', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10427.jpeg', '10006', 1),
(10428, NULL, 'NGF College Of Engineering And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000013', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10428.jpeg', '10006', 1),
(10429, NULL, 'Dayananada Sagar College Of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000014', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10429.png', '10006', 1),
(10430, NULL, 'Government Polytechnic College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000015', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10430.jpeg', '10006', 1),
(10431, NULL, 'Seshasayee Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000016', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10431.jpeg', '10006', 1),
(10432, NULL, 'IIT (ISM)', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000017', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10432.jpeg', '10006', 1),
(10434, NULL, 'Assam Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000019', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10434.jpeg', '10006', 1),
(10435, NULL, 'Prasad Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000020', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10435.jpeg', '10006', 1),
(10436, NULL, 'SCSIT DAVV', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000021', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10436.jpeg', '10006', 1),
(10437, NULL, 'Mahavir Swami College Of Engineering And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000022', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10437.jpeg', '10006', 1),
(10438, NULL, 'R V R & J C College Of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000023', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10438.jpeg', '10006', 1),
(10439, NULL, 'SNJBS\'s KBJ COE Chandwad', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000024', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10439.jpeg', '10006', 1),
(10440, NULL, 'Viva Institute Of Technology, Mumbai University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000025', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10440.jpeg', '10006', 1),
(10441, NULL, 'Datta Meghe College Of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000026', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10441.jpeg', '10006', 1),
(10442, NULL, 'Mata Sundri College For Women', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000027', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10442.jpeg', '10006', 1),
(10443, NULL, 'Amrita College Of Engineering And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000028', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10443.jpeg', '10006', 1),
(10444, NULL, 'Francis Xavier Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000029', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10444.jpeg', '10006', 1),
(10445, NULL, 'MDIT Polytechnic College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000030', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10445.jpeg', '10006', 1),
(10446, NULL, 'Technique Polytechnic Institute', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000031', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10446.jpeg', '10006', 1),
(10447, NULL, 'Government Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000032', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10447.png', '10006', 1),
(10448, NULL, 'Sarojini Naidu Vanita Maha Vidyalaya College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000033', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10448.jpeg', '10006', 1),
(10449, NULL, 'RKSD College Of Pharmacy', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000034', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10449.jpeg', '10006', 1),
(10450, NULL, 'A S Patil College Of Commerce', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000035', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10450.jpeg', '10006', 1),
(10451, NULL, 'MIT College Of Railway Engineering &Amp; Research', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 13, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000036', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10451.jpeg', '10006', 1),
(10452, NULL, 'NBN Sinhgad School Of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000037', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10452.jpeg', '10006', 1),
(10453, NULL, 'Nit Polytechnic', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000038', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10453.jpeg', '10006', 1),
(10454, NULL, 'Arya Bhatt Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000039', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10454.jpeg', '10006', 1),
(10455, NULL, 'Bhagwan Mahavir College Of Engineering And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000040', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10455.jpeg', '10006', 1),
(10457, NULL, 'Er Perumal Manimekalai College Of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000041', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10457.jpeg', '10006', 1);
INSERT INTO `resource-profiledesign` (`designid`, `resource_profile_design_categorie_id`, `designName`, `lastUpdated`, `content`, `designPrice`, `category`, `format`, `isPrivate`, `sections`, `version`, `sectionOrder`, `sectionDefault`, `sectionColumn`, `isDownload`, `author`, `rating`, `downloadTimes`, `web`, `app`, `heading`, `color1`, `color2`, `color3`, `color4`, `basevalue`, `headText`, `timeLine`, `timeLineSmall`, `timeSubLine`, `headLine`, `subLine`, `baseLine`, `introLine`, `nameLine`, `nameHeight`, `introHeight`, `headLineHeight`, `headerLineHeight`, `GenLine`, `logo`, `template`, `status`) VALUES
(10458, NULL, 'Indrashil University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000042', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10458.jpeg', '10006', 1),
(10459, NULL, 'Bhagwan Mahavir University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000043', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10459.jpeg', '10006', 1),
(10460, NULL, 'Vivekananda Education Society Insitute Of Management Studies And Research', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000044', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10460.png', '10006', 1),
(10461, NULL, 'Jaipur National University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000045', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10461.png', '10006', 1),
(10462, NULL, 'Padmabhooshan Vasantraodada Patil Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000046', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10462.jpeg', '10006', 1),
(10463, NULL, 'Government Polytechnic College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000047', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10463.jpeg', '10006', 1),
(10464, NULL, 'Government Polytechnic', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000048', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10464.jpeg', '10006', 1),
(10465, NULL, 'Baba Saheb Ambedkar Government Polytechnic College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000049', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10465.png', '10006', 1),
(10466, NULL, 'Dayanand Sagar Academy Of Technology And Management', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000050', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10466.jpeg', '10006', 1),
(10467, NULL, 'Sahaydri College Of Engineering And Management', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000051', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10467.jpeg', '10006', 1),
(10468, NULL, 'Vikram University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000052', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10468.jpeg', '10006', 1),
(10469, NULL, 'Central Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000053', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10469.jpeg', '10006', 1),
(10470, NULL, 'Anjali College Of Pharmacy & Science', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000054', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10470.png', '10006', 1),
(10472, NULL, 'Dilkap Research Institute Of Management Studies And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000055', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10472.jpeg', '10006', 1),
(10473, NULL, 'Mahatma Gandhi Mission College Of Engineering And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000056', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10473.jpeg', '10006', 1),
(10474, NULL, 'Gourishankar Institute Of Pharmaceutical Education And Research', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000057', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10474.jpeg', '10006', 1),
(10476, NULL, 'Mahavir Swami College Of Polytechnic', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000058', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10476.jpeg', '10006', 1),
(10477, NULL, 'KCE College Of Engineering And Management', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000059', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10477.jpeg', '10006', 1),
(10478, NULL, 'SKSVMACET', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000060', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10478.jpeg', '10006', 1),
(10479, NULL, 'Tapi Diploma Engineering College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000061', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10479.jpeg', '10006', 1),
(10480, NULL, 'College Of Engineering Kallooppara', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000062', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10480.jpeg', '10006', 1),
(10481, NULL, 'Prestige Institute Of Management And Research', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000063', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10481.jpeg', '10006', 1),
(10482, NULL, 'Sri Vani Degree And PG College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000064', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10482.jpeg', '10006', 1),
(10483, NULL, 'C T Group Of Institutions', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000065', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10483.jpeg', '10006', 1),
(10484, NULL, 'Bhagwan Mahavir College Of Pharmacy', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000066', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10484.jpeg', '10006', 1),
(10485, NULL, 'Government College Of Engineering', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000067', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10485.jpeg', '10006', 1),
(10486, NULL, 'Shivaji College, University Of Delhi', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000068', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10486.jpeg', '10006', 1),
(10487, NULL, 'Rishi MS Institute Of Engineering And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000069', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10487.jpeg', '10006', 1),
(10488, NULL, 'Roland Institute Of Pharmaceutical Science', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000070', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10488.jpeg', '10006', 1),
(10489, NULL, 'Graphic Era Hill University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000071', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10489.jpeg', '10006', 1),
(10490, NULL, 'IMI', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000072', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10490.png', '10006', 1),
(10491, NULL, 'Poornima University', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000073', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10491.jpeg', '10006', 1),
(10492, NULL, 'Kamala Nehru Institute Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000074', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10492.jpeg', '10006', 1),
(10493, NULL, 'N G Patel Polytechnic', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000075', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10493.png', '10006', 1),
(10494, NULL, 'Alwardas Polytechnic College', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000076', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10494.jpeg', '10006', 1),
(10495, NULL, 'Discovery Institute Of Polytechnic', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000077', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10495.jpeg', '10006', 1),
(10496, NULL, 'Jayamukhi College Of Pharmacy Narsampet', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000078', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10496.jpeg', '10006', 1),
(10497, NULL, 'Oriental College Of Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000079', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10497.jpeg', '10006', 1),
(10498, NULL, 'Tatyasaheb Kore Institute Of Engineering And Technology', '2021-06-05', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000', '#666', '#F9F9FF', '#edebea', '#000080', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10498.jpeg', '10006', 1),
(10499, NULL, 'Indian Institute of Management - Shillong (IIMS)', '2021-06-05', 'Content', 299, '4', 3, 1, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 0, 0, 1, 1, '#000000', '#272727', '#000000', '#dddddd', '#000000', 1.8, 0.5, 0.6, 0.4, 0.375, 0.55, 0.55, 0.45, 0.525, 1.25, 0.85, 0.8, 0.55, 0.65, 0.8, 'iims.jpg', '10499', 1),
(10500, NULL, 'Albertian Institute of Science And Technology - kerala', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10500.png', '10006', 1),
(10501, NULL, 'Amiraj College of Engineering & Technology - Gujrat', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10501.jpeg', '10006', 1),
(10502, NULL, 'Xavier Institute of Management &Amp; Entrepreneurship - Chennai', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10502.jpeg', '10006', 1),
(10504, NULL, 'Aryabhatta College of Engineering & Research Center Ajmer - Ajmer', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10504.jpeg', '10006', 1),
(10505, NULL, 'Annai Vailankani College of Engineering - Tamil Nadu', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10505.jpeg', '10006', 1),
(10506, NULL, 'Vimal Joythi Engineering College - kerala', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10506.jpeg', '10006', 1),
(10507, NULL, 'Vishwakarma Institute of Technology, Pune', '2021-12-12', 'Content', 299, '4', 2, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.5, 0.6, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10507.png', '10507', 1),
(10508, NULL, 'Bheemanna Khandre Institute of Technology, Bhalki - Karnataka', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10508.jpeg', '10006', 1),
(10509, NULL, 'Birla Institue of Technology, Mesra,Ranchi - Jharkhand', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10509.png', '10006', 1),
(10510, NULL, 'Brindavan College of Engineering - Karnataka', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10510.jpeg', '10006', 1),
(10511, NULL, 'Central Institute of Petrochemicals Engineering And Technology (Cipet) - Tamil Nadu', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10511.jpeg', '10006', 1),
(10512, NULL, 'Christ Institute of Management - West Bengal', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10512.jpeg', '10006', 1),
(10513, NULL, 'College of Engineering, Kottarakara - kerala', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10513.jpeg', '10006', 1),
(10514, NULL, 'Community Institute of Management Studies - Karnataka', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10514.png', '10006', 1),
(10515, NULL, 'Chhatrapati Shahu Institute of Business Education And Research - Maharashtra', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10515.png', '10006', 1),
(10516, NULL, 'Dhaanish Ahmed College of Engineering, Padappai, Tambaram - Tamil Nadu', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10516.png', '10006', 1),
(10517, NULL, 'Dr Ambedkar Institute of Management Research And Training Nagpur - Maharashtra', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10517.jpeg', '10006', 1),
(10518, NULL, 'Dr L H Hiranandani College of Pharmacy - Maharashtra', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10518.jpeg', '10006', 1),
(10519, NULL, 'Dr. Bhim Rao Ambedkar Polytechnic Collage Gwalior - Madhya Pradesh', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10519.png', '10006', 1),
(10520, NULL, 'Dr. D.Y.Patil Pratishthan\'S College of Engineering,Salokhenagar, Kolhapur - Maharashtra', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10520.jpeg', '10006', 1),
(10521, NULL, 'Hindu College of Pharmacy - Andhra Pradesh', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10521.jpeg', '10006', 1),
(10522, NULL, 'Dream Institute of Technology - West Bengal', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10522.jpeg', '10006', 1),
(10523, NULL, 'Fostiima Business School - Delhi', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10523.jpeg', '10006', 1),
(10524, NULL, 'Global Business School - West Bengal', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10524.jpeg', '10006', 1),
(10525, NULL, 'Government Woman Engineering College Ajmer - Ajmer', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10525.png', '10006', 1),
(10526, NULL, 'Harcourt Butler Technical University - Uttar Pradesh', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10526.png', '10006', 1),
(10527, NULL, 'Toch Institute of Science & Technology - Kerala', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10527.png', '10006', 1),
(10529, NULL, 'Hmr Institute of Technology And Management - Delhi', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10529.jpeg', '10006', 1),
(10530, NULL, 'IIT Roorkee - Uttarakhand', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10530.jpeg', '10006', 1),
(10531, NULL, 'Indira Gandhi Delhi Technical University For Women - Delhi', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10531.png', '10006', 1),
(10532, NULL, 'Jawaharlal Nehru Technological University College of Engineering Pulivendula - Andhra Pradesh', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10532.jpeg', '10006', 1),
(10533, NULL, 'Tatyasaheb Kore Institute of Engineering & Technology - Maharashtra', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10533.jpeg', '10006', 1),
(10534, NULL, 'Jowai Polytechnic Institute - Meghalya', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10534.jpeg', '10006', 1),
(10535, NULL, 'Kumaraguru College of Technology - Tamil Nadu', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10535.jpeg', '10006', 1),
(10536, NULL, 'L N Mishra Institute of Economic Development And Social Change,Patna - Bihar', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10536.jpeg', '10006', 1),
(10537, NULL, 'Lal Bahadur Shastri Institute of Technology And Management - Madhya Pradesh', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10537.jpeg', '10006', 1),
(10538, NULL, 'Laxmi Institute of Technology - Gujrat', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10538.jpeg', '10006', 1),
(10539, NULL, 'M S Ramaiah College of Arts Science And Commerce - Karnataka', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10539.jpeg', '10006', 1),
(10540, NULL, 'Marathwada Mitra Mandal\'s Polytechnic - Maharashtra', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10540.jpeg', '10006', 1),
(10541, NULL, 'Mysore College of Engineering And Management - Karnataka', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10541.jpeg', '10006', 1),
(10542, NULL, 'Nie Institute of Technology Mysore - Karnataka', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10542.jpeg', '10006', 1),
(10544, NULL, 'Potti Sri Ramulu Chalavadi Mallikarjuna Rao College of Engineering And Technology - Andhra Pradesh', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10544.jpeg', '10006', 1),
(10545, NULL, 'Pravara Rural College of Pharmacy - Maharashtra', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10545.jpeg', '10006', 1),
(10547, NULL, 'Raak College of Engineering And Technology - pondicherry', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10547.jpeg', '10006', 1),
(10548, NULL, 'Shri Vithal Education & Research Institute - Maharashtra', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10548.jpeg', '10006', 1),
(10549, NULL, 'Ramco Institute of Technology - Tamil Nadu', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10549.png', '10006', 1),
(10550, NULL, 'Ravindhra Engineering College For Women - Andhra Pradesh', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10550.jpeg', '10006', 1),
(10551, NULL, 'RTC Institue of Technology - Jharkhand', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10551.jpeg', '10006', 1),
(10552, NULL, 'P.S.R.Rengasamy College of Engineering For Women - Tamil Nadu', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10552.jpeg', '10006', 1),
(10553, NULL, 'RVR & JC College of Engineering - Andhra Pradesh', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10553.jpeg', '10006', 1),
(10554, NULL, 'S S Agrawal Institute of Engineering And Technology Navsari - Gujrat', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10554.jpeg', '10006', 1),
(10555, NULL, 'Sankalchand Patel College of Engineering Visnagar - Gujrat', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10555.jpeg', '10006', 1),
(10557, NULL, 'Shekawati Institute of Engineering And Technology - Rajasthan', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10557.jpeg', '10006', 1),
(10558, NULL, 'Shree Sant Gadgebaba College of Engineering And Technology - Maharashtra', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10558.jpeg', '10006', 1),
(10559, NULL, 'Shri Vishnu Engineering College For Women - Andhra Pradesh', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10559.jpeg', '10006', 1),
(10560, NULL, 'Siddhant Collage of Pharmacy - Maharashtra', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10560.png', '10006', 1),
(10561, NULL, 'Sree Chithira Thirunal College of Engineering - Kerala', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10561.jpeg', '10006', 1),
(10562, NULL, 'Srinivas Institute of Technology - Karnataka', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10562.jpeg', '10006', 1);
INSERT INTO `resource-profiledesign` (`designid`, `resource_profile_design_categorie_id`, `designName`, `lastUpdated`, `content`, `designPrice`, `category`, `format`, `isPrivate`, `sections`, `version`, `sectionOrder`, `sectionDefault`, `sectionColumn`, `isDownload`, `author`, `rating`, `downloadTimes`, `web`, `app`, `heading`, `color1`, `color2`, `color3`, `color4`, `basevalue`, `headText`, `timeLine`, `timeLineSmall`, `timeSubLine`, `headLine`, `subLine`, `baseLine`, `introLine`, `nameLine`, `nameHeight`, `introHeight`, `headLineHeight`, `headerLineHeight`, `GenLine`, `logo`, `template`, `status`) VALUES
(10563, NULL, 'SRM University - West Bengal', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10563.jpeg', '10006', 1),
(10564, NULL, 'St.Vincent Pallotti College of Engineering And Technology - Maharashtra', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10564.jpeg', '10006', 1),
(10565, NULL, 'Surana College PG Department - Karnataka', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10565.jpeg', '10006', 1),
(10566, NULL, 'Hindustan Institute of Technology - Chennai', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10566.png', '10006', 1),
(10567, NULL, 'Academy of Business Administration - Balasore', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10567.jpeg', '10006', 1),
(10568, NULL, 'Aisect - Jharkhand', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10568.png', '10006', 1),
(10569, NULL, 'All India Shri Shivaji Memorial Society\'S College of Engineering - Pune', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10569.jpeg', '10006', 1),
(10570, NULL, 'B.K.N. Govt. Polytechnic Narnaul - Jaipur', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10570.jpeg', '10006', 1),
(10571, NULL, 'Dewan V.S. Institute of Hotel Management & Technology - Meerut', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10571.jpeg', '10006', 1),
(10572, NULL, 'Dr.D.Y.Patil Institute of Management & Entrepreneur Development - Pune', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10572.png', '10006', 1),
(10573, NULL, 'Faculty of Engineering Technology & Reserach - Surat', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10573.jpeg', '10006', 1),
(10574, NULL, 'Ganpat University - B S Patel Polytechnic - Gujarat', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10574.jpeg', '10006', 1),
(10575, NULL, 'Goverment College of Engineering And Research Centre ... - Maharashtra', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10575.jpeg', '10006', 1),
(10576, NULL, 'Government College of Engineering - Karad Satara', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10576.jpeg', '10006', 1),
(10578, NULL, 'Government Polytechnic College - Shopian', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10578.jpeg', '10006', 1),
(10579, NULL, 'Government Polytechnic College - Meham', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10579.png', '10006', 1),
(10580, NULL, 'H R Institute of Engineering And Technology - Ghaziabad', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10580.jpeg', '10006', 1),
(10581, NULL, 'Government Polytechnic College - Uttawar', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10581.jpeg', '10006', 1),
(10582, NULL, 'S.L.N. COLLEGE of ENGINEERING - RAICHUR', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10582.jpeg', '10006', 1),
(10583, NULL, 'Indian Institute of Health Management Research - Jaipur', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10583.jpeg', '10006', 1),
(10584, NULL, 'Institute of Excellence In Management Science - Dharwad', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10584.jpeg', '10006', 1),
(10585, NULL, 'Jaya Group of Institutions - Chennai', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10585.jpeg', '10006', 1),
(10586, NULL, 'Kalpataru Institute of Technology - Tumkur', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10586.jpeg', '10006', 1),
(10587, NULL, 'Kanak Manjari Institute of Pharmaceutical Sciences - odisha', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10587.jpeg', '10006', 1),
(10588, NULL, 'Krishna Group of Institutions - Kanpur', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10588.jpeg', '10006', 1),
(10589, NULL, 'M-Dit Polytechnic College - kozhikode', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10589.png', '10006', 1),
(10590, NULL, 'Mahendra Institute of Management & Technical Studies - Bhubaneswar', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10590.jpeg', '10006', 1),
(10591, NULL, 'Maratha Mandal\'S Engineering College - Karnataka', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10591.jpeg', '10006', 1),
(10592, NULL, 'Met\'S Institute of Technology-Polytechnic - Nashik', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10592.png', '10006', 1),
(10593, NULL, 'Madanapalle Institute of Technology and Science - Gwalior', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10593.jpeg', '10006', 1),
(10594, NULL, 'P R Pote(Patil) Education & Welfare Trust\'S Group of Institutions College of Engineering & Managemen', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10594.jpeg', '10006', 1),
(10595, NULL, 'Pacific Academy of Higher Education And Research University - udaipur', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10595.jpeg', '10006', 1),
(10596, NULL, 'Panimalar Engineering College - Chennai', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10596.jpeg', '10006', 1),
(10597, NULL, 'Priyadarshini Bhagwati College of Engineering - Nagpur', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10597.jpeg', '10006', 1),
(10598, NULL, 'Proudhadevaraya Institute of Technology - Bellary', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10598.jpeg', '10006', 1),
(10599, NULL, 'R.K.S.D. College of Pharmacy - Kaithal', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10599.jpeg', '10006', 1),
(10601, NULL, 'Sanketika Vidya Parishad Engineering College - Vishakhapatnam', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10601.jpeg', '10006', 1),
(10602, NULL, 'Sengunthar College of Engineering - Namakkal', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10602.png', '10006', 1),
(10603, NULL, 'Sngist Group of Institutions - Ernakulam', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10603.jpeg', '10006', 1),
(10604, NULL, 'Swami Nithyananda Polytechnic College - kanhangadh', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10604.jpeg', '10006', 1),
(10605, NULL, 'Thanthai Roever Institute of Polytechnic College - Tamil Nadu', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10605.jpeg', '10006', 1),
(10606, NULL, 'Vadodara Institute of Engineering - Delhi', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10606.jpeg', '10006', 1),
(10608, NULL, 'Vishnu Institute of Pharmaceutical Education And Research - Telangana', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10608.png', '10006', 1),
(10609, NULL, 'Vivekanand Education Society\'S Institute of Management Studies And Research - Mumbai', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10609.jpeg', '10006', 1),
(10610, NULL, 'Xavier Institute of Engineering - Mumbai', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10610.png', '10006', 1),
(10612, NULL, 'Sandip Foundation - Nashik', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10612.jpeg', '10006', 1),
(10613, NULL, 'Jawaharlal Darda Institute of Engineering And Technology - Maharashtra', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10613.jpeg', '10006', 1),
(10614, NULL, 'Salem College of Engineering And Technology - Tamil Nadu', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10614.jpeg', '10006', 1),
(10615, NULL, 'Maharaja Agrasen Institute of Technology - Lucknow', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10615.png', '10006', 1),
(10616, NULL, 'Salem Survey Institute - Tamil Nadu', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10616.png', '10006', 1),
(10617, NULL, 'Government Polytechnic College(Girls) - Ahmedabad', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10617.jpeg', '10006', 1),
(10618, NULL, 'Central Institute of Business Management Research - Nagpur', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10618.jpeg', '10006', 1),
(10619, NULL, 'Meri College - West Bengal', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10619.jpeg', '10006', 1),
(10620, NULL, 'College of Management Studies - Delhi', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10620.jpeg', '10006', 1),
(10621, NULL, 'Dr. B.R. Ambedkar Polytechnic College - Puducherry', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10621.jpeg', '10006', 1),
(10622, NULL, 'Sri Ramakrishna Engineering College - Chennai', '2021-12-12', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 0, 1, 1, '#1d1b16', '#2B547E', '#F9F9FF', '#edebea', '', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '10622.jpeg', '10006', 1),
(10623, NULL, 'RITEE Group of Institutes', '2022-01-29', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51118\",\"51119\",\"51120\",\"51114\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 0, 323, 1, 1, '#7f7e7a', '#31343a', '#a9a9bc', '#c4c1c0', '', 1.8, 0.55, 0.6, 0.5, 0.375, 0.7, 0.5, 0.5, 0.525, 0.9, 0.85, 0.8, 0.8, 0.65, 0.8, 'ritthumbnaill.png', '10629', 1),
(10624, NULL, 'ITM University', '2022-06-01', '', 299, '4', 1, 1, '', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\",\"51101\",\"51121\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51107\",\"51108\",\"51109\",\"51106\",\"51122\",\"51110\",\"51112\",\"51114\",\"51116\",\"51117\",\"51125\",\"51113\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 4.7, 5, 1, 1, '#a55555', '#808080', '#765656', '#d1d1d1', '#e6e6e6', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.6, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.8, 'ITM.png', '10629', 1),
(10625, NULL, 'ITM Group of Institution', '2022-06-01', '', 299, '4', 1, 1, '', '[6,7]', '[[\"51111\",\"51118\",\"51119\",\"51120\",\"51101\",\"51121\"],[\"51115\",\"51099\",\"51104\",\"51105\",\"51107\",\"51108\",\"51109\",\"51106\",\"51122\",\"51110\",\"51112\",\"51114\",\"51116\",\"51117\",\"51125\",\"51113\",\"51123\"]]', '[]', 0, 1, 'cvDragon', 4.7, 0, 1, 1, '#a55555', '#808080', '#765656', '#d1d1d1', '#e6e6e6', 1.8, 0.85, 0.55, 0.45, 0.4, 0.65, 0.6, 0.5, 0.55, 1.2, 1, 0.9, 0.9, 0.55, 0.8, 'images.png', '10629', 1),
(10626, NULL, 'DELONIX SOCIETY’S BARAMATI COLLEGE OF PHARMACY, BARAMATI', '2022-04-25', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 14, 1, 1, '#342e67', '#333', '#ECECEC', '#edebea', '#000000', 1.8, 0.55, 0.6, 0.5, 0.375, 0.7, 0.65, 0.5, 0.525, 0.9, 0.85, 0.8, 0.8, 0.65, 0.8, '1627.jpg', '10629', 1),
(10627, NULL, 'INSTITUTE OF MANAGEMENT & RESEARCH, JALGAON', '2022-04-25', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 36, 1, 1, '#342e67', '#333', '#ECECEC', '#edebea', '#000000', 1.8, 0.55, 0.6, 0.5, 0.375, 0.7, 0.65, 0.5, 0.525, 0.9, 0.85, 0.8, 0.8, 0.65, 0.8, '1628.png', '10629', 1),
(10628, NULL, 'COLLEGE OF ENGINEERING AND MANAGEMENT, JALGAON', '2022-04-25', 'Content', 299, '4', 1, 1, '0', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 152, 1, 1, '#342e67', '#333', '#ECECEC', '#edebea', '#000000', 1.8, 0.55, 0.6, 0.5, 0.375, 0.7, 0.65, 0.5, 0.525, 0.9, 0.85, 0.8, 0.8, 0.65, 0.8, '1629.png', '10629', 1),
(10629, NULL, 'ICFAI Business School', '2022-06-02', '', 299, '4', 1, 1, '', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.8, 252, 1, 1, '#342e67', '#333', '#ECECEC', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '1630.png', '10629', 1),
(10630, NULL, 'Shri Gulabrao Deokar College of Pharmacy', '0000-00-00', '', 299, '4', 1, 1, '', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 414, 1, 1, '#342e67', '#333', '#ECECEC', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'gulabrao logo.png', '10629', 1),
(10631, NULL, 'H.V.P.M College of Engineering and Technology', '0000-00-00', '', 299, '4', 1, 1, '', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 0, 1, 1, 1, '#342e67', '#333', '#ECECEC', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'hvpm.png', '10629', 1),
(10632, NULL, 'Renaissance University', '2022-07-05', '', 299, '4', 1, 1, '', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, '', 0, 124, 1, 1, '#342e67', '#333', '#ECECEC', '#edebea', '#000000', 1.8, 0.55, 0.6, 0.5, 0.375, 0.7, 0.5, 0.5, 0.525, 0.9, 0.85, 0.8, 0.8, 0.65, 0.8, 'logo_ins.png', '10632', 1),
(10633, NULL, 'LM Thapar School of Management', '2022-06-02', '', 299, '4', 1, 1, '', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.8, 41, 1, 1, '#342e67', '#333', '#ECECEC', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, 'images.png', '10629', 1),
(10634, NULL, 'Maharishi Markandeshwar (DU), Ambala (Haryana)', '2022-06-02', '', 299, '4', 1, 1, '', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.8, 4, 1, 1, '#342e67', '#333', '#ECECEC', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '1635.png', '10629', 1),
(10635, NULL, 'Rajagiri College of Social Sciences - Kochi, Kerala', '2022-06-02', '', 299, '4', 1, 1, '', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.8, 220, 1, 1, '#342e67', '#333', '#ECECEC', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '1636.png', '10629', 1),
(10636, NULL, 'ICBM School Of Business Excellence - Telangana ', '2022-06-02', '', 299, '4', 1, 1, '', '[6,7]', '[[\"51103\",\"51115\",\"51099\",\"51104\",\"51105\",\"51108\",\"51109\",\"51106\",\"51107\",\"51110\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.8, 396, 1, 1, '#342e67', '#333', '#ECECEC', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.525, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '1637.png', '10629', 1),
(10637, NULL, 'Army Institute of Management Kolkata', '2024-06-02', '', 299, '4', 1, 1, '', '[6,7]', '[[\"51103\",\"51115\",\"51104\",\"51105\",\"51108\",\"51109\",\"51112\",\"51106\",\"51107\",\"51110\",\"51099\",\"51113\",\"51112\",\"51116\",\"51117\",\"51122\",\"51125\",\"51111\",\"51114\",\"51123\"]]', '', 0, 1, 'cvDragon', 4.8, 23062, 1, 1, '#342e67', '#333', '#ECECEC', '#edebea', '#000000', 1.8, 0.5, 0.6, 0.5, 0.375, 0.55, 0.55, 0.45, 0.45, 1, 0.85, 0.8, 0.55, 0.65, 0.8, '1638.png', '10637', 1),
(99999, NULL, 'cvDragon', '2021-06-05', 'Content', 299, '4', 1, 0, '0', '[6,7]', '', '', 0, 1, 'cvDragon', 4.9, 3433, 1, 0, '#000', '#666', '#F9F9FF', '#edebea', '', 1.8, 0.85, 0.75, 0.575, 0.375, 0.675, 0.6, 0.525, 0.6, 1.2, 0, 0.9, 0.65, 0.6, 0.8, '99999', '99999', 0);

-- --------------------------------------------------------

--
-- Table structure for table `resource-profilefont`
--

CREATE TABLE `resource-profilefont` (
  `fontid` int(11) NOT NULL,
  `fontTypeName` varchar(100) NOT NULL,
  `fontType` varchar(200) NOT NULL,
  `googleFontName` varchar(255) NOT NULL,
  `fontSize` int(11) NOT NULL,
  `appliedOn` text NOT NULL,
  `downloadTime` int(11) NOT NULL,
  `web` tinyint(4) NOT NULL,
  `app` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource-profilefont`
--

INSERT INTO `resource-profilefont` (`fontid`, `fontTypeName`, `fontType`, `googleFontName`, `fontSize`, `appliedOn`, `downloadTime`, `web`, `app`, `status`) VALUES
(1, 'Hind Vadodara', ':Hind', 'Hind', 2, '', 12986, 0, 1, 1),
(2, 'RobotoCondensed', ':RobotoCondensed', 'RobotoCondensed', 2, '', 12986, 0, 1, 1),
(3, 'Roboto', ':Roboto', 'roboto', 2, '', 12986, 0, 1, 1),
(4, 'Quicksand', ':quicksand', 'Quicksand', 2, '', 12986, 0, 1, 1),
(5, 'Tahoma', ':Tahoma', '', 2, '', 14050, 0, 0, 0),
(6, 'Lucida', ':Lucida Sans Unicode', '', 2, '', 13119, 0, 0, 0),
(7, 'Serif', ':MS Serif', '', 2, '', 13252, 0, 0, 0),
(8, 'Comic Sans', ':Comic Sans MS', '', 2, '', 13385, 0, 0, 0),
(9, 'Helvetica', ':helvetica', '', 2, '', 12587, 0, 0, 0),
(10, 'Palatino', ':Palatino Linotype', '', 2, '', 12986, 0, 0, 0),
(11, 'Redressed', ':Redressed', 'redressed', 2, '', 12986, 0, 1, 0),
(12, 'Lora', ':Lora', 'lora', 2, '', 12986, 0, 1, 1),
(13, 'Inconsolata', ':Inconsolata', 'inconsolata', 2, '', 12986, 0, 1, 0),
(14, 'Markazi', ':Markazi', 'markazi', 2, '', 12986, 0, 1, 1),
(15, 'PTSans', ':PTSans', 'ptsans', 2, '', 12986, 0, 1, 1),
(18, 'Cabin', ':cabin', 'Cabin', 2, '', 12986, 0, 1, 1),
(19, 'Lato', ':Lato', 'Lato', 2, '', 12986, 0, 1, 1),
(20, 'Merri', ':Merri', 'Merri', 2, '', 12986, 0, 1, 1),
(21, 'OverPass', ':OverPass', 'OverPass', 2, '', 12986, 0, 1, 1),
(22, 'Oxygen', ':Oxygen', 'Oxygen', 2, '', 12986, 0, 1, 1),
(23, 'PTMono', ':PTMono', 'PTMono', 2, '', 12986, 0, 1, 0),
(24, 'PTSansNarrow', ':PTSansNarrow', 'PTSansNarrow', 2, '', 12986, 0, 1, 1),
(27, 'UbuntuCondensed', ':UbuntuCondensed', 'UbuntuCondensed', 2, '', 12986, 0, 1, 1),
(28, 'Calibri', ':calibri', '', 2, '', 13917, 0, 0, 0),
(29, 'Verdana', ':Verdana', '', 2, '', 13651, 0, 0, 0),
(30, 'Arial', ':arial', '', 2, '', 13917, 0, 0, 0),
(31, 'Times Roman', ':timesnewroman', '', 2, '', 12853, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `resource-profilesetting`
--

CREATE TABLE `resource-profilesetting` (
  `settingid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `heading` varchar(10) NOT NULL,
  `color1` varchar(10) DEFAULT NULL,
  `color2` varchar(10) DEFAULT NULL,
  `color3` varchar(10) DEFAULT NULL,
  `color4` varchar(10) DEFAULT NULL,
  `downloadTimes` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource-profilesetting`
--

INSERT INTO `resource-profilesetting` (`settingid`, `name`, `content`, `heading`, `color1`, `color2`, `color3`, `color4`, `downloadTimes`, `status`) VALUES
(1, 'Black', 'Pure Black Colors', '#000000', '#333333', '#000000', '#e5e5e5', '#f1f1f1', 1124, 1),
(2, 'Theme 1', 'Check theme', '#283655', '#1E1F26', '#283655', '#D0E1F9', '#F9F9FF', 1300, 1),
(3, 'Theme 2', 'Check theme', '#C9A66B', '#662E1C', '#C9A66B', '#EBDCB2', '#F9F9FF', 1353, 1),
(4, 'Theme 5', 'Check theme', '#2F496E', '#2F496E', '#FE7A47', '#F4EADE', '#F9F9FF', 1512, 1),
(5, 'Default', 'This is the default color combination', '#F62A00', '#00293C', '#D55448', '#F1F3CE', '#F9F9FF', 1247, 0),
(7, 'Theme 8', 'Check theme', '#3A5199', '#2F2E33', '#3A5199', '#F0EFF0', '#F9F9FF', 1671, 0),
(8, 'Theme 7', 'Check theme', '#919636', '#524A3A', '#919636', '#FFFAE1', '#F9F9FF', 1618, 1),
(11, 'Theme 3', 'Check theme', '#F77604', '#333333', '#F77604', '#EEEEEE', '#F9F9FF', 1406, 1),
(12, 'Theme 11', 'Check theme', '#F62A00', '#00293C', '#F62A00', '#F1F3CE', '#F9F9FF', 1883, 1),
(14, 'Theme 13', 'Check theme', '#283655', '#1E1F26', '#283655', '#D0E1F9', '#F9F9FF', 1989, 0),
(15, 'Theme 14', 'Check theme', '#C9A66B', '#662E1C', '#C9A66B', '#EBDCB2', '#F9F9FF', 2042, 0),
(16, 'Theme 15', 'Check theme', '#F77604', '#231B12', '#F77604', '#EEEEEE', '#F9F9FF', 2095, 0),
(17, 'Theme 16', 'Check theme', '#C0B2B5', '#D72C16', '#C0B2B5', '#F0EFEA', '#F9F9FF', 2148, 0),
(19, 'Theme 18', 'Check theme', '#ED8C72', '#2F496E', '#ED8C72', '#F4EADE', '#F9F9FF', 2254, 1),
(20, 'Theme 19', 'Check theme', '#EDB83D', '#000C29', '#EDB83D', '#F8F5F2', '#F9F9FF', 2307, 1),
(21, 'Theme 20', 'Check theme', '#F9BA32', '#426E86', '#F9BA32', '#F8F1E5', '#F9F9FF', 2360, 1),
(22, 'Theme 21', 'Check theme', '#919636', '#524A3A', '#919636', '#FFFAE1', '#F9F9FF', 2413, 0),
(23, 'Theme 22', 'Check theme', '#3A5199', '#2F2E33', '#3A5199', '#F0EFF0', '#F9F9FF', 2466, 0),
(25, 'Theme 23', 'Check theme', '#D55448', '#896E69', '#D55448', '#F9F9FF', '#F9F9FF', 2572, 0),
(26, 'Theme 24', 'Check theme', '#5596e6', '#3d70b2', '#5596e6', '#E3C4A8', '#F9F9FF', 2360, 0),
(27, 'Theme 25', 'Check theme', '#b7714b', '#261e1e', '#b7714b', '#eec5b0', '#F9F9FF', 2413, 0),
(28, 'Theme 26', 'Check theme', '#0067b6', '#33393d', '#0067b6', '#9dc8e4', '#F9F9FF', 2360, 0),
(29, 'Theme 27', 'Check theme', '#c70039', '#900c3f', '#c70039', '#dee1ec', '#F9F9FF', 2413, 0),
(30, 'Theme 28', 'Check theme', '#ff8162', '#d34848', '#ff8162', '#dee1ec', '#F9F9FF', 2360, 0),
(31, 'Theme 29', 'Check theme', '#b55400', '#393e46', '#b55400', '#eeeeee', '#F9F9FF', 2413, 0),
(32, 'Theme 30', 'Check theme', '#c7004c', '#8f1537', '#c7004c', '#ffaaaa', '#F9F9FF', 2466, 0),
(33, 'Theme 31', 'Check theme', '#76b39d', '#05004e', '#76b39d', '#f9f8eb', '#F9F9FF', 2360, 0),
(34, 'Theme 32', 'Check theme', '#364e68', '#132238', '#364e68', '#ebf0f6', '#F9F9FF', 2413, 1),
(35, 'Theme 33', 'Check theme', '#207E82', '#1D5464', '#207E82', '#D8D860', '#F9F9FF', 2466, 0),
(36, 'Theme 34', 'Check theme', '#C5D86D', '#260C1A', '#C5D86D', '#FAF9F9', '#F9F9FF', 2572, 1),
(37, 'Theme 35', 'Check theme', '#DB5F29', '#7B3C3C', '#DB5F29', '#F0F0E4', '#F9F9FF', 2413, 1),
(38, 'Theme 36', 'Check theme', '#5C636E', '#393E46', '#5C636E', '#F7F7F7', '#F9F9FF', 2466, 1),
(39, 'Theme 37', 'Check theme', '#8AAE92', '#616161', '#8AAE92', '#F4F9F4', '#F9F9FF', 2572, 1),
(40, 'New Color Theme', 'Colors in the shades of green', '#0ec81a', '#1ce33d', '#36ec6d', '#0a522d', '#ffffff', 12, 0),
(41, 'Theme 40', '', '#342858', '#595959', '#342858', '#bfbfbf', '#f9f9ff', 2255, 1),
(43, 'Theme 42', '', '#AF9660', '#252E3E', '#AF9660', '#EAE9E6', '#f9f9ff', 2255, 1),
(44, 'Theme 43', '', '#D7E2E3', '#AFD1D7', '#D7E2E3', '#E9F6F7', '#f9f9ff', 2255, 0),
(45, 'Theme 44', '', '#B8B7B5', '#484848', '#B8B7B5', '#EAE9E6', '#f9f9ff', 2255, 1),
(46, 'Theme 45', '', '#000', '#095153\r\n', '#DAE3ED\r\n', '#E4EBED\r\n', '#f9f9ff', 2255, 1);

-- --------------------------------------------------------

--
-- Table structure for table `resource-publicdesign`
--

CREATE TABLE `resource-publicdesign` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `isPublic` int(11) NOT NULL,
  `publicDesignName` varchar(100) NOT NULL,
  `publicDesignDetails` text NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resource-redirect`
--

CREATE TABLE `resource-redirect` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `redirectDisplayIndex` varchar(100) NOT NULL,
  `redirectHeading` varchar(200) NOT NULL,
  `redirectDescription` varchar(200) NOT NULL,
  `redirectLink` varchar(200) NOT NULL,
  `redirectImage` varchar(200) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resource-section`
--

CREATE TABLE `resource-section` (
  `id` int(11) NOT NULL,
  `master_cv_sections_id` int(11) UNSIGNED NOT NULL,
  `main` tinyint(4) NOT NULL,
  `orderSection` int(11) NOT NULL,
  `defaultSection` tinyint(4) NOT NULL,
  `sectionContent` text NOT NULL,
  `sectionContentApp` text NOT NULL,
  `sectionInfoApp` text NOT NULL,
  `sectionDefaultContent` text NOT NULL,
  `sectionName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sectionLink` varchar(100) NOT NULL,
  `sectionTable` varchar(20) NOT NULL,
  `idColumnName` varchar(225) NOT NULL,
  `status` smallint(6) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `resource-section`
--

INSERT INTO `resource-section` (`id`, `master_cv_sections_id`, `main`, `orderSection`, `defaultSection`, `sectionContent`, `sectionContentApp`, `sectionInfoApp`, `sectionDefaultContent`, `sectionName`, `sectionLink`, `sectionTable`, `idColumnName`, `status`, `created_at`, `updated_at`) VALUES
(0, 1, 3, 0, 0, '', '', '', '', 'Free', '', 'designs', '0', 1, NULL, NULL),
(1, 2, 3, 0, 0, '', '', '', '', 'Attitude', '', 'designs', '1', 1, NULL, NULL),
(2, 1, 3, 0, 0, '', '', '', '', 'Elegance', '', 'designs', '2', 1, NULL, NULL),
(3, 1, 3, 0, 0, '', '', '', '', 'Creativity', '', 'designs', '3', 1, NULL, NULL),
(4, 1, 3, 0, 0, '', '', '', '', 'My Designs', '', 'designs', '4', 1, NULL, NULL),
(5, 1, 3, 0, 0, '', '', '', '', '👑 Pro', '', 'designs', '5', 1, NULL, NULL),
(1001, 1, 3, 0, 0, '', '', '', '', 'Videos', '', 'resources', '1', 1, NULL, NULL),
(1023, 1, 3, 0, 0, '', '', '', '', 'Full-Time', '', 'job', '23', 1, NULL, NULL),
(1024, 1, 3, 0, 0, '', '', '', '', 'Internships', '', 'job', '24', 1, NULL, NULL),
(1025, 1, 3, 0, 0, '', '', '', '', 'Part-Time', '', 'job', '25', 1, NULL, NULL),
(1026, 1, 3, 0, 0, '', '', '', '', 'Contractual', '', 'job', '26', 1, NULL, NULL),
(1027, 1, 3, 0, 0, '', '', '', '', 'Trainings', '', 'resources', '27', 1, NULL, NULL),
(1028, 1, 3, 0, 0, '', '', '', '', 'Webinars', '', 'resources', '28', 1, NULL, NULL),
(1029, 1, 3, 0, 0, '', '', '', '', 'Programs', '', 'job', '29', 1, NULL, NULL),
(1030, 1, 3, 0, 0, '', '', '', '', 'Work From Home', '', 'job', '30', 1, NULL, NULL),
(1031, 3, 3, 0, 0, '', '', '', '', 'Certifications', '', 'resources', '26', 1, NULL, NULL),
(1032, 1, 3, 0, 0, '', '', '', '', 'Workshops', '', 'resources', '32', 1, NULL, NULL),
(51099, 2, 1, 5, 0, '<div>Enter details about all the responsibilities you have handled and is worth mentioning in your resume.&nbsp;</div><div>&nbsp;</div>', '<div>Enter details about all the responsibilities you have handled and is worth mentioning in your resume.&nbsp;</div><div>&nbsp;</div>', 'Any positions you hold which is important to mention in your resume', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Position of Responsibility', 'position-responsibility', 'cv-POA', 'poaid', 1, NULL, NULL),
(51100, 1, 1, 1, 1, '<div>Your basic information like your nationality, marital status, etc needs to be entered in this section.</div>', '<div>Your basic information like your nationality, marital status, etc needs to be entered in this section.</div>', '', '<div style=\"color:#FFF;\">\r\nThis is not a default section. To add new data click on \"Add New Data\"\r\n</div>\r\n<div style=\"color:#FF0;\">\r\nTo know more about the section, click on the \"Know More\" button\r\n</div>\r\n', 'Basic Info', 'basic-info', 'cv-basic-info', 'basicinfoid', 1, NULL, NULL),
(51101, 1, 1, 2, 1, '<div>Enter your contact details in this section.&nbsp;</div><div><br />You can leave the &quot;Full Address&quot; section blank if you do not wish to share your complete address.</div><div>&nbsp;</div><div>Disclosing your contact number and email id is however mandatory.&nbsp;</div>', '<div>Enter your contact details in this section.&nbsp;</div><div><br />You can leave the &quot;Full Address&quot; section blank if you do not wish to share your complete address.</div><div>&nbsp;</div><div>Disclosing your contact number and email id is however mandatory.&nbsp;</div>', '', '<div style=\"color:#FFF;\">\r\nThis is not a default section. To add new data click on \"Add New Data\"\r\n</div>\r\n<div style=\"color:#FF0;\">\r\nTo know more about the section, click on the \"Know More\" button\r\n</div>\r\n', 'Contact Details', 'contact-info', 'cv-contact', 'contactid', 1, NULL, NULL),
(51102, 1, 1, 3, 1, '<div>Upload a High Resolution &quot;Single&quot; Professional photograph of yours which will be the&nbsp;profile image of&nbsp;your resume.&nbsp;</div><div>&nbsp;</div><div>Remember your photograph will be the first thing your prospective employer will view.</div>', '<div>Upload a High Resolution &quot;Single&quot; Professional photograph of yours which will be the&nbsp;profile image of&nbsp;your resume.&nbsp;</div><div>&nbsp;</div><div>Remember your photograph will be the first thing your prospective employer will view.</div>', 'Tap the \"Set Image\" button to set your Profile Image', '<div style=\"color:#FFF;\">\r\nThis is not a default section. To add new data click on \"Add New Data\"\r\n</div>\r\n<div style=\"color:#FF0;\">\r\nTo know more about the section, click on the \"Know More\" button\r\n</div>\r\n', 'Profile Image', 'image', 'cv-images', 'imageid', 1, NULL, NULL),
(51103, 1, 1, 4, 1, '<div>Enter a brief description about your career history and the most valuable skills and experience you have to offer.</div><div><br />It is the first thing a potential employer reads about you, so you can sell yourself quickly by writing a very impressive description.</div><div><br />The summary should be in a paragraph not&nbsp;having&nbsp;more than 3-5 compact sentences.</div>', '<div>Enter a brief description about your career history and the most valuable skills and experience you have to offer.</div><div><br />It is the first thing a potential employer reads about you, so you can sell yourself quickly by writing a very impressive description.</div><div><br />The summary should be in a paragraph not&nbsp;having&nbsp;more than 3-5 compact sentences.</div>', 'Career Objective Statement is a Pitch to showcase yourself, Take the help of Key Phrases to view samples', '<div style=\"color:#FFF;\">\r\nThis is not a default section. To add new data click on \"Add New Data\"\r\n</div>\r\n<div style=\"color:#FF0;\">\r\nTo know more about the section, click on the \"Know More\" button\r\n</div>\r\n', 'Career Summary', 'introduction', 'cv-introduction', 'introid', 1, NULL, NULL),
(51104, 2, 1, 6, 0, '<div>Enter your work experince history in this section. This is the most important section of your resume because based on it, your prospective employer will decide&nbsp;upon your candidature.&nbsp;</div><div>&nbsp;</div><div>While writing a brief description about your roles and responsibilities, be accurate, concise and use minimum words.&nbsp;</div><div><br />For example: Rather than &quot;I was responsible to work on a daily basis with the company&#39;s most important clients and helped them solve problems&quot;, write it as &quot;Worked with clients to solve problems&quot;.<br /><br />In this section do not enter details about the Projects you have undertaken in your organization. A seperate section is available to add deatils on&nbsp;Projects.</div>', '<div>Enter your work experince history in this section. This is the most important section of your resume because based on it, your prospective employer will decide&nbsp;upon your candidature.&nbsp;</div><div>&nbsp;</div><div>While writing a brief description about your roles and responsibilities, be accurate, concise and use minimum words.&nbsp;</div><div><br />For example: Rather than &quot;I was responsible to work on a daily basis with the company&#39;s most important clients and helped them solve problems&quot;, write it as &quot;Worked with clients to solve problems&quot;.<br /><br />In this section do not enter details about the Projects you have undertaken in your organization. A seperate section is available to add deatils on&nbsp;Projects.</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Work Experience', 'work-details', 'cv-work', 'workid', 1, NULL, NULL),
(51105, 2, 1, 7, 0, '<div>Enter details about all the projects you have undertaken in your career&nbsp;which you think are worth mentioning in your resume.&nbsp;</div><div><br />Remember, details entered in this section shall be a part of the&nbsp;&#39;Work Experience&#39;&nbsp;section of your resume.</div>', '<div>Enter details about all the projects you have undertaken in your career&nbsp;which you think are worth mentioning in your resume.&nbsp;</div><div><br />Remember, details entered in this section shall be a part of the&nbsp;&#39;Work Experience&#39;&nbsp;section of your resume.</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Work Projects', 'projects', 'cv-project', 'projectid', 1, NULL, NULL),
(51106, 2, 1, 8, 0, '<div>If you have undergone any internship program, summer program or articleship while pursuing any degree or course, then enter relevant details in this section.&nbsp;</div>', '<div>If you have undergone any internship program, summer program or articleship while pursuing any degree or course, then enter relevant details in this section.&nbsp;</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Internships', 'internships', 'cv-internship', 'internshipid', 1, NULL, NULL),
(51107, 5, 1, 16, 0, '<div>In this section, showcase your training skills by entering details about the&nbsp;trainings that you have conducted. Details about trainings conducted both independently and in the course of your job should be disclosed here.&nbsp;</div><div><br />By giving a brief description about the trainings you have conducted, you can let your prospective employer know about your areas of expertise, your capability in handling a team and your leadership skills.</div>', '<div>In this section, showcase your training skills by entering details about the&nbsp;trainings that you have conducted. Details about trainings conducted both independently and in the course of your job should be disclosed here.&nbsp;</div><div><br />By giving a brief description about the trainings you have conducted, you can let your prospective employer know about your areas of expertise, your capability in handling a team and your leadership skills.</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Trainings Conducted', 'training-conducted', 'cv-trainings', 'trainingid', 1, NULL, NULL),
(51108, 1, 1, 9, 0, '<div>If you hold any professional qualification like &quot;MBA&quot;, &quot;Chartered Accountant&quot;, etc, enter details in this section.</div><div><br />Please do not enter details about any certification or short term courses here, A&nbsp;seperate section is available for disclosing such courses.</div>', '<div>If you hold any professional qualification like &quot;MBA&quot;, &quot;Chartered Accountant&quot;, etc, enter details in this section.</div><div><br />Please do not enter details about any certification or short term courses here, A&nbsp;seperate section is available for disclosing such courses.</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Professional Qualifications', 'professional-details', 'cv-professional', 'professionalid', 1, NULL, NULL),
(51109, 3, 1, 10, 1, '<div>Enter details about your Secondary, Higher Secondary and Graduation in these sub sections. These are compulsory sections.</div>', '<div>Enter details about your Secondary, Higher Secondary and Graduation in these sub sections. These are compulsory sections.</div>', 'To add more Education Information, Use Professional Qualification Section', '<div style=\"color:#FFF;\">\r\nThis is not a default section. To add new data click on \"Add New Data\"\r\n</div>\r\n<div style=\"color:#FF0;\">\r\nTo know more about the section, click on the \"Know More\" button\r\n</div>\r\n', 'Educational Background', 'educational-details', 'cv-education', 'eduid', 1, NULL, NULL),
(51110, 1, 1, 11, 0, '<div>If you have undertaken any certification courses like &quot;Certificate in Digital Marketing&quot; , &quot;PC Assembly and Troubleshooting Training&quot;, &quot;Advance Certificate in Management&quot;, etc., enter details in this section</div>', '<div>If you have undertaken any certification courses like &quot;Certificate in Digital Marketing&quot; , &quot;PC Assembly and Troubleshooting Training&quot;, &quot;Advance Certificate in Management&quot;, etc., enter details in this section</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Certificates', 'certificates', 'cv-certification', 'certificateid', 1, NULL, NULL),
(51111, 4, 1, 17, 0, '<div>Showcase you technical skills by entering details in this section.&nbsp;<br />For example: You have &quot;working knowledge about Java&quot; or &quot;expert knowledge about MS Office.&quot;</div>', '<div>Showcase you technical skills by entering details in this section.&nbsp;<br />For example: You have &quot;working knowledge about Java&quot; or &quot;expert knowledge about MS Office.&quot;</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Technical Skills', 'technical-knowledge', 'cv-technical', 'technicalid', 1, NULL, NULL),
(51112, 5, 1, 23, 0, '<div>Enter details about your writings that has&nbsp;been published in any journal, magazine, newspaper or has&nbsp;been included in any conference proceedings.</div>', '<div>Enter details about your writings that has&nbsp;been published in any journal, magazine, newspaper or has&nbsp;been included in any conference proceedings.</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Publications', 'publications', 'cv-publications', 'publishid', 1, NULL, NULL),
(51113, 5, 1, 24, 0, '<div><span>Enter details about patent that have been granted to you by government authority.&nbsp;</span><br /><span>Invention for which patents have been granted can be a product or a process that provides, in general, a new way of doing something or offers a new technical solution to a problem</span></div>', '<div><span>Enter details about patent that have been granted to you by government authority.&nbsp;</span><br /><span>Invention for which patents have been granted can be a product or a process that provides, in general, a new way of doing something or offers a new technical solution to a problem</span></div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Patents', 'patents', 'cv-patent', 'patentid', 1, NULL, NULL),
(51114, 4, 1, 13, 0, '<div>Do not mention your job responsibilities under this section, they don&#39;t fall under the category of achievements.&nbsp;&nbsp;</div><div><br />Achievements are things you did and which&nbsp;had a lasting impact for your company or client. It is a result that you personally bring about while fulfilling your roles and responsibilities.&nbsp;</div><div><br />Your achievements are unique to your experience and tells the employer that you can deliver.&nbsp;<br /><br />Do not add any National/State level awards received as we have a seperate section for that.</div>', '<div>Do not mention your job responsibilities under this section, they don&#39;t fall under the category of achievements.&nbsp;&nbsp;</div><div><br />Achievements are things you did and which&nbsp;had a lasting impact for your company or client. It is a result that you personally bring about while fulfilling your roles and responsibilities.&nbsp;</div><div><br />Your achievements are unique to your experience and tells the employer that you can deliver.&nbsp;<br /><br />Do not add any National/State level awards received as we have a seperate section for that.</div>', 'Define your achievements properly, add a Heading and a short description', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Achievements', 'achievements', 'cv-achievements', 'achieveid', 1, NULL, NULL),
(51115, 1, 1, 14, 0, '<div>If you have received any scholarships or honors and awards in your education or work &nbsp;life, enter details in this section.</div>', '<div>If you have received any scholarships or honors and awards in your education or work &nbsp;life, enter details in this section.</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Honors & Awards', 'honors-awards', 'cv-awards', 'awardid', 1, NULL, NULL),
(51116, 5, 1, 21, 0, '<div>In this section enter details about your associations with professional organisations.&nbsp;<br /><br />For example: &quot;You are a member of The Institute of Company Secretaries of India&quot;, &quot;You are the Secretary of Rotary Wing Society of India&quot;, etc.</div>', '<div>In this section enter details about your associations with professional organisations.&nbsp;<br /><br />For example: &quot;You are a member of The Institute of Company Secretaries of India&quot;, &quot;You are the Secretary of Rotary Wing Society of India&quot;, etc.</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Associations', 'associations', 'cv-association', 'associationid', 1, NULL, NULL),
(51117, 2, 1, 22, 0, '<div>If you are associated with any NGOs and have volunteered in social activities, enter relevant details here.&nbsp;</div>', '<div>If you are associated with any NGOs and have volunteered in social activities, enter relevant details here.&nbsp;</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Volunteer Experience', 'volunteer-experience', 'cv-volunteer', 'volunteerid', 1, NULL, NULL),
(51118, 4, 1, 18, 0, '<div>When completing this section, consider entering skills that has been&nbsp;asked for, by your prospective employer for the job position you&#39;re seeking. Employers quickly scan resumes. So,&nbsp;long lists are not likely to be read.&nbsp;<br />Hence a short, targeted skills&#39; list will be more effective than a&nbsp;long and overwhelming one.</div>', '<div>When completing this section, consider entering skills that has been&nbsp;asked for, by your prospective employer for the job position you&#39;re seeking. Employers quickly scan resumes. So,&nbsp;long lists are not likely to be read.&nbsp;<br />Hence a short, targeted skills&#39; list will be more effective than a&nbsp;long and overwhelming one.</div>', 'Add one skill at a time', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Soft Skills', 'skills', 'cv-skills', 'skillid', 1, NULL, NULL),
(51119, 4, 1, 19, 0, '<div>Hobbies and interests you put on your resume, say something specific about you to your employers. Therefore,&nbsp;try to mention those interests and hobbies that matches the requirement of the job role.<br /><br />For Example: If you are applying for a trainer&#39;s profile, then mentioning hobbies like, blogging and web browsing might seem irrelevant or insignificant.</div>', '<div>Hobbies and interests you put on your resume, say something specific about you to your employers. Therefore,&nbsp;try to mention those interests and hobbies that matches the requirement of the job role.<br /><br />For Example: If you are applying for a trainer&#39;s profile, then mentioning hobbies like, blogging and web browsing might seem irrelevant or insignificant.</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Interests', 'interests', 'cv-interests', 'interestid', 1, NULL, NULL),
(51120, 4, 1, 20, 0, '<div>Mention here, the languages you can speak, read or write. There is also an option of mentioning a particular language which you can only speak and cannot write. You see, The&nbsp;More, the merrier.</div>', '<div>Mention here, the languages you can speak, read or write. There is also an option of mentioning a particular language which you can only speak and cannot write. You see, The&nbsp;More, the merrier.</div>', 'Add One Language at a time', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Spoken Languages', 'spoken-language', 'cv-languages', 'langid', 1, NULL, NULL),
(51121, 5, 1, 27, 1, '<div>Enter details about your job preference, notice period, recomendations, etc in this section.&nbsp;<br />In case you do not want to add a particular information in your Resume, use the &quot;skip&quot; button to move to the next section.</div>', '<div>Enter details about your job preference, notice period, recomendations, etc in this section.&nbsp;<br />In case you do not want to add a particular information in your Resume, use the &quot;skip&quot; button to move to the next section.</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Preferences', 'preferences', 'cv-preference', 'prefid', 1, NULL, NULL),
(51122, 3, 1, 12, 0, '<div>Enter details about all the projects you have researched and presented in your Instititute&nbsp;which you think are worth mentioning in your resume.&nbsp;</div><div>&nbsp;</div><div>This section may be irrelavant for those having more than 2&nbsp;years of work experience.</div>', '<div>Enter details about all the projects you have researched and presented in your Instititute&nbsp;which you think are worth mentioning in your resume.&nbsp;</div><div>&nbsp;</div><div>This section may be irrelavant for those having more than 2&nbsp;years of work experience.</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Academic Projects', 'academic-projects', 'cv-academic-projects', 'academicid', 1, NULL, NULL),
(51123, 3, 1, 15, 0, '<div>Co-curricular refers to extra activities, programs, and learning experiences other than the educational activities.&nbsp;</div>', '<div>Co-curricular refers to extra activities, programs, and learning experiences other than the educational activities.&nbsp;</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Co-Curricular Activities', 'co-curricular-activities', 'cv-co-curricular-act', 'activityid', 1, NULL, NULL),
(51124, 1, 2, 0, 0, '<div>Job seekers often wonder if it is essential to have a cover letter with their resume. The answer is YES! Just like&nbsp;your resume, you should have a customized version of cover letter as well that talks about&nbsp;your experiences and skills. This will benefit the particular company that you want to work for.&nbsp;<br />Remember, you are promoting yourself through the cover letter and resume.&nbsp;<br />Follow the subsequent steps and get your cover letter drafted in just a few clicks!&nbsp;</div>', '<div>Job seekers often wonder if it is essential to have a cover letter with their resume. The answer is YES! Just like&nbsp;your resume, you should have a customized version of cover letter as well that talks about&nbsp;your experiences and skills. This will benefit the particular company that you want to work for.&nbsp;<br />Remember, you are promoting yourself through the cover letter and resume.&nbsp;<br />Follow the subsequent steps and get your cover letter drafted in just a few clicks!&nbsp;</div>', '', '', 'Cover Letter', 'coverLetter', '', '0', 1, NULL, NULL),
(51125, 5, 1, 25, 0, '<div>Presentation refers to activities, PPTs, and seminars, that&nbsp;students have presented in their college.</div><div>&nbsp;</div>', '<div>Presentation refers to activities, PPTs, and seminars, that&nbsp;students have presented in their college.</div><div>&nbsp;</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'References', 'presentations', 'cv-presentations', 'activityid', 1, NULL, NULL),
(51126, 1, 1, 26, 0, '<div>Add a section anywhere in your resume.</div>', '<div>Add a section anywhere in your resume.</div>', '', '<img src=\"https://cvdragon.com/public/img/app/defaultData.png\">', 'Add a Section', 'add-section', 'cv-add-section', 'addid', 1, NULL, NULL),
(51200, 1, 2, 0, 0, '', '', '', '', 'Dashboard', 'dashboard', '', '0', 1, NULL, NULL),
(51201, 1, 2, 0, 0, '<div>You can create multiple profiles for applying to multiple companies. So, you can name your profiles in a way which is identifiable to you.&nbsp;</div><div>This won&#39;t reflect in your resume.&nbsp;&nbsp;</div>', '<div>You can create multiple profiles for applying to multiple companies. So, you can name your profiles in a way which is identifiable to you.&nbsp;</div><div>This won&#39;t reflect in your resume.&nbsp;&nbsp;</div>', '', '', 'My Profiles', 'myProfiles', '', '0', 1, NULL, NULL),
(51202, 1, 2, 0, 0, '', '', '', '', 'My Sections', 'mySections', '', '0', 1, NULL, NULL),
(51203, 1, 2, 0, 0, '', '', '', '', 'Add Sections', 'addSections', '', '0', 1, NULL, NULL),
(51204, 1, 2, 0, 0, '', '', '', '', 'Profile', 'profile', '', '0', 1, NULL, NULL),
(51205, 1, 2, 0, 0, '', '', '', '', 'Add Profile Sections', 'addProfileSections', '', '0', 1, NULL, NULL),
(51206, 1, 2, 0, 0, '', '', '', '', 'profileSetting', 'profileSetting', '', '0', 1, NULL, NULL),
(51207, 1, 2, 0, 0, '', '', '', '', 'publicURL', 'publicProfile', '', '0', 1, NULL, NULL),
(51208, 1, 2, 0, 0, '', '', '', '', 'Profile Design', 'profileDesign', '', '0', 1, NULL, NULL),
(51209, 1, 2, 0, 0, '', '', '', '', 'View Designs', 'viewDesigns', '', '0', 1, NULL, NULL),
(51210, 1, 2, 0, 0, '', '', '', '', 'Notifications', 'notification', '', '0', 1, NULL, NULL),
(51211, 1, 2, 0, 0, '', '', '', '', 'Settings', 'settings', '', '0', 1, NULL, NULL),
(51212, 1, 2, 0, 0, '', '', '', '', 'Resume', 'Resume', '', '0', 1, NULL, NULL),
(51213, 1, 3, 0, 0, '', '', '', '', 'social links', 'cv_social_links', 'cv_social_links', 'socialid', 1, '2025-05-19 07:31:11', '2025-05-19 07:31:11');

-- --------------------------------------------------------

--
-- Table structure for table `resource-securitykeys`
--

CREATE TABLE `resource-securitykeys` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `assign_id` int(10) UNSIGNED NOT NULL,
  `assign_to` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `security_voucher` bigint(20) UNSIGNED NOT NULL,
  `security_key` varchar(19) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `design_id` int(10) UNSIGNED NOT NULL,
  `time_period` int(10) UNSIGNED NOT NULL,
  `message` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `original_id` bigint(20) UNSIGNED NOT NULL,
  `note` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resource_carrers`
--

CREATE TABLE `resource_carrers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1 = Active, 0 = Inactive',
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource_carrers`
--

INSERT INTO `resource_carrers` (`id`, `title`, `status`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Student', 1, NULL, '2025-05-16 07:46:31', '2025-05-16 07:46:31'),
(2, 'Fresher', 1, NULL, '2025-05-16 07:46:31', '2025-05-16 07:46:31'),
(3, 'Experience', 1, NULL, '2025-05-16 07:47:21', '2025-05-16 07:47:21'),
(4, 'Women Restarting Career', 1, NULL, '2025-05-16 07:47:21', '2025-05-16 07:47:21'),
(5, 'Prefer Not To say', 1, NULL, '2025-05-16 07:47:21', '2025-05-16 07:47:21');

-- --------------------------------------------------------

--
-- Table structure for table `resource_profile_design_categories`
--

CREATE TABLE `resource_profile_design_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `icon` varchar(200) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1 = Active, 0 = Inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource_profile_design_categories`
--

INSERT INTO `resource_profile_design_categories` (`id`, `title`, `slug`, `icon`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Institude', 'institude', '', 1, '2025-05-17 07:04:21', '2025-05-17 07:04:21'),
(2, 'Standerd', 'standerd', '', 1, '2025-05-17 07:04:21', '2025-05-17 07:04:21');

-- --------------------------------------------------------

--
-- Table structure for table `section_questions`
--

CREATE TABLE `section_questions` (
  `sectionquestionid` int(10) UNSIGNED NOT NULL,
  `resource_section_id` int(11) NOT NULL,
  `question_column_name` varchar(255) DEFAULT NULL,
  `question` text DEFAULT NULL,
  `question_type` enum('text','select','radio','checkbox','date','file') NOT NULL,
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Options for select/radio/checkbox types',
  `dependent_on_question_id` int(11) DEFAULT NULL COMMENT 'References another question in this table',
  `triggering_answer` tinyint(1) DEFAULT 0 COMMENT '1= yes, 0= no',
  `required` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = yes, 0 = no',
  `ordering` tinyint(4) DEFAULT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Status: 1 = active, 0 = inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `section_questions`
--

INSERT INTO `section_questions` (`sectionquestionid`, `resource_section_id`, `question_column_name`, `question`, `question_type`, `options`, `dependent_on_question_id`, `triggering_answer`, `required`, `ordering`, `status`, `created_at`, `updated_at`) VALUES
(1, 51100, 'cvFullName', 'Your Name', 'text', NULL, NULL, NULL, 1, 1, 1, '2025-05-17 09:50:08', '2025-05-17 09:50:08'),
(2, 51100, 'nationality', 'Nationality', 'text', NULL, NULL, NULL, 1, 2, 1, '2025-05-17 09:50:08', '2025-05-17 09:50:08'),
(9, 51100, NULL, 'Show Gender', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]\n', NULL, NULL, 1, 3, 1, '2025-05-19 05:36:09', '2025-05-19 05:36:09'),
(10, 51100, 'gender', 'Gender', 'radio', '[\r\n    { \"label\": \"Male\", \"value\": \"M\" },\r\n    { \"label\": \"Female\", \"value\": \"F\" }\r\n]', 9, 1, 1, 4, 1, '2025-05-19 05:37:06', '2025-05-19 05:37:06'),
(11, 51100, '', 'Show Age', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]', NULL, NULL, 1, 5, 1, '2025-05-19 05:38:44', '2025-05-19 05:38:44'),
(12, 51100, 'dateBirth', 'Date of Birth', 'date', NULL, NULL, NULL, 1, 6, 1, '2025-05-19 05:38:44', '2025-05-19 05:38:44'),
(13, 51100, NULL, 'Show Martial Status', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]', NULL, NULL, 1, 7, 1, '2025-05-19 05:39:57', '2025-05-19 05:39:57'),
(14, 51100, 'maritalStatus', 'Martial Status', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]', 13, 1, 1, 8, 1, '2025-05-19 05:39:57', '2025-05-19 05:39:57'),
(15, 51101, 'emailAddress', 'Email Address', 'text', NULL, NULL, NULL, 1, 9, 1, '2025-05-19 05:47:20', '2025-05-19 05:47:20'),
(16, 51101, 'phoneNumber', 'Mobile Number', 'text', NULL, NULL, NULL, 1, 10, 1, '2025-05-19 05:47:20', '2025-05-19 05:47:20'),
(17, 51101, 'location', 'Location', 'text', NULL, NULL, NULL, 1, 11, 1, '2025-05-19 05:48:50', '2025-05-19 05:48:50'),
(18, 51101, 'fullAddress', 'Address', 'text', NULL, NULL, NULL, 1, 12, 1, '2025-05-19 05:48:50', '2025-05-19 05:48:50'),
(19, 51102, 'image', 'Profile Image', 'file', NULL, NULL, NULL, 1, 13, 1, '2025-05-19 05:53:46', '2025-05-19 05:53:46'),
(20, 51103, 'title', 'Current Profile', 'text', NULL, NULL, NULL, 1, 14, 1, '2025-05-19 05:54:55', '2025-05-19 05:54:55'),
(21, 51103, 'introduction', 'Introduction', 'text', NULL, NULL, NULL, 1, 15, 1, '2025-05-19 05:54:55', '2025-05-19 05:54:55'),
(22, 51104, 'organization', 'Organization', 'text', NULL, NULL, NULL, 1, 16, 1, '2025-05-19 05:58:52', '2025-05-19 05:58:52'),
(23, 51104, 'designation', 'Designation', 'text', NULL, NULL, NULL, 1, 17, 1, '2025-05-19 05:58:52', '2025-05-19 05:58:52'),
(24, 51104, 'location', 'Location', 'text', NULL, NULL, NULL, 1, 18, 1, '2025-05-19 05:59:59', '2025-05-19 05:59:59'),
(25, 51104, NULL, 'Job Description', 'text', NULL, NULL, NULL, 1, 19, 1, '2025-05-19 05:59:59', '2025-05-19 05:59:59'),
(26, 51104, 'dateJoined', 'Date of Joining', 'date', NULL, NULL, NULL, 1, 20, 1, '2025-05-19 05:59:59', '2025-05-19 05:59:59'),
(27, 51104, 'currentWorking', 'Currently Working', 'text', NULL, NULL, NULL, 1, 21, 1, '2025-05-19 05:59:59', '2025-05-19 05:59:59'),
(28, 51106, NULL, 'Organization', 'text', NULL, NULL, NULL, 1, 22, 1, '2025-05-19 06:02:23', '2025-05-19 06:02:23'),
(29, 51106, NULL, 'Project Name', 'text', NULL, NULL, NULL, 1, 23, 1, '2025-05-19 06:02:56', '2025-05-19 06:02:56'),
(30, 51106, NULL, 'Designation', 'text', NULL, NULL, NULL, 1, 24, 1, '2025-05-19 06:02:56', '2025-05-19 06:02:56'),
(31, 51106, NULL, 'Location', 'text', NULL, NULL, NULL, 1, 25, 1, '2025-05-19 06:03:39', '2025-05-19 06:03:39'),
(32, 51106, NULL, 'Duration', 'text', NULL, NULL, NULL, 1, 26, 1, '2025-05-19 06:03:39', '2025-05-19 06:03:39'),
(33, 51106, NULL, 'Description', 'text', NULL, NULL, NULL, 1, 27, 1, '2025-05-19 06:03:39', '2025-05-19 06:03:39'),
(34, 51105, 'title', 'Project Title', 'text', NULL, NULL, NULL, 1, 28, 1, '2025-05-19 06:06:03', '2025-05-19 06:06:03'),
(35, 51105, 'designation', 'Designation', 'text', NULL, NULL, NULL, 1, 29, 1, '2025-05-19 06:06:03', '2025-05-19 06:06:03'),
(36, 51105, 'organization', 'Organization', 'text', NULL, NULL, NULL, 1, 30, 1, '2025-05-19 06:06:40', '2025-05-19 06:06:40'),
(37, 51105, 'duration', 'Duration', 'text', NULL, NULL, NULL, 1, 31, 1, '2025-05-19 06:06:40', '2025-05-19 06:06:40'),
(38, 51105, 'location', 'Location', 'text', NULL, NULL, NULL, 1, 32, 1, '2025-05-19 06:06:40', '2025-05-19 06:06:40'),
(39, 51105, 'description', 'Description', 'text', NULL, NULL, NULL, 1, 33, 1, '2025-05-19 06:06:40', '2025-05-19 06:06:40'),
(40, 51117, NULL, 'Associated Organization', 'text', NULL, NULL, NULL, 1, 34, 1, '2025-05-19 06:09:33', '2025-05-19 06:09:33'),
(41, 51117, NULL, 'Cause', 'text', NULL, NULL, NULL, 1, 35, 1, '2025-05-19 06:09:33', '2025-05-19 06:09:33'),
(42, 51117, NULL, 'Role', 'text', NULL, NULL, NULL, 1, 36, 1, '2025-05-19 06:10:12', '2025-05-19 06:10:12'),
(43, 51117, NULL, 'Description', 'text', NULL, NULL, NULL, 1, 37, 1, '2025-05-19 06:10:12', '2025-05-19 06:10:12'),
(44, 51117, NULL, 'Date of Joining', 'date', NULL, NULL, NULL, 1, 38, 1, '2025-05-19 06:10:12', '2025-05-19 06:10:12'),
(45, 51117, NULL, 'Date of Leaving', 'date', NULL, NULL, NULL, 1, 39, 1, '2025-05-19 06:10:12', '2025-05-19 06:10:12'),
(46, 51117, NULL, 'Currently Associated', 'text', NULL, NULL, NULL, 1, 40, 1, '2025-05-19 06:10:12', '2025-05-19 06:10:12'),
(47, 51099, 'title', 'Designation', 'text', NULL, NULL, NULL, 1, 41, 1, '2025-05-19 06:13:25', '2025-05-19 06:13:25'),
(48, 51099, 'description', 'Description', 'text', NULL, NULL, NULL, 1, 42, 1, '2025-05-19 06:13:25', '2025-05-19 06:13:25'),
(49, 1031, NULL, 'Certificate', 'text', NULL, NULL, NULL, 1, 43, 1, '2025-05-19 06:15:04', '2025-05-19 06:15:04'),
(50, 1031, NULL, 'Year', 'date', NULL, NULL, NULL, 1, 44, 1, '2025-05-19 06:15:04', '2025-05-19 06:15:04'),
(51, 1031, NULL, 'Issued by', 'text', NULL, NULL, NULL, 1, 45, 1, '2025-05-19 06:16:00', '2025-05-19 06:16:00'),
(59, 51109, NULL, 'Name of the Institute', 'text', NULL, NULL, NULL, 1, 46, 1, '2025-05-19 06:18:03', '2025-05-19 06:18:03'),
(60, 51109, NULL, 'University', 'text', NULL, NULL, NULL, 1, 47, 1, '2025-05-19 06:18:03', '2025-05-19 06:18:03'),
(61, 51109, NULL, 'Location', 'text', NULL, NULL, NULL, 1, 48, 1, '2025-05-19 06:19:00', '2025-05-19 06:19:00'),
(62, 51109, NULL, 'Specialization ', 'text', NULL, NULL, NULL, 1, 49, 1, '2025-05-19 06:19:00', '2025-05-19 06:19:00'),
(63, 51109, NULL, 'Show Grade', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]', NULL, NULL, 1, 50, 1, '2025-05-19 06:19:00', '2025-05-19 06:19:00'),
(64, 51109, NULL, 'Score', 'checkbox', '[\n    { \"label\": \"CGPA\", \"value\": \"CGPA\" },\n    { \"label\": \"%\", \"value\": \"%\" },\n    { \"label\": \"Division\", \"value\": \"Division\" }\n]', NULL, NULL, 1, 51, 1, '2025-05-19 06:19:00', '2025-05-19 06:19:00'),
(65, 51109, NULL, 'Year', 'date', NULL, NULL, NULL, 1, 52, 1, '2025-05-19 06:19:00', '2025-05-19 06:19:00'),
(66, 51122, 'title', 'Project Name', 'text', NULL, NULL, NULL, 1, 53, 1, '2025-05-19 06:23:17', '2025-05-19 06:23:17'),
(67, 51122, 'description', 'Description ', 'text', NULL, NULL, NULL, 1, 54, 1, '2025-05-19 06:23:17', '2025-05-19 06:23:17'),
(68, 51123, 'title', 'Extracurricular Activities', 'text', NULL, NULL, NULL, 1, 55, 1, '2025-05-19 06:24:40', '2025-05-19 06:24:40'),
(69, 51123, 'description', 'Description', 'text', NULL, NULL, NULL, 1, 56, 1, '2025-05-19 06:24:40', '2025-05-19 06:24:40'),
(70, 51111, 'technical', 'Skill', 'text', NULL, NULL, NULL, 1, 57, 1, '2025-05-19 06:26:36', '2025-05-19 06:26:36'),
(71, 51118, 'skill', 'Skill', 'text', NULL, NULL, NULL, 1, 58, 1, '2025-05-19 06:29:59', '2025-05-19 06:29:59'),
(72, 51114, NULL, 'Achievement', 'text', NULL, NULL, NULL, 1, 59, 1, '2025-05-19 06:30:57', '2025-05-19 06:30:57'),
(73, 51114, NULL, 'Year', 'text', NULL, NULL, NULL, 1, 60, 1, '2025-05-19 06:30:57', '2025-05-19 06:30:57'),
(74, 51114, NULL, 'Description ', 'text', NULL, NULL, NULL, 1, 61, 1, '2025-05-19 06:31:53', '2025-05-19 06:31:53'),
(75, 51119, NULL, 'Interest', 'text', NULL, NULL, NULL, 1, 62, 1, '2025-05-19 06:32:51', '2025-05-19 06:32:51'),
(76, 51119, NULL, 'Hobby ', 'select', NULL, NULL, NULL, 1, 63, 1, '2025-05-19 06:32:51', '2025-05-19 06:32:51'),
(77, 51119, NULL, 'Passion ', 'text', NULL, NULL, NULL, 1, 64, 1, '2025-05-19 06:34:12', '2025-05-19 06:34:12'),
(78, 51120, NULL, 'Language', 'text', NULL, NULL, NULL, 1, 65, 1, '2025-05-19 06:35:30', '2025-05-19 06:35:30'),
(79, 51120, NULL, 'Read', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]', 78, NULL, 1, 66, 1, '2025-05-19 06:35:30', '2025-05-19 06:35:30'),
(80, 51120, NULL, 'Write', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]', 78, NULL, 1, 67, 1, '2025-05-19 06:37:15', '2025-05-19 06:37:15'),
(81, 51120, NULL, 'Speak', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]', 78, NULL, 1, 68, 1, '2025-05-19 06:37:15', '2025-05-19 06:37:15'),
(82, 51107, NULL, 'Type of Training', 'text', NULL, NULL, NULL, 1, 69, 1, '2025-05-19 06:40:10', '2025-05-19 06:40:10'),
(83, 51107, NULL, 'Number of Trainings Conducted', 'text', NULL, NULL, NULL, 1, 70, 1, '2025-05-19 06:40:10', '2025-05-19 06:40:10'),
(84, 51107, NULL, 'Description', 'text', NULL, NULL, NULL, 1, 71, 1, '2025-05-19 06:40:42', '2025-05-19 06:40:42'),
(129, 51112, NULL, 'Name of the Publication', 'text', NULL, NULL, NULL, 1, 72, 1, '2025-05-19 06:51:05', '2025-05-19 06:51:05'),
(130, 51112, NULL, 'Publisher', 'text', NULL, NULL, NULL, 1, 73, 1, '2025-05-19 06:51:26', '2025-05-19 06:51:26'),
(131, 51112, NULL, 'Publishing Date', 'date', NULL, NULL, NULL, 1, 74, 1, '2025-05-19 06:51:26', '2025-05-19 06:51:26'),
(132, 51112, NULL, 'Description', 'text', NULL, NULL, NULL, 1, 75, 1, '2025-05-19 06:52:10', '2025-05-19 06:52:10'),
(133, 51112, NULL, 'Category', 'checkbox', '[\r\n    { \"label\": \"Journal\", \"value\": \"Journal\"},\r\n    { \"label\": \"News Letter\", \"value\": \"NewsLetter\"},\r\n    { \"label\": \"Magazine\", \"value\": \"Magazine\"},\r\n    { \"label\": \"Conference\", \"value\": \"Conference\"},\r\n  { \"label\": \"Book\", \"value\": \"Book\"},\r\n    { \"label\": \"Bullet in\", \"value\": \"Bullet_in\"}\r\n]\r\n', NULL, NULL, 1, 76, 1, '2025-05-19 06:52:32', '2025-05-19 06:52:32'),
(134, 51113, NULL, 'Name of the Patent', 'text', NULL, NULL, NULL, 1, 77, 1, '2025-05-19 06:54:37', '2025-05-19 06:54:37'),
(135, 51113, NULL, 'Patent Office', 'text', NULL, NULL, NULL, 1, 78, 1, '2025-05-19 06:54:37', '2025-05-19 06:54:37'),
(136, 51113, NULL, 'Patent Application', 'text', NULL, NULL, NULL, 1, 79, 1, '2025-05-19 06:55:15', '2025-05-19 06:55:15'),
(137, 51113, NULL, 'Patent Date', 'date', NULL, NULL, NULL, 1, 80, 1, '2025-05-19 06:55:15', '2025-05-19 06:55:15'),
(138, 51113, NULL, 'Description', 'text', NULL, NULL, NULL, 1, 81, 1, '2025-05-19 06:55:15', '2025-05-19 06:55:15'),
(139, 51113, NULL, 'Patent', 'radio', '[\r\n    { \"label\": \"Issued\", \"value\": \"Issued\" },\r\n    { \"label\": \"Pending\", \"value\": \"Pending\" }\r\n]', NULL, NULL, 1, 82, 1, '2025-05-19 06:56:21', '2025-05-19 06:56:21'),
(140, 51116, NULL, 'Associated Organization', 'text', NULL, NULL, NULL, 1, 83, 1, '2025-05-19 06:58:08', '2025-05-19 06:58:08'),
(141, 51116, NULL, 'Position Hold', 'text', NULL, NULL, NULL, 1, 84, 1, '2025-05-19 06:58:08', '2025-05-19 06:58:08'),
(142, 51116, NULL, 'Location', 'text', NULL, NULL, NULL, 1, 85, 1, '2025-05-19 06:58:43', '2025-05-19 06:58:43'),
(143, 51116, NULL, 'Description', 'text', NULL, NULL, NULL, 1, 86, 1, '2025-05-19 06:58:43', '2025-05-19 06:58:43'),
(144, 51116, NULL, 'Date of Joining', 'date', NULL, NULL, NULL, 1, 87, 1, '2025-05-19 06:58:43', '2025-05-19 06:58:43'),
(145, 51116, NULL, 'Date of Leaving', 'date', NULL, NULL, NULL, 1, 88, 1, '2025-05-19 06:58:43', '2025-05-19 06:58:43'),
(146, 51116, NULL, 'Currently Associated', 'text', NULL, NULL, NULL, 1, 89, 1, '2025-05-19 06:58:43', '2025-05-19 06:58:43'),
(147, 51121, NULL, 'Show Prefernce', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]', NULL, NULL, 1, 90, 1, '2025-05-19 07:02:20', '2025-05-19 07:02:20'),
(148, 51121, 'preferredLocation', 'Preferred Job Location', 'text', NULL, NULL, NULL, 1, 91, 1, '2025-05-19 07:02:20', '2025-05-19 07:02:20'),
(149, 51121, 'canRelocate', 'Can Relocate?', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]', NULL, NULL, 1, 92, 1, '2025-05-19 07:03:07', '2025-05-19 07:03:07'),
(150, 51121, 'noticePeriod', 'Notice Period ( Days/weeks/months)', 'text', NULL, NULL, NULL, 1, 93, 1, '2025-05-19 07:03:07', '2025-05-19 07:03:07'),
(151, 51121, 'canJoin', 'Can Join Immediately?', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]', NULL, NULL, 1, 94, 1, '2025-05-19 07:03:07', '2025-05-19 07:03:07'),
(152, 51121, 'expectedCTC', 'Expected CTC', 'text', NULL, NULL, NULL, 1, 95, 1, '2025-05-19 07:03:07', '2025-05-19 07:03:07'),
(153, 51121, 'isNegotiate', 'Salary Negotiable?', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]', NULL, NULL, 1, 96, 1, '2025-05-19 07:03:07', '2025-05-19 07:03:07'),
(154, 51121, 'passportDetails', 'Show Passport Details', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]', NULL, NULL, 1, 97, 1, '2025-05-19 07:03:07', '2025-05-19 07:03:07'),
(155, 51121, 'declaration', 'Add Declaration', 'text', NULL, NULL, NULL, 1, 98, 1, '2025-05-19 07:03:07', '2025-05-19 07:03:07'),
(156, 51121, 'signature', 'Add Signature', 'text', NULL, NULL, NULL, 1, 99, 1, '2025-05-19 07:03:07', '2025-05-19 07:03:07'),
(157, 51121, NULL, 'Upload Signature', 'file', NULL, NULL, NULL, 1, 100, 1, '2025-05-19 07:03:07', '2025-05-19 07:03:07'),
(158, 51109, NULL, 'course', 'text', NULL, NULL, NULL, 1, NULL, 1, '2025-05-19 07:26:45', '2025-05-19 07:26:45'),
(159, 51109, NULL, 'organization', 'text', NULL, NULL, NULL, 1, NULL, 1, NULL, NULL),
(160, 51109, NULL, 'isPursuing', 'radio', '[\n    { \"label\": \"yes\", \"value\": 1 },\n    { \"label\": \"no\", \"value\": 0 }\n]', NULL, NULL, 1, NULL, 1, '2025-05-19 07:28:00', '2025-05-19 07:28:00'),
(161, 51213, 'link_name', 'social link heading', 'text', NULL, NULL, NULL, 1, NULL, 1, '2025-05-19 07:38:32', '2025-05-19 07:38:32'),
(162, 51213, 'link', 'social link', 'text', NULL, NULL, NULL, 1, NULL, 1, '2025-05-19 07:38:32', '2025-05-19 07:38:32');

-- --------------------------------------------------------

--
-- Table structure for table `sessionapplication`
--

CREATE TABLE `sessionapplication` (
  `sessionID` int(11) NOT NULL,
  `sessionCategory` tinyint(4) NOT NULL,
  `sessionDetails` varchar(100) NOT NULL,
  `sessionName` varchar(50) NOT NULL,
  `sessionPhone` varchar(15) NOT NULL,
  `sessionEmail` varchar(100) NOT NULL,
  `sessionInstitute` varchar(100) NOT NULL,
  `sessionQualification` varchar(100) NOT NULL,
  `sessionLocation` varchar(100) NOT NULL,
  `sessionYear` varchar(10) NOT NULL,
  `referralCode` varchar(6) NOT NULL,
  `referenceNo` bigint(20) NOT NULL,
  `sessionDate` datetime NOT NULL,
  `id` bigint(20) NOT NULL,
  `pricePaid` int(11) NOT NULL,
  `orderId` varchar(255) NOT NULL,
  `sessionDetailsEmail` int(11) NOT NULL,
  `registrationEmail` tinyint(4) NOT NULL,
  `marketingEmail` tinyint(4) NOT NULL,
  `whatsAppGroup` int(11) NOT NULL,
  `sessionAttended` int(11) NOT NULL,
  `certificateIssued` tinyint(4) NOT NULL,
  `workshop1` tinyint(4) NOT NULL,
  `workshop2` tinyint(4) NOT NULL,
  `workshop3` tinyint(4) NOT NULL,
  `workshop4` tinyint(4) NOT NULL,
  `workshop5` tinyint(4) NOT NULL,
  `workshop6` tinyint(4) NOT NULL,
  `workshop7` tinyint(4) NOT NULL,
  `PPPP` int(11) NOT NULL,
  `certificateType` varchar(50) NOT NULL,
  `freeSubscription` int(11) NOT NULL,
  `sessionDetailsWA` tinyint(4) NOT NULL,
  `revenue` int(11) NOT NULL,
  `old` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `specializations`
--

CREATE TABLE `specializations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1 = Active, 0 = Inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `specializations`
--

INSERT INTO `specializations` (`id`, `course_id`, `title`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Computer Science & Engineering', 1, '2025-05-16 08:23:15', '2025-05-16 08:23:15'),
(2, 2, 'Chemistry', 1, '2025-05-16 08:23:15', '2025-05-16 08:23:15'),
(3, 3, 'Accounting & Finance', 1, '2025-05-16 08:23:50', '2025-05-16 08:23:50'),
(4, 4, 'Psychology', 1, '2025-05-16 08:23:50', '2025-05-16 08:23:50');

-- --------------------------------------------------------

--
-- Table structure for table `supportcalls`
--

CREATE TABLE `supportcalls` (
  `callID` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `userPhone` varchar(20) NOT NULL,
  `userEmail` varchar(255) NOT NULL,
  `userDuplicatePhone` tinyint(4) NOT NULL,
  `userDuplicateEmail` tinyint(4) NOT NULL,
  `userImage` varchar(255) NOT NULL,
  `userPlayerID` varchar(255) NOT NULL,
  `userVersion` int(11) NOT NULL,
  `userReferralCode` varchar(150) NOT NULL,
  `userCategory` int(11) NOT NULL,
  `userLastAppLogin` datetime NOT NULL,
  `userLastWebLogin` datetime NOT NULL,
  `userPremium` tinyint(4) NOT NULL,
  `userAssociate` int(11) NOT NULL,
  `userPremiumStart` date NOT NULL,
  `userAssociateStart` date NOT NULL,
  `userPremiumExpiry` date NOT NULL,
  `userAssociateExpiry` date NOT NULL,
  `userVoucherDetails` int(11) NOT NULL,
  `userInstituteName` varchar(255) NOT NULL,
  `userPassYear` int(4) NOT NULL,
  `userInstituteID` int(11) NOT NULL,
  `instituteDesign` int(11) NOT NULL,
  `resumeID` varchar(150) NOT NULL,
  `resumeCount` int(11) NOT NULL,
  `sectionCount` int(11) NOT NULL,
  `51099` int(11) NOT NULL,
  `51100` int(11) NOT NULL,
  `51101` int(11) NOT NULL,
  `51102` int(11) NOT NULL,
  `51103` int(11) NOT NULL,
  `51104` int(11) NOT NULL,
  `51105` int(11) NOT NULL,
  `51106` int(11) NOT NULL,
  `51107` int(11) NOT NULL,
  `51108` int(11) NOT NULL,
  `51109` int(11) NOT NULL,
  `51110` int(11) NOT NULL,
  `51111` int(11) NOT NULL,
  `51112` int(11) NOT NULL,
  `51113` int(11) NOT NULL,
  `51114` int(11) NOT NULL,
  `51115` int(11) NOT NULL,
  `51116` int(11) NOT NULL,
  `51117` int(11) NOT NULL,
  `51118` int(11) NOT NULL,
  `51119` int(11) NOT NULL,
  `51120` int(11) NOT NULL,
  `51121` int(11) NOT NULL,
  `51122` int(11) NOT NULL,
  `51123` int(11) NOT NULL,
  `51125` int(11) NOT NULL,
  `51126` int(11) NOT NULL,
  `DND` tinyint(4) NOT NULL,
  `DNW` tinyint(4) NOT NULL,
  `mailCount` int(11) NOT NULL,
  `ui_welcomemessage` tinyint(4) NOT NULL,
  `ui_cvcreation` tinyint(4) NOT NULL,
  `ui_offerfirst` tinyint(4) NOT NULL,
  `ui_digitalprofile` tinyint(4) NOT NULL,
  `ui_profileimage` tinyint(4) NOT NULL,
  `ui_paymentfailed` tinyint(4) NOT NULL,
  `cvid` int(11) NOT NULL,
  `callerID` bigint(20) NOT NULL,
  `callLastRemarks` text NOT NULL,
  `callOrderCount` int(11) NOT NULL,
  `callFollowUpCount` tinyint(4) NOT NULL,
  `callOrderPriceTotal` int(11) NOT NULL,
  `callLastStatus` varchar(255) NOT NULL,
  `callFeedbackStatus` tinyint(4) NOT NULL,
  `callReported` bigint(4) NOT NULL,
  `callReportedType` varchar(255) NOT NULL,
  `callReportedReason` text NOT NULL,
  `firstCallDone` int(11) NOT NULL DEFAULT 0,
  `callCreated` timestamp NOT NULL DEFAULT current_timestamp(),
  `callUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `supportcalls`
--

INSERT INTO `supportcalls` (`callID`, `id`, `userName`, `userPhone`, `userEmail`, `userDuplicatePhone`, `userDuplicateEmail`, `userImage`, `userPlayerID`, `userVersion`, `userReferralCode`, `userCategory`, `userLastAppLogin`, `userLastWebLogin`, `userPremium`, `userAssociate`, `userPremiumStart`, `userAssociateStart`, `userPremiumExpiry`, `userAssociateExpiry`, `userVoucherDetails`, `userInstituteName`, `userPassYear`, `userInstituteID`, `instituteDesign`, `resumeID`, `resumeCount`, `sectionCount`, `51099`, `51100`, `51101`, `51102`, `51103`, `51104`, `51105`, `51106`, `51107`, `51108`, `51109`, `51110`, `51111`, `51112`, `51113`, `51114`, `51115`, `51116`, `51117`, `51118`, `51119`, `51120`, `51121`, `51122`, `51123`, `51125`, `51126`, `DND`, `DNW`, `mailCount`, `ui_welcomemessage`, `ui_cvcreation`, `ui_offerfirst`, `ui_digitalprofile`, `ui_profileimage`, `ui_paymentfailed`, `cvid`, `callerID`, `callLastRemarks`, `callOrderCount`, `callFollowUpCount`, `callOrderPriceTotal`, `callLastStatus`, `callFeedbackStatus`, `callReported`, `callReportedType`, `callReportedReason`, `firstCallDone`, `callCreated`, `callUpdated`, `status`) VALUES
(6184, 14889791841417, 'cvDragon', '9163942424', 'cherag.bachhawat@lifeinmba.com', 1, 1, 'https://cvdragon.com/public/resources/profileImages/1687528425019.jpg', '482bebc8-cedc-4883-be8e-a299ad59f0e3', 25, '0', 3, '2025-05-08 11:18:07', '2025-05-06 16:19:02', 1, 1, '2023-04-01', '2024-08-23', '2024-03-31', '2025-10-01', 66030, 'cvDragon Premium', 2024, 1002, 10027, '3891746683928', 1014, -184, -4, 1, 1, -4, 1, 0, -1, 2, 3, 0, 1, 0, 3, 0, 0, 0, 0, 0, 0, 5, -5, 0, 1, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 162816, 0, '', 11, 0, 497, '', 0, 0, '', '', 0, '0000-00-00 00:00:00', '2025-05-08 05:58:48', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user-basic`
--

CREATE TABLE `user-basic` (
  `id` bigint(11) NOT NULL,
  `fullName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `emailAddress` varchar(200) DEFAULT NULL,
  `countryCode` int(4) DEFAULT NULL,
  `phoneNumber` bigint(20) DEFAULT NULL,
  `profileImageUrl` text DEFAULT NULL,
  `profileVideoURL` varchar(200) DEFAULT NULL,
  `publicProfileStatus` int(11) NOT NULL DEFAULT 1,
  `publicProfile` int(11) DEFAULT NULL,
  `publicProfileDesign` int(11) DEFAULT NULL,
  `iconList` tinyint(4) DEFAULT NULL,
  `showFAQ` tinyint(4) DEFAULT NULL,
  `showKey` tinyint(4) DEFAULT NULL,
  `showDatabase` tinyint(4) DEFAULT NULL,
  `DND` tinyint(4) DEFAULT NULL,
  `DNE` tinyint(4) DEFAULT NULL,
  `DNW` tinyint(4) DEFAULT NULL,
  `notiHelp` tinyint(4) DEFAULT 1,
  `notiDesign` tinyint(4) DEFAULT 1,
  `notiPlacement` tinyint(4) DEFAULT 1,
  `notiOther` tinyint(4) DEFAULT 1,
  `showMobile` tinyint(4) NOT NULL DEFAULT 0,
  `showProfile` tinyint(4) DEFAULT 1,
  `showEmail` tinyint(4) DEFAULT 0,
  `sendEmailStatus` int(11) DEFAULT NULL,
  `isInternational` tinyint(4) DEFAULT NULL,
  `showDelete` tinyint(4) DEFAULT 1,
  `showWizard` tinyint(4) NOT NULL DEFAULT 1,
  `wizardProfile` int(11) DEFAULT NULL,
  `wizardWorkExp` int(11) DEFAULT NULL,
  `wizardEducationProfile` varchar(255) DEFAULT NULL,
  `wizardWorkProfile` varchar(255) DEFAULT NULL,
  `wizardEducationSpecialization` varchar(255) DEFAULT NULL,
  `wizardWorkSpecialization` varchar(255) DEFAULT NULL,
  `showFeatureFreeSubscription` tinyint(4) NOT NULL DEFAULT 0,
  `showFeatureReview` tinyint(4) NOT NULL DEFAULT 0,
  `showFeatureInstitute` tinyint(4) NOT NULL DEFAULT 0,
  `showFeatureMyResume` tinyint(4) NOT NULL DEFAULT 1,
  `showFeatureNotification` tinyint(4) NOT NULL DEFAULT 1,
  `showFeatureWorkshops` int(11) NOT NULL DEFAULT 1,
  `showFeatureKC` int(11) NOT NULL DEFAULT 1,
  `showFeaturePublicProfile` int(11) NOT NULL DEFAULT 1,
  `showFeatureJobs` int(11) NOT NULL DEFAULT 1,
  `showFeatureResources` int(11) NOT NULL DEFAULT 1,
  `showFeatureTips` tinyint(4) NOT NULL DEFAULT 1,
  `showFeatureArticles` tinyint(4) NOT NULL DEFAULT 1,
  `showFeatureFAQs` tinyint(4) NOT NULL DEFAULT 1,
  `showFeatureReorder` int(11) DEFAULT NULL,
  `showOptionFeedback` int(11) NOT NULL DEFAULT 1,
  `dateCreated` datetime DEFAULT NULL,
  `dateUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` smallint(6) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user-basic`
--

INSERT INTO `user-basic` (`id`, `fullName`, `emailAddress`, `countryCode`, `phoneNumber`, `profileImageUrl`, `profileVideoURL`, `publicProfileStatus`, `publicProfile`, `publicProfileDesign`, `iconList`, `showFAQ`, `showKey`, `showDatabase`, `DND`, `DNE`, `DNW`, `notiHelp`, `notiDesign`, `notiPlacement`, `notiOther`, `showMobile`, `showProfile`, `showEmail`, `sendEmailStatus`, `isInternational`, `showDelete`, `showWizard`, `wizardProfile`, `wizardWorkExp`, `wizardEducationProfile`, `wizardWorkProfile`, `wizardEducationSpecialization`, `wizardWorkSpecialization`, `showFeatureFreeSubscription`, `showFeatureReview`, `showFeatureInstitute`, `showFeatureMyResume`, `showFeatureNotification`, `showFeatureWorkshops`, `showFeatureKC`, `showFeaturePublicProfile`, `showFeatureJobs`, `showFeatureResources`, `showFeatureTips`, `showFeatureArticles`, `showFeatureFAQs`, `showFeatureReorder`, `showOptionFeedback`, `dateCreated`, `dateUpdated`, `status`) VALUES
(1748065614627, NULL, NULL, NULL, 6290489884, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, 1, 0, 1, 0, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, 1, NULL, '2025-05-24 05:46:54', 1),
(14889791841417, 'cvDragon', 'cherag.bachhawat@lifeinmba.com', 91, 9163942424, 'https://media.licdn.com/mpr/mprx/0_0nZjK-2gtnjGANa2vnC1AvmyvCW0tXt3vnCjv6_g-FlYcN03zF8yZ_GgcQQ0BcCTJtCyghTjj8wON8MAzLg3Z62AZ8wxN8USzLgOPFJpPTY1Yn8AMNIK1PcD4zl7j82yyQJAqJr78aU', '', 1, 162816, 2, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 3, 17, '10048', '20004', '100383', '209739', 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, '2017-03-15 00:00:00', '2025-05-08 05:48:06', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user-documents`
--

CREATE TABLE `user-documents` (
  `documentID` int(11) NOT NULL,
  `documentTitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `documentLocation` varchar(255) NOT NULL,
  `documentSection` int(11) NOT NULL,
  `documentSubSection` varchar(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `date` datetime NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `user-documents`
--

INSERT INTO `user-documents` (`documentID`, `documentTitle`, `documentLocation`, `documentSection`, `documentSubSection`, `id`, `date`, `status`) VALUES
(7, 'Date Of Birth', 'https://cvdragon.com/public/resources/documentUpload/163871837536.jpeg', 51100, 'dateBirth', 14889791841417, '2021-12-05 21:02:55', 0),
(8, 'Entrepreneur', 'https://cvdragon.com/public/resources/documentUpload/163913459950.jpeg', 51104, '270', 14889791841417, '2021-12-10 16:39:59', 0),
(11, 'Arabic', 'https://cvdragon.com/public/resources/documentUpload/16398190248.jpeg', 51120, '39046', 14889791841417, '2021-12-18 14:47:04', 0),
(116, 'Aakash Institute', 'https://cvdragon.com/public/resources/documentUpload/167031396977.jpg', 51106, '21868', 14889791841417, '2022-12-06 13:36:09', 0),
(117, 'Accountant details', 'https://cvdragon.com/public/resources/documentUpload/167031405227.jpg', 51104, '14422', 14889791841417, '2022-12-06 13:37:32', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user-feedback`
--

CREATE TABLE `user-feedback` (
  `feedbackid` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `userName` varchar(100) NOT NULL,
  `userPhone` varchar(20) NOT NULL,
  `userEmail` varchar(50) NOT NULL,
  `feedback` text NOT NULL,
  `rating` int(11) NOT NULL,
  `isResolved` tinyint(4) NOT NULL,
  `dateResolved` datetime NOT NULL,
  `dateCreated` timestamp NOT NULL DEFAULT current_timestamp(),
  `mode` varchar(10) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user-feedback`
--

INSERT INTO `user-feedback` (`feedbackid`, `id`, `userName`, `userPhone`, `userEmail`, `feedback`, `rating`, `isResolved`, `dateResolved`, `dateCreated`, `mode`, `status`) VALUES
(30, 14889791841417, 'Cherag Bachhawat', '9163942424', 'cherag.bachhawat@lifeinmba.com', 'hi', 0, 1, '2018-05-01 12:57:50', '2018-03-19 15:34:51', '', 1),
(812, 14889791841417, '', '', '', '[\"Application Interface\",\"Professional Resume Designs\",\"Simple CV Creation Process\"]', 5, 0, '0000-00-00 00:00:00', '2022-02-23 12:55:14', 'App', 1),
(813, 14889791841417, '', '', '', '[\"Did not liked the application\",\"Had difficulty in creating CV\",\"Need more Professional Designs\"]', 0, 0, '0000-00-00 00:00:00', '2022-02-23 13:00:52', 'Delete', 1),
(1437, 14889791841417, '', '', '', '[\"Did not liked the application\"]', 0, 0, '0000-00-00 00:00:00', '2022-07-01 06:10:25', 'Delete', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user-subscription`
--

CREATE TABLE `user-subscription` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `design` int(11) NOT NULL,
  `activate` date NOT NULL,
  `expiry` date NOT NULL,
  `securityKey` varchar(19) NOT NULL,
  `dateCreated` date NOT NULL,
  `dateUpdated` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `categoryid` int(11) DEFAULT NULL COMMENT '0 - Guest, 1 - Free, 2 - Premium, 3 - Pro, 4 - Lifetime Access, 5 - Student, 10 - Admin',
  `referenceID` bigint(20) DEFAULT NULL,
  `socialType` varchar(100) DEFAULT NULL,
  `socialid` varchar(100) DEFAULT NULL,
  `authKey` varchar(255) DEFAULT NULL,
  `socialToken` varchar(800) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `usermobile` varchar(20) DEFAULT NULL,
  `userEmail` varchar(100) DEFAULT NULL,
  `playerID` varchar(50) DEFAULT NULL,
  `playerIDMore` varchar(100) DEFAULT NULL,
  `mobilePlatform` tinyint(4) DEFAULT NULL,
  `appVersion` int(11) DEFAULT NULL,
  `openCount` tinyint(4) DEFAULT NULL,
  `dateUpdated` timestamp NULL DEFAULT current_timestamp(),
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '0 = inactive, 1 = active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `categoryid`, `referenceID`, `socialType`, `socialid`, `authKey`, `socialToken`, `username`, `gender`, `usermobile`, `userEmail`, `playerID`, `playerIDMore`, `mobilePlatform`, `appVersion`, `openCount`, `dateUpdated`, `status`) VALUES
(1748065614627, 1, NULL, NULL, NULL, '9540f797bc8a669f0c659cb723ca5585', NULL, NULL, NULL, '6290489884', NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-24 05:46:54', 1),
(14889791841417, 3, 1624, '4', 'hF9SRdR5y2', '598f1c61f6a2d7623b31af8b13178df8', NULL, 'cvDragon Private Limited', NULL, '919163942424', NULL, '482bebc8-cedc-4883-be8e-a299ad59f0e3', '11f6cb55-de88-4ec9-b940-b4ad06b421ae', 2, 25, NULL, '2025-05-20 08:57:12', 1);

-- --------------------------------------------------------

--
-- Table structure for table `userss`
--

CREATE TABLE `userss` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `guest_token` int(11) DEFAULT NULL,
  `categoryid` int(11) DEFAULT NULL COMMENT '0 - Guest, 1 - Free, 2 - Premium, 3 - Pro, 4 - Lifetime Access, 5 - Student, 10 - Admin',
  `affiliateID` varchar(6) DEFAULT NULL,
  `referenceID` bigint(20) DEFAULT NULL,
  `socialType` varchar(100) DEFAULT NULL COMMENT '0= google, 1 = linkedin, 2 = fb',
  `socialid` varchar(100) DEFAULT NULL,
  `authKey` varchar(255) DEFAULT NULL,
  `socialToken` varchar(800) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `usermobile` varchar(20) DEFAULT NULL,
  `userEmail` varchar(100) DEFAULT NULL,
  `userPassword` varchar(100) DEFAULT NULL,
  `playerID` varchar(50) DEFAULT NULL,
  `playerIDMore` varchar(100) DEFAULT NULL,
  `mobilePlatform` tinyint(4) DEFAULT NULL,
  `appVersion` int(11) DEFAULT NULL,
  `openCount` tinyint(4) DEFAULT NULL,
  `dateUpdated` timestamp NULL DEFAULT current_timestamp(),
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '0 = inactive, 1 = active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uservoucherdetails`
--

CREATE TABLE `uservoucherdetails` (
  `sn` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `userName` varchar(200) NOT NULL,
  `userEmail` varchar(200) NOT NULL,
  `userPhone` varchar(20) NOT NULL,
  `userInstitute` varchar(200) NOT NULL,
  `userInstituteID` int(11) NOT NULL,
  `userLocation` varchar(50) NOT NULL,
  `userEducation` varchar(50) NOT NULL,
  `userPassYear` int(4) NOT NULL,
  `voucherSN` int(11) NOT NULL,
  `voucherCode` varchar(19) NOT NULL,
  `voucherDesign` int(11) NOT NULL,
  `voucherDuration` int(11) NOT NULL,
  `notify` tinyint(4) NOT NULL,
  `notifyDetails` varchar(200) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `uservoucherdetails`
--

INSERT INTO `uservoucherdetails` (`sn`, `id`, `userName`, `userEmail`, `userPhone`, `userInstitute`, `userInstituteID`, `userLocation`, `userEducation`, `userPassYear`, `voucherSN`, `voucherCode`, `voucherDesign`, `voucherDuration`, `notify`, `notifyDetails`, `status`) VALUES
(66030, 14889791841417, 'cvDragon Private Limited', 'cherag.bachhawat@lifeinmba.com', '9163942424', 'cvDragon Premium', 1002, 'Shirpur', '', 2024, 364487, '7827-6462-4799-7621', 10006, 365, 0, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_categories`
--

CREATE TABLE `user_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT '1' COMMENT 'active = 1, inactive = 0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_categories`
--

INSERT INTO `user_categories` (`id`, `category`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Guest', '1', '2025-05-16 05:57:30', '2025-05-16 05:57:30'),
(2, 'Free', '1', '2025-05-16 05:57:30', '2025-05-16 05:57:30'),
(3, 'Premium', '1', '2025-05-16 05:58:01', '2025-05-16 05:58:01'),
(4, 'Pro', '1', '2025-05-16 05:58:01', '2025-05-16 05:58:01'),
(5, 'Lifetime Access', '1', '2025-05-16 05:58:01', '2025-05-16 05:58:01'),
(6, 'Student\r\n', '1', '2025-05-16 05:58:01', '2025-05-16 05:58:01'),
(7, 'Admin', '1', '2025-05-16 05:58:01', '2025-05-16 05:58:01');

-- --------------------------------------------------------

--
-- Table structure for table `user_otps`
--

CREATE TABLE `user_otps` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `otp` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_otps`
--

INSERT INTO `user_otps` (`id`, `identifier`, `otp`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, '6290489884', '038490', '2025-05-26 03:54:05', '2025-05-26 03:49:05', '2025-05-26 03:49:05');

-- --------------------------------------------------------

--
-- Table structure for table `user_voucher_details`
--

CREATE TABLE `user_voucher_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `userName` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `userEmail` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `userPhone` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `userInstitute` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `userInstituteID` int(11) NOT NULL,
  `userLocation` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `userEducation` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `userPassYear` int(11) NOT NULL,
  `voucherSN` int(11) NOT NULL,
  `voucherCode` varchar(19) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `voucherDesign` int(11) NOT NULL,
  `voucherDuration` int(11) NOT NULL,
  `notify` tinyint(4) NOT NULL,
  `notifyDetails` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appdownloads`
--
ALTER TABLE `appdownloads`
  ADD PRIMARY KEY (`appID`);

--
-- Indexes for table `clprofiles`
--
ALTER TABLE `clprofiles`
  ADD PRIMARY KEY (`clid`),
  ADD KEY `clprofiles_clid_index` (`clid`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `courses_resource_carrer_id_foreign` (`resource_carrer_id`);

--
-- Indexes for table `create-cvprofile`
--
ALTER TABLE `create-cvprofile`
  ADD UNIQUE KEY `cvid` (`cvid`);

--
-- Indexes for table `create-cvprofilesection`
--
ALTER TABLE `create-cvprofilesection`
  ADD UNIQUE KEY `cvid` (`cvid`,`section`,`status`),
  ADD KEY `psid` (`psid`);

--
-- Indexes for table `cv-academic-projects`
--
ALTER TABLE `cv-academic-projects`
  ADD UNIQUE KEY `trainingid` (`academicid`);

--
-- Indexes for table `cv-achievements`
--
ALTER TABLE `cv-achievements`
  ADD UNIQUE KEY `achieveid` (`achieveid`);

--
-- Indexes for table `cv-association`
--
ALTER TABLE `cv-association`
  ADD UNIQUE KEY `associationid` (`associationid`);

--
-- Indexes for table `cv-basic-info`
--
ALTER TABLE `cv-basic-info`
  ADD PRIMARY KEY (`basicinfoid`);

--
-- Indexes for table `cv-certification`
--
ALTER TABLE `cv-certification`
  ADD UNIQUE KEY `certificateid` (`certificateid`);

--
-- Indexes for table `cv-co-curricular-activities`
--
ALTER TABLE `cv-co-curricular-activities`
  ADD UNIQUE KEY `trainingid` (`activityid`);

--
-- Indexes for table `cv-contact`
--
ALTER TABLE `cv-contact`
  ADD PRIMARY KEY (`contactid`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `userid` (`id`);

--
-- Indexes for table `cv-education`
--
ALTER TABLE `cv-education`
  ADD KEY `eduid` (`eduid`);

--
-- Indexes for table `cv-images`
--
ALTER TABLE `cv-images`
  ADD PRIMARY KEY (`id`,`image`),
  ADD UNIQUE KEY `imageid` (`imageid`);

--
-- Indexes for table `cv-internship`
--
ALTER TABLE `cv-internship`
  ADD UNIQUE KEY `internshipid` (`internshipid`);

--
-- Indexes for table `cv-introduction`
--
ALTER TABLE `cv-introduction`
  ADD PRIMARY KEY (`introid`);

--
-- Indexes for table `cv-languages`
--
ALTER TABLE `cv-languages`
  ADD UNIQUE KEY `langid` (`langid`);

--
-- Indexes for table `cv-patent`
--
ALTER TABLE `cv-patent`
  ADD UNIQUE KEY `patentid` (`patentid`);

--
-- Indexes for table `cv-poa`
--
ALTER TABLE `cv-poa`
  ADD UNIQUE KEY `trainingid` (`poaid`);

--
-- Indexes for table `cv-preference`
--
ALTER TABLE `cv-preference`
  ADD UNIQUE KEY `profileid` (`prefid`);

--
-- Indexes for table `cv-presentations`
--
ALTER TABLE `cv-presentations`
  ADD UNIQUE KEY `trainingid` (`activityid`);

--
-- Indexes for table `cv-project`
--
ALTER TABLE `cv-project`
  ADD UNIQUE KEY `projectid` (`projectid`);

--
-- Indexes for table `cv-publications`
--
ALTER TABLE `cv-publications`
  ADD UNIQUE KEY `publishid` (`publishid`);

--
-- Indexes for table `cv-skills`
--
ALTER TABLE `cv-skills`
  ADD UNIQUE KEY `skillid` (`skillid`);

--
-- Indexes for table `cv-technical`
--
ALTER TABLE `cv-technical`
  ADD PRIMARY KEY (`technicalid`),
  ADD KEY `technicalid` (`technicalid`);

--
-- Indexes for table `cv-trainings`
--
ALTER TABLE `cv-trainings`
  ADD UNIQUE KEY `trainingid` (`trainingid`);

--
-- Indexes for table `cv-volunteer`
--
ALTER TABLE `cv-volunteer`
  ADD PRIMARY KEY (`id`,`organization`,`cause`),
  ADD UNIQUE KEY `volunteerid` (`volunteerid`);

--
-- Indexes for table `cv-work`
--
ALTER TABLE `cv-work`
  ADD KEY `workid` (`workid`) USING BTREE;

--
-- Indexes for table `cvdragonappconfignew`
--
ALTER TABLE `cvdragonappconfignew`
  ADD PRIMARY KEY (`configid`);

--
-- Indexes for table `cvprofiles`
--
ALTER TABLE `cvprofiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cvprofiles_user_id_foreign` (`user_id`);

--
-- Indexes for table `cvsections`
--
ALTER TABLE `cvsections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cvsections_section_index` (`section`),
  ADD KEY `cvsections_sectionid_index` (`sectionid`);

--
-- Indexes for table `cv_social_links`
--
ALTER TABLE `cv_social_links`
  ADD PRIMARY KEY (`socialid`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `help-chat`
--
ALTER TABLE `help-chat`
  ADD PRIMARY KEY (`chatID`);

--
-- Indexes for table `help-faq`
--
ALTER TABLE `help-faq`
  ADD PRIMARY KEY (`faqID`);

--
-- Indexes for table `help-videos`
--
ALTER TABLE `help-videos`
  ADD PRIMARY KEY (`videoID`);

--
-- Indexes for table `interests`
--
ALTER TABLE `interests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `interests_specialization_id_foreign` (`specialization_id`);

--
-- Indexes for table `master_cv_sections`
--
ALTER TABLE `master_cv_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offerregistration`
--
ALTER TABLE `offerregistration`
  ADD UNIQUE KEY `offerID` (`offerID`),
  ADD UNIQUE KEY `offerCategory` (`offerCategory`,`offerDetails`,`offerEmail`,`status`),
  ADD UNIQUE KEY `offerCategory_2` (`offerCategory`,`offerDetails`,`offerPhone`,`status`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `resource-links`
--
ALTER TABLE `resource-links`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `resource-profiledesign`
--
ALTER TABLE `resource-profiledesign`
  ADD PRIMARY KEY (`designid`);

--
-- Indexes for table `resource-profilefont`
--
ALTER TABLE `resource-profilefont`
  ADD PRIMARY KEY (`fontid`);

--
-- Indexes for table `resource-profilesetting`
--
ALTER TABLE `resource-profilesetting`
  ADD PRIMARY KEY (`settingid`);

--
-- Indexes for table `resource-publicdesign`
--
ALTER TABLE `resource-publicdesign`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `resource-redirect`
--
ALTER TABLE `resource-redirect`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `resource-section`
--
ALTER TABLE `resource-section`
  ADD PRIMARY KEY (`id`),
  ADD KEY `abc` (`master_cv_sections_id`);

--
-- Indexes for table `resource-securitykeys`
--
ALTER TABLE `resource-securitykeys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `resource_carrers`
--
ALTER TABLE `resource_carrers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `resource_profile_design_categories`
--
ALTER TABLE `resource_profile_design_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `section_questions`
--
ALTER TABLE `section_questions`
  ADD PRIMARY KEY (`sectionquestionid`);

--
-- Indexes for table `sessionapplication`
--
ALTER TABLE `sessionapplication`
  ADD PRIMARY KEY (`sessionID`),
  ADD UNIQUE KEY `sessionID` (`sessionID`),
  ADD UNIQUE KEY `sessionCategory` (`sessionCategory`,`sessionName`,`sessionPhone`,`sessionEmail`,`status`,`sessionDetails`,`sessionDate`) USING BTREE;

--
-- Indexes for table `specializations`
--
ALTER TABLE `specializations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `specializations_course_id_foreign` (`course_id`);

--
-- Indexes for table `supportcalls`
--
ALTER TABLE `supportcalls`
  ADD PRIMARY KEY (`callID`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `user-basic`
--
ALTER TABLE `user-basic`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_2` (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `user-documents`
--
ALTER TABLE `user-documents`
  ADD PRIMARY KEY (`documentID`);

--
-- Indexes for table `user-feedback`
--
ALTER TABLE `user-feedback`
  ADD UNIQUE KEY `feedbackid` (`feedbackid`);

--
-- Indexes for table `user-subscription`
--
ALTER TABLE `user-subscription`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userss`
--
ALTER TABLE `userss`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uservoucherdetails`
--
ALTER TABLE `uservoucherdetails`
  ADD PRIMARY KEY (`sn`),
  ADD UNIQUE KEY `voucherSN` (`voucherSN`,`voucherCode`);

--
-- Indexes for table `user_categories`
--
ALTER TABLE `user_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_otps`
--
ALTER TABLE `user_otps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_otps_identifier_index` (`identifier`);

--
-- Indexes for table `user_voucher_details`
--
ALTER TABLE `user_voucher_details`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appdownloads`
--
ALTER TABLE `appdownloads`
  MODIFY `appID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clprofiles`
--
ALTER TABLE `clprofiles`
  MODIFY `clid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `create-cvprofile`
--
ALTER TABLE `create-cvprofile`
  MODIFY `cvid` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=353446;

--
-- AUTO_INCREMENT for table `create-cvprofilesection`
--
ALTER TABLE `create-cvprofilesection`
  MODIFY `psid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5819403;

--
-- AUTO_INCREMENT for table `cv-academic-projects`
--
ALTER TABLE `cv-academic-projects`
  MODIFY `academicid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33964;

--
-- AUTO_INCREMENT for table `cv-achievements`
--
ALTER TABLE `cv-achievements`
  MODIFY `achieveid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=423105;

--
-- AUTO_INCREMENT for table `cv-association`
--
ALTER TABLE `cv-association`
  MODIFY `associationid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=498;

--
-- AUTO_INCREMENT for table `cv-basic-info`
--
ALTER TABLE `cv-basic-info`
  MODIFY `basicinfoid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `cv-certification`
--
ALTER TABLE `cv-certification`
  MODIFY `certificateid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5216506;

--
-- AUTO_INCREMENT for table `cv-co-curricular-activities`
--
ALTER TABLE `cv-co-curricular-activities`
  MODIFY `activityid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cv-contact`
--
ALTER TABLE `cv-contact`
  MODIFY `contactid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cv-education`
--
ALTER TABLE `cv-education`
  MODIFY `eduid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1306253;

--
-- AUTO_INCREMENT for table `cv-images`
--
ALTER TABLE `cv-images`
  MODIFY `imageid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149522;

--
-- AUTO_INCREMENT for table `cv-internship`
--
ALTER TABLE `cv-internship`
  MODIFY `internshipid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38698;

--
-- AUTO_INCREMENT for table `cv-introduction`
--
ALTER TABLE `cv-introduction`
  MODIFY `introid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `cv-languages`
--
ALTER TABLE `cv-languages`
  MODIFY `langid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=239663;

--
-- AUTO_INCREMENT for table `cv-patent`
--
ALTER TABLE `cv-patent`
  MODIFY `patentid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=192;

--
-- AUTO_INCREMENT for table `cv-poa`
--
ALTER TABLE `cv-poa`
  MODIFY `poaid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38336;

--
-- AUTO_INCREMENT for table `cv-preference`
--
ALTER TABLE `cv-preference`
  MODIFY `prefid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=325751;

--
-- AUTO_INCREMENT for table `cv-presentations`
--
ALTER TABLE `cv-presentations`
  MODIFY `activityid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8517;

--
-- AUTO_INCREMENT for table `cv-project`
--
ALTER TABLE `cv-project`
  MODIFY `projectid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `cv-publications`
--
ALTER TABLE `cv-publications`
  MODIFY `publishid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1478;

--
-- AUTO_INCREMENT for table `cv-skills`
--
ALTER TABLE `cv-skills`
  MODIFY `skillid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=434201;

--
-- AUTO_INCREMENT for table `cv-technical`
--
ALTER TABLE `cv-technical`
  MODIFY `technicalid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cv-trainings`
--
ALTER TABLE `cv-trainings`
  MODIFY `trainingid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2100;

--
-- AUTO_INCREMENT for table `cv-volunteer`
--
ALTER TABLE `cv-volunteer`
  MODIFY `volunteerid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1892;

--
-- AUTO_INCREMENT for table `cv-work`
--
ALTER TABLE `cv-work`
  MODIFY `workid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46092;

--
-- AUTO_INCREMENT for table `cvdragonappconfignew`
--
ALTER TABLE `cvdragonappconfignew`
  MODIFY `configid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=721;

--
-- AUTO_INCREMENT for table `cvprofiles`
--
ALTER TABLE `cvprofiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cvsections`
--
ALTER TABLE `cvsections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cv_social_links`
--
ALTER TABLE `cv_social_links`
  MODIFY `socialid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `help-chat`
--
ALTER TABLE `help-chat`
  MODIFY `chatID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19875;

--
-- AUTO_INCREMENT for table `help-faq`
--
ALTER TABLE `help-faq`
  MODIFY `faqID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `help-videos`
--
ALTER TABLE `help-videos`
  MODIFY `videoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `interests`
--
ALTER TABLE `interests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `master_cv_sections`
--
ALTER TABLE `master_cv_sections`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `offerregistration`
--
ALTER TABLE `offerregistration`
  MODIFY `offerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15086;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resource-links`
--
ALTER TABLE `resource-links`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resource-profiledesign`
--
ALTER TABLE `resource-profiledesign`
  MODIFY `designid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100000;

--
-- AUTO_INCREMENT for table `resource-profilefont`
--
ALTER TABLE `resource-profilefont`
  MODIFY `fontid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `resource-profilesetting`
--
ALTER TABLE `resource-profilesetting`
  MODIFY `settingid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `resource-publicdesign`
--
ALTER TABLE `resource-publicdesign`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resource-redirect`
--
ALTER TABLE `resource-redirect`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resource-securitykeys`
--
ALTER TABLE `resource-securitykeys`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resource_carrers`
--
ALTER TABLE `resource_carrers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `resource_profile_design_categories`
--
ALTER TABLE `resource_profile_design_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `section_questions`
--
ALTER TABLE `section_questions`
  MODIFY `sectionquestionid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;

--
-- AUTO_INCREMENT for table `sessionapplication`
--
ALTER TABLE `sessionapplication`
  MODIFY `sessionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84603;

--
-- AUTO_INCREMENT for table `specializations`
--
ALTER TABLE `specializations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `supportcalls`
--
ALTER TABLE `supportcalls`
  MODIFY `callID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=428242;

--
-- AUTO_INCREMENT for table `user-documents`
--
ALTER TABLE `user-documents`
  MODIFY `documentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=184;

--
-- AUTO_INCREMENT for table `user-feedback`
--
ALTER TABLE `user-feedback`
  MODIFY `feedbackid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4125;

--
-- AUTO_INCREMENT for table `user-subscription`
--
ALTER TABLE `user-subscription`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14889791841418;

--
-- AUTO_INCREMENT for table `userss`
--
ALTER TABLE `userss`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=652;

--
-- AUTO_INCREMENT for table `uservoucherdetails`
--
ALTER TABLE `uservoucherdetails`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68346;

--
-- AUTO_INCREMENT for table `user_categories`
--
ALTER TABLE `user_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_otps`
--
ALTER TABLE `user_otps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_voucher_details`
--
ALTER TABLE `user_voucher_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_resource_carrer_id_foreign` FOREIGN KEY (`resource_carrer_id`) REFERENCES `resource_carrers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cvprofiles`
--
ALTER TABLE `cvprofiles`
  ADD CONSTRAINT `cvprofiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `userss` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `interests`
--
ALTER TABLE `interests`
  ADD CONSTRAINT `interests_specialization_id_foreign` FOREIGN KEY (`specialization_id`) REFERENCES `specializations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `resource-section`
--
ALTER TABLE `resource-section`
  ADD CONSTRAINT `abc` FOREIGN KEY (`master_cv_sections_id`) REFERENCES `master_cv_sections` (`id`);

--
-- Constraints for table `specializations`
--
ALTER TABLE `specializations`
  ADD CONSTRAINT `specializations_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
