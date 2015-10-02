
		<?php
		require_once 'Genel/VeritabaniBaglantisi.php';
		
		// 11' or '1'='1'#

		// PersonelNo olarak:00000000002' # ya da Şifre olarak: 1' OR '1'='1 girildiğinde doğrulama yapılmadığı için login yapılmış olur...
		
		

		//$sql="SELECT personelNo,sifre FROM personel where personelNo='".$_POST['personelNo']."' AND sifre='".$_POST['sifre']."'";
		
		$sql="SELECT personelNo,sifre FROM personel where personelNo='".mysqli_real_escape_string($baglantiNo,$_POST['personelNo'])."' AND sifre='".mysql_real_escape_string($_POST['sifre'])."'";
		
		$sql="SELECT personelNo,sifre FROM personel where personelNo='".filter_var($_POST['personelNo'],FILTER_SANITIZE_STRING)."' AND sifre='".filter_var($_POST['sifre'],FILTER_SANITIZE_STRING)."'";
	
		//$sql="SELECT personelNo,sifre FROM personel where personelNo='".$_POST['personelNo']."' AND sifre='".md5($_POST['sifre'])."'";
		
		 
		$result = mysqli_query($baglantiNo,$sql);
		
		mysqli_close($baglantiNo);

		//$data=array();
		if(mysqli_num_rows($result)!=0)
		{
			session_start();
			
			$_SESSION['personelNo'] = $_POST['personelNo'];
			
			$_SESSION['baglandi'] =TRUE;
			
			$_SESSION['baslangicZamani']=time();
			
			// Yetki düzeyi de eklenmeli...
				
			$data= array ('sonuc'=>'1');
			//print_r($data);	
		}
		else 
		{
			$data= array ('sonuc'=>'0');
			//print_r($data);
			
		}
		
		echo json_encode($data);
		//  JavaScript Object Notation yalnızca veri alış-verişi amacıyla oluşturulmuş bir veri biçimlendirme yöntemidir
		// XML e göre daha az yer kaplar. json verilerini java script ile erişmek XML e (parsing is necessary) 
		// göre çok daha kolaydır.
		// $.getJSON(), ve $.ajax({ dataType: 'json'}) fonksiyonlarıyla verilere erişilebilir.
		?>
