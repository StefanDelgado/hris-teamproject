-- HRIS Database Schema
-- Created from ERD: January 15, 2026
-- Database Management System: MySQL

-- Create Database
CREATE DATABASE IF NOT EXISTS hris_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hris_db;

-- ============================================
-- REFERENCE TABLES
-- ============================================

-- Role Table
CREATE TABLE IF NOT EXISTS Role (
    role_id INT NOT NULL AUTO_INCREMENT,
    role_description CHAR(50) NOT NULL,
    PRIMARY KEY (role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Department Table
CREATE TABLE IF NOT EXISTS Department (
    department_id INT NOT NULL AUTO_INCREMENT,
    department_description CHAR(50) NOT NULL,
    PRIMARY KEY (department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Employment Table
CREATE TABLE IF NOT EXISTS Employment (
    employment_id INT NOT NULL AUTO_INCREMENT,
    employment_type CHAR(50) NOT NULL,
    employment_start_date DATETIME NOT NULL,
    employment_end_date DATETIME NULL,
    PRIMARY KEY (employment_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Civil_Status Table
CREATE TABLE IF NOT EXISTS Civil_Status (
    civil_status_id INT NOT NULL AUTO_INCREMENT,
    civil_status_type CHAR(50) NOT NULL,
    PRIMARY KEY (civil_status_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Gender Table
CREATE TABLE IF NOT EXISTS Gender (
    gender_id INT NOT NULL AUTO_INCREMENT,
    gender_type CHAR(50) NOT NULL,
    PRIMARY KEY (gender_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Leave_Type Table
CREATE TABLE IF NOT EXISTS Leave_Type (
    leave_type_id INT NOT NULL AUTO_INCREMENT,
    leave_type_description CHAR(50) NOT NULL,
    PRIMARY KEY (leave_type_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- USER TABLE
-- ============================================

-- User Table
CREATE TABLE IF NOT EXISTS User (
    user_id INT NOT NULL AUTO_INCREMENT,
    role_id INT NOT NULL,
    user_first_name CHAR(50) NOT NULL,
    user_last_name CHAR(50) NOT NULL,
    user_password CHAR(50) NOT NULL,
    user_position CHAR(50) NOT NULL,
    user_level INT NULL,
    department_id INT NOT NULL,
    employment_id INT NOT NULL,
    client_id INT NOT NULL,
    PRIMARY KEY (user_id),
    FOREIGN KEY (role_id) REFERENCES Role(role_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (department_id) REFERENCES Department(department_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (employment_id) REFERENCES Employment(employment_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- EMPLOYEE TABLE
-- ============================================

-- Employee Table
CREATE TABLE IF NOT EXISTS Employee (
    employee_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    employee_first_name DATETIME NOT NULL,
    employee_bith_name DATETIME NOT NULL,
    civil_status_id INT NOT NULL,
    gender_id INT NOT NULL,
    benefits_id INT NOT NULL,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (civil_status_id) REFERENCES Civil_Status(civil_status_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (gender_id) REFERENCES Gender(gender_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- CLIENT TABLE
-- ============================================

-- Client Table
CREATE TABLE IF NOT EXISTS Client (
    client_id INT NOT NULL AUTO_INCREMENT,
    client_contact_name CHAR(50) NOT NULL,
    client_contact_number CHAR(50) NOT NULL,
    client_contact_email CHAR(50) NOT NULL,
    client_website CHAR(50) NOT NULL,
    project_id CHAR(50) NOT NULL,
    PRIMARY KEY (client_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add foreign key to User table for client_id
ALTER TABLE User 
ADD CONSTRAINT fk_user_client 
FOREIGN KEY (client_id) REFERENCES Client(client_id) ON DELETE RESTRICT ON UPDATE CASCADE;

-- ============================================
-- PROJECTS TABLE
-- ============================================

-- Projects Table
CREATE TABLE IF NOT EXISTS Projects (
    project_id INT NOT NULL AUTO_INCREMENT,
    project_name CHAR(50) NOT NULL,
    PRIMARY KEY (project_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- BENEFITS TABLE
-- ============================================

-- Benefits Table
CREATE TABLE IF NOT EXISTS Benefits (
    benefits_id INT NOT NULL AUTO_INCREMENT,
    benefits_sss_id INT NOT NULL,
    benefits_sss_amount INT NOT NULL,
    benefits_philhealth_id INT NOT NULL,
    benefits_philhealth_amount INT NOT NULL,
    benefits_bir_id INT NULL,
    benefits_bir_amount INT NOT NULL,
    benefits_insurance_id INT,
    benefits_insurance_amount INT,
    PRIMARY KEY (benefits_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add foreign key to Employee table for benefits_id
ALTER TABLE Employee 
ADD CONSTRAINT fk_employee_benefits 
FOREIGN KEY (benefits_id) REFERENCES Benefits(benefits_id) ON DELETE RESTRICT ON UPDATE CASCADE;

-- ============================================
-- DEPENDENTS TABLE
-- ============================================

-- Dependents Table
CREATE TABLE IF NOT EXISTS Dependents (
    dependents_id INT NOT NULL AUTO_INCREMENT,
    employee_id INT NOT NULL,
    dependent_type CHAR(50) NOT NULL,
    dependent_first_name CHAR(50) NOT NULL,
    dependent_relationship CHAR(50) NOT NULL,
    PRIMARY KEY (dependents_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- SALARY TABLE
-- ============================================

-- Salary Table
CREATE TABLE IF NOT EXISTS Salary (
    salary_id INT NOT NULL AUTO_INCREMENT,
    salary_amount INT NOT NULL,
    salary_bonus INT NOT NULL,
    PRIMARY KEY (salary_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- PAYROLL TABLE
-- ============================================

-- Payroll Table
CREATE TABLE IF NOT EXISTS Payroll (
    payroll_id INT NOT NULL AUTO_INCREMENT,
    employee_id INT NOT NULL,
    salary_id INT NOT NULL,
    timesheet_id INT NOT NULL,
    benefits_id INT NOT NULL,
    payroll_start_date DATETIME NOT NULL,
    payroll_end_date DATETIME NOT NULL,
    payroll_amount INT NOT NULL,
    PRIMARY KEY (payroll_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (salary_id) REFERENCES Salary(salary_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (benefits_id) REFERENCES Benefits(benefits_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- HOLIDAYS TABLE
-- ============================================

-- Holidays Table
CREATE TABLE IF NOT EXISTS Holidays (
    holiday_id INT NOT NULL AUTO_INCREMENT,
    holiday_type CHAR(50) NOT NULL,
    holiday_name CHAR(50) NOT NULL,
    holiday_date DATETIME NOT NULL,
    holiday_rate INT NOT NULL,
    PRIMARY KEY (holiday_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- TIMESHEET TABLE
-- ============================================

-- Timesheet Table
CREATE TABLE IF NOT EXISTS Timesheet (
    timesheet_id INT NOT NULL AUTO_INCREMENT,
    employee_id INT NOT NULL,
    holiday_id INT NULL,
    employee_leave_id INT NULL,
    night_diff_id INT NOT NULL,
    timesheet_start_time DATETIME NOT NULL,
    timesheet_end_time DATETIME NOT NULL,
    timesheet_start_date DATETIME NOT NULL,
    timesheet_end_date DATETIME NOT NULL,
    timesheet_workhours DATETIME NOT NULL,
    timesheet_overtime DATETIME NOT NULL,
    PRIMARY KEY (timesheet_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (holiday_id) REFERENCES Holidays(holiday_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add foreign key to Payroll table for timesheet_id
ALTER TABLE Payroll 
ADD CONSTRAINT fk_payroll_timesheet 
FOREIGN KEY (timesheet_id) REFERENCES Timesheet(timesheet_id) ON DELETE RESTRICT ON UPDATE CASCADE;

-- ============================================
-- NIGHT DIFFERENTIAL TABLE
-- ============================================

-- Night_Diff Table
CREATE TABLE IF NOT EXISTS Night_Diff (
    night_diff_id INT NOT NULL AUTO_INCREMENT,
    night_diff_hours DATETIME NOT NULL,
    night_diff_rate INT NOT NULL,
    PRIMARY KEY (night_diff_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add foreign key to Timesheet table for night_diff_id
ALTER TABLE Timesheet 
ADD CONSTRAINT fk_timesheet_nightdiff 
FOREIGN KEY (night_diff_id) REFERENCES Night_Diff(night_diff_id) ON DELETE RESTRICT ON UPDATE CASCADE;

-- ============================================
-- ANNUAL LEAVE TABLE
-- ============================================

-- Annual_Leave Table
CREATE TABLE IF NOT EXISTS Annual_Leave (
    annual_leave_id INT NOT NULL AUTO_INCREMENT,
    employee_id INT NOT NULL,
    annual_leave_year INT NOT NULL,
    annual_leave_days_per_year INT NOT NULL,
    annual_leave_days_taken INT NOT NULL,
    annual_leave_days_remain INT NOT NULL,
    annual_leave_date_updated DATETIME NOT NULL,
    leave_type_id INT NOT NULL,
    PRIMARY KEY (annual_leave_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (leave_type_id) REFERENCES Leave_Type(leave_type_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- EMPLOYEE LEAVE TABLE
-- ============================================

-- Employee_Leave Table
CREATE TABLE IF NOT EXISTS Employee_Leave (
    employee_leave_id INT NOT NULL AUTO_INCREMENT,
    leave_type_id INT NOT NULL,
    employee_id INT NOT NULL,
    employee_leave_start DATETIME NOT NULL,
    employee_leave_end DATETIME NOT NULL,
    PRIMARY KEY (employee_leave_id),
    FOREIGN KEY (leave_type_id) REFERENCES Leave_Type(leave_type_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add foreign key to Timesheet table for employee_leave_id
ALTER TABLE Timesheet 
ADD CONSTRAINT fk_timesheet_employeeleave 
FOREIGN KEY (employee_leave_id) REFERENCES Employee_Leave(employee_leave_id) ON DELETE RESTRICT ON UPDATE CASCADE;

-- ============================================
-- INDEXES FOR OPTIMIZATION
-- ============================================

-- User table indexes
CREATE INDEX idx_user_role ON User(role_id);
CREATE INDEX idx_user_department ON User(department_id);
CREATE INDEX idx_user_employment ON User(employment_id);
CREATE INDEX idx_user_client ON User(client_id);

-- Employee table indexes
CREATE INDEX idx_employee_user ON Employee(user_id);
CREATE INDEX idx_employee_civil_status ON Employee(civil_status_id);
CREATE INDEX idx_employee_gender ON Employee(gender_id);
CREATE INDEX idx_employee_benefits ON Employee(benefits_id);

-- Payroll table indexes
CREATE INDEX idx_payroll_employee ON Payroll(employee_id);
CREATE INDEX idx_payroll_salary ON Payroll(salary_id);
CREATE INDEX idx_payroll_timesheet ON Payroll(timesheet_id);
CREATE INDEX idx_payroll_benefits ON Payroll(benefits_id);

-- Timesheet table indexes
CREATE INDEX idx_timesheet_employee ON Timesheet(employee_id);
CREATE INDEX idx_timesheet_holiday ON Timesheet(holiday_id);
CREATE INDEX idx_timesheet_employee_leave ON Timesheet(employee_leave_id);
CREATE INDEX idx_timesheet_night_diff ON Timesheet(night_diff_id);

-- Leave table indexes
CREATE INDEX idx_annual_leave_employee ON Annual_Leave(employee_id);
CREATE INDEX idx_annual_leave_type ON Annual_Leave(leave_type_id);
CREATE INDEX idx_employee_leave_type ON Employee_Leave(leave_type_id);
CREATE INDEX idx_employee_leave_employee ON Employee_Leave(employee_id);

-- Dependents table indexes
CREATE INDEX idx_dependents_employee ON Dependents(employee_id);
