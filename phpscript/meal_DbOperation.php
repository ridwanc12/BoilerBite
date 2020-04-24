<?php

class meal_DbOperation
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
    public function meal_insert($userName, $total_calorie, $meal, $date)
    {
        print "username" . $userName. "\n";
        print "calorie" . $total_calorie. "\n";
        print "meal" . $meal. "\n";
        print "date" . $date. "\n";
        $stmt = $this->conn->prepare("INSERT INTO meal(userName, total_calorie, meal, date) 
        values(?, ?, ?, ?)");
        $stmt->bind_param("ssss", $userName, $total_calorie, $meal, $date);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }
    
 
    

}