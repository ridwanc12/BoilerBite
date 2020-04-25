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
                        total_calorie,
                        meal,
                        date
                    FROM meal
                    WHERE userName = :name';
        $q = $this->pdo->prepare($sql);
        $q->bindValue(':name', $username);
        $q->execute();
        $q->setFetchMode(PDO::FETCH_ASSOC);
        // Add up all calories of food items eaten on the given day
        $result_Arr = array();
        $temp_Arr = array();
        $cal = 0;
        $breakfast = 0;
        $lunch = 0;
        $late_lunch = 0;
        $dinner = 0;
        while ($user = $q->fetch()) {
            $moment = $user['date'];
            $temp_Arr = $user;
            if ($time == $moment) {
                $meal = $user['meal'];
                $cal = 0;
                if ($meal == "Breakfast") {
                    $cal = $user['total_calorie'];
                    $breakfast += $cal;
                } else if ($meal == "Lunch") {
                    $cal = $user['total_calorie'];
                    $lunch += $cal;
                } else if ($meal == "Late_Lunch") {
                    $cal = $user['total_calorie'];
                    $late_lunch += $cal;
                } else if ($meal == "Dinner") {
                    $cal = $user['total_calorie'];
                    $dinner += $cal;
                }
                $cal += $cal;
            }
        }
        $sql = 'SELECT calories_total FROM goals WHERE userName = :name';
        $q = $this->pdo->prepare($sql);
        $q->bindValue(':name', $username);
        $q->execute();
        $q->setFetchMode(PDO::FETCH_ASSOC);
        if ($user = $q->fetch()) {
            $goal = $user['calories_total'];
        } else {
            echo nl2br("No such user");
        }
        $cal = $breakfast + $lunch + $late_lunch + $dinner;
        $s =  "$breakfast $lunch $late_lunch $dinner $cal $goal";
        return $s;
    }
} // End of functions


// Create new obj to run function
$obj = new insertTable();
$username = $_POST['userName'];
// $username = "Jeremy";
$tz = 'America/New_York';
$tz_obj = new DateTimeZone($tz);
$today = new DateTime("now", $tz_obj);
$date = $today->format('Y-m-d');

$file = $obj->checkMeal($username, $date);
echo $file;

?>