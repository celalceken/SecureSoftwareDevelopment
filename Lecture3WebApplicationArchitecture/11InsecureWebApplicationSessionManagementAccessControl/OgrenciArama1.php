<?php  require_once 'Guvenlik/PersonelDenetim.php';


require_once 'Include/DatabaseConnection.php';
require_once(__DIR__.'/Model/Ogrenci.class.php');
require_once 'Model/ModelFactory.class.php';
require_once(__DIR__.'/Model/OgrenciGoruntuleJSON.class.php');



/*if(!isset($_GET['mod']))
    $sql="SELECT * FROM ogrenciler where ogrenciNo='".$_POST['ogrenciNo']."'
        OR adi like '".$_POST['adi']."%' OR soyadi='".$_POST['soyadi']."'";
else
*/
if(($_POST['mod'])==1)
	$sql="SELECT \"ogrenciNo\", \"adi\", \"soyadi\" FROM \"Ogrenci\" where \"adi\" Like '".$_POST['adi']."%'";
else if(($_POST['mod'])==2)
	$sql="SELECT \"ogrenciNo\", \"adi\", \"soyadi\" FROM \"Ogrenci\" Where \"ogrenciNo\"='".$_POST['ogrenciNo']."'";
//echo $sql;
//$sql="SELECT * FROM \"AkademikPersonel\" where \"personelNo\"= :pn AND \"sifre\"= :sfr";

$query = $veritabaniBaglantisi->prepare($sql);
$query->execute();
//$sth->execute(array(':pn' => $this->userName, ':sfr' => $this->password));
//$result = $sth->fetchAll();


$query->setFetchMode(PDO::FETCH_CLASS, "\cc\Ogrenci");
$ogrenciler=$query->fetchAll();

//var_dump($ogrenciler);

?>
<div class="table-responsive">
	<table class="table  table-hover table-condensed" style="font-size: x-small">
		<thead>
		<tr>
			<th>Öğrenci No</th>
			<th> Adı</th>
			<th>Soyadi</th>

			<th>Düzenle</th>
			<th>Sil</th>
			<th>Ayrıntı</th>
			<th>JSON</th>
		</tr>
		</thead>
		<?php

		$satirNo=0;
		$ogrenciJSON = ModelFactory::getModel('OgrenciGoruntuleJSON');
		foreach($ogrenciler as $ogrenci)
		{
			if($satirNo++%2)
				/*echo "<tr class=\"success\">";
			else*/
				echo "<tr class=\"active\">";



			echo "<td>". $ogrenci->getOgrenciNo()."</td>";
			echo "<td>". $ogrenci->getAdi()."</td>";
			echo "<td>". $ogrenci->getSoyadi()."</td>";


			?>
			<td>
				<a href="#" class="duzenle" id="<?php echo $ogrenci->getOgrenciNo();?>" >Düzenle</a>
			</td>
			<td>
				<a href="#" class="sil"  id="<?php echo $ogrenci->getOgrenciNo();?>">Sil</a>
			</td>
			<?php

			echo "<td>  <a href=\"#\" class=\"ayrinti\" rel=\"pop-up\"  id=\"".$ogrenci->getOgrenciNo()."\">Ayrıntı</a></td>";
			echo "<td>". $ogrenciJSON->getKisi($ogrenci)."</td>";

			//Strategy tasarım deseni örneği. XML Görüntülemek gerektiğinde Ogrenci sınıfındaki yazdir içerisini
			// değiştirmeye gerek kalmadan OgrenciGoruntuleXML sınıfı tanımlanıp XML çıktısı yazdırılabilir.
			echo "<td>". $ogrenci->yazdir(ModelFactory::getModel('OgrenciGoruntuleJSON'))."</td>";
			?>

			</tr>

		<?php } ?>
	</table>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		$('#mesaj3').hide();
		$('#mesaj4').hide();

		$("a.sil").click(function(){

			var adres= 'OgrenciSil.php?ogrenciNo='+ this.id;
			//alert(adres);
			$.ajax({
				url: adres,
				type: 'POST',
				dataType: 'json',
				//data: form_data,
				success: function(data)
				{	 //$("#listele1").slideDown("1500");
					//$("#mesaj3").slideDown("1500");
					if(data.sonuc==1)
					{	alert("Silme işlemi başarılı !!!");
						//if ($("#mesaj3").is(":hidden"))
						//{
						// $("#mesaj3").slideDown("1500");
						// $('#mytable').hide();
						// $('#mesaj4').hide();

						//}
						//else
						//{
						//$("#mesaj2").slideUp("1500");
						//}


						exit(0);
					}else
					{
						alert("Silme işlemi başarılı değil !!!");
						//if ($("#mesaj2").is(":hidden"))
						//{
						//$("#mesaj4").slideDown("1500");
						//}
						//else
						//{
						//$("#mesaj2").slideUp("1500");
						//}

						exit(0);
					}
					//$('#sagForm').html(msg).fadeIn("slow");//.fadeOut("slow");
				},
				error: function()
				{
					alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
					$("#mesaj4").slideDown("1500");
				}
			});

			return false;
		});


		$("a.duzenle").click(function() {

			var form_data = {
				ogrenciNo: this.id
			};
			//var adres= 'OgrenciDuzenle.php?ogrenciNo='+ this.id;

			$.ajax({
				url: 'OgrenciDuzenle.php',
				type: 'POST',
				//dataType: 'json',
				data: form_data,
				success: function(msg)
				{
					$('#liste').html(msg).fadeIn("slow");//.fadeOut("slow");
				},
				error: function()
				{
					alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
					//$("#mesaj4").slideDown("1500");
				}
			});

			return false;
		});



		$("a.ayrinti").click(function() {


			//alert(this.id+"xx");
			var form_data = {
				ogrenciNo: this.id

			};

			var adres= 'OgrenciSil.php?ogrenciNo='+ this.id;
			$.ajax({
				url: adres,
				type: 'POST',
				//dataType: 'json',
				data: form_data,

				success: function(msg)
				{	 //$("#listele").slideDown("1500");
					//$('#solAltForm').fadeOut("slow");
					//alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
					//$('#listele2').html(msg).fadeIn("slow");//.fadeOut("slow");
					//{ width: 460 },{ autoOpen: true },{ modal: true },
					//$('#listele2').html(msg);
					$('#ayrintiMesaj').html(msg);
					//$('#listele2').dialog();//.
					//$('#listele2').dialog();//.fadeOut("slow");
					$( "#ayrintiMesaj" ).dialog({ width: 550 },{ modal: true },{ show: 'slide' });
				},
				error: function()
				{
					alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
				}
			});


		});

	});

</script>




