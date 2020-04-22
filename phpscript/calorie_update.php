
<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    //$value = $_POST['value'] ?? '';

    //getting values
    //$teamName = $_POST['name'];
    //$memberCount = $_POST['member'];

    $username = isset($_GET['userName']) ? $_GET['userName'] : '';
    $username = !empty($_GET['userName']) ? $_GET['userName'] : '';

    $calories = isset($_GET['calories_total']) ? $_GET['calories_total'] : '';
    $calories = !empty($_GET['calories_total']) ? $_GET['calories_total'] : '';
    
    $calorie_fat = 0;
    $gram_fat = 0;
    $gram_protein = 0;
    $gram_carb = 0;

    //including the db operation file
    require_once '../php/calories_DbOperation.php';

    $db = new calories_DbOperation();

    //inserting values
    if($db->calories_createTeam($username, $calories, $calorie_fat, $gram_fat, $gram_protein, $gram_carb)){
        $response['error']=false;
        $response['message']='Team added successfully';
    }else{
        $response['error']=true;
        $response['message']='Could not add team';
    }

}else{
    $response['error']=true;
    $response['message']='You are not authorized';
}
echo json_encode($response);
