-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.38-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table 80.assignment
DROP TABLE IF EXISTS `assignment`;
CREATE TABLE IF NOT EXISTS `assignment` (
  `T_SSN` varchar(20) NOT NULL,
  `Course_No` varchar(20) NOT NULL,
  `Sec_No` varchar(20) NOT NULL,
  PRIMARY KEY (`T_SSN`,`Course_No`,`Sec_No`),
  KEY `Course_No` (`Course_No`),
  KEY `Sec_No` (`Sec_No`),
  CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`T_SSN`) REFERENCES `staff` (`T_SSN`),
  CONSTRAINT `assignment_ibfk_2` FOREIGN KEY (`Course_No`) REFERENCES `courses` (`Course_No`),
  CONSTRAINT `assignment_ibfk_3` FOREIGN KEY (`Sec_No`) REFERENCES `section` (`Sec_No`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table 80.assignment: ~0 rows (approximately)
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;

-- Dumping structure for table 80.building
DROP TABLE IF EXISTS `building`;
CREATE TABLE IF NOT EXISTS `building` (
  `Building_Id` int(11) NOT NULL AUTO_INCREMENT,
  `B_Name` varchar(100) DEFAULT NULL,
  `Location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Building_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table 80.building: ~1 rows (approximately)
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` (`Building_Id`, `B_Name`, `Location`) VALUES
	(1, 'Main Campus', 'City Center');
/*!40000 ALTER TABLE `building` ENABLE KEYS */;

-- Dumping structure for table 80.courses
DROP TABLE IF EXISTS `courses`;
CREATE TABLE IF NOT EXISTS `courses` (
  `Course_No` varchar(20) NOT NULL,
  `Course_Name` varchar(100) DEFAULT NULL,
  `Credit` double DEFAULT NULL,
  `TA_hr_req` varchar(100) DEFAULT NULL,
  `Dept_Code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Course_No`),
  KEY `Dept_Code` (`Dept_Code`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`Dept_Code`) REFERENCES `departments` (`Dept_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table 80.courses: ~8 rows (approximately)
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` (`Course_No`, `Course_Name`, `Credit`, `TA_hr_req`, `Dept_Code`) VALUES
	('ACCT101', 'Accounting', 4, NULL, 'FA'),
	('ENG101', 'Enghlish as Language', 3, NULL, 'LA'),
	('ENG102', 'English Literature', 4, NULL, 'LA'),
	('FIN101', 'Financial Reporting', 4, NULL, 'FA'),
	('JAVA101', 'Introduction to Java', 4, NULL, 'CS'),
	('MKT101', 'Marketing', 4, NULL, 'BM'),
	('MKT102', 'Marketing in 21st Century', 4, NULL, 'BM'),
	('PY101', 'Python Basics', 4, NULL, 'CS');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;

-- Dumping structure for table 80.departments
DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
  `Dept_Code` varchar(20) NOT NULL,
  `Dept_Name` varchar(100) DEFAULT NULL,
  `A_Budget` int(11) DEFAULT NULL,
  `Building_Id` int(11) DEFAULT NULL,
  `Dept_Chair` varchar(20) DEFAULT NULL,
  `Dept_location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Dept_Code`),
  KEY `Building_Id` (`Building_Id`),
  KEY `Dept_Chair` (`Dept_Chair`),
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`Building_Id`) REFERENCES `building` (`Building_Id`),
  CONSTRAINT `departments_ibfk_2` FOREIGN KEY (`Dept_Chair`) REFERENCES `staff` (`T_SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table 80.departments: ~4 rows (approximately)
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` (`Dept_Code`, `Dept_Name`, `A_Budget`, `Building_Id`, `Dept_Chair`, `Dept_location`) VALUES
	('BM', 'Business Management', NULL, 1, '102', NULL),
	('CS', 'Computer Sceinces', NULL, 1, '100', NULL),
	('FA', 'Finance and Accounts', NULL, 1, '103', NULL),
	('LA', 'Language Arts', NULL, 1, '101', NULL);
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;

-- Dumping structure for table 80.faculty_department
DROP TABLE IF EXISTS `faculty_department`;
CREATE TABLE IF NOT EXISTS `faculty_department` (
  `T_SSN` varchar(20) NOT NULL,
  `Dept_Code` varchar(20) NOT NULL,
  PRIMARY KEY (`T_SSN`,`Dept_Code`),
  KEY `Dept_Code` (`Dept_Code`),
  CONSTRAINT `faculty_department_ibfk_1` FOREIGN KEY (`T_SSN`) REFERENCES `staff` (`T_SSN`),
  CONSTRAINT `faculty_department_ibfk_2` FOREIGN KEY (`Dept_Code`) REFERENCES `departments` (`Dept_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table 80.faculty_department: ~0 rows (approximately)
/*!40000 ALTER TABLE `faculty_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `faculty_department` ENABLE KEYS */;

-- Dumping structure for table 80.registration
DROP TABLE IF EXISTS `registration`;
CREATE TABLE IF NOT EXISTS `registration` (
  `S_ID` int(11) NOT NULL,
  `Sec_No` varchar(20) NOT NULL,
  `Course_No` varchar(20) NOT NULL,
  PRIMARY KEY (`S_ID`,`Sec_No`,`Course_No`),
  KEY `Sec_No` (`Sec_No`),
  KEY `Course_No` (`Course_No`),
  CONSTRAINT `registration_ibfk_1` FOREIGN KEY (`S_ID`) REFERENCES `student` (`S_ID`),
  CONSTRAINT `registration_ibfk_2` FOREIGN KEY (`Sec_No`) REFERENCES `section` (`Sec_No`),
  CONSTRAINT `registration_ibfk_3` FOREIGN KEY (`Course_No`) REFERENCES `courses` (`Course_No`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table 80.registration: ~12 rows (approximately)
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` (`S_ID`, `Sec_No`, `Course_No`) VALUES
	(1, 'ACA', 'ACCT101'),
	(1, 'BMA', 'MKT101'),
	(1, 'LAA', 'ENG101'),
	(1, 'LAB', 'ENG102'),
	(2, 'BMB', 'MKT102'),
	(2, 'CSA', 'JAVA101'),
	(2, 'CSB', 'PY101'),
	(3, 'BMB', 'MKT102'),
	(3, 'CSA', 'JAVA101'),
	(4, 'BMA', 'MKT101'),
	(4, 'BMB', 'MKT102'),
	(6, 'BMA', 'MKT101');
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;

-- Dumping structure for table 80.room
DROP TABLE IF EXISTS `room`;
CREATE TABLE IF NOT EXISTS `room` (
  `Building_Id` int(11) NOT NULL,
  `Room_No` varchar(20) NOT NULL,
  `Capacity` int(11) DEFAULT NULL,
  `Audio_Visual` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Building_Id`,`Room_No`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`Building_Id`) REFERENCES `building` (`Building_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table 80.room: ~2 rows (approximately)
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` (`Building_Id`, `Room_No`, `Capacity`, `Audio_Visual`) VALUES
	(1, 'A1', 100, 'Multimedia, Speakers'),
	(1, 'A2', 100, 'Multimedia, Speakers');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;

-- Dumping structure for table 80.section
DROP TABLE IF EXISTS `section`;
CREATE TABLE IF NOT EXISTS `section` (
  `Sec_No` varchar(20) NOT NULL,
  `Course_No` varchar(20) DEFAULT NULL,
  `C_Year` int(11) DEFAULT NULL,
  `Semester` varchar(100) DEFAULT NULL,
  `Max_enroll` int(11) DEFAULT NULL,
  `Instructor_SSN` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Sec_No`),
  KEY `Course_No` (`Course_No`),
  KEY `Instructor_SSN` (`Instructor_SSN`),
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`Course_No`) REFERENCES `courses` (`Course_No`),
  CONSTRAINT `section_ibfk_2` FOREIGN KEY (`Instructor_SSN`) REFERENCES `staff` (`T_SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table 80.section: ~8 rows (approximately)
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` (`Sec_No`, `Course_No`, `C_Year`, `Semester`, `Max_enroll`, `Instructor_SSN`) VALUES
	('ACA', 'ACCT101', 2019, 'Spring', 10, '101'),
	('ACB', 'FIN101', 2019, 'Autumn', 10, '101'),
	('BMA', 'MKT101', 2019, 'Spring', 10, '103'),
	('BMB', 'MKT102', 2019, 'Autumn', 3, '103'),
	('CSA', 'JAVA101', 2019, 'Spring', 10, '100'),
	('CSB', 'PY101', 2019, 'Autumn', 10, '100'),
	('LAA', 'ENG101', 2019, 'Spring', 10, '102'),
	('LAB', 'ENG102', 2019, 'Autumn', 10, '102');
/*!40000 ALTER TABLE `section` ENABLE KEYS */;

-- Dumping structure for table 80.sectioninroom
DROP TABLE IF EXISTS `sectioninroom`;
CREATE TABLE IF NOT EXISTS `sectioninroom` (
  `Building_Id` int(11) NOT NULL,
  `Room_No` varchar(20) NOT NULL,
  `Course_No` varchar(20) NOT NULL,
  `Sec_No` varchar(20) NOT NULL,
  `Weekday` varchar(20) DEFAULT NULL,
  `Time` time DEFAULT NULL,
  PRIMARY KEY (`Building_Id`,`Room_No`,`Course_No`,`Sec_No`),
  KEY `Course_No` (`Course_No`),
  KEY `Sec_No` (`Sec_No`),
  CONSTRAINT `sectioninroom_ibfk_1` FOREIGN KEY (`Building_Id`, `Room_No`) REFERENCES `room` (`Building_Id`, `Room_No`),
  CONSTRAINT `sectioninroom_ibfk_2` FOREIGN KEY (`Course_No`) REFERENCES `courses` (`Course_No`),
  CONSTRAINT `sectioninroom_ibfk_3` FOREIGN KEY (`Sec_No`) REFERENCES `section` (`Sec_No`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table 80.sectioninroom: ~8 rows (approximately)
/*!40000 ALTER TABLE `sectioninroom` DISABLE KEYS */;
INSERT INTO `sectioninroom` (`Building_Id`, `Room_No`, `Course_No`, `Sec_No`, `Weekday`, `Time`) VALUES
	(1, 'A1', 'ACCT101', 'ACA', 'Monday', '08:30:00'),
	(1, 'A1', 'ENG101', 'LAA', 'Tuesday', '11:00:00'),
	(1, 'A1', 'ENG102', 'LAB', 'Wednesday', '12:30:00'),
	(1, 'A1', 'MKT101', 'BMA', 'Thursday', '15:00:00'),
	(1, 'A2', 'FIN101', 'ACB', 'Tuesday', '11:00:00'),
	(1, 'A2', 'JAVA101', 'CSA', 'Monday', '08:30:00'),
	(1, 'A2', 'MKT102', 'BMB', 'Thursday', '15:00:00'),
	(1, 'A2', 'PY101', 'CSB', 'Wednesday', '12:30:00');
/*!40000 ALTER TABLE `sectioninroom` ENABLE KEYS */;

-- Dumping structure for table 80.staff
DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff` (
  `T_SSN` varchar(20) NOT NULL,
  `T_NAME` varchar(100) DEFAULT NULL,
  `T_ADD` varchar(250) DEFAULT NULL,
  `staff_function` varchar(100) DEFAULT NULL,
  `T_Salary` int(11) DEFAULT NULL,
  `staff_rank` varchar(100) DEFAULT NULL,
  `Course_Load` int(11) DEFAULT NULL,
  `Work_hr` int(11) DEFAULT NULL,
  PRIMARY KEY (`T_SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table 80.staff: ~6 rows (approximately)
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` (`T_SSN`, `T_NAME`, `T_ADD`, `staff_function`, `T_Salary`, `staff_rank`, `Course_Load`, `Work_hr`) VALUES
	('100', 'Prof Albert', NULL, NULL, NULL, NULL, NULL, NULL),
	('101', 'Prof Brian', NULL, NULL, NULL, NULL, NULL, NULL),
	('102', 'Prof Charlie', NULL, NULL, NULL, NULL, NULL, NULL),
	('103', 'Prof Douglas', NULL, NULL, NULL, NULL, NULL, NULL),
	('104', 'Prof Elrado', NULL, NULL, NULL, NULL, NULL, NULL),
	('105', 'Prof Franklin', NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;

-- Dumping structure for table 80.student
DROP TABLE IF EXISTS `student`;
CREATE TABLE IF NOT EXISTS `student` (
  `S_ID` int(11) NOT NULL AUTO_INCREMENT,
  `S_SSN` varchar(20) DEFAULT NULL,
  `S_Name` varchar(100) DEFAULT NULL,
  `S_Add` varchar(250) DEFAULT NULL,
  `S_High` varchar(100) DEFAULT NULL,
  `S_Year` int(11) DEFAULT NULL,
  `Major` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`S_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dumping data for table 80.student: ~6 rows (approximately)
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` (`S_ID`, `S_SSN`, `S_Name`, `S_Add`, `S_High`, `S_Year`, `Major`) VALUES
	(1, '1', 'Adam', 'Adam Street', 'A', 2019, 'Artificial Intelligence'),
	(2, '2', 'Britney', 'Britney Street', 'B', 2019, 'Business Administration'),
	(3, '3', 'Christina', 'Christy Street', 'C', 2019, 'Computer Sciences'),
	(4, '4', 'David', 'David Street', 'D', 2019, 'Databases'),
	(5, '5', 'Emaa', 'Emaa Street', 'E', 2019, 'English Literature'),
	(6, '6', 'Frank', 'Frank Street', 'F', 2019, 'Financial Accounting');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
