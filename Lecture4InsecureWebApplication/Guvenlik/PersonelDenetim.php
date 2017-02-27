

		<?php

			
			session_start();
			
			if(!isset($_SESSION['baglandi']))	
			{
			
				echo "Yetkili kullanıcı değilsiniz....Giriş yapmanız gerekiyorrr
				<a href=\"index.html\" >Giriş</a>";
				
				exit();
			
			}
			
			$oturumOmru =10*60; // Oturum süresi 1 dk.
			
			if (isset($_SESSION['baslangicZamani']))
			{
				$oturumSuresi = time() - $_SESSION['baslangicZamani'];
				if ($oturumSuresi > $oturumOmru)
				{
					echo "Oturum süreniz dolmuştur...";	
					header("Location: Include/Cikis.php");
				}
			}
			$_SESSION['baslangicZamani'] = time();
			
			
				
						
		?>
	
