<?php
require_once 'dbconfig.php';

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    echo "Connected to $dbname at $host successfully.";

} catch (PDOException $pe) {
    die("could not connect to: " . $pe->getmessage());

}