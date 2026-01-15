# HRIS Database - ERD to SQL Implementation

## Overview
This database schema is created based on the HRIS Entity Relationship Diagram (ERD). It implements a comprehensive Human Resource Information System with the following key features:

- User and Employee Management
- Payroll Processing
- Leave Management
- Timesheet and Attendance
- Benefits Administration
- Client and Project Tracking

## Database Structure

### Reference Tables
1. **Role** - User roles and permissions
2. **Department** - Company departments
3. **Employment** - Employment types and dates
4. **Civil_Status** - Marital status
5. **Gender** - Gender types
6. **Leave_Type** - Types of leaves available

### Core Tables
7. **User** - System users with authentication
8. **Employee** - Employee personal information
9. **Client** - Client information
10. **Projects** - Project details
11. **Benefits** - Employee benefits (SSS, PhilHealth, BIR, Insurance)
12. **Dependents** - Employee dependents information

### Operational Tables
13. **Salary** - Salary and bonus information
14. **Payroll** - Payroll processing records
15. **Holidays** - Holiday calendar with rates
16. **Timesheet** - Employee time tracking
17. **Night_Diff** - Night differential records
18. **Annual_Leave** - Annual leave balances
19. **Employee_Leave** - Leave requests and records

## Installation

### Prerequisites
- XAMPP installed with MySQL/MariaDB
- MySQL running on port 3306
- phpMyAdmin or MySQL CLI access

### Quick Setup (Using Batch File - Recommended)

1. Open Command Prompt or PowerShell as Administrator
2. Navigate to the database folder:
   ```
   cd "c:\xampp\htdocs\WebDesign_BSITA-2\2nd sem\Joshan_System\hris-teamproject\database"
   ```
3. Run the setup script:
   ```
   setup.bat
   ```
4. Follow the prompts to create the database and optionally load sample data

### Manual Setup

#### Method 1: Using phpMyAdmin
1. Start XAMPP and ensure MySQL is running
2. Open phpMyAdmin (http://localhost/phpmyadmin)
3. Click "Import" tab
4. Select `hris_schema.sql` and click "Go"
5. After completion, import `sample_data.sql` (optional)

#### Method 2: Using MySQL Command Line
```bash
cd C:\xampp\mysql\bin

# Login to MySQL
mysql -u root -p

# Create database and tables
source "c:\xampp\htdocs\WebDesign_BSITA-2\2nd sem\Joshan_System\hris-teamproject\database\hris_schema.sql";

# Load sample data (optional)
source "c:\xampp\htdocs\WebDesign_BSITA-2\2nd sem\Joshan_System\hris-teamproject\database\sample_data.sql";
```

#### Method 3: Using PowerShell
```powershell
cd C:\xampp\mysql\bin

# Create schema
.\mysql.exe -u root -p < "c:\xampp\htdocs\WebDesign_BSITA-2\2nd sem\Joshan_System\hris-teamproject\database\hris_schema.sql"

# Load sample data
.\mysql.exe -u root -p < "c:\xampp\htdocs\WebDesign_BSITA-2\2nd sem\Joshan_System\hris-teamproject\database\sample_data.sql"
```

## Database Configuration

### Connection Details
- **Database Name:** hris_db
- **Host:** localhost
- **Port:** 3306
- **Username:** root
- **Password:** (empty by default in XAMPP)
- **Charset:** utf8mb4

### PHP Connection
Use the provided `db_config.php` file for PHP applications:
```php
require_once 'database/db_config.php';
$db = new Database();
$conn = $db->getConnection();
```

## Entity Relationships

### Key Relationships
- **User → Role:** Many-to-One (Users have one role)
- **User → Department:** Many-to-One (Users belong to one department)
- **User → Employment:** Many-to-One (Users have one employment type)
- **User → Client:** Many-to-One (Users associated with clients)
- **Employee → User:** One-to-One (Each employee has a user account)
- **Employee → Benefits:** Many-to-One (Employees have benefits)
- **Employee → Dependents:** One-to-Many (Employees can have multiple dependents)
- **Employee → Annual_Leave:** One-to-Many (Employees have multiple leave types)
- **Employee → Employee_Leave:** One-to-Many (Employees can have multiple leave records)
- **Payroll → Employee:** Many-to-One
- **Payroll → Salary:** Many-to-One
- **Payroll → Timesheet:** Many-to-One
- **Payroll → Benefits:** Many-to-One
- **Timesheet → Holiday:** Many-to-One (Optional)
- **Timesheet → Employee_Leave:** Many-to-One (Optional)
- **Timesheet → Night_Diff:** Many-to-One

## Sample Queries

### Get Employee Full Details
```sql
SELECT 
    u.user_first_name,
    u.user_last_name,
    u.user_position,
    d.department_description,
    e.employment_type,
    cs.civil_status_type,
    g.gender_type
FROM User u
JOIN Employee emp ON u.user_id = emp.user_id
JOIN Department d ON u.department_id = d.department_id
JOIN Employment e ON u.employment_id = e.employment_id
JOIN Civil_Status cs ON emp.civil_status_id = cs.civil_status_id
JOIN Gender g ON emp.gender_id = g.gender_id;
```

### Calculate Employee Payroll
```sql
SELECT 
    u.user_first_name,
    u.user_last_name,
    s.salary_amount,
    s.salary_bonus,
    b.benefits_sss_amount,
    b.benefits_philhealth_amount,
    b.benefits_bir_amount,
    p.payroll_amount
FROM Payroll p
JOIN Employee emp ON p.employee_id = emp.employee_id
JOIN User u ON emp.user_id = u.user_id
JOIN Salary s ON p.salary_id = s.salary_id
JOIN Benefits b ON p.benefits_id = b.benefits_id
WHERE p.payroll_start_date >= '2026-01-01'
ORDER BY u.user_last_name;
```

### Check Leave Balances
```sql
SELECT 
    u.user_first_name,
    u.user_last_name,
    lt.leave_type_description,
    al.annual_leave_days_per_year,
    al.annual_leave_days_taken,
    al.annual_leave_days_remain
FROM Annual_Leave al
JOIN Employee emp ON al.employee_id = emp.employee_id
JOIN User u ON emp.user_id = u.user_id
JOIN Leave_Type lt ON al.leave_type_id = lt.leave_type_id
WHERE al.annual_leave_year = 2026
ORDER BY u.user_last_name, lt.leave_type_description;
```

### Timesheet Summary
```sql
SELECT 
    u.user_first_name,
    u.user_last_name,
    DATE(t.timesheet_start_date) as work_date,
    t.timesheet_workhours,
    t.timesheet_overtime,
    nd.night_diff_hours,
    h.holiday_name
FROM Timesheet t
JOIN Employee emp ON t.employee_id = emp.employee_id
JOIN User u ON emp.user_id = u.user_id
LEFT JOIN Night_Diff nd ON t.night_diff_id = nd.night_diff_id
LEFT JOIN Holidays h ON t.holiday_id = h.holiday_id
ORDER BY t.timesheet_start_date DESC, u.user_last_name;
```

## Data Validation Notes

Based on the ERD, please note:
- **employee_first_name** and **employee_bith_name** are DATETIME fields (as per ERD)
- **timesheet_workhours** and **timesheet_overtime** are DATETIME fields (as per ERD)
- All amounts in Benefits and Salary are INT type (as per ERD)

If these should be different data types (e.g., VARCHAR for names, DECIMAL for hours, etc.), please update the schema accordingly.

## Maintenance

### Backup Database
```bash
mysqldump -u root -p hris_db > hris_backup_YYYYMMDD.sql
```

### Restore Database
```bash
mysql -u root -p hris_db < hris_backup_YYYYMMDD.sql
```

### Optimize Tables
```sql
OPTIMIZE TABLE User, Employee, Payroll, Timesheet;
```

## Security Recommendations

1. **Password Hashing:** Use bcrypt or Argon2 for password hashing
2. **SQL Injection:** Always use prepared statements
3. **Access Control:** Implement role-based access control
4. **Database User:** Create a dedicated database user with limited privileges
5. **Backup:** Schedule regular automated backups
6. **SSL/TLS:** Use encrypted connections in production

## Testing

After installation, run the test queries:
```bash
mysql -u root -p hris_db < test_queries.sql
```

## Troubleshooting

### MySQL Not Running
- Open XAMPP Control Panel
- Click "Start" next to MySQL
- Wait for status to show "Running"

### Import Errors
- Check MySQL error log: `C:\xampp\mysql\data\mysql_error.log`
- Ensure no syntax errors in SQL files
- Verify MySQL version compatibility

### Connection Issues
- Verify MySQL is running on port 3306
- Check firewall settings
- Confirm database credentials in `db_config.php`

## Version
- **Version:** 1.0
- **Created:** January 15, 2026
- **Database:** hris_db
- **Charset:** utf8mb4_unicode_ci

## Support
For issues or questions, refer to:
- ERD diagram documentation
- MySQL official documentation
- XAMPP troubleshooting guide
