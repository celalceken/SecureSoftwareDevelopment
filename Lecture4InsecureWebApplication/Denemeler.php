<?php
/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 10.03.2016
 * Time: 17:36
 */
require_once 'Include/DatabaseConnection.php';
//require_once 'Include/Logger.php';
//require_once(__DIR__.'/Model/Ogrenci.class.php');
//require_once(__DIR__.'/Model/Kisi.class.php');
/*require_once(__DIR__.'/Model/OgrenciGoruntuleJSON.class.php');
require_once(__DIR__ . '/Classes/Logger.class.php');*/


//require_once 'Model/ModelFactory.class.php';
//require_once (__DIR__.'/Classes/ObjectFactory.class.php');
//$ogr=new \cc\Ogrenci();
$sql="SELECT \"ogrenciNo\",\"adi\", \"soyadi\", \"bolum\" FROM \"Ogrenci\" where \"ogrenciNo\"= :pn";

$sth = $veritabani->prepare($sql);
//$sth->execute(array(':pn' => 'B151212323'));
//$sth->setFetchMode(PDO::FETCH_CLASS, "\cc\Ogrenci");
//$ogrenci=$sth->fetchAll();

//var_dump($ogrenci);

//$ogrenciJSON = ModelOlusturucu::modelOlustur('OgrenciGoruntuleJSON');
//echo $ogrenciJSON->tekGoruntule($ogrenci[0]);




//$ogrenciJSONLog = NesneOlusturucu::nesneOlustur('Logger','Log.txt');

/*try
{

    $ogrenciJSONLog->log('Hata...',LOGGER::ERROR);
}
catch (Exception $e)
{
    echo $e -> hataGoruntule();
    exit(1);
}*/


/*


//echo "xyzzzz". $ogrenci[0]->getOgrenciNo()."". $ogrenci[0]->getAdi();


$userService1=NesneOlusturucu::nesneOlustur('SessionManagement', $veritabani,'A1','1');

$akademikPersonel=$userService1->login();
var_dump($akademikPersonel);*/
