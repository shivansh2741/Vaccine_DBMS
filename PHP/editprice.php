<?php

$dns = 'mysql:host=localhost;dbname=id18842170_dbms_tut';
   $user='id18842170_depression131714';
   $pass='Prototype13171$';
   $host='localhost';
   $dbname='id18842170_dbms_tut';
    $conn = new mysqli($host, $user, $pass, $dbname);
    
if(isset($_POST['cost'])&&isset($_POST['code'])){
    $code=$_POST['code'];
    $cost=$_POST['cost'];
    $sql = "UPDATE vaccine SET cost = $cost WHERE code = $code";
$result = $conn->query($sql);

if(isset($result->num_rows) && $result->num_rows >0){
    echo "Records added successfully.";
} else{
    echo "Error";
}
$conn->close();
    
}
else{
    exit;
}


?>