<?php

$dns = 'mysql:host=localhost;dbname=id18842170_dbms_tut';
   $user='id18842170_depression131714';
   $pass='Prototype13171$';
   $host='localhost';
   $dbname='id18842170_dbms_tut';
    $conn = new mysqli($host, $user, $pass, $dbname);
    
if (isset($_POST['email'])) {
    $email = $_POST['email'];
    }
    else{
        exit;
    }

if (isset($_POST['password'])) {
    $password = $_POST['password'];
}
else{
        exit;
    }

if (isset($_POST['username'])) {
    $username = $_POST['username'];
}
else{
        exit;
    }
$sql = "INSERT INTO logindetails (email, password, username) VALUES ('$email', '$password', '$username')";
$result = $conn->query($sql);
if($result->num_rows>0){
    echo "Records added successfully.";
} else{
    echo "ERROR:";
}
$conn->close();

?>