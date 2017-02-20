<?php
require_once (__DIR__ . '/Model/VeritabaniIslemleri.class.php');
require_once(__DIR__.'/Model/Ogrenci.class.php');
require_once 'Model/ModelFactory.class.php';

//$ogrenci=ModelFactory::getModel('Ogrenci',$_POST[ogrenciNo],$_POST[adi],$_POST[soyadi]);
$ogrenci=ModelFactory::getModel('Ogrenci');

$ogrenci->setOgrenciNo($_POST['ogrenciNo']);
$ogrenci->setAdi($_POST['adi']);
$ogrenci->setSoyadi($_POST['soyadi']);

//var_dump($ogrenci);
$entity = array("ogrenciNo" => "'{$ogrenci->getOgrenciNo()}'", "adi" => "'{$ogrenci->getAdi()}'", "soyadi" =>"'{$ogrenci->getSoyadi()}'");

//var_dump( $entities);

//$entities = array("ogrenciNo" => "'$_POST[ogrenciNo]'", "adi" => "'$_POST[adi]'", "soyadi" =>"'$_POST[soyadi]'");

$data= (\cc\VeritabaniIslemleri::insert('Ogrenci',$entity)) ? array ('sonuc'=>'1') : array ('sonuc'=>'0');

echo json_encode($data);

