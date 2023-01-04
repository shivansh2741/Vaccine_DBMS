<?php

$dns = 'mysql:host=localhost;dbname=id18842170_dbms_tut';
   $user='id18842170_depression131714';
   $pass='Prototype13171$';
   $host='localhost';
   $dbname='id18842170_dbms_tut';
    $conn = new mysqli($host, $user, $pass, $dbname);
    
if(isset($_POST['id'])&&isset($_POST['amount'])){
    $id=$_POST['id'];
    $amount=$_POST['amount'];
    $sql = "UPDATE vaccine_stock SET stock_total = '$amount' WHERE stock_id = '$id'";
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