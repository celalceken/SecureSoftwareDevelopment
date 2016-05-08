<?php

require_once 'Include/DatabaseConnection.php';
require_once (__DIR__.'/Model/Ogrenci.class.php');


//$sql="SELECT * FROM \"Ogrenci\" where \"ogrenciNo\" Like '".$_POST['ogrenciNo']."%'";
$sql="SELECT \"ogrenciNo\", \"adi\", \"soyadi\"  FROM \"Ogrenci\" where \"ogrenciNo\" = :ogrenciNumarasi";


$sth = $veritabaniBaglantisi->prepare($sql);
$sth->execute(array(':ogrenciNumarasi' => $_POST['ogrenciNo']));

$sth->setFetchMode(PDO::FETCH_CLASS, "\cc\Ogrenci");
$ogrenci=$sth->fetchAll();

if(count($ogrenci)>=1)

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