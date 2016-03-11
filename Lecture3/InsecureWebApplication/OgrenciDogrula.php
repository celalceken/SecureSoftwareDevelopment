<?php
require_once 'Include/VeritabaniBaglantisi.php';
		
		
		$sql="SELECT ogrenciNo FROM ogrenciler where ogrenciNo='".$_GET['ogrenciNo']."'";
			 
		$result = mysqli_query($baglantiNo,$sql);
		
		mysqli_close($baglantiNo);

		//$data=array();
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
?>
