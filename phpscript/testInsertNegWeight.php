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

    function insertSingleRow($username, $email, $height, $weight, $pass, $age) {
        $flag = 0;
        $error = '';
        if ($height <= 0) {
            $error = $error . "Please make sure height is non-negative.\r\n";
            $flag = 1;
        }
        if ($weight <= 0) {
            $error = $error . "Please make sure weight is non-negative.\r\n";    
            $flag = 1;
        }
        if ($age <= 0) {
            $error = $error . "Please make sure age is non-negative.\r\n";    
            $flag = 1;
        }
        //If any of the above values are negative, print erro message and exit.
        if ($flag == 1) {
            $error = $error . "Query failed.";
            echo nl2br($error);
            exit();
        }
        $passwrd = PASSWORD_HASH("$pass", PASSWORD_DEFAULT);
        echo $passwrd;
        $task = array(
            ':username' => $username,
            ':email' => $email,
            ':height' => $height,
            ':weight' => $weight,
            ':pass' => $passwrd,
            ':age' => $age);
 
        $sql = 'INSERT INTO profiles (
                      userName,
                      userEmail,
                      height,
                      weight,
                      hashpass,
                      age
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
    if ($obj->insertSingleRow('username', 'email', '140', '-21', 'weee', '21')) {
        echo "Query executed.";
    } else {
        echo "Query error.";
    };
    
