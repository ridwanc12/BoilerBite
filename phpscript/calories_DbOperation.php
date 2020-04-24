<?php

class calories_DbOperation
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
    public function calories_createTeam($username,$calories, $calorie_fat, $gram_fat, $gram_protein, $gram_carb)
    {
        $stmt = $this->conn->prepare("INSERT INTO goals(userName, calories_total, calorie_fat, gram_fat, gram_protein, gram_carb) values(?, ?, ? , ?, ?, ?)");
        $stmt->bind_param("siiiii", $username, $calories, $calorie_fat, $gram_fat, $gram_protein, $gram_carb);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }

}