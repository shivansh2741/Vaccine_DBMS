<?php
    $dns = 'mysql:host=localhost;dbname=id18842170_dbms_tut';
   $user='id18842170_depression131714';
   $pass='Prototype13171$';
   $host='localhost';
   $dbname='id18842170_dbms_tut';
    $conn = new mysqli($host, $user, $pass, $dbname);
    $sql = "SELECT * FROM staff_account";
    $result = $conn->query($sql);
    $ans=array();
    if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
      if($row['email']!=''){
        $ans[]=array('email'=>$row['email']);
      }
        
  }
  echo json_encode($ans);
}
$conn->close();
?>