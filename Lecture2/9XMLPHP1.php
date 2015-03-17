<?php

require_once "../Configuration/DatabaseConnection1.php";


$sql="SELECT * FROM ogrenciler where adi Like '".$_POST['adi']."%'";

$result = mysqli_query($baglantiNo, $sql);

mysqli_close($baglantiNo);

$strXML= '<?xml version="1.0" encoding="UTF-8"?><ogrenciler>';
while ($row = mysqli_fetch_array($result))
{

    $strXML.= "<ogrenci><adi> ". $row['adi']."</adi><soyadi>".$row['soyadi']."</soyadi></ogrenci>";
}
$strXML.= '</ogrenciler>';
print ($strXML);


