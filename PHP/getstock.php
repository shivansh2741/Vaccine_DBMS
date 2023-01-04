<?php
    $dns = 'mysql:host=localhost;dbname=id18842170_dbms_tut';
   $user='id18842170_depression131714';
   $pass='Prototype13171$';
   $host='localhost';
   $dbname='id18842170_dbms_tut';
    $conn = new mysqli($host, $user, $pass, $dbname);
    $sql = "SELECT * FROM vaccine_stock";
    $result = $conn->query($sql);
    $ans=array();
    if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
        $ans[]=array('stock_id'=>$row['stock_id'],'vaccine_code'=>$row['vaccine_code'],'stock_total'=>$row['stock_total'],'expiry_date'=>$row['expiry_date']);
  }
  echo json_encode($ans);
}
$conn->close();
?>