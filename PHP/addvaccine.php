<?php

$dns = 'mysql:host=localhost;dbname=id18842170_dbms_tut';
   $user='id18842170_depression131714';
   $pass='Prototype13171$';
   $host='localhost';
   $dbname='id18842170_dbms_tut';
    $conn = new mysqli($host, $user, $pass, $dbname);
    
if(isset($_POST['name'])&&isset($_POST['code'])&&isset($_POST['cost'])&&isset($_POST['efficacy'])){
    $name=$_POST['name'];
    $code=$_POST['code'];
    $cost=$_POST['cost'];
    $efficacy=$_POST['efficacy'];
    $sql = "INSERT INTO vaccine (name, code, cost,efficacy) VALUES ('$name', '$code', '$cost','$efficacy')";
$result = $conn->query($sql);
if($result->num_rows>0){
    echo "Records added successfully.";
} else{
    echo "ERROR:";
}
$conn->close();
    
}
else{
    exit;
}


?>