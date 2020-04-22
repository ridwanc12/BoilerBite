<?php

class calories_DbConnect
{
    private $conn;

    function __construct()
    {
    }

    /**
     * Establishing database connection
     * @return database connection handler
     */
    function calories_connect()
    {
        require_once 'Config_calories.php';

        // Connecting to mysql database
        $this->conn = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);

        // Check for database connection error
        if (mysqli_connect_errno()) {
            echo "Failed to connect to MySQL: " . mysqli_connect_error();
        }

        // returning connection resource
        return $this->conn;
    }
}