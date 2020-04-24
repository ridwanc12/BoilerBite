
<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    //$value = $_POST['value'] ?? '';

    //getting values
    //$teamName = $_POST['name'];
    //$memberCount = $_POST['member'];

    $userName = isset($_GET['userName']) ? $_GET['userName'] : '';
    $userName = !empty($_GET['userName']) ? $_GET['userName'] : '';

    $height = isset($_GET['height']) ? $_GET['height'] : '';
    $height = !empty($_GET['height']) ? $_GET['height'] : '';

    $weight = isset($_GET['weight']) ? $_GET['weight'] : '';
    $weight = !empty($_GET['weight']) ? $_GET['weight'] : '';

    $age = isset($_GET['age']) ? $_GET['age'] : '';
    $age = !empty($_GET['age']) ? $_GET['age'] : '';

    //including the db operation file
    require_once '../php/update_DbOperation.php';

    $db = new update_DbOperation();  // might have to add update_

    //inserting values
    if($db->update_createTeam($userName, $height, $weight, $age)){
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
