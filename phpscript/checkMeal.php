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


    // Function to show users in table
    function checkMeal($username, $time): String
    {
        // Execute query to get profiles currently in the table.
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        $sql = 'SELECT userName,
                        food_name,
                        total_calorie,
                        date
                    FROM progress
                    WHERE userName = :name';
        $q = $this->pdo->prepare($sql);
        $q->bindValue(':name', $username);
        $q->execute();
        $q->setFetchMode(PDO::FETCH_ASSOC);
        // Add up all calories of food items eaten on the given day
        $result_Arr = array();
        $temp_Arr = array();
        $cal = 0;
        while ($user = $q->fetch()) {
            $moment = $user['date'];
            $temp_Arr = $user;
            if ($time == $moment) {
                $calorie = $user['total_calorie'];
                $cal += $calorie;
                array_push($result_Arr, $temp_Arr);
            }
        }
        $sql = 'SELECT calories_total FROM goals WHERE userName = :name';
        $q = $this->pdo->prepare($sql);
        $q->bindValue(':name', $username);
        $q->execute();
        $q->setFetchMode(PDO::FETCH_ASSOC);
        if ($user = $q->fetch()) {
            $goal = $user['calories_total'];
            // $diff = abs($cal - $goal);
            // if ($cal > $goal) {
            //     echo "Over $diff calories.";
            // } else {
            //     echo "Under $diff calories.";
            // }
            echo "$cal/$goal";
        } else {
            echo nl2br("No such user");
        }
        //echo nl2br("$cal\n");
        return json_encode($result_Arr);
    }
} // End of functions


// Create new obj to run function
$obj = new insertTable();
$username = $_POST['userName'];
$date = "2020-04-10";
//$date = date("Y-m-d");

// $username = "admini";

//echo $date;
$file = $obj->checkMeal($username, $date);
//echo $file;

?>