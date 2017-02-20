<?php

	$sunucu="localhost";
	$veritabani="ob";
	$kullaniciAdi="LectureUser";
	$sifre="LecturePassword"; // Bu bilgileri daha güvenli bir klasörde (etc/...) saklayıp oradan erişmek daha güvenlidir.

	$baglantiNo= mysqli_connect($sunucu, $kullaniciAdi, $sifre, $veritabani);
	// Bağlantiyi doğrula
	if (mysqli_connect_errno()) 
	{
		echo "bağlantı başarısız... " . mysqli_connect_error();
	}
	mysqli_set_charset($baglantiNo,"utf8");
