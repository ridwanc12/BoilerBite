<?php

class  updateRow
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

    /* Function to check if username and password match by comparing
     * userID selected from the table by both values. Returns 1 if userID
     * catches, else returns 0.
     */

    // function verifyUser($username, $pass): int{
    //     $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
    //     try {
    //         $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
    //         $sql = "SELECT hashPass FROM profiles WHERE userName = '$username'";
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
    //         echo nl2br("No such user.\n");
    //         return 0;
    //     }
    //     $passFromUser = $result['hashPass'];

    //     // Get hashed password from function input.
    //     $passwrd = sha1($pass);
    //     if ($passwrd == $passFromUser) {
    //         echo nl2br("User found!!!!!\n");
    //         return 1;
    //     }
    //     return 0;
    // }

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

    function updateWholeRow($username, $height, $weight, $age)
    {
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

        // Check if there's any errors with inputs.
        // Print error message and exit.
        if ($flag == 1) {
            $error = $error . "Query failed.\n\n";
            echo nl2br($error);
            return 0;
        }

        $ID = $this->findID($username);

        $task = array(
            ':height' => $height,
            ':weight' => $weight,
            ':age' => $age,
            ':userID' => $ID
        );
        // Write query to collect data
        $sql = 'UPDATE info
                    SET height          = :height,
                        weight          = :weight,
                        age             = :age
                    WHERE  userID = :userID';

        $q = $this->pdo->prepare($sql);
        if ($q->execute($task)) {
            echo nl2br("User info UPDATED.\n\n");
        }
    }
}
$obj = new updateRow();

// Show user profiles in the database
$obj->showUsers();
echo nl2br("Begin Unit test for updating Profile:\n\n");

$username = 'Rid';
$height = '180';
$weight = '130';
$age = '20';
echo nl2br("Testing when all values are valid:
                Height: $height, Weight: $weight, Age: $age\n");
$obj->updateWholeRow($username, $height, $weight, $age);

$obj->showUsers();
