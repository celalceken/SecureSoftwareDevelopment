<?php
require_once 'Guvenlik/PersonelDenetim.php';
require_once 'Include/VeritabaniBaglantisi.php';
// 		
//echo "denemeemememe";
		/*$sql="Update Ogrenciler
		set adi='$_POST[adi]',
			soyadi='$_POST[soyadi]',
			sifre='$_POST[sifre]',
			telefonNo='$_POST[telefonNo]'
		where ogrenciNo='$_POST[ogrenciNo]'";*/

$sql="Update Ogrenciler
		set adi='$_POST[adi]'

		where ogrenciNo='$_POST[ogrenciNo]'";
//

		$result = mysqli_real_query($baglantiNo,$sql);
       //var_dump(print_r($result));
//
		mysqli_close($baglantiNo);

		// //$data=array();
		if($result)
		{
			
			$data= array ('sonuc'=>'1');
			print_r($data);
		}
		else 
		{
			$data= array ('sonuc'=>'0');
			//print_r($data);
			
		}
		//$data= array ('sonuc'=>'1');
		echo json_encode($data);
