
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

    $calories_total = isset($_GET['calories_total']) ? $_GET['calories_total'] : '';
    $calories_total = !empty($_GET['calories_total']) ? $_GET['calories_total'] : '';
    
    $meal = isset($_GET['meal']) ? $_GET['meal'] : '';
    $meal = !empty($_GET['meal']) ? $_GET['meal'] : '';

    $tz = 'America/New_York';
    $tz_obj = new DateTimeZone($tz);
    $today = new DateTime("now", $tz_obj);
    $date = $today->format('Y-m-d');
    
    $userId = 145;
    //including the db operation file
    require_once '../php/meal_DbOperation.php';
    
    //echo "hashpass: " .$password;

    $db = new meal_DbOperation();

  
    //inserting values
    if($db->meal_insert($userName, $calories_total, $meal, $date)){
        
        $response['error']=false;
        $response['message']='Team profiles added successfully';
        $res = 1;
    }else{
        
        $response['error']=true;
        $response['message']='Could not add meal';
        $res = 0;
    } 
    

}else{
    $response['error']=true;
    $response['message']='You are not authorized';
}
echo json_encode($response);
