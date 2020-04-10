<?php

class update_DbOperation
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
    public function update_createteam($userName,$height,$weight,$age)
    {
        echo "print: ". $userName;
        echo "print: ". $height;
        echo "print: ". $weight;
        echo "print: ". $age;
        
        $sql = "UPDATE info SET height='$height' , weight='$weight', age='$age' WHERE userName='$userName'";

        $stmt = $this->conn->prepare($sql);
        $result=$stmt->execute();

        if ($result) {
            return true;
        } else {
            return false;
        }

    }

}