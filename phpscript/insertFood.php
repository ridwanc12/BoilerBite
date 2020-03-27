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
            echo nl2br("Calories Total: $holder");
            $holder = $user['food_name'];
            echo nl2br("Food: $holder\n\n");
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

    function insertFood(
        $username,
        $food,
        $total_calorie,
        $calorie_fat,
        $gram_fat,
        $gram_protein,
        $gram_carbs
    ) {
        // Check if $calories_total is non-negative.
        // If negative, print message and exit().
        if ($total_calorie < 0) {
            echo nl2br("Please make sure the input is non-negative.\n");
            return 0;
        }
        // Check if user is in the database
        $id = $this->findID($username);
        if ($id == 0) {
            echo nl2br("Incorrect username.\n");
            return 0;
        } else {
        }
        //echo nl2br("$id\n");
        // Insert value into array to 
        $task = array(
            ':id' => $id,
            ':food' => $food,
            ':cal_total' => $total_calorie,
            ':cal_fat' => $calorie_fat,
            ':g_fat' => $gram_fat,
            ':g_protein' => $gram_protein,
            ':g_carbs' => $gram_carbs
        );
        $sql = 'INSERT INTO progress (
                        userID,
                        food_name,
                        total_calorie,
                        calorie_fat,
                        gram_fat,
                        gram_protein,
                        gram_carbs
                        )
                        VALUES (
                            :id,
                            :food,
                            :cal_total,
                            :cal_fat,
                            :g_fat,
                            :g_protein,
                            :g_carbs
                        )';

        $q = $this->pdo->prepare($sql);
        return $q->execute($task);
    }
}
$obj = new insertTable();
$obj->showUsers();
echo nl2br("Begin unit testing for inserting food item:\n\n");

//Testing input
if ($obj->insertFood("Mac n Cheese", 500, 123, 123, 123, 123, 123)) {
    echo nl2br("Food inserted.\n");
} else {
    echo nl2br("Failed.\n");
}


$obj->showUsers();

?>

<html>

<head>
    <title>
        insertFood
    </title>
</head>

</html>