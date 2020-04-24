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

    function findID($username): int
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
        $idFromUser = $result['userID'];
        return $idFromUser;
    }

    /* 
     * Function to insert a row of data based on the parameters given to the function.
     * Checks if any values of height, weight, age is negative. If contains negative values,
     * the function will print out corresponding fields and exits.    
     */

    function insertSingleRow($username, $height, $weight, $age)
    {
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        // try {
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        //     // Check if username is in database.
        //     // If username is in the table display erro message and exit().
        //     $sql = "SELECT userName FROM profiles WHERE userName = '$username'";

        //     // Execute query to get userName.
        //     $q = $pdo->query($sql);
        //     $q->setFetchMode(PDO::FETCH_ASSOC);

        //     // Store fetch() result into $result.
        //     $name_result = $q->fetch();
        //     if ($name_result != FALSE) {
        //         echo nl2br("$username is taken. Please choose another username.\n");
        //         return 0;
        //     }
        // } catch (PDOException $e) {
        //     echo $e->getMessage();
        // }

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
            $error = $error . "Query failed.\n\n";
            echo nl2br("$error");
            return 0;
        }
        $ID = $this->findID($username);
        // Insert values into array to be executed
        $task = array(
            ':userID' => $ID,
            ':height' => $height,
            ':weight' => $weight,
            ':age' => $age
        );
        // SQL query to inert values into profiles
        $sql = 'INSERT INTO info (
                      userID,
                      height,
                      weight,
                      age
                  )
                  VALUES (
                      :userID,
                      :height,
                      :weight,
                      :age
                  );';
        // Prepare and execute sql query
        $q = $this->pdo->prepare($sql);
        if ($q->execute($task)) {
            echo nl2br("INSERT success\n\n");
            return 1;
        } else {
            echo nl2br("INSERT failed\n\n");
        }
    }

    // Function to show users in table
    function showUsers(): void
    {
        // Execute query to get profiles currently in the table.
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        $sql = 'SELECT userID,                        
                        height,
                        weight,
                        age
                    FROM info';
        $q = $pdo->query($sql);
        $q->setFetchMode(PDO::FETCH_ASSOC);
        // Print out values returned by query
        $flag = 0;
        while ($user = $q->fetch()) {
            $holder = $user['userID'];
            echo "ID: $holder, ";
            $holder = $user['height'];
            echo "Height: $holder, ";
            $holder = $user['weight'];
            echo nl2br("Weight: $holder, \n");
            $holder = $user['age'];
            echo nl2br("Age: $holder\n\n");
            $flag = 1;
        }
        if ($flag == 0) {
            //echo nl2br("No users in the database.\n\n");
        }
    }
} // End of functions


// Create new obj to run function
$obj = new insertTable();
$obj->showUsers();
$username = 'Rid';
$height = '-160';
$weight = '140';
$age = '20';
echo nl2br("Begin testing INSERT info:
    
                Testing negative height:\n");
echo nl2br("Testing when user enters a negative height:
                Height: $height, Weight: $weight, Age: $age\n");
//INSERT into info table based on $username
$obj->insertSingleRow($username, $height, $weight, $age);

$username = 'Rid';
$height = '160';
$weight = '-140';
$age = '20';
echo nl2br("Testing when user enters a negative weight:
                Height: $height, Weight: $weight, Age: $age\n");
//INSERT into info table based on $username
$obj->insertSingleRow($username, $height, $weight, $age);

$username = 'Rid';
$height = '160';
$weight = '140';
$age = '-20';
echo nl2br("Testing when user enters a negative age:
                Height: $height, Weight: $weight, Age: $age\n");
//INSERT into info table based on $username
$obj->insertSingleRow($username, $height, $weight, $age);

$username = 'Rid';
$height = '-160';
$weight = '-140';
$age = '-20';
echo nl2br("Testing when all values are negative:
                Height: $height, Weight: $weight, Age: $age\n");
//INSERT into info table based on $username
$obj->insertSingleRow($username, $height, $weight, $age);

$username = 'Rid';
$height = '160';
$weight = '140';
$age = '20';
echo nl2br("Testing when all values are valid:
                Height: $height, Weight: $weight, Age: $age\n");
//INSERT into info table based on $username
$obj->insertSingleRow($username, $height, $weight, $age);
?>

<html>
    <head>
        <title>
            insertInfoUnit
        </title>
    </head>
</html>
