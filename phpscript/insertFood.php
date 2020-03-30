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
    // function findID($username): int
    // {
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
    //     $idFromUser = $result['userID'];
    //     return $idFromUser;
    // }

    // Function to show users in table
    function showUsers(): void
    {
        // Execute query to get profiles currently in the table.
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        $sql = 'SELECT  total_calorie,
                        food_name,
                        date
                    FROM progress';
        $q = $pdo->query($sql);
        $q->setFetchMode(PDO::FETCH_ASSOC);
        // Print out values returned by query
        $flag = 0;
        while ($user = $q->fetch()) {
            $holder = $user['total_calorie'];
            echo nl2br("Calories Total: $holder, ");
            $holder = $user['food_name'];
            echo nl2br("Food: $holder, ");
            $holder = $user['date'];
            echo nl2br("Time: $holder\n\n");
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
        //$id = $this->findID($username);

        //echo nl2br("$id\n");

        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        $sql = 'SELECT  userName
                    FROM profiles';
        $q = $pdo->query($sql);
        $q->setFetchMode(PDO::FETCH_ASSOC);

        // Check if query returned results
        $user = $q->fetch();
        if ($user == false) {
            echo nl2br("No such user.\n\n");
            return;
        } else {
            echo nl2br("user found.\n\n");
        }

        //Insert value into array to 
        $task = array(
            ':name' => $username,
            ':food' => $food,
            ':cal_total' => $total_calorie,
            ':cal_fat' => $calorie_fat,
            ':g_fat' => $gram_fat,
            ':g_protein' => $gram_protein,
            ':g_carbs' => $gram_carbs
        );
        $sql = 'INSERT INTO progress (
                        userName,
                        food_name,
                        total_calorie,
                        calorie_fat,
                        gram_fat,
                        gram_protein,
                        gram_carbs
                        )
                        VALUES (
                            :name,
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
// $username = "Jeremy"; //$_POST['userName'];
// $food = "mac"; //$_POST['food_name'];
// $total_cal = "123"; //$_POST['total_calorie'];
// $cal_fat = "123"; //$_POST['calorie_fat'];
// $g_fat = "123"; //$_POST['gram_fat'];
// $g_protein = "123"; //$_POST['gram_protein'];
// $g_carb = "123"; //$_POST['gram_carbs'];

$username = $_POST['userName'];
$food = $_POST['food_name'];
$total_cal = $_POST['total_calorie'];
$cal_fat = $_POST['calorie_fat'];
$g_fat = $_POST['gram_fat'];
$g_protein =  $_POST['gram_protein'];
$g_carb = $_POST['gram_carbs'];

if ($obj->insertFood($username, $food, $total_cal, $cal_fat, $g_fat, $g_protein, $g_carb)) {
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