# HRIS Project Architecture

## 📁 Project Directory Structure

```
hris-teamproject/
│
├── 📂 database/                    # Database files and scripts
│   ├── hris_schema.sql            # Database schema
│   ├── sample_data.sql            # Sample data for testing
│   ├── db_config.php              # Database connection configuration
│   ├── setup.bat                  # Automated database setup script
│   ├── test_queries.sql           # Test and verification queries
│   └── README.md                  # Database documentation
│
├── 📂 config/                      # Configuration files
│   ├── config.php                 # Main application configuration
│   ├── database.php               # Database connection settings
│   ├── constants.php              # System constants and settings
│   └── session.php                # Session management configuration
│
├── 📂 includes/                    # Reusable PHP includes
│   ├── header.php                 # Common header template
│   ├── footer.php                 # Common footer template
│   ├── navbar.php                 # Navigation bar component
│   ├── sidebar.php                # Sidebar navigation component
│   ├── functions.php              # Common utility functions
│   └── validation.php             # Form validation functions
│
├── 📂 assets/                      # Static resources
│   │
│   ├── 📂 css/                    # Stylesheets
│   │   ├── style.css              # Main stylesheet
│   │   ├── admin.css              # Admin panel styles
│   │   ├── dashboard.css          # Dashboard styles
│   │   ├── forms.css              # Form styles
│   │   └── responsive.css         # Responsive design styles
│   │
│   ├── 📂 js/                     # JavaScript files
│   │   ├── main.js                # Main JavaScript file
│   │   ├── validation.js          # Form validation scripts
│   │   ├── ajax.js                # AJAX request handlers
│   │   ├── charts.js              # Chart and graph scripts
│   │   └── datatable.js           # DataTable configurations
│   │
│   ├── 📂 images/                 # Image assets
│   │   ├── logo.png               # Company/system logo
│   │   ├── icons/                 # Icon files
│   │   └── backgrounds/           # Background images
│   │
│   └── 📂 uploads/                # User uploaded files
│       ├── 📂 documents/          # Employee documents
│       └── 📂 profiles/           # Profile pictures
│
├── 📂 modules/                     # Feature modules
│   │
│   ├── 📂 auth/                   # Authentication module
│   │   ├── login.php              # Login page
│   │   ├── logout.php             # Logout handler
│   │   ├── register.php           # User registration
│   │   ├── forgot-password.php    # Password recovery
│   │   └── reset-password.php     # Password reset
│   │
│   ├── 📂 dashboard/              # Dashboard module
│   │   ├── index.php              # Main dashboard
│   │   ├── stats.php              # Dashboard statistics
│   │   └── widgets.php            # Dashboard widgets
│   │
│   ├── 📂 employees/              # Employee management
│   │   ├── index.php              # Employee list
│   │   ├── add.php                # Add new employee
│   │   ├── edit.php               # Edit employee
│   │   ├── view.php               # View employee details
│   │   ├── delete.php             # Delete employee
│   │   └── dependents.php         # Manage dependents
│   │
│   ├── 📂 payroll/                # Payroll management
│   │   ├── index.php              # Payroll dashboard
│   │   ├── generate.php           # Generate payroll
│   │   ├── view.php               # View payroll details
│   │   ├── process.php            # Process payroll
│   │   ├── salary.php             # Salary management
│   │   └── deductions.php         # Deductions management
│   │
│   ├── 📂 attendance/             # Attendance/Timesheet module
│   │   ├── index.php              # Attendance list
│   │   ├── clock-in.php           # Clock in/out
│   │   ├── timesheet.php          # Timesheet management
│   │   ├── overtime.php           # Overtime records
│   │   └── night-diff.php         # Night differential
│   │
│   ├── 📂 leaves/                 # Leave management
│   │   ├── index.php              # Leave requests list
│   │   ├── apply.php              # Apply for leave
│   │   ├── approve.php            # Approve/reject leave
│   │   ├── balance.php            # Leave balance
│   │   └── types.php              # Leave types management
│   │
│   ├── 📂 benefits/               # Benefits management
│   │   ├── index.php              # Benefits overview
│   │   ├── sss.php                # SSS management
│   │   ├── philhealth.php         # PhilHealth management
│   │   ├── pagibig.php            # Pag-IBIG management
│   │   └── insurance.php          # Insurance management
│   │
│   ├── 📂 projects/               # Project management
│   │   ├── index.php              # Projects list
│   │   ├── add.php                # Add new project
│   │   ├── edit.php               # Edit project
│   │   └── view.php               # View project details
│   │
│   ├── 📂 clients/                # Client management
│   │   ├── index.php              # Clients list
│   │   ├── add.php                # Add new client
│   │   ├── edit.php               # Edit client
│   │   └── view.php               # View client details
│   │
│   ├── 📂 reports/                # Reports module
│   │   ├── index.php              # Reports dashboard
│   │   ├── payroll-report.php     # Payroll reports
│   │   ├── attendance-report.php  # Attendance reports
│   │   ├── leave-report.php       # Leave reports
│   │   ├── employee-report.php    # Employee reports
│   │   └── export.php             # Export functionality
│   │
│   └── 📂 settings/               # System settings
│       ├── index.php              # Settings dashboard
│       ├── departments.php        # Department management
│       ├── positions.php          # Position management
│       ├── roles.php              # Role management
│       ├── holidays.php           # Holiday calendar
│       └── system.php             # System configuration
│
├── 📂 admin/                       # Admin panel (Administrator role)
│   ├── index.php                  # Admin dashboard
│   ├── users.php                  # User management
│   ├── roles.php                  # Role management
│   ├── departments.php            # Department management
│   ├── system-logs.php            # System audit logs
│   └── settings.php               # System settings
│
├── 📂 hr/                          # HR Manager panel
│   ├── index.php                  # HR dashboard
│   ├── employees.php              # Employee management
│   ├── recruitment.php            # Recruitment management
│   ├── leave-approvals.php        # Leave approvals
│   └── performance.php            # Performance management
│
├── 📂 manager/                     # Manager panel
│   ├── index.php                  # Manager dashboard
│   ├── team.php                   # Team management
│   ├── approve-leave.php          # Approve team leave
│   ├── timesheets.php             # Team timesheets
│   └── reports.php                # Team reports
│
├── 📂 employee/                    # Employee panel
│   ├── index.php                  # Employee dashboard
│   ├── profile.php                # Employee profile
│   ├── my-leave.php               # My leave requests
│   ├── my-timesheet.php           # My timesheet
│   ├── my-payslip.php             # My payslips
│   └── my-benefits.php            # My benefits
│
├── 📂 api/                         # API endpoints (for AJAX requests)
│   ├── employees.php              # Employee API endpoints
│   ├── payroll.php                # Payroll API endpoints
│   ├── attendance.php             # Attendance API endpoints
│   ├── leaves.php                 # Leave API endpoints
│   └── reports.php                # Report API endpoints
│
├── 📂 vendor/                      # Third-party libraries (Composer)
│   └── autoload.php               # Composer autoloader
│
├── 📂 logs/                        # Application logs
│   ├── error.log                  # Error logs
│   ├── access.log                 # Access logs
│   └── audit.log                  # Audit trail logs
│
├── 📂 backups/                     # Database backups
│   └── (auto-generated backups)
│
├── 📄 index.php                    # Main entry point / Landing page
├── 📄 .htaccess                    # Apache configuration
├── 📄 .gitignore                   # Git ignore file
├── 📄 composer.json                # Composer dependencies
└── 📄 README.md                    # Project documentation
```

## 🏗️ Architecture Overview

### **1. Presentation Layer (Frontend)**
- **Location:** `assets/`, `includes/`, module view files
- **Purpose:** User interface and user experience
- **Technologies:** HTML5, CSS3, JavaScript, Bootstrap
- **Components:**
  - Responsive layouts
  - Forms and input validation
  - Data tables and charts
  - Navigation and routing

### **2. Business Logic Layer (Backend)**
- **Location:** `modules/`, `api/`, `includes/functions.php`
- **Purpose:** Application logic and processing
- **Technologies:** PHP 7.4+, PDO
- **Components:**
  - User authentication and authorization
  - CRUD operations
  - Business rules enforcement
  - Data validation and sanitization

### **3. Data Access Layer**
- **Location:** `database/`, `config/database.php`
- **Purpose:** Database interaction
- **Technologies:** MySQL/MariaDB, PDO
- **Components:**
  - Database connection management
  - Query execution
  - Transaction handling
  - Data persistence

### **4. Role-Based Access Control (RBAC)**

| Role | Access Level | Directories |
|------|-------------|-------------|
| **Administrator** | Full system access | `/admin/`, all modules |
| **HR Manager** | HR functions, employee management | `/hr/`, most modules |
| **Manager** | Team management, approvals | `/manager/`, limited modules |
| **Employee** | Personal information, self-service | `/employee/`, own data only |

## 🔄 Application Flow

```
1. User Access
   ↓
2. index.php (Entry Point)
   ↓
3. Authentication (modules/auth/)
   ↓
4. Role-Based Routing
   ├── Admin → /admin/
   ├── HR Manager → /hr/
   ├── Manager → /manager/
   └── Employee → /employee/
   ↓
5. Module Processing (modules/)
   ↓
6. Database Operations (database/)
   ↓
7. Response/View Rendering
   ↓
8. User Interface (includes/ + assets/)
```

## 📊 Module Breakdown

### **Core Modules**

1. **Authentication (auth/)**
   - User login/logout
   - Password management
   - Session handling
   - Access control

2. **Dashboard (dashboard/)**
   - Role-specific dashboards
   - Statistics and metrics
   - Quick actions
   - Notifications

3. **Employee Management (employees/)**
   - Employee CRUD operations
   - Personal information
   - Employment history
   - Dependent management

4. **Payroll (payroll/)**
   - Salary processing
   - Deductions calculation
   - Benefits integration
   - Payslip generation

5. **Attendance (attendance/)**
   - Time tracking
   - Clock in/out
   - Overtime management
   - Night differential

6. **Leave Management (leaves/)**
   - Leave applications
   - Approval workflow
   - Leave balance tracking
   - Leave types

7. **Benefits (benefits/)**
   - SSS, PhilHealth, Pag-IBIG
   - Insurance management
   - Benefit calculations

8. **Reports (reports/)**
   - Payroll reports
   - Attendance reports
   - Leave reports
   - Export functionality

## 🔐 Security Features

- **Authentication:** Session-based with secure password hashing
- **Authorization:** Role-based access control (RBAC)
- **Input Validation:** Server-side and client-side validation
- **SQL Injection Prevention:** Prepared statements with PDO
- **XSS Protection:** Output escaping and sanitization
- **CSRF Protection:** Token-based form validation
- **File Upload Security:** Type and size validation
- **Audit Logging:** Track user actions in `logs/`

## 🗄️ Database Integration

- **Connection:** PDO with `config/database.php`
- **Schema:** Located in `database/hris_schema.sql`
- **Migrations:** Manual SQL scripts
- **Backups:** Automated backups in `backups/`
- **Testing:** Sample data in `database/sample_data.sql`

## 🎨 Frontend Technologies

- **CSS Framework:** Bootstrap 5 / Custom CSS
- **JavaScript:** Vanilla JS / jQuery
- **Charts:** Chart.js / ApexCharts
- **DataTables:** For tabular data
- **Icons:** Font Awesome / Bootstrap Icons
- **Responsive:** Mobile-first design

## 🔧 Development Guidelines

### **File Naming Conventions**
- PHP files: `lowercase-with-hyphens.php`
- CSS files: `lowercase-with-hyphens.css`
- JavaScript: `camelCase.js`
- Classes: `PascalCase`

### **Code Organization**
- One feature per module
- Separate concerns (MVC-like)
- Reusable components in `includes/`
- API endpoints in `api/`

### **Database Access**
- Always use prepared statements
- Use transaction for multi-step operations
- Close connections properly
- Log database errors

## 📝 Getting Started

1. **Setup Database**
   ```bash
   cd database
   setup.bat
   ```

2. **Configure Application**
   - Update `config/database.php` with credentials
   - Set timezone and constants in `config/config.php`

3. **Set Permissions**
   ```bash
   chmod 755 assets/uploads/
   chmod 755 logs/
   chmod 755 backups/
   ```

4. **Access Application**
   - URL: `http://localhost/WebDesign_BSITA-2/2nd sem/Joshan_System/hris-teamproject/`
   - Default admin credentials (from sample data)

## 🚀 Deployment Checklist

- [ ] Update database credentials
- [ ] Set error reporting to production mode
- [ ] Enable HTTPS
- [ ] Secure file upload directories
- [ ] Set up automated backups
- [ ] Configure proper file permissions
- [ ] Remove sample data
- [ ] Enable audit logging
- [ ] Test all modules
- [ ] Update documentation

## 📚 Additional Resources

- **Database Documentation:** `database/README.md`
- **ERD Diagram:** `HRIS Documentation.pdf`
- **API Documentation:** (To be created in `api/`)
- **User Manual:** (To be created)

## 🤝 Team Collaboration

- **Version Control:** Git (GitHub repository)
- **Branching Strategy:** Feature branches
- **Code Reviews:** Required before merge
- **Documentation:** Keep README files updated

---

**Version:** 1.0  
**Last Updated:** January 15, 2026  
**Project:** HRIS Team Project
