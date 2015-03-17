<?php

require_once "../Configuration/DatabaseConnection1.php";


$sql="SELECT * FROM ogrenciler where ogrenciNo Like '".$_POST['ogrenciNo']."%'";


$result = mysqli_query($baglantiNo,$sql);

mysqli_close($baglantiNo);

if(mysqli_num_rows($result)!=0)
{


    $data= array ('sonuc'=>'1');
    //print_r($data);
}
else
{
    $data= array ('sonuc'=>'0');
    //print_r($data);

}

echo json_encode($data);

mysqli_free_result($result);
