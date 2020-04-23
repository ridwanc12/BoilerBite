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

//print "de";

//creating object of class DbOperation
$db = new DbOperation();

//getting the teams using the function we created
$teams_count = $db->getcalTeams($teamName, $date);
$teams = $db->getcalTeams($teamName, $date);

//looping through all the teams.
$cnt = 0;
while($te = $teams_count->fetch_assoc()) {
    $cnt++;
}

$e = $cnt;
print " ". $e . " ";

while($team = $teams->fetch_assoc()) {
    //print "here";
    //creating a temporary array
    $temp = array();

    $temp['total_calorie'] = $team['total_calorie'];
    $temp['meal'] = $team['meal'];

    print $temp['total_calorie'].",".$temp['meal']." ";
}

//echo json_encode($temp);