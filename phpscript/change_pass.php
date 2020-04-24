
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

    $password = isset($_GET['hashPass']) ? $_GET['hashPass'] : '';
    $password = !empty($_GET['hashPass']) ? $_GET['hashPass'] : '';

    //including the db operation file
    require_once '../php/pass_Dboperation.php';

    $db = new change_DbOperation(); // change this and 27

    //inserting values
    $password= $password + "salt";
    $pass = sha1($password);
    if($db->change_createteam($username, $pass)){
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
