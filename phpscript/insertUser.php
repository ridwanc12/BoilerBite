<?php

class  insertTable
{
    const DB_HOST = 'localhost';

    const DB_NAME = 'id12866202_boilerbite';

    const DB_USER = 'id12866202_bb307';

    const DB_PASS = 'bb307';

    private $pdo = null;

    public function __construct()
    {
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);

        try {
            $this->pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }
    public function __destruct()
    {
        // close the database connection
        $this->pdo = null;
    }

    /* 
     * Function to insert a row of data based on the parameters given to the function.
     * Checks if any values of height, weight, age is negative. If contains negative values,
     * the function will print out corresponding fields and exits.    
     */

    function insertSingleRow($username, $email, $pass)
    {
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        try {
            $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
            // Check if username is in database.
            // If username is in the table display error message and return.
            $sql = "SELECT userName FROM profiles WHERE userName = '$username'";

            // Execute query to get userName.
            $q = $pdo->query($sql);
            $q->setFetchMode(PDO::FETCH_ASSOC);

            // Store fetch() result into $result.
            $name_result = $q->fetch();
            if ($name_result != FALSE) {
                echo nl2br("$username is taken. Please choose another username.\n");
                return 0;
            }
        } catch (PDOException $e) {
            echo $e->getMessage();
        }

        // Execute query to get userEmail.
        $sql = "SELECT userName FROM profiles WHERE userEmail = '$email'";
        $q = $pdo->query($sql);
        $q->setFetchMode(PDO::FETCH_ASSOC);

        // Store fetch() result into $result.
        $mail_result = $q->fetch();
        if ($mail_result != FALSE) {
            echo nl2br("$email is already registed.\n");
            return 0;
        }

        $flag = 0;
        $error = '';
        // If any of the above values are negative, print error message and exit.
        if ($flag == 1) {
            $error = $error . "Query failed.\n";
            echo nl2br("$error");
            return 0;
        }
        // Hash the password.
        $passwrd = sha1($pass);
        // Insert values into array to be executed
        $task = array(
            ':username' => $username,
            ':email' => $email,
            ':pass' => $passwrd
        );
        // SQL query to inert values into profiles
        $sql = 'INSERT INTO profiles (
                      userName,
                      userEmail,
                      hashpass
                  )
                  VALUES (
                      :username,
                      :email,
                      :pass
                  );';
        // Prepare and execute sql query
        $q = $this->pdo->prepare($sql);
        return $q->execute($task);
    }

    // Function to initialize the goals profile of the user.
    function initializeGoal($username)
    {
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        try {
            $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
            $sql = "SELECT userID FROM profiles WHERE userName = '$username'";
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
            return 0;
        }
        $id = $result['userID'];
        $task = array(':id' => $id);

        $sql = 'INSERT INTO goals (
                        userID
                    )
                    VALUES (
                        :id
                    );';
        $q = $this->pdo->prepare($sql);

        return $q->execute($task);
    }

    // Funtion to initialize info of user
    function initializeInfo($username)
    {
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        try {
            $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
            $sql = "SELECT userID FROM profiles WHERE userName = '$username'";
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
            return 0;
        }
        $id = $result['userID'];
        $task = array(':id' => $id);

        $sql = 'INSERT INTO info (
                        userID
                    )
                    VALUES (
                        :id
                    );';
        $q = $this->pdo->prepare($sql);

        return $q->execute($task);
    }

    // Function to show users in table
    function showUsers(): void
    {
        // Execute query to get profiles currently in the table.
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        $sql = 'SELECT userID,
                        userName,
                        userEmail,
                        hashPass
                    FROM profiles;';
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
            echo "Passwrd: $holder\n\n";
            $flag = 1;
        }
        if ($flag == 0) {
            echo nl2br("No users in the database.\n\n");
        }
    }
} // End of functions


// Create new obj to run function
$obj = new insertTable();
$obj->showUsers();

// Get values from ios application
// $username = $_POST['userName'];
// $email = $_POST['userEmail'];
// $pass = $_POST['pass'];
$username = "Jeremy";
$email = "jeremy";
$pass = "jeremy";
echo nl2br(" \nInserting:
                 Username: $username, Email: $email, Password: $pass\n");
if ($obj->insertSingleRow($username, $email, $pass)) {
    if ($obj->initializeGoal($username)) {
        //echo nl2br("Goals initialized.\n");
        if ($obj->initializeInfo($username)) {
            echo nl2br("Info initialized\n");
        } else {
            echo nl2br("Something is wrong\n");
        }
    } else {
        //echo nl2br("Error when trying to initialize goals.\n");
    }
    echo nl2br("Values inserted.\n\n");
} else {
    echo nl2br("Value insertion failed.\n\n");
}
$obj->showUsers();
