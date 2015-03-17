<?php

require_once "../Configuration/DatabaseConnection1.php";


$sql="SELECT * FROM ogrenciler where adi Like '".$_POST['adi']."%'";

$result = mysqli_query($baglantiNo, $sql);

mysqli_close($baglantiNo);


while ($row = mysqli_fetch_array($result))
{

    $str[] = array('adi' => $row['adi'], 'soyadi' => $row['soyadi']);
}

print json_encode($str);


