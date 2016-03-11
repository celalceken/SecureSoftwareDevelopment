<?php
		 require_once 'Include/VeritabaniBaglantisi.php';
//
// 		
		$sifre=md5($_POST['sifre']);

		$sql="INSERT INTO ogrenciler (ogrenciNo,adi,soyadi,sifre,telefonNo)
			VALUES ('$_POST[ogrenciNo]','$_POST[adi]','$_POST[soyadi]',
			'$sifre','$_POST[telefonNo]')";
// 			 
		$result = mysqli_real_query($baglantiNo,$sql);
// 		
		mysqli_close($baglantiNo);

		// //$data=array();
		if($result)
		{
			
			$data= array ('sonuc'=>'1');
			//print_r($data);	
		}
		else 
		{
			$data= array ('sonuc'=>'0');
			//print_r($data);
			
		}
		//$data= array ('sonuc'=>'1');
		echo json_encode($data);
?>
