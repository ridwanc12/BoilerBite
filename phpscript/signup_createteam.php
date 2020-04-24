
<?php

//creating response array
$response = array();  // change to signup response

if($_SERVER['REQUEST_METHOD']=='POST'){

    //$value = $_POST['value'] ?? '';


    //getting values
    //$teamName = $_POST['name'];
    //$memberCount = $_POST['member'];

    $userName = isset($_GET['userName']) ? $_GET['userName'] : '';
    $userName = !empty($_GET['userName']) ? $_GET['userName'] : '';

    $firstName = isset($_GET['firstName']) ? $_GET['firstName'] : '';
    $firstName = !empty($_GET['firstName']) ? $_GET['firstName'] : '';
    
    $lastName = isset($_GET['lastName']) ? $_GET['lastName'] : '';
    $lastName = !empty($_GET['lastName']) ? $_GET['lastName'] : '';

    $height = isset($_GET['height']) ? $_GET['height'] : '';
    $height = !empty($_GET['height']) ? $_GET['height'] : '';
    
    //print "height: ". $height;

    $weight = isset($_GET['weight']) ? $_GET['weight'] : '';
    $weight = !empty($_GET['weight']) ? $_GET['weight'] : '';
    
    //print "weight: ". $weight;

    $age = isset($_GET['age']) ? $_GET['age'] : '';
    $age = !empty($_GET['age']) ? $_GET['age'] : '';
    
    //print "age: ". $age;

    $password = isset($_GET['password']) ? $_GET['password'] : '';
    $password = !empty($_GET['password']) ? $_GET['password'] : '';
    
    //$hashPass = isset($_GET['hashPass']) ? $_GET['hashPass'] : '';
    //$hashPass = !empty($_GET['hashPass']) ? $_GET['hashPass'] : '';
    $userId = 145;
    //including the db operation file
    require_once '../php/signup_DbOperation.php';
    
    //echo "hashpass: " .$password;

    $db = new signup_DbOperation();

    //inserting values
    $pass = $pass + "salt";
    $password = sha1($pass);
    if($db->signup_teamprofiles($userName, $firstName, $password)){
        $response['error']=false;
        $response['message']='Team profiles added successfully';
        $res = 1;
    }else{
        $response['error']=true;
        $response['message']='Could not add team profiles';
        $res = 0;
    } 
    
    if($db->signup_teaminfo($userName, $height, $weight, $age)){
        $response['error']=false;
        $response['message']='Team info added successfully';
    }else{
        $response['error']=true;
        $response['message']='Could not add team info';
    }

}else{
    $response['error']=true;
    $response['message']='You are not authorized';
}
echo json_encode($res);
