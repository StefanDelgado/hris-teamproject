<?php
/**
 * HRIS Database Connection Configuration
 * Based on ERD Implementation
 * Created: January 15, 2026
 */

// Database configuration constants
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'hris_db');
define('DB_CHARSET', 'utf8mb4');

/**
 * Database Connection Class
 * Handles all database operations with PDO
 */
class Database {
    private $host = DB_HOST;
    private $user = DB_USER;
    private $pass = DB_PASS;
    private $dbname = DB_NAME;
    private $charset = DB_CHARSET;
    
    protected $conn;
    
    /**
     * Constructor - Initializes database connection
     */
    public function __construct() {
        $this->connect();
    }
    
    /**
     * Create PDO database connection
     */
    private function connect() {
        try {
            $dsn = "mysql:host=" . $this->host . ";dbname=" . $this->dbname . ";charset=" . $this->charset;
            $options = [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ];
            
            $this->conn = new PDO($dsn, $this->user, $this->pass, $options);
            
        } catch(PDOException $e) {
            die("Connection failed: " . $e->getMessage());
        }
    }
    
    /**
     * Get database connection
     * @return PDO connection object
     */
    public function getConnection() {
        return $this->conn;
    }
    
    /**
     * Close database connection
     */
    public function closeConnection() {
        $this->conn = null;
    }
    
    /**
     * Execute a prepared statement query
     * @param string $sql SQL query
     * @param array $params Parameters for prepared statement
     * @return PDOStatement
     */
    public function query($sql, $params = []) {
        try {
            $stmt = $this->conn->prepare($sql);
            $stmt->execute($params);
            return $stmt;
        } catch(PDOException $e) {
            throw new Exception("Query failed: " . $e->getMessage());
        }
    }
    
    /**
     * Fetch all results from query
     * @param string $sql SQL query
     * @param array $params Parameters for prepared statement
     * @return array Result set
     */
    public function fetchAll($sql, $params = []) {
        $stmt = $this->query($sql, $params);
        return $stmt->fetchAll();
    }
    
    /**
     * Fetch single result from query
     * @param string $sql SQL query
     * @param array $params Parameters for prepared statement
     * @return array|false Single row or false
     */
    public function fetchOne($sql, $params = []) {
        $stmt = $this->query($sql, $params);
        return $stmt->fetch();
    }
    
    /**
     * Get last inserted ID
     * @return string Last insert ID
     */
    public function lastInsertId() {
        return $this->conn->lastInsertId();
    }
    
    /**
     * Begin transaction
     * @return bool
     */
    public function beginTransaction() {
        return $this->conn->beginTransaction();
    }
    
    /**
     * Commit transaction
     * @return bool
     */
    public function commit() {
        return $this->conn->commit();
    }
    
    /**
     * Rollback transaction
     * @return bool
     */
    public function rollback() {
        return $this->conn->rollBack();
    }
}

/**
 * Example Usage:
 */

/*
// Initialize database connection
$db = new Database();

// ============================================
// USER QUERIES
// ============================================

// Get all users with their roles and departments
$users = $db->fetchAll("
    SELECT u.*, r.role_description, d.department_description 
    FROM User u
    JOIN Role r ON u.role_id = r.role_id
    JOIN Department d ON u.department_id = d.department_id
");

// Get single user by ID
$user = $db->fetchOne("SELECT * FROM User WHERE user_id = ?", [1]);

// Insert new user
$sql = "INSERT INTO User (role_id, user_first_name, user_last_name, user_password, 
        user_position, user_level, department_id, employment_id, client_id) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
$db->query($sql, [3, 'John', 'Doe', password_hash('password123', PASSWORD_DEFAULT), 
                  'Developer', 2, 2, 1, 1]);
$userId = $db->lastInsertId();

// ============================================
// EMPLOYEE QUERIES
// ============================================

// Get employee with full details
$employee = $db->fetchOne("
    SELECT e.*, u.user_first_name, u.user_last_name, 
           cs.civil_status_type, g.gender_type
    FROM Employee e
    JOIN User u ON e.user_id = u.user_id
    JOIN Civil_Status cs ON e.civil_status_id = cs.civil_status_id
    JOIN Gender g ON e.gender_id = g.gender_id
    WHERE e.employee_id = ?
", [1]);

// Get all employees with their benefits
$employees = $db->fetchAll("
    SELECT e.employee_id, u.user_first_name, u.user_last_name,
           b.benefits_sss_amount, b.benefits_philhealth_amount, 
           b.benefits_bir_amount
    FROM Employee e
    JOIN User u ON e.user_id = u.user_id
    JOIN Benefits b ON e.benefits_id = b.benefits_id
");

// ============================================
// PAYROLL QUERIES
// ============================================

// Get payroll for specific period
$payroll = $db->fetchAll("
    SELECT p.*, u.user_first_name, u.user_last_name, 
           s.salary_amount, s.salary_bonus
    FROM Payroll p
    JOIN Employee e ON p.employee_id = e.employee_id
    JOIN User u ON e.user_id = u.user_id
    JOIN Salary s ON p.salary_id = s.salary_id
    WHERE p.payroll_start_date >= ? AND p.payroll_end_date <= ?
", ['2026-01-01', '2026-01-31']);

// Calculate employee net pay
$netPay = $db->fetchOne("
    SELECT s.salary_amount + s.salary_bonus as gross_pay,
           b.benefits_sss_amount + b.benefits_philhealth_amount + 
           b.benefits_bir_amount as total_deductions,
           (s.salary_amount + s.salary_bonus) - 
           (b.benefits_sss_amount + b.benefits_philhealth_amount + 
            b.benefits_bir_amount) as net_pay
    FROM Payroll p
    JOIN Salary s ON p.salary_id = s.salary_id
    JOIN Benefits b ON p.benefits_id = b.benefits_id
    WHERE p.employee_id = ? AND p.payroll_id = ?
", [1, 1]);

// ============================================
// LEAVE QUERIES
// ============================================

// Get employee leave balances
$leaveBalances = $db->fetchAll("
    SELECT lt.leave_type_description,
           al.annual_leave_days_per_year,
           al.annual_leave_days_taken,
           al.annual_leave_days_remain
    FROM Annual_Leave al
    JOIN Leave_Type lt ON al.leave_type_id = lt.leave_type_id
    WHERE al.employee_id = ? AND al.annual_leave_year = ?
", [1, 2026]);

// Get employee leave history
$leaveHistory = $db->fetchAll("
    SELECT el.*, lt.leave_type_description
    FROM Employee_Leave el
    JOIN Leave_Type lt ON el.leave_type_id = lt.leave_type_id
    WHERE el.employee_id = ?
    ORDER BY el.employee_leave_start DESC
", [1]);

// ============================================
// TIMESHEET QUERIES
// ============================================

// Get employee timesheet records
$timesheets = $db->fetchAll("
    SELECT t.*, nd.night_diff_hours, h.holiday_name
    FROM Timesheet t
    LEFT JOIN Night_Diff nd ON t.night_diff_id = nd.night_diff_id
    LEFT JOIN Holidays h ON t.holiday_id = h.holiday_id
    WHERE t.employee_id = ?
    ORDER BY t.timesheet_start_date DESC
", [1]);

// ============================================
// TRANSACTION EXAMPLE
// ============================================

try {
    $db->beginTransaction();
    
    // Insert user
    $db->query("INSERT INTO User (...) VALUES (...)");
    $userId = $db->lastInsertId();
    
    // Insert employee
    $db->query("INSERT INTO Employee (user_id, ...) VALUES (?, ...)", [$userId]);
    
    // Insert leave balances
    $db->query("INSERT INTO Annual_Leave (...) VALUES (...)");
    
    $db->commit();
    echo "Transaction completed successfully!";
    
} catch (Exception $e) {
    $db->rollback();
    echo "Transaction failed: " . $e->getMessage();
}

// ============================================
// AUTHENTICATION EXAMPLE
// ============================================

// Login function
function authenticateUser($db, $username, $password) {
    $user = $db->fetchOne("
        SELECT u.*, r.role_description 
        FROM User u
        JOIN Role r ON u.role_id = r.role_id
        WHERE u.user_first_name = ? OR u.user_last_name = ?
    ", [$username, $username]);
    
    if ($user && password_verify($password, $user['user_password'])) {
        return $user;
    }
    return false;
}

// Usage
$authenticatedUser = authenticateUser($db, 'Maria', 'password123');
if ($authenticatedUser) {
    echo "Login successful! Welcome " . $authenticatedUser['user_first_name'];
} else {
    echo "Invalid credentials";
}
*/

?>
