<?php

require_once 'Include/VeritabaniBaglantisi.php';

		$sql="Delete From ogrenciler where ogrenciNo='$_GET[ogrenciNo]'";
 		//echo $sql;
		$result = mysqli_real_query($baglantiNo,$sql);
// 		
		mysqli_close($baglantiNo);

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
