<?php

//including the file dboperation
require_once '../php/DbOperation.php';

//creating a response array to store data
$response = array();


$teamName = isset($_GET['userName']) ? $_GET['userName'] : '';
$teamName = !empty($_GET['userName']) ? $_GET['userName'] : '';

//creating a key in the response array to insert values
//this key will store an array iteself
//$response['teams'] = array();

//creating object of class DbOperation
$db = new DbOperation();

//getting the teams using the function we created
$teams = $db->getProfileTeams($teamName);

//looping through all the teams.
$team = $teams->fetch_assoc();
    //creating a temporary array
    $temp = array();

    //inserting the team in the temporary array
    $temp['userEmail'] = $team['userEmail'];
    //$temp['name']=$teams['name'];
    $temp['hashPass']=$team['hashPass'];

$tea = $db->getInfoTeams($teamName);
$te = $tea->fetch_assoc();
    //inserting the temporary array inside response
    $temp['height']=$te['height'];
    $temp['weight']=$te['weight'];
    $temp['age']=$te['age'];
//}
//array_push($response['teams'],$temp);

//displaying the array in json format
print $temp['userEmail']. " ";
print $temp['hashPass']. " ";
print $temp['height']. " ";
print $temp['weight']. " ";
print $temp['age']. " ";
//echo json_encode($temp);