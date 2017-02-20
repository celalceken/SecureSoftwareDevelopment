<!DOCTYPE html>

<html>
	<head>
		<title>index1</title>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

	</head>

	<body>

		<?php
			session_start();
			
			session_destroy(); // Oturum sonlandırılıyor. Tüm oturum bilgileri yok edilir.
		

			echo "Giriş yapmanız gerekiyor
				<a href=\"../index.html\" >Giriş</a>";
		?>

		
	</body>
</html>

