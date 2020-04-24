<?php

class change_DbOperation
{
    private $conn;

    //Constructor
    function __construct()
    {
        require_once dirname(__FILE__) . '/Config_calories.php';
        require_once dirname(__FILE__) . '/calories_DbConnect.php';
        // opening db connection
        $db = new calories_DbConnect();
        $this->conn = $db->calories_connect();

    }

    //Function to create a new user
    public function change_createteam($username,$hashPass)
    {
        echo "username: " . $username;
        echo "hashPass: " . $hashPass;
        
        $sql = "UPDATE profiles SET hashPass='$hashPass' WHERE userName='$username'";

        $stmt = $this->conn->prepare($sql);
        $result=$stmt->execute();

        if ($result) {
            return true;
        } else {
            return false;
        }

    }

}