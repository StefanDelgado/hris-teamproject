-- HRIS Sample Data
-- Created from ERD: January 15, 2026

USE hris_db;

-- ============================================
-- INSERT SAMPLE DATA
-- ============================================

-- Insert Roles
INSERT INTO Role (role_description) VALUES
('Administrator'),
('HR Manager'),
('Employee'),
('Manager'),
('Supervisor');

-- Insert Departments
INSERT INTO Department (department_description) VALUES
('Human Resources'),
('Information Technology'),
('Finance'),
('Sales and Marketing'),
('Operations'),
('Customer Service');

-- Insert Employment Types
INSERT INTO Employment (employment_type, employment_start_date, employment_end_date) VALUES
('Full-time', '2020-01-15 08:00:00', NULL),
('Part-time', '2020-02-01 08:00:00', NULL),
('Contract', '2021-03-10 08:00:00', '2023-03-10 17:00:00'),
('Full-time', '2019-06-15 08:00:00', NULL),
('Full-time', '2021-05-20 08:00:00', NULL),
('Full-time', '2018-08-01 08:00:00', NULL),
('Full-time', '2020-10-15 08:00:00', NULL),
('Full-time', '2022-01-10 08:00:00', NULL);

-- Insert Civil Status
INSERT INTO Civil_Status (civil_status_type) VALUES
('Single'),
('Married'),
('Divorced'),
('Widowed'),
('Separated');

-- Insert Gender
INSERT INTO Gender (gender_type) VALUES
('Male'),
('Female'),
('Other');

-- Insert Leave Types
INSERT INTO Leave_Type (leave_type_description) VALUES
('Vacation Leave'),
('Sick Leave'),
('Emergency Leave'),
('Maternity Leave'),
('Paternity Leave'),
('Bereavement Leave');

-- Insert Clients
INSERT INTO Client (client_contact_name, client_contact_number, client_contact_email, client_website, project_id) VALUES
('ABC Corporation', '02-1234-5678', 'contact@abccorp.com', 'www.abccorp.com', '1'),
('XYZ Industries', '02-8765-4321', 'info@xyzind.com', 'www.xyzind.com', '2'),
('Tech Solutions Inc', '02-5555-6666', 'support@techsol.com', 'www.techsol.com', '3'),
('Global Services Ltd', '02-7777-8888', 'hello@globalserv.com', 'www.globalserv.com', '4');

-- Insert Projects
INSERT INTO Projects (project_name) VALUES
('Website Development'),
('Mobile App Development'),
('ERP Implementation'),
('Digital Marketing Campaign'),
('Infrastructure Upgrade');

-- Insert Benefits
INSERT INTO Benefits (benefits_sss_id, benefits_sss_amount, benefits_philhealth_id, benefits_philhealth_amount, 
    benefits_bir_id, benefits_bir_amount, benefits_insurance_id, benefits_insurance_amount) VALUES
(111111, 1200, 222222, 800, 333333, 2500, 444444, 1500),
(111112, 1000, 222223, 700, 333334, 2000, 444445, 1200),
(111113, 1400, 222224, 900, 333335, 3000, 444446, 1800),
(111114, 1100, 222225, 750, 333336, 2200, 444447, 1300),
(111115, 1300, 222226, 850, 333337, 2800, 444448, 1600),
(111116, 1500, 222227, 950, 333338, 3200, 444449, 2000);

-- Insert Users
INSERT INTO User (role_id, user_first_name, user_last_name, user_password, user_position, user_level, 
    department_id, employment_id, client_id) VALUES
(1, 'Maria', 'Garcia', 'hashed_password_1', 'HR Manager', 3, 1, 1, 1),
(3, 'Juan', 'Cruz', 'hashed_password_2', 'Software Developer', 2, 2, 2, 2),
(4, 'Ana', 'Lopez', 'hashed_password_3', 'IT Manager', 4, 2, 4, 3),
(3, 'Pedro', 'Reyes', 'hashed_password_4', 'Accountant', 2, 3, 5, 1),
(3, 'Sofia', 'Fernandez', 'hashed_password_5', 'Marketing Specialist', 2, 4, 6, 4),
(5, 'Carlos', 'Santos', 'hashed_password_6', 'Operations Supervisor', 3, 5, 7, 2),
(3, 'Isabel', 'Torres', 'hashed_password_7', 'Customer Service Rep', 1, 6, 8, 3),
(3, 'Miguel', 'Villanueva', 'hashed_password_8', 'Sales Representative', 2, 4, 1, 4);

-- Insert Employees
INSERT INTO Employee (user_id, employee_first_name, employee_bith_name, civil_status_id, gender_id, benefits_id) VALUES
(1, '1985-03-15 00:00:00', '1985-03-15 00:00:00', 2, 2, 1),
(2, '1990-07-22 00:00:00', '1990-07-22 00:00:00', 1, 1, 2),
(3, '1988-11-05 00:00:00', '1988-11-05 00:00:00', 1, 2, 3),
(4, '1992-04-18 00:00:00', '1992-04-18 00:00:00', 2, 1, 4),
(5, '1991-09-30 00:00:00', '1991-09-30 00:00:00', 1, 2, 5),
(6, '1987-12-12 00:00:00', '1987-12-12 00:00:00', 2, 1, 6),
(7, '1993-05-25 00:00:00', '1993-05-25 00:00:00', 1, 2, 1),
(8, '1989-08-08 00:00:00', '1989-08-08 00:00:00', 2, 1, 2);

-- Insert Dependents
INSERT INTO Dependents (employee_id, dependent_type, dependent_first_name, dependent_relationship) VALUES
(1, 'Child', 'Anna Garcia', 'Daughter'),
(1, 'Spouse', 'Roberto Garcia', 'Husband'),
(4, 'Child', 'Luis Reyes', 'Son'),
(4, 'Spouse', 'Carmen Reyes', 'Wife'),
(6, 'Child', 'Elena Santos', 'Daughter'),
(6, 'Child', 'Marco Santos', 'Son'),
(6, 'Spouse', 'Patricia Santos', 'Wife'),
(8, 'Spouse', 'Diana Villanueva', 'Wife');

-- Insert Salary
INSERT INTO Salary (salary_amount, salary_bonus) VALUES
(55000, 5000),
(38000, 3000),
(60000, 6000),
(35000, 2500),
(42000, 3500),
(50000, 4500),
(28000, 2000),
(45000, 4000);

-- Insert Holidays
INSERT INTO Holidays (holiday_type, holiday_name, holiday_date, holiday_rate) VALUES
('Regular Holiday', 'New Year\'s Day', '2026-01-01 00:00:00', 200),
('Special Non-working', 'Chinese New Year', '2026-01-29 00:00:00', 130),
('Regular Holiday', 'EDSA Revolution', '2026-02-25 00:00:00', 200),
('Regular Holiday', 'Maundy Thursday', '2026-04-02 00:00:00', 200),
('Regular Holiday', 'Good Friday', '2026-04-03 00:00:00', 200),
('Regular Holiday', 'Labor Day', '2026-05-01 00:00:00', 200),
('Regular Holiday', 'Independence Day', '2026-06-12 00:00:00', 200),
('Special Non-working', 'Ninoy Aquino Day', '2026-08-21 00:00:00', 130),
('Regular Holiday', 'National Heroes Day', '2026-08-31 00:00:00', 200),
('Regular Holiday', 'Bonifacio Day', '2026-11-30 00:00:00', 200),
('Regular Holiday', 'Christmas Day', '2026-12-25 00:00:00', 200),
('Regular Holiday', 'Rizal Day', '2026-12-30 00:00:00', 200);

-- Insert Night Differential
INSERT INTO Night_Diff (night_diff_hours, night_diff_rate) VALUES
('2026-01-08 02:00:00', 110),
('2026-01-08 03:00:00', 110),
('2026-01-09 01:30:00', 110),
('2026-01-10 04:00:00', 110);

-- Insert Annual Leave
INSERT INTO Annual_Leave (employee_id, annual_leave_year, annual_leave_days_per_year, 
    annual_leave_days_taken, annual_leave_days_remain, annual_leave_date_updated, leave_type_id) VALUES
(1, 2026, 15, 3, 12, '2026-01-15 10:00:00', 1),
(1, 2026, 15, 2, 13, '2026-01-15 10:00:00', 2),
(2, 2026, 15, 1, 14, '2026-01-15 10:00:00', 1),
(2, 2026, 15, 0, 15, '2026-01-15 10:00:00', 2),
(3, 2026, 15, 5, 10, '2026-01-15 10:00:00', 1),
(3, 2026, 15, 1, 14, '2026-01-15 10:00:00', 2),
(4, 2026, 15, 0, 15, '2026-01-15 10:00:00', 1),
(5, 2026, 15, 2, 13, '2026-01-15 10:00:00', 1);

-- Insert Employee Leave
INSERT INTO Employee_Leave (leave_type_id, employee_id, employee_leave_start, employee_leave_end) VALUES
(1, 1, '2026-02-10 08:00:00', '2026-02-12 17:00:00'),
(2, 2, '2026-01-20 08:00:00', '2026-01-20 17:00:00'),
(1, 3, '2026-03-15 08:00:00', '2026-03-19 17:00:00'),
(1, 5, '2026-02-05 08:00:00', '2026-02-07 17:00:00');

-- Insert Timesheet
INSERT INTO Timesheet (employee_id, holiday_id, employee_leave_id, night_diff_id, 
    timesheet_start_time, timesheet_end_time, timesheet_start_date, timesheet_end_date, 
    timesheet_workhours, timesheet_overtime) VALUES
(1, NULL, NULL, 1, '2026-01-08 08:00:00', '2026-01-08 19:00:00', '2026-01-08 00:00:00', '2026-01-08 23:59:59', '2026-01-08 08:00:00', '2026-01-08 03:00:00'),
(2, NULL, NULL, 2, '2026-01-08 08:00:00', '2026-01-08 20:00:00', '2026-01-08 00:00:00', '2026-01-08 23:59:59', '2026-01-08 08:00:00', '2026-01-08 04:00:00'),
(3, NULL, NULL, 1, '2026-01-09 08:00:00', '2026-01-09 17:00:00', '2026-01-09 00:00:00', '2026-01-09 23:59:59', '2026-01-09 08:00:00', '2026-01-09 00:00:00'),
(4, NULL, NULL, 3, '2026-01-09 08:00:00', '2026-01-09 18:30:00', '2026-01-09 00:00:00', '2026-01-09 23:59:59', '2026-01-09 08:00:00', '2026-01-09 02:30:00'),
(1, NULL, NULL, 1, '2026-01-10 08:00:00', '2026-01-10 17:00:00', '2026-01-10 00:00:00', '2026-01-10 23:59:59', '2026-01-10 08:00:00', '2026-01-10 00:00:00'),
(2, NULL, 2, 1, '2026-01-20 08:00:00', '2026-01-20 17:00:00', '2026-01-20 00:00:00', '2026-01-20 23:59:59', '2026-01-20 08:00:00', '2026-01-20 00:00:00');

-- Insert Payroll
INSERT INTO Payroll (employee_id, salary_id, timesheet_id, benefits_id, 
    payroll_start_date, payroll_end_date, payroll_amount) VALUES
(1, 1, 1, 1, '2026-01-01 00:00:00', '2026-01-15 23:59:59', 27500),
(2, 2, 2, 2, '2026-01-01 00:00:00', '2026-01-15 23:59:59', 19000),
(3, 3, 3, 3, '2026-01-01 00:00:00', '2026-01-15 23:59:59', 30000),
(4, 4, 4, 4, '2026-01-01 00:00:00', '2026-01-15 23:59:59', 17500),
(1, 1, 5, 1, '2026-01-16 00:00:00', '2026-01-31 23:59:59', 27500),
(2, 2, 6, 2, '2026-01-16 00:00:00', '2026-01-31 23:59:59', 19000);

-- Display summary
SELECT 'Database populated successfully!' as Status;
SELECT 'Total Roles:', COUNT(*) as Count FROM Role;
SELECT 'Total Departments:', COUNT(*) as Count FROM Department;
SELECT 'Total Users:', COUNT(*) as Count FROM User;
SELECT 'Total Employees:', COUNT(*) as Count FROM Employee;
SELECT 'Total Payroll Records:', COUNT(*) as Count FROM Payroll;
