<?php

class  insertTable {
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

    /* 
     * Function to insert a row of data based on the parameters given to the function.
     * Checks if any values of height, weight, age is negative. If contains negative values,
     * the function will print out corresponding fields and exits.    
     */
    
    function insertSingleRow($username, $email, $height, $weight, $pass, $age) {
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        try {
            $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
            // Check if username is in database.
            // If username is in the table display erro message and exit().
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
            $name = $mail_result['userName'];
            echo nl2br("$email is already registed as $name.\n");
            return 0;
        }
        
        $flag = 0;
        $error = '';
        // Check to make sure height is non-negative.
        // Appends error message if height is negative.
        if ($height < 0) {
            $error = $error . "Please make sure height is non-negative.\r\n";
            $flag = 1;
        }
        // Check to make sure weight is non-negative.
        // Appends error message if weight is negative.
        if ($weight < 0) {
            $error = $error . "Please make sure weight is non-negative.\r\n";    
            $flag = 1;
        }
        // Check to make sure age is non-negative.
        // Appends error message if age is negative.
        if ($age < 0) {
            $error = $error . "Please make sure age is non-negative.\r\n";    
            $flag = 1;
        }
        // If any of the above values are negative, print erro message and exit.
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
            ':height' => $height,
            ':weight' => $weight,
            ':pass' => $passwrd,
            ':age' => $age);
        // SQL query to inert values into profiles
        $sql = 'INSERT INTO profiles (
                      userName,
                      userEmail,
                      height,
                      weight,
                      hashpass,
                      age
                  )
                  VALUES (
                      :username,
                      :email,
                      :height,
                      :weight,
                      :pass,
                      :age
                  );';
        // Prepare and execute sql query
        $q = $this->pdo->prepare($sql);
        return $q->execute($task);
    }

    // Function to initialize the goals profile of the user.
    function initializeGoal($username) {
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

    // Function to show users in table
    function showUsers(): void {
        // Execute query to get profiles currently in the table.
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        $sql = 'SELECT userID,
                        userName,
                        userEmail,
                        height,
                        weight,
                        hashPass,
                        age
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
            $holder = $user['height'];
            echo "Height: $holder, ";
            $holder = $user['weight'];
            echo nl2br("Weight: $holder, \n");
            $holder = $user['hashPass'];
            echo "Hashed Passwrd: $holder, ";
            $holder = $user['age'];
            echo nl2br("Age: $holder\n\n");
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
   
    // Unit Test: All Values Equal to 0
    $username = 'Jeremy';
    $email = 'jeremy@gamil.com';
    $height = '0';
    $weight = '0';
    $pass = 'jeremy';
    $age = '0';
    echo nl2br("Testing when user enters a negative weight.
                Username: $username, Email: $email, Height: $height, Weight: $weight, Age: $age,Password: $pass\n");
    if ($obj->insertSingleRow($username, $email, $height, $weight, $pass, $age)) {
        if ($obj->initializeGoal($username)) {
            //echo nl2br("Goals initialized.\n");
        } else {
            //echo nl2br("Error when trying to initialize goals.\n");
        }
        echo nl2br("Values inserted.\n\n");
    } else {
        echo nl2br("Value insertion failed.\n\n");
    }
    $obj->showUsers(); 
?>
    
