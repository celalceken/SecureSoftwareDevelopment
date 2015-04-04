<?php
	$title="Personel Ana Sayfası";
	require_once 'Genel/Baslik.php';
	require_once 'Guvenlik/PersonelDenetim.php'; //Site içerisindeki tüm sayfalara eklenmeli...
 ?>



<div id="content">

	<div id="liste">

		<span class="contentBox"> <h4>

			<?php echo $_SERVER['DOCUMENT_ROOT'];	echo $_SERVER['SERVER_NAME'];     echo " --- ".$_SERVER['HTTP_HOST'];echo $_SERVER['REQUEST_URI'];

			echo "<br />".$_SESSION['personelNo'];
				//echo "<img src=\"Resimler\/$_SESSION['personelNo']\.jpg\" /> ";
	// $this -> CI = &get_instance();
	// $b = "PersonelDenetim/sayfaGoster1/PersonelAnaSayfaSiteHaritasi/0";
	// $this -> CI -> session -> set_userdata(array('oncekiSayfa' => $b));
	//
	// //echo  $this->session->userdata('personelNo')."<br />";
	//
	// echo $this -> session -> userdata('adi') . " ";
	//
	// echo $this -> session -> userdata('soyadi');
			?></h4> </span>



		<div id="accordion">
			<h3><a href="#"><strong>&nbsp;&nbsp;&nbsp;Öğrenci İşlemleri</strong></a></h3>
			<div >
				<table>
					<tr>
						<td width="50%">
						<li type="circle">
							<a href="#" id="ogrenciEkleme">Öğrenci Ekleme</a>
						</li>
						<li type="circle">
							<a href="#" id="ogrenciArama">Öğrenci Arama</a>
						</li>
						<li type="circle">
							<a href="#" id="ogrenciSilme">Öğrenci Silme</a>
						</li>
						<li type="circle">
							<a href="#" id="ogrenciDuzenleme">Öğrenci Düzenleme</a>
						</li>
						</td>
						<td width="40%"><img src="../../img/1357675917_preferences-contact-list.png" align="left" width="128" height="128"  /></td><td width="10%">&nbsp;</td>

					</tr>
				</table>

			</div>
			<h3><a href="#"><strong>&nbsp;&nbsp;&nbsp;Ders İşlemleri</strong></a></h3>
			<div style="">
				<table>
					<tr>
						<td width="50%">
						<li type="circle">
							<a href="#" id="bransGoruntuleme" >Ders Görüntüleme</a>
						</li>
						<li type="circle">
							<a href="#" id="bransEkleme" >Ders Ekleme</a>
						</li>
						<li type="circle">
							<a href="#" id="bransSilme" >Ders Silme</a>
						</li>
						</td>
						<td width="40%"><img src="" align="left" width="128" height="128"  /></td><td width="10%">&nbsp;</td>
					</tr>
				</table>
			</div>


			<h3><a href="#"><strong>&nbsp;&nbsp;&nbsp;Personel İşlemleri</strong></a></h3>
			<div>
				<table>
					<tr>
						<td width="50%">
						<li type="circle">
							<a href="#" id="personelEkleme" >Personel Ekleme</a>
						</li>
						<li type="circle">
							<a href="#" id="personelArama" >Personel Arama</a>
						</li>
						<li type="circle">
							<a href="#" id="personelSilme" >Personel Silme</a>
						</li>
						<li type="circle">
							<a href="#" id="personelDuzenleme" >Personel Düzenleme</a>
						</li></td>
						<td width="40%"><img src="" align="left" width="128" height="128"  /></td><td width="10%">&nbsp;</td>

					</tr>
				</table>

			</div>



			<h3><a href="#"><strong>&nbsp;&nbsp;&nbsp;İstatistik</strong></a></h3>
			<div>

				<table>
					<tr>
						<td width="50%">
						<li type="circle">
							<a href="#" id="ogrenciSayilari" >Cinsiyete Göre Öğrenci Sayıları</a>
						</li>
						<li type="circle">
							<a href="#" id="ogrenciSayilariYas" >Yaşa Göre Öğrenci Sayıları</a>
						</li>
						<li type="circle">
							<a href="#" id="ogrenciSayilariMezuniyet" >Öğrenim Durumuna Göre Öğrenci Sayıları</a>
						</li></td>

						<td width="40%"><img src="../../img/istatistik1.png" align="left" width="128" height="128"  /></td><td width="10%">&nbsp;</td>
					</tr>
				</table>
			</div>

		
		</div>

	</div>

</div>

<script>
$(function()
{
		$("#accordion").accordion({ animated: 'bounceslide',autoHeight: false });
		
		$('#ogrenciArama,#ogrenciSilme,#ogrenciDuzenleme').click(function() 
		{
	
	
			$.ajax({
				url: 'OgrenciArama.php',
				type: 'POST',
				//data: form_data,
				success: function(msg) 
				{
					// $("#listele").slideDown("500");
					$("#liste").html(msg).fadeIn("slow");//.fadeOut("slow");
				},
				error: function()
				{
					alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
				}
	
			});
			
		});
		
		
		$('#ogrenciEkleme').click(function() 
		{
	
	
			$.ajax({
				url: 'OgrenciEkle.php',
				type: 'POST',
				//data: form_data,
				success: function(msg) 
				{
					// $("#listele").slideDown("500");
					$("#liste").html(msg).fadeIn("slow");//.fadeOut("slow");
				},
				error: function()
				{
					alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
				}
	
			});
			
		});
		
		

}); 
</script>


<?php
	include 'Genel/Altlik.php';
