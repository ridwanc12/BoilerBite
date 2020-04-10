<?php

class signup_DbOperation
{
    private $conn;

    //Constructor
    function __construct()
    {
        require_once dirname(__FILE__) . '/signup_config.php';
        require_once dirname(__FILE__) . '/signup_DbConnect.php';
        // opening db connection
        $db = new signup_DbConnect();
        $this->conn = $db->signup_connect();

    }

    //Function to create a new user
    public function signup_teamprofiles($userName, $userEmail, $hashPass)
    {
         $result = $this->conn->query("SELECT * FROM profiles WHERE userName = '$userName' ");
        if(mysqli_num_rows($result) == 0) {
            //print("no signin")
            //return false;
        } else {
            //printf("yes signin ");
            return false;
        }
        
        $stmt = $this->conn->prepare("INSERT INTO profiles(userName, userEmail, hashPass) values(?, ?, ?)");
        $stmt->bind_param("sss", $userName, $userEmail, $hashPass);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }
    
    public function signup_teaminfo($userName, $height, $weight, $age)
    {
    
        $stmt = $this->conn->prepare("INSERT INTO info(userName, height, weight, age) values(?, ?, ?, ?)");
        $stmt->bind_param("siii",$userName, $height, $weight, $age);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }
    

}