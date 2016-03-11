

		<?php
			
			session_start();
			
			if(!isset($_SESSION['baglandi']))	
			{
			
				echo "Yetkili kullanıcı değilsiniz....Giriş yapmanız gerekiyor
				<a href=\"../index.html\" >Giriş</a>";
				
				exit();
			
			}
			
			$oturumOmru = 10*60; // Oturum süresi 10 dk.
			
			if (isset($_SESSION['baslangicZamani']))
			{
				$oturumSuresi = time() - $_SESSION['baslangicZamani'];
				if ($oturumSuresi > $oturumOmru)
				{
					echo "Oturum süreniz dolmuştur...";	
					header("Location: Guvenlik/Cikis.php");
				}
			}
			$_SESSION['baslangicZamani'] = time();
			
			
				
						
		?>
	
