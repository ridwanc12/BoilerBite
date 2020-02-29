<?php

class  checkUser {
    const DB_HOST = 'localhost';

    const DB_NAME = 'boilerbite';

    const DB_USER = 'root';

    const DB_PASS = '7658389656';

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
                        userEmail,
                        hashPass
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
            $holder = $user['hashPass'];
            echo "Hashed Passwrd: $holder, ";
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
            $sql = "SELECT hashPass FROM profiles WHERE userName = '$username'";
            // Execute query to get userName.
            $q = $pdo->query($sql);
            $q->setFetchMode(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }

        $result = $q->fetch();

        // Check if username is in database.
        // If username is not in the table $result will be FALSE.
        if ($result == FALSE) {
            echo nl2br("Incorrect username and password.\n\n");
            return 0;
        }
        $passFromUser = $result['hashPass'];

        // Get hashed password from function input.
        $passwrd = sha1($pass);
        // echo nl2br("$passwrd
        //             $passFromUser");
        if ($passwrd == $passFromUser) {
            echo nl2br("Login success!\n\n");
            return 1;
        } else {
            echo nl2br("Incorrect username and password.\n\n");
            return 0;
        }
    }
}
    // Create new obj to run code
    $obj = new checkUser;
    $obj->showUsers();

    echo nl2br("Begin unit testing for login:\n\n");

    // Test existing user with wrong password
    echo nl2br("Testing correct username and wrong password:\n");
    $name = 'Rid';
    $pass = 'jeremy';
    $corr = 'rid';
    echo nl2br("Username: $name
                Wrong Password: $pass
                Correct: $corr\n");
    $obj->verifyUser($name, $pass);

    // Test non-existent user
    echo nl2br("Testing non-existent user:\n");
    $name = 'Jesus';
    $pass = 'rid';
    echo nl2br("Username: $name
                Password: $pass\n");
    $obj->verifyUser($name, $pass);

    // Test existing user with right password
    echo nl2br("Testing correct username and password:\n");
    $name = 'Rid';
    $pass = 'rid';
    echo nl2br("Username: $name
                Correct: $corr\n");
     $obj->verifyUser($name, $pass);
?>