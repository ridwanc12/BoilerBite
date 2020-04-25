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

    function checkMeal($username, $time)
    {
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        // Get ALL meals eaten by specified user
        $sql = 'SELECT userName,
                        total_calorie,
                        date
                    FROM progress
                    WHERE userName = :name';
        $q = $this->pdo->prepare($sql);
        $q->bindValue(':name', $username);
        $q->execute();
        $q->setFetchMode(PDO::FETCH_ASSOC);
        $cal = 0;
        // Add up all the calories eaten today
        while ($user = $q->fetch()) {
            $moment = $user['date'];
            //$temp_Arr = $user;
            if ($time == $moment) {
                $calorie = $user['total_calorie'];
                $cal += $calorie;
            }
        }
        // Get the specified user's daily goal
        $sql = 'SELECT userName,
                        calories_total
                    FROM goals
                    WHERE userName = :name';
        $q = $this->pdo->prepare($sql);
        $q->bindValue(':name', $username);
        $q->execute();
        $q->setFetchMode(PDO::FETCH_ASSOC);
        // Compare current eaten calories agains user's goal
        if ($user = $q->fetch()) {
            $goal = $user['calories_total'];
            if ($cal > $goal) {
                $diff = abs($cal - $goal);
                echo "Over $diff calories";
            } else {
                $diff = abs($cal - $goal);
                echo "Under $diff calories";
            }
        } else {
            //echo nl2br("No such user\n");
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
            //echo nl2br("Please make sure the input is non-negative.\n");
            return 0;
        }
        // Check if user is in the database
        //$id = $this->findID($username);

        //echo nl2br("$id\n");
        $tz = 'America/New_York';
        $tz_obj = new DateTimeZone($tz);
        $today = new DateTime("now", $tz_obj);
        $date = $today->format('Y-m-d');


        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        $sql = 'SELECT  userName
                    FROM profiles';
        $q = $pdo->query($sql);
        $q->setFetchMode(PDO::FETCH_ASSOC);

        // Check if query returned results
        $user = $q->fetch();
        if ($user == false) {
            //echo nl2br("No such user.\n\n");
            return;
        } else {
            //echo nl2br("user found.\n\n");
        }

        //Insert value into array
        $task = array(
            ':name' => $username,
            ':food' => $food,
            ':cal_total' => $total_calorie,
            ':cal_fat' => $calorie_fat,
            ':g_fat' => $gram_fat,
            ':g_protein' => $gram_protein,
            ':g_carbs' => $gram_carbs,
            ':date' => $date
        );
        $sql = 'INSERT INTO progress (
                        userName,
                        food_name,
                        total_calorie,
                        calorie_fat,
                        gram_fat,
                        gram_protein,
                        gram_carbs,
                        date
                        )
                        VALUES (
                            :name,
                            :food,
                            :cal_total,
                            :cal_fat,
                            :g_fat,
                            :g_protein,
                            :g_carbs,
                            :date
                        )';
        $q = $this->pdo->prepare($sql);
        return $q->execute($task);
    }
}

$obj = new insertTable();
//$obj->showUsers();
//echo nl2br("Begin unit testing for inserting food item:\n\n");

// Testing input

// $username = "admini"; //$_POST['userName'];
// $food = "mac"; //$_POST['food_name'];
// $total_cal = "1230"; //$_POST['total_calorie'];
// $cal_fat = "123"; //$_POST['calorie_fat'];
// $g_fat = "123"; //$_POST['gram_fat'];
// $g_protein = "123"; //$_POST['gram_protein'];
// $g_carb = "123"; //$_POST['gram_carbs'];

$tz = 'America/New_York';
$tz_obj = new DateTimeZone($tz);
$today = new DateTime("now", $tz_obj);
$date = $today->format('Y-m-d');
$username = $_POST['userName'];
$food = $_POST['food_name'];
$total_cal = $_POST['total_calorie'];
$cal_fat = $_POST['calorie_fat'];
$g_fat = $_POST['gram_fat'];
$g_protein =  $_POST['gram_protein'];
$g_carb = $_POST['gram_carbs'];
if ($obj->insertFood($username, $food, $total_cal, $cal_fat, $g_fat, $g_protein, $g_carb)) {
    //echo nl2br("Food inserted.\n");
    $obj->checkMeal($username, $date);
} else {
    echo "Failed.";
}
