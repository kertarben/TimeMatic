-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 24, 2025 at 01:19 AM
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
-- Database: `tm`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `AnnouncementID` int(11) NOT NULL,
  `Title` varchar(100) NOT NULL,
  `Message` text NOT NULL,
  `TargetRole` enum('student','instructor','all') NOT NULL DEFAULT 'all',
  `DatePosted` datetime DEFAULT current_timestamp(),
  `PostedBy` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `classroom`
--

CREATE TABLE `classroom` (
  `ClassroomID` int(11) NOT NULL,
  `Room` varchar(50) NOT NULL,
  `Building` varchar(50) NOT NULL,
  `Capacity` int(11) DEFAULT NULL CHECK (`Capacity` > 0),
  `Equipment` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classroom`
--

INSERT INTO `classroom` (`ClassroomID`, `Room`, `Building`, `Capacity`, `Equipment`) VALUES
(1, 'CSS Lab1', 'CICTE', 30, 'Projector, Whiteboard'),
(2, 'CSS Lab 2', 'CICTE', 25, 'Projector, Whiteboard, Computers'),
(3, 'Com. Lab 5', 'Main Building', 40, 'Projector, Whiteboard'),
(4, 'Com. Lab 7', 'Main Building', 35, 'Projector, Whiteboard, Smart Board'),
(5, 'Trainers L', 'CICTE', 20, 'Computers, Projector');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `CourseCode` varchar(10) NOT NULL,
  `CourseName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`CourseCode`, `CourseName`) VALUES
('ACT', 'Associate in Computer Technology'),
('BSCpE', 'Bachelor of Science in Computer Engineering'),
('BSCS', 'Bachelor of Science in Computer Science'),
('BSIT', 'Bachelor of Science in Information Technology');

-- --------------------------------------------------------

--
-- Table structure for table `dean`
--

CREATE TABLE `dean` (
  `DeanID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dean`
--

INSERT INTO `dean` (`DeanID`, `UserID`, `Name`, `Email`) VALUES
(4, 1, 'Dean1', 'dean@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `enrollment`
--

CREATE TABLE `enrollment` (
  `EnrollmentID` int(11) NOT NULL,
  `StudentID` int(11) NOT NULL,
  `SectionID` int(11) NOT NULL,
  `YearLevel` int(11) DEFAULT NULL CHECK (`YearLevel` between 1 and 4)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `instructor`
--

CREATE TABLE `instructor` (
  `InstructorID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Department` varchar(50) NOT NULL,
  `OfficeLocation` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instructor`
--

INSERT INTO `instructor` (`InstructorID`, `UserID`, `Name`, `Department`, `OfficeLocation`) VALUES
(1, 2, 'Instructor1', 'CICTE', 'CICTE Office'),
(2, 3, 'Instructor2', 'CICTE', 'CICTE Office'),
(10, 16, 'inst', 'CICTE', 'CICTE Office');

-- --------------------------------------------------------

--
-- Table structure for table `instructoravailability`
--

CREATE TABLE `instructoravailability` (
  `AvailabilityID` int(11) NOT NULL,
  `InstructorID` int(11) NOT NULL,
  `SlotID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prerequisite`
--

CREATE TABLE `prerequisite` (
  `CourseCode` varchar(10) NOT NULL,
  `PrereqCode` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `ScheduleID` int(11) NOT NULL,
  `SectionID` int(11) NOT NULL,
  `InstructorID` int(11) NOT NULL,
  `SubjectCode` varchar(10) NOT NULL,
  `RoomID` int(11) NOT NULL,
  `SlotID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

CREATE TABLE `section` (
  `SectionID` int(11) NOT NULL,
  `CourseCode` varchar(10) NOT NULL,
  `SectionNumber` varchar(5) NOT NULL,
  `InstructorID` int(11) NOT NULL,
  `ClassroomID` int(11) NOT NULL,
  `SlotID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section`
--

INSERT INTO `section` (`SectionID`, `CourseCode`, `SectionNumber`, `InstructorID`, `ClassroomID`, `SlotID`) VALUES
(1, 'BSCS', '1101', 10, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `StudentID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `YearLevel` int(11) DEFAULT NULL CHECK (`YearLevel` between 1 and 4),
  `Email` varchar(255) NOT NULL,
  `CourseCode` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`StudentID`, `UserID`, `Name`, `YearLevel`, `Email`, `CourseCode`) VALUES
(1, 4, 'Student1', 2, 'student1@gmail.com', 'BSCS'),
(2, 5, 'Student2', 3, 'student2@gmail.com', 'BSIT');

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `SubjectCode` varchar(10) NOT NULL,
  `SubjectName` varchar(100) NOT NULL,
  `Units` smallint(6) DEFAULT NULL CHECK (`Units` > 0),
  `Description` text DEFAULT NULL,
  `CourseCode` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `timeslot`
--

CREATE TABLE `timeslot` (
  `SlotID` int(11) NOT NULL,
  `DayOfWeek` varchar(50) DEFAULT NULL,
  `StartTime` time NOT NULL,
  `EndTime` time NOT NULL,
  `Semester` enum('1st Semester','2nd Semester','Summer','') DEFAULT NULL,
  `Year` int(11) DEFAULT NULL CHECK (`Year` >= 2000)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `timeslot`
--

INSERT INTO `timeslot` (`SlotID`, `DayOfWeek`, `StartTime`, `EndTime`, `Semester`, `Year`) VALUES
(1, 'MWF', '07:30:00', '09:30:00', '1st Semester', 2026);

-- --------------------------------------------------------

--
-- Table structure for table `useraccount`
--

CREATE TABLE `useraccount` (
  `UserID` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `Name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `useraccount`
--

INSERT INTO `useraccount` (`UserID`, `email`, `password`, `role`, `Name`) VALUES
(1, 'dean@gmail.com', '$2b$10$Ixopw1TsSj539qxgcWGUCu8NDgzALGKVVdB1NiWySP2vni9Vfegmq', 'dean', 'Dean1'),
(2, 'inst1@gmail.com', '$2b$10$fNpE/y8FRVGMB93pwYPiBOP9K6Q6c9mmzNCSEcKQsrBDTJkmEuK1.', 'instructor', 'New Instructor'),
(3, 'instructor2@gmail.com', '$2b$10$/JLQCBupsUl4NA6Q..qo5epbayG/m5tba0Ufj0joGtbseah240VKW', 'instructor', 'Instructor2'),
(4, 'student1@gmail.com', '$2b$10$5UTrQdypOMWhOk1qK374Eeh/5pmn/9QvJg2m08FOyJxTUmf2iovMi', 'student', 'Student1'),
(5, 'student2@gmail.com', '$2b$10$Ta1RV5dyh/7MIML3ffr.necZgqY1xuUUIo54xbXQYyLzdtF/NQvcK', 'student', 'Student2'),
(16, 'inst@gmail.com', '$2b$10$5MDv14zT3vMJs7YyZ8iAWO/DbORIpCo36IsQaGcYUVjKhlJkgVaTW', 'instructor', 'inst');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`AnnouncementID`),
  ADD KEY `PostedBy` (`PostedBy`);

--
-- Indexes for table `classroom`
--
ALTER TABLE `classroom`
  ADD PRIMARY KEY (`ClassroomID`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`CourseCode`);

--
-- Indexes for table `dean`
--
ALTER TABLE `dean`
  ADD PRIMARY KEY (`DeanID`),
  ADD UNIQUE KEY `UserID` (`UserID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD PRIMARY KEY (`EnrollmentID`),
  ADD KEY `StudentID` (`StudentID`),
  ADD KEY `SectionID` (`SectionID`);

--
-- Indexes for table `instructor`
--
ALTER TABLE `instructor`
  ADD PRIMARY KEY (`InstructorID`),
  ADD UNIQUE KEY `UserID` (`UserID`);

--
-- Indexes for table `instructoravailability`
--
ALTER TABLE `instructoravailability`
  ADD PRIMARY KEY (`AvailabilityID`),
  ADD KEY `InstructorID` (`InstructorID`),
  ADD KEY `SlotID` (`SlotID`);

--
-- Indexes for table `prerequisite`
--
ALTER TABLE `prerequisite`
  ADD PRIMARY KEY (`CourseCode`,`PrereqCode`),
  ADD KEY `PrereqCode` (`PrereqCode`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`ScheduleID`),
  ADD KEY `SectionID` (`SectionID`),
  ADD KEY `InstructorID` (`InstructorID`),
  ADD KEY `SubjectCode` (`SubjectCode`),
  ADD KEY `RoomID` (`RoomID`),
  ADD KEY `SlotID` (`SlotID`);

--
-- Indexes for table `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`SectionID`),
  ADD KEY `CourseCode` (`CourseCode`),
  ADD KEY `InstructorID` (`InstructorID`),
  ADD KEY `ClassroomID` (`ClassroomID`),
  ADD KEY `SlotID` (`SlotID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`StudentID`),
  ADD UNIQUE KEY `UserID` (`UserID`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `FK_Student_Course` (`CourseCode`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`SubjectCode`),
  ADD KEY `CourseCode` (`CourseCode`);

--
-- Indexes for table `timeslot`
--
ALTER TABLE `timeslot`
  ADD PRIMARY KEY (`SlotID`);

--
-- Indexes for table `useraccount`
--
ALTER TABLE `useraccount`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `AnnouncementID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `classroom`
--
ALTER TABLE `classroom`
  MODIFY `ClassroomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `dean`
--
ALTER TABLE `dean`
  MODIFY `DeanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `enrollment`
--
ALTER TABLE `enrollment`
  MODIFY `EnrollmentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `instructor`
--
ALTER TABLE `instructor`
  MODIFY `InstructorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `instructoravailability`
--
ALTER TABLE `instructoravailability`
  MODIFY `AvailabilityID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `ScheduleID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `section`
--
ALTER TABLE `section`
  MODIFY `SectionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `StudentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `timeslot`
--
ALTER TABLE `timeslot`
  MODIFY `SlotID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `useraccount`
--
ALTER TABLE `useraccount`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`PostedBy`) REFERENCES `useraccount` (`UserID`);

--
-- Constraints for table `dean`
--
ALTER TABLE `dean`
  ADD CONSTRAINT `dean_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `useraccount` (`UserID`) ON DELETE CASCADE;

--
-- Constraints for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD CONSTRAINT `enrollment_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`),
  ADD CONSTRAINT `enrollment_ibfk_2` FOREIGN KEY (`SectionID`) REFERENCES `section` (`SectionID`);

--
-- Constraints for table `instructor`
--
ALTER TABLE `instructor`
  ADD CONSTRAINT `instructor_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `useraccount` (`UserID`) ON DELETE CASCADE;

--
-- Constraints for table `instructoravailability`
--
ALTER TABLE `instructoravailability`
  ADD CONSTRAINT `instructoravailability_ibfk_1` FOREIGN KEY (`InstructorID`) REFERENCES `instructor` (`InstructorID`),
  ADD CONSTRAINT `instructoravailability_ibfk_2` FOREIGN KEY (`SlotID`) REFERENCES `timeslot` (`SlotID`);

--
-- Constraints for table `prerequisite`
--
ALTER TABLE `prerequisite`
  ADD CONSTRAINT `prerequisite_ibfk_1` FOREIGN KEY (`CourseCode`) REFERENCES `course` (`CourseCode`),
  ADD CONSTRAINT `prerequisite_ibfk_2` FOREIGN KEY (`PrereqCode`) REFERENCES `course` (`CourseCode`);

--
-- Constraints for table `schedules`
--
ALTER TABLE `schedules`
  ADD CONSTRAINT `schedules_ibfk_1` FOREIGN KEY (`SectionID`) REFERENCES `section` (`SectionID`),
  ADD CONSTRAINT `schedules_ibfk_2` FOREIGN KEY (`InstructorID`) REFERENCES `instructor` (`InstructorID`),
  ADD CONSTRAINT `schedules_ibfk_3` FOREIGN KEY (`SubjectCode`) REFERENCES `subject` (`SubjectCode`),
  ADD CONSTRAINT `schedules_ibfk_4` FOREIGN KEY (`RoomID`) REFERENCES `classroom` (`ClassroomID`),
  ADD CONSTRAINT `schedules_ibfk_5` FOREIGN KEY (`SlotID`) REFERENCES `timeslot` (`SlotID`);

--
-- Constraints for table `section`
--
ALTER TABLE `section`
  ADD CONSTRAINT `section_ibfk_1` FOREIGN KEY (`CourseCode`) REFERENCES `course` (`CourseCode`),
  ADD CONSTRAINT `section_ibfk_2` FOREIGN KEY (`InstructorID`) REFERENCES `instructor` (`InstructorID`),
  ADD CONSTRAINT `section_ibfk_3` FOREIGN KEY (`ClassroomID`) REFERENCES `classroom` (`ClassroomID`),
  ADD CONSTRAINT `section_ibfk_4` FOREIGN KEY (`SlotID`) REFERENCES `timeslot` (`SlotID`);

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `FK_Student_Course` FOREIGN KEY (`CourseCode`) REFERENCES `course` (`CourseCode`) ON DELETE SET NULL,
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `useraccount` (`UserID`) ON DELETE CASCADE;

--
-- Constraints for table `subject`
--
ALTER TABLE `subject`
  ADD CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`CourseCode`) REFERENCES `course` (`CourseCode`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
