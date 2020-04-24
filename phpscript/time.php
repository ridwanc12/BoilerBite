<?php

class  insertTable
{
    
} // End of functions

$tz = 'America/New_York';
$tz_obj = new DateTimeZone($tz);
$today = new DateTime("now", $tz_obj);
$today_formatted = $today->format('Y-m-d');
echo nl2br($today_formatted);

//$obj->showUsers();
?>

