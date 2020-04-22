<?php

//including the file dboperation
require_once '../php/DbOperation.php';

//creating a response array to store data
$response = array();


$teamName = isset($_GET['userName']) ? $_GET['userName'] : '';
$teamName = !empty($_GET['userName']) ? $_GET['userName'] : '';


$date = isset($_GET['date']) ? $_GET['date'] : '';
$date = !empty($_GET['date']) ? $_GET['date'] : '';

//creating a key in the response array to insert values
//this key will store an array iteself
//$response['teams'] = array();

//creating object of class DbOperation
$db = new DbOperation();

//getting the teams using the function we created
$teams = $db->getcalTeams($teamName, $date);

//looping through all the teams.
$team = $teams->fetch_assoc();
    //creating a temporary array
    $temp = array();

    $temp['total_calorie'] = $team['total_calorie'];

//displaying the array in json format
print $temp['total_calorie'];

//echo json_encode($temp);