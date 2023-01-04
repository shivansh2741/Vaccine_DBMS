<?php
   $dns = 'mysql:host=localhost;dbname=id18842170_dbms_tut';
   $user='id18842170_depression131714';
   $pass='[>f&(Hb3Gy?Lvv0o';
   $host='localhost';
   $dbname='id18842170_dbms_tut';
   try{
      $conn = new mysqli($host, $user, $pass, $dbname);
      echo "connected";
   }
   catch(PDOException $e){
      echo $e;

   }
?>