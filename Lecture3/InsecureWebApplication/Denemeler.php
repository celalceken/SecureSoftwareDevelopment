<?php
/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 10.03.2016
 * Time: 17:36
 */
require_once 'Include/DatabaseConnection.php';
require_once(__DIR__.'/Model/Ogrenci.class.php');
require_once(__DIR__.'/Model/Kisi.class.php');

//$ogr=new \cc\Ogrenci();
$sql="SELECT \"ogrenciNo\",\"adi\", \"soyadi\", \"bolum\" FROM \"Ogrenci\" where \"ogrenciNo\"= :pn";

$sth = $veritabani->prepare($sql);
$sth->execute(array(':pn' => 'B151212323'));
$sth->setFetchMode(PDO::FETCH_CLASS, "\cc\Ogrenci");
$ogrenci=$sth->fetchAll();



echo "xyzzzz". $ogrenci[0]->getOgrenciNo()."". $ogrenci[0]->getAdi();