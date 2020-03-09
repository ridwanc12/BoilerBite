<?php

class  checkUser {
    const DB_HOST = 'localhost';

    const DB_NAME = 'id12866202_boilerbite';

    const DB_USER = 'id12866202_bb307';

    const DB_PASS = 'bb307';

    private $pdo = null;

    public function __construct() {
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);

        try {
            $this->pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }

    }
    public function __destruct() {
        // close the database connection
        $this->pdo = null;
    }

    // Function to show users in table
    function showUsers(): void {
        // Execute query to get profiles currently in the table.
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        $sql = 'SELECT userID,
                        userName,
                        userEmail
                    FROM profiles';
        $q = $pdo->query($sql);
        $q->setFetchMode(PDO::FETCH_ASSOC);
        // Print out values returned by query
        $flag = 0;
        while ($user = $q->fetch()) {
            $holder = $user['userID'];
            echo "UserID: $holder, ";
            $holder = $user['userName'];
            echo "Username: $holder, ";
            $holder = $user['userEmail'];
            echo "Email: $holder, ";
            $flag = 1;
        }
        if ($flag == 0) {
            echo nl2br("No users in the database.\n\n");
        }
    }

    /* Function to check if username and password match by comparing
     * userID selected from the table by both values. Returns 1 if userID
     * catches, else returns 0.
     */

    function verifyUser($username, $pass): int{
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        try {
            $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
            //find user password in the database
            $sql = "SELECT hashPass FROM profiles WHERE userName = '$username'";
            // Execute query to get password
            $q = $pdo->query($sql);
            $q->setFetchMode(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }

        $result = $q->fetch();

        // Check if username is in database.
        // If username is not in the table $result will be FALSE.
        if ($result == FALSE) {
            echo nl2br("No such user.");
            return 0;
        }
        // Get password from database
        $passFromUser = $result['hashPass'];

        // Get hashed password from function input.
        $passwrd = sha1($pass);
        
        // Check provided password against password in database
        if ($passwrd == $passFromUser) {
            echo nl2br("User found!!!!!\n");
            return 1;
        } else {
            echo "Incorrect username or password.";
        }
    }
}
    // Create new obj to run code
    $obj = new checkUser;
    $obj->showUsers();

    $name = 'Rid';
    $pass = 'rid';
    $obj->verifyUser($name, $pass);


?>