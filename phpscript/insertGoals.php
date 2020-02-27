<?php

class  insertTable {
    const DB_HOST = 'localhost';

    const DB_NAME = 'boilerbite';

    const DB_USER = 'root';

    const DB_PASS = '7658389656';

    private $pdo = null;

    public function __construct() {
        $conStr = sprintf("mysql:host=%s;dbname=%s", self::DB_HOST, self::DB_NAME);

        try {
            $this->pdo = new PDO($conStr, self::DB_USER, self::DB_PASS);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }

    }
    public function __destruct() {
        // close the database connection
        $this->pdo = null;
    }

    function findID($username): int{
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
    
    function insertCalTotal($username, $calories_total) {
        // Check if $calories_total is non-negative.
        // If negative, print message and exit().
        if ($calories_total < 0) {
            echo nl2br("Please make sure the input is non-negative.\n");
            exit();
        }
        $id = $this->findID($username);
        if ($id == 0) {
            echo nl2br("User does not exist.");
            exit();
        }
        echo nl2br("$id\n");
        $task = array(
            ':cal_total' => $calories_total,
            ':id' => $id);
        $sql = 'INSERT INTO goals (
                      calories_total
                  )
                  VALUES (
                      :username,
                      :email,
                      :height,
                      :weight,
                      :pass,
                      :age
                  );';
 
        $q = $this->pdo->prepare($sql);
 
        return $q->execute($task);
    }
}
    $obj = new insertTable();
    if ($obj->insertSingleRow('Twnyang', 'smicjeremy@hotmail.com', '170', '75', 'jeez', '21')) {
        echo "Query executed.";
    } else {
        echo "Query error.";
    };
    
