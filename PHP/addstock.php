<?php

$dns = 'mysql:host=localhost;dbname=id18842170_dbms_tut';
   $user='id18842170_depression131714';
   $pass='Prototype13171$';
   $host='localhost';
   $dbname='id18842170_dbms_tut';
    $conn = new mysqli($host, $user, $pass, $dbname);
    
if(isset($_POST['stock_id'])&&isset($_POST['vaccine_code'])&&isset($_POST['stock_total'])&&isset($_POST['expiry_date'])){
    $expiry_date=$_POST['expiry_date'];
    $stock_total=$_POST['stock_total'];
    $vaccine_code=$_POST['vaccine_code'];
    $stock_id=$_POST['stock_id'];
    $sql = "INSERT INTO vaccine_stock (stock_id,vaccine_code, stock_total,expiry_date) VALUES ('$stock_id', '$vaccine_code', '$stock_total','$expiry_date')";
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