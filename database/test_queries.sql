-- HRIS Database Test Queries
-- Run these queries to verify the database setup

USE hris_db;

-- ============================================
-- VERIFICATION QUERIES
-- ============================================

-- Check all tables exist
SELECT 'Checking all tables...' as Status;
SHOW TABLES;

-- Check table row counts
SELECT 'Table row counts:' as Status;
SELECT 
    'Role' as table_name, COUNT(*) as row_count FROM Role
UNION ALL SELECT 'Department', COUNT(*) FROM Department
UNION ALL SELECT 'Employment', COUNT(*) FROM Employment
UNION ALL SELECT 'Civil_Status', COUNT(*) FROM Civil_Status
UNION ALL SELECT 'Gender', COUNT(*) FROM Gender
UNION ALL SELECT 'Leave_Type', COUNT(*) FROM Leave_Type
UNION ALL SELECT 'User', COUNT(*) FROM User
UNION ALL SELECT 'Employee', COUNT(*) FROM Employee
UNION ALL SELECT 'Client', COUNT(*) FROM Client
UNION ALL SELECT 'Projects', COUNT(*) FROM Projects
UNION ALL SELECT 'Benefits', COUNT(*) FROM Benefits
UNION ALL SELECT 'Dependents', COUNT(*) FROM Dependents
UNION ALL SELECT 'Salary', COUNT(*) FROM Salary
UNION ALL SELECT 'Payroll', COUNT(*) FROM Payroll
UNION ALL SELECT 'Holidays', COUNT(*) FROM Holidays
UNION ALL SELECT 'Timesheet', COUNT(*) FROM Timesheet
UNION ALL SELECT 'Night_Diff', COUNT(*) FROM Night_Diff
UNION ALL SELECT 'Annual_Leave', COUNT(*) FROM Annual_Leave
UNION ALL SELECT 'Employee_Leave', COUNT(*) FROM Employee_Leave;

-- ============================================
-- USER AND EMPLOYEE QUERIES
-- ============================================

-- Get all users with their roles and departments
SELECT 'Users with roles and departments:' as Status;
SELECT 
    u.user_id,
    CONCAT(u.user_first_name, ' ', u.user_last_name) as full_name,
    u.user_position,
    r.role_description,
    d.department_description,
    e.employment_type
FROM User u
JOIN Role r ON u.role_id = r.role_id
JOIN Department d ON u.department_id = d.department_id
JOIN Employment e ON u.employment_id = e.employment_id
ORDER BY u.user_id;

-- Get employees with full details
SELECT 'Employees with full details:' as Status;
SELECT 
    emp.employee_id,
    CONCAT(u.user_first_name, ' ', u.user_last_name) as full_name,
    cs.civil_status_type,
    g.gender_type,
    d.department_description,
    u.user_position
FROM Employee emp
JOIN User u ON emp.user_id = u.user_id
JOIN Civil_Status cs ON emp.civil_status_id = cs.civil_status_id
JOIN Gender g ON emp.gender_id = g.gender_id
JOIN Department d ON u.department_id = d.department_id
ORDER BY emp.employee_id;

-- ============================================
-- PAYROLL QUERIES
-- ============================================

-- Payroll summary with salary and deductions
SELECT 'Payroll summary:' as Status;
SELECT 
    CONCAT(u.user_first_name, ' ', u.user_last_name) as employee_name,
    s.salary_amount,
    s.salary_bonus,
    (s.salary_amount + s.salary_bonus) as gross_pay,
    b.benefits_sss_amount,
    b.benefits_philhealth_amount,
    b.benefits_bir_amount,
    (b.benefits_sss_amount + b.benefits_philhealth_amount + b.benefits_bir_amount) as total_deductions,
    p.payroll_amount as net_pay,
    p.payroll_start_date,
    p.payroll_end_date
FROM Payroll p
JOIN Employee emp ON p.employee_id = emp.employee_id
JOIN User u ON emp.user_id = u.user_id
JOIN Salary s ON p.salary_id = s.salary_id
JOIN Benefits b ON p.benefits_id = b.benefits_id
ORDER BY p.payroll_start_date DESC, u.user_last_name;

-- ============================================
-- LEAVE MANAGEMENT QUERIES
-- ============================================

-- Annual leave balances
SELECT 'Annual leave balances:' as Status;
SELECT 
    CONCAT(u.user_first_name, ' ', u.user_last_name) as employee_name,
    lt.leave_type_description,
    al.annual_leave_year,
    al.annual_leave_days_per_year as total_days,
    al.annual_leave_days_taken as taken,
    al.annual_leave_days_remain as remaining
FROM Annual_Leave al
JOIN Employee emp ON al.employee_id = emp.employee_id
JOIN User u ON emp.user_id = u.user_id
JOIN Leave_Type lt ON al.leave_type_id = lt.leave_type_id
WHERE al.annual_leave_year = 2026
ORDER BY u.user_last_name, lt.leave_type_description;

-- Employee leave history
SELECT 'Employee leave history:' as Status;
SELECT 
    CONCAT(u.user_first_name, ' ', u.user_last_name) as employee_name,
    lt.leave_type_description,
    el.employee_leave_start,
    el.employee_leave_end,
    DATEDIFF(el.employee_leave_end, el.employee_leave_start) + 1 as days_count
FROM Employee_Leave el
JOIN Employee emp ON el.employee_id = emp.employee_id
JOIN User u ON emp.user_id = u.user_id
JOIN Leave_Type lt ON el.leave_type_id = lt.leave_type_id
ORDER BY el.employee_leave_start DESC;

-- ============================================
-- TIMESHEET QUERIES
-- ============================================

-- Timesheet records with overtime and night differential
SELECT 'Timesheet records:' as Status;
SELECT 
    CONCAT(u.user_first_name, ' ', u.user_last_name) as employee_name,
    DATE(t.timesheet_start_date) as work_date,
    t.timesheet_start_time,
    t.timesheet_end_time,
    t.timesheet_workhours as work_hours,
    t.timesheet_overtime as overtime,
    nd.night_diff_hours,
    nd.night_diff_rate,
    h.holiday_name
FROM Timesheet t
JOIN Employee emp ON t.employee_id = emp.employee_id
JOIN User u ON emp.user_id = u.user_id
LEFT JOIN Night_Diff nd ON t.night_diff_id = nd.night_diff_id
LEFT JOIN Holidays h ON t.holiday_id = h.holiday_id
ORDER BY t.timesheet_start_date DESC;

-- ============================================
-- BENEFITS QUERIES
-- ============================================

-- Employee benefits summary
SELECT 'Employee benefits summary:' as Status;
SELECT 
    CONCAT(u.user_first_name, ' ', u.user_last_name) as employee_name,
    b.benefits_sss_id as sss_number,
    b.benefits_sss_amount as sss_contribution,
    b.benefits_philhealth_id as philhealth_number,
    b.benefits_philhealth_amount as philhealth_contribution,
    b.benefits_bir_id as tin_number,
    b.benefits_bir_amount as tax_amount,
    b.benefits_insurance_id as insurance_number,
    b.benefits_insurance_amount as insurance_premium
FROM Employee emp
JOIN User u ON emp.user_id = u.user_id
JOIN Benefits b ON emp.benefits_id = b.benefits_id
ORDER BY u.user_last_name;

-- ============================================
-- DEPENDENTS QUERIES
-- ============================================

-- Employees with dependents
SELECT 'Employees with dependents:' as Status;
SELECT 
    CONCAT(u.user_first_name, ' ', u.user_last_name) as employee_name,
    d.dependent_first_name as dependent_name,
    d.dependent_type,
    d.dependent_relationship
FROM Dependents d
JOIN Employee emp ON d.employee_id = emp.employee_id
JOIN User u ON emp.user_id = u.user_id
ORDER BY u.user_last_name, d.dependent_relationship;

-- Count dependents per employee
SELECT 'Dependents count per employee:' as Status;
SELECT 
    CONCAT(u.user_first_name, ' ', u.user_last_name) as employee_name,
    COUNT(d.dependents_id) as total_dependents
FROM Employee emp
JOIN User u ON emp.user_id = u.user_id
LEFT JOIN Dependents d ON emp.employee_id = d.employee_id
GROUP BY emp.employee_id
HAVING total_dependents > 0
ORDER BY total_dependents DESC, u.user_last_name;

-- ============================================
-- HOLIDAY CALENDAR
-- ============================================

-- Upcoming holidays in 2026
SELECT 'Holidays calendar 2026:' as Status;
SELECT 
    holiday_name,
    holiday_date,
    holiday_type,
    CONCAT(holiday_rate, '%') as rate
FROM Holidays
WHERE YEAR(holiday_date) = 2026
ORDER BY holiday_date;

-- ============================================
-- CLIENT AND PROJECT QUERIES
-- ============================================

-- Clients list
SELECT 'Clients list:' as Status;
SELECT * FROM Client ORDER BY client_contact_name;

-- Projects list
SELECT 'Projects list:' as Status;
SELECT * FROM Projects ORDER BY project_name;

-- Users assigned to clients
SELECT 'Users assigned to clients:' as Status;
SELECT 
    c.client_contact_name,
    CONCAT(u.user_first_name, ' ', u.user_last_name) as employee_name,
    u.user_position,
    d.department_description
FROM User u
JOIN Client c ON u.client_id = c.client_id
JOIN Department d ON u.department_id = d.department_id
ORDER BY c.client_contact_name, u.user_last_name;

-- ============================================
-- DATABASE STATISTICS
-- ============================================

-- Foreign key relationships
SELECT 'Foreign key relationships:' as Status;
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'hris_db' 
    AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME, COLUMN_NAME;

-- Table indexes
SELECT 'Database indexes:' as Status;
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    GROUP_CONCAT(COLUMN_NAME ORDER BY SEQ_IN_INDEX) as columns
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'hris_db'
GROUP BY TABLE_NAME, INDEX_NAME
ORDER BY TABLE_NAME, INDEX_NAME;

-- Database size
SELECT 'Database size:' as Status;
SELECT 
    table_name AS 'Table',
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.TABLES
WHERE table_schema = 'hris_db'
ORDER BY (data_length + index_length) DESC;

-- Total database size
SELECT 
    'Total Database Size' as Description,
    ROUND(SUM((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.TABLES
WHERE table_schema = 'hris_db';

SELECT 'All tests completed!' as Status;
