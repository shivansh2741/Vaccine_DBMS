<?php

$dns = 'mysql:host=localhost;dbname=id18842170_dbms_tut';
   $user='id18842170_depression131714';
   $pass='Prototype13171$';
   $host='localhost';
   $dbname='id18842170_dbms_tut';
    $conn = new mysqli($host, $user, $pass, $dbname);
    
if (isset($_POST['name'])) {
    $name = $_POST['name'];
    }
    else{
        exit;
    }

if (isset($_POST['roll'])) {
    $roll = $_POST['roll'];
}
else{
        exit;
    }

if (isset($_POST['subject'])) {
    $subject = $_POST['subject'];
}
else{
        exit;
    }
if (isset($_POST['marks'])) {
    $marks = $_POST['marks'];
}
else{
        exit;
    }
// $name = mysqli_real_escape_string($conn, $_REQUEST['name']);

// $subject = mysqli_real_escape_string($conn, $_REQUEST['subject']);
// $roll = mysqli_real_escape_string($conn, $_REQUEST['roll']);
// $marks = mysqli_real_escape_string($conn, $_REQUEST['marks']);
$sql = "INSERT INTO trial (name, roll, subject,marks) VALUES ('$name', '$roll', '$subject','$marks')";
$result = $conn->query($sql);
if($result->num_rows>0){
    echo "Records added successfully.";
} else{
    echo "ERROR:";
}
$conn->close();

?>