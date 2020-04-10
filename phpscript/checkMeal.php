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
    function showUsers($username, $time): String
    {
        // Execute query to get profiles currently in the table.
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);
        $pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        $sql = 'SELECT userName,
                        total_calorie,
                        date
                    FROM progress
                    WHERE userName = :name';
        $q = $this->pdo->prepare($sql);
        $q->bindValue(':name', $username);
        $q->execute();
        $q->setFetchMode(PDO::FETCH_ASSOC);
        // Print out values returned by query
        $result_Arr = array();
        $temp_Arr = array();
        while ($user = $q->fetch()) {
            $moment = $user['date'];
            $temp_Arr = $user;
            if ($time == $moment) {
                array_push($result_Arr, $temp_Arr);
            }
        }
        return json_encode($result_Arr);
    }
} // End of functions


// Create new obj to run function
$obj = new insertTable();
$file = $obj->showUsers("admini", "2020-03-31");
echo $file;

?>

<html>

<head>
    <title>
        check
    </title>
</head>

</html>