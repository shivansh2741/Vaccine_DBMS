<?php
    $dns = 'mysql:host=localhost;dbname=id18842170_dbms_tut';
   $user='id18842170_depression131714';
   $pass='Prototype13171$';
   $host='localhost';
   $dbname='id18842170_dbms_tut';
    $conn = new mysqli($host, $user, $pass, $dbname);
    $sql = "SELECT * FROM booking";
    $result = $conn->query($sql);
    $ans=array();
    if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
        $ans[]=array('payment_id'=>$row['payment_id'],'email'=>$row['email'],'amount'=>$row['amount'],'vaccine_code'=>$row['vaccine_code'],'date'=>$row['date']);
  }
  echo json_encode($ans);
}
$conn->close();
?>