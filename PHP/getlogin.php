<?php
    $dns = 'mysql:host=localhost;dbname=id18842170_dbms_tut';
   $user='id18842170_depression131714';
   $pass='Prototype13171$';
   $host='localhost';
   $dbname='id18842170_dbms_tut';
    $conn = new mysqli($host, $user, $pass, $dbname);
    $sql = "SELECT * FROM logindetails";
    $result = $conn->query($sql);
    $ans=array();
    if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
        $ans[]=array('email'=>$row['email'],'password'=>$row['password'],'username'=>$row['username']);
  }
  echo json_encode($ans);
}
$conn->close();
?>