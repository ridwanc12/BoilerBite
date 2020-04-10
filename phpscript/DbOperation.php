<?php

class DbOperation
{
    private $conn;

    //Constructor
    function __construct()
    {
        require_once dirname(__FILE__) . '/Config.php';
        require_once dirname(__FILE__) . '/DbConnect.php';
        // opening db connection
        $db = new DbConnect();
        $this->conn = $db->connect();
    }

    //Function to create a new user
    public function createTeam($name, $memberCount)
    {
        //$mysqli = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);
        // userName = '$name'and 
        $result = $this->conn->query("SELECT * FROM profiles WHERE (hashPass = '$memberCount' and userName = '$name') ");
        if(mysqli_num_rows($result) == 0) {
            //print("no signin")
            return false;
        } else {
            //printf("yes signin ");
            return true;
        }

        $stmt = $this->conn->prepare("INSERT INTO profiles(userName, hashPass) values(?, ?)");
        $stmt->bind_param("ss", $name, $memberCount);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            printf("Number of result in the table : ");
            return true;
        } else {
            printf("false for second");
            return false;
        }
    }

}