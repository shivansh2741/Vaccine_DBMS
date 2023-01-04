<?php

$dns = 'mysql:host=localhost;dbname=id18842170_dbms_tut';
   $user='id18842170_depression131714';
   $pass='Prototype13171$';
   $host='localhost';
   $dbname='id18842170_dbms_tut';
    $conn = new mysqli($host, $user, $pass, $dbname);
    
if(isset($_POST['id'])&&isset($_POST['email'])&&isset($_POST['code'])&&isset($_POST['amount'])&&isset($_POST['date'])){
    $id=$_POST['id'];
    $email=$_POST['email'];
    $code=$_POST['code'];
    $amount=$_POST['amount'];
    $date=$_POST['date'];
    $sql = "INSERT INTO booking (payment_id,email,vaccine_code,amount,date) VALUES ('$id', '$email', '$code','$amount','$date')";
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