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
     * Function to find the ID of the user from the given username.
     * If the user is not in the database, the function will print error message and
     * return 0.
     */
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

    // Function to show users in table
    function showUsers(): void
    {
        // Execute query to get profiles currently in the table.
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        $sql = 'SELECT userID,                        
                        calories_total
                    FROM goals';
        $q = $pdo->query($sql);
        $q->setFetchMode(PDO::FETCH_ASSOC);
        // Print out values returned by query
        $flag = 0;
        while ($user = $q->fetch()) {
            $holder = $user['userID'];
            echo "ID: $holder, ";
            $holder = $user['calories_total'];
            echo nl2br("Calories Total: $holder\n\n");
            $flag = 1;
        }
        if ($flag == 0) {
            //echo nl2br("No users in the database.\n\n");
        }
    }

    /* 
     * Function to insert a row of data based on the parameters given to the function.
     * Checks if any values of height, weight, age is negative. If contains negative values,
     * the function will print out corresponding fields and exits.    
     */

    function insertCalTotal($username, $calories_total)
    {
        // Check if $calories_total is non-negative.
        // If negative, print message and exit().
        if ($calories_total < 0) {
            echo nl2br("Please make sure the input is non-negative.\n");
            return 0;
        }
        // Check if user is in the database
        $id = $this->findID($username);
        if ($id == 0) {
            echo nl2br("Incorrect username.\n");
            return 0;
        }
        //echo nl2br("$id\n");
        // Insert value into array to 
        $task = array(
            ':cal_total' => $calories_total,
            ':id' => $id
        );
        $sql = 'INSERT INTO goals (
                        userID,
                        calories_total
                        )
                        VALUES (
                            :id,
                            :cal_total
                        )';

        $q = $this->pdo->prepare($sql);
        return $q->execute($task);
    }
}
$obj = new insertTable();
$obj->showUsers();
echo nl2br("Begin unit testing for inserting desired calorie intake:\n\n");

//Testing negative input

$name = 'Rid';
$cal_total = -2600;
echo nl2br("Test for negative input:
                Username: $name, Calories Total: $cal_total\n");
if ($obj->insertCalTotal($name, $cal_total)) {
    echo nl2br("Insert success.\n\n");
} else {
    echo nl2br("Insert error.\n\n");
};

//Testing non-existent user
$name = 'Jesus';
$cal_total = 2600;
echo nl2br("Test for non-existent user:
                Username: $name, Calories Total: $cal_total\n");
if ($obj->insertCalTotal($name, $cal_total)) {
    echo nl2br("Insert success.\n\n");
} else {
    echo nl2br("Insert error.\n\n");
};

//Testing valid input
$name = 'Rid';
$cal_total = 2500;
echo nl2br("Test for valid inputs:
                Username: $name, Calories Total: $cal_total\n");
if ($obj->insertCalTotal($name, $cal_total)) {
    echo nl2br("Insert success.\n\n");
} else {
    echo nl2br("Insert error.\n\n");
};
$obj->showUsers();
