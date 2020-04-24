
<?php

//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){

    //$value = $_POST['value'] ?? '';

    //getting values
    //$teamName = $_POST['name'];
    //$memberCount = $_POST['member'];

    $teamName = isset($_GET['userName']) ? $_GET['userName'] : '';
    $teamName = !empty($_GET['userName']) ? $_GET['userName'] : '';

    //$temp1 = $_GET['member'];
    $memberCount = isset($_GET['hashPass']) ? $_GET['hashPass'] : '';
    $memberCount = !empty($_GET['hashPass']) ? $_GET['hashPass'] : '';
    
    //print "t: ". $teamName;
    //print "m: ". $memberCount;

    //including the db operation file
    require_once '../php/DbOperation.php';

    $db = new DbOperation();

    //inserting values
    echo sha1($memberCount);
    $memberCount = $memberCount . "salt";
    $memberCount = sha1($memberCount);
    echo "\n " . $memberCount . " ";
    if($db->createTeam($teamName,$memberCount)){
        $response['error']=false;
        $response['message']='login successful';
        //echo $memberCount;
        $res = 1;
    }else{

        $response['error']=true;
        $response['message']='login unsuccessful';
        $res = 0;
    }

}else{
    $response['error']=true;
    $response['message']='You are not authorized';
}
echo json_encode($res);
