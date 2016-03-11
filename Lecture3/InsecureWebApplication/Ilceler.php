
	

		<?php
		//echo $_POST['il'];
		//Bağlantı kurma isteği
		$con = mysqli_connect("localhost", "LectureUser", "LecturePassword", "ob");

        //require_once 'Include/DatabaseConnection.php';
		
		//istemci için karakter setini ayarlar
		mysqli_set_charset($con, "utf8");
		
		// Bağlantiyi doğrula
		if (mysqli_connect_errno()) {
			echo "bağlantı başarısız... " . mysqli_connect_error();
		}
		
		$strsql="SELECT * FROM ilceler where il='".$_POST['il']."'";
		//Sorgu çalıştırma
		$result = mysqli_query($con, $strsql);
		
		//Bağlantı sonlandırma...
		mysqli_close($con);
			
		echo '<select name="ilce" id="ilce">';
                  while ($row1 = mysqli_fetch_row($result)) 
				  {
					 	echo '<option  value="'.$row1[0].'" >'.$row1[2].'</option>';
                  }
                  
                  echo "</select>";

	//sorgu sonucu için ayrılan bellek bölgesinin serbest bırakılması gerekir...
		
		mysqli_free_result($result);
	
		?>
		
	