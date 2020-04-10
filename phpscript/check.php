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

    // function insertSingleRow($username, $email, $pass) {
    //     $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
    //     try {
    //         $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
    //         // Check if username is in database.
    //         // If username is in the table display erro message and exit().
    //         $sql = "SELECT userName FROM profiles WHERE userName = '$username'";

    //         // Execute query to get userName.
    //         $q = $pdo->query($sql);
    //         $q->setFetchMode(PDO::FETCH_ASSOC);

    //         // Store fetch() result into $result.
    //         $name_result = $q->fetch();
    //         if ($name_result != FALSE) {
    //             echo nl2br("$username is taken. Please choose another username.\n");
    //             return 0;
    //         }
    //     } catch (PDOException $e) {
    //         echo $e->getMessage();
    //     }

    //     // Execute query to get userEmail.
    //     $sql = "SELECT userName FROM profiles WHERE userEmail = '$email'";
    //     $q = $pdo->query($sql);
    //     $q->setFetchMode(PDO::FETCH_ASSOC);

    //     // Store fetch() result into $result.
    //     $mail_result = $q->fetch();
    //     if ($mail_result != FALSE) {
    //         $name = $mail_result['userName'];
    //         echo nl2br("$email is already registed as $name.\n");
    //         return 0;
    //     }

    //     $flag = 0;
    //     $error = '';
    //     // If any of the above values are negative, print error message and exit.
    //     if ($flag == 1) {
    //         $error = $error . "Query failed.\n";
    //         echo nl2br("$error");
    //         return 0;
    //     }
    //     // Hash the password.
    //     $passwrd = sha1($pass);
    //     // Insert values into array to be executed
    //     $task = array(
    //         ':username' => $username,
    //         ':email' => $email,
    //         ':pass' => $passwrd);
    //     // SQL query to inert values into profiles
    //     $sql = 'INSERT INTO profiles (
    //                   userName,
    //                   userEmail,
    //                   hashpass
    //               )
    //               VALUES (
    //                   :username,
    //                   :email,
    //                   :pass
    //               );';
    //     // Prepare and execute sql query
    //     $q = $this->pdo->prepare($sql);
    //     return $q->execute($task);
    // }

    // Function to initialize the goals profile of the user.
    // function initializeGoal($username) {
    //     $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
    //     try {
    //         $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
    //         $sql = "SELECT userID FROM profiles WHERE userName = '$username'";
    //         // Execute query to get userName.
    //         $q = $pdo->query($sql);
    //         $q->setFetchMode(PDO::FETCH_ASSOC);
    //     } catch (PDOException $e) {
    //         echo $e->getMessage();
    //     }

    //     $result = $q->fetch();

    //     // Check if username is in database.
    //     // If username is not in the table $result will be FALSE.
    //     if ($result == FALSE) {
    //         return 0;
    //     }
    //     $id = $result['userID'];
    //     $task = array(':id' => $id);

    //     $sql = 'INSERT INTO goals (
    //                     userID
    //                 )
    //                 VALUES (
    //                     :id
    //                 );';
    //     $q = $this->pdo->prepare($sql);

    //     return $q->execute($task);
    // }

    // Function to show users in table
    function showUsers(): String
    {
        // Execute query to get profiles currently in the table.
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        $sql = 'SELECT userName,
                        userEmail,
                        hashPass
                    FROM profiles;';
        $q = $pdo->query($sql);
        $q->setFetchMode(PDO::FETCH_ASSOC);
        // Print out values returned by query
        $result_Arr = array();
        $temp_Arr = array();
        while ($user = $q->fetch()) {
            $temp_Arr = $user;
            array_push($result_Arr, $temp_Arr);
        }
        return json_encode($result_Arr);
    }
} // End of functions


// Create new obj to run function
$obj = new insertTable();
$file = $obj->showUsers();
echo $file;
// echo "Connected to file ser online. ";
// echo "PHP script executed from hosting service.";
// Unit Test: All Values Equal to 0
/*$username = 'Jeremy';
    $email = 'jeremy@gamil.com';
    $pass = 'jeremy';
    echo nl2br(" \nInserting:
                 Username: $username, Email: $email, Password: $pass\n");
    if ($obj->insertSingleRow($username, $email, $pass)) {
        // if ($obj->initializeGoal($username)) {
        //     //echo nl2br("Goals initialized.\n");
        // } else {
        //     //echo nl2br("Error when trying to initialize goals.\n");
        // }
        echo nl2br("Values inserted.\n\n");
    } else {
        echo nl2br("Value insertion failed.\n\n");
    }*/
//$obj->showUsers(); 

?>

<html>

<head>
    <title>
        check
    </title>
</head>

</html>