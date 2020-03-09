<?php

class  updateRow {
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

    /* Function to check if username and password match by comparing
     * userID selected from the table by both values. Returns 1 if userID
     * catches, else returns 0.
     */

    function checkUser($username, $pass): int{
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
        $idFromUser = $result['userID'];
        // Get hashed password from function input.
        $passwrd = sha1($pass);
        $sql = "SELECT userID FROM profiles WHERE hashPass = '$passwrd'";
        $q = $pdo->query($sql);

        $q->setFetchMode(PDO::FETCH_ASSOC);
        while ($result = $q->fetch()) {
            $idFromPass = $result['userID'];
            if ($idFromPass == $idFromUser) {
                break;
            }
        }

        //Check if password is in table.
        //If passwrd is not in table $result will be FALSE.
        if ($result == FALSE) {
            return 0;
        }
        echo nl2br("$idFromPass\n");
        echo nl2br("$idFromUser\n");
        if ($idFromPass == null or $idFromUser == null) {
            $check = 0;
            return $check;
        }
        if ($idFromPass == $idFromUser) {
            $check = 1;
            return $check;
        } else {
            $check = 0;
            return $check;
        }
    }

    /* 
     * Function to insert a row of data based on the parameters given to the function.
     * Checks if any values of height, weight, age is negative. If contains negative values,
     * the function will print out corresponding fields and exits.    
     */
    
    function updateWholeRow($username, $email, $height, $weight, $pass, $age) {
        $flag = 0;
        $error = '';

        // Check to make sure height is non-negative.
        // Appends error message if height is negative.
        if ($height <= 0) {
            $error = $error . "Please make sure height is non-negative.\r\n";
            $flag = 1;
        }

        // Check to make sure weight is non-negative.
        // Appends error message if weight is negative.
        if ($weight <= 0) {
            $error = $error . "Please make sure weight is non-negative.\r\n";    
            $flag = 1;
        }

        // Check to make sure age is non-negative.
        // Appends error message if age is negative.
        if ($age <= 0) {
            $error = $error . "Please make sure age is non-negative.\r\n";    
            $flag = 1;
        }

        // Check if there's any errors with inputs.
        // Print error message and exit.
        if ($flag == 1) {
            $error = $error . "Query failed.";
            echo nl2br($error);
            exit();
        }

        $passCheck = $this->checkUser("$username", "$pass");
        $passwrd = sha1($pass);
        echo nl2br("\r\n");

        // exit() if username and password doesn't match.
        if ($passCheck == 0){
            echo "Incorrect username and password.";
            exit();
        }

        $task = array(
            ':email' => $email,
            ':height' => $height,
            ':weight' => $weight,
            ':age' => $age,
            ':username' => $username
        );
        // Write query to 
        $sql = 'UPDATE profiles
                    SET userEmail       = :email,
                        height          = :height,
                        weight          = :weight,
                        age             = :age
                    WHERE  userName = :username';
 
        $q = $this->pdo->prepare($sql);
 
        return $q->execute($task);
    }
}
    $obj = new updateRow();
    if ($obj->updateWholeRow('username', 'email', '140', '-60', 'congrats', '21')) {
        echo "Query executed.";
    } else {
        echo "Query error.";
    };
    
?>