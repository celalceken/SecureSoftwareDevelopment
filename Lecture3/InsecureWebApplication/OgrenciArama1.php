<?php  require_once 'Guvenlik/PersonelDenetim.php';


require_once 'Include/DatabaseConnection.php';

/*if(!isset($_GET['mod']))
    $sql="SELECT * FROM ogrenciler where ogrenciNo='".$_POST['ogrenciNo']."'
        OR adi like '".$_POST['adi']."%' OR soyadi='".$_POST['soyadi']."'";
else
*/

$sql="SELECT \"ogrenciNo\", \"adi\", \"soyadi\" FROM \"Ogrenci\" where \"adi\" Like '".$_POST['adi']."%'";


//$sql="SELECT * FROM \"AkademikPersonel\" where \"personelNo\"= :pn AND \"sifre\"= :sfr";

$query = $veritabani->prepare($sql);
$query->execute();
//$sth->execute(array(':pn' => $this->userName, ':sfr' => $this->password));
//$result = $sth->fetchAll();



?>
<div class="table-responsive">
	<table class="table table-hover">
		<thead>
		<tr>
			<th>Öğrenci No</th>
			<th> Adı</th>
			<th>Soyadi</th>
			<th>Düzenle</th>
			<th>Sil</th>
			<th>Ayrıntı</th>

		</tr>
		</thead>
		<?php

		$satirNo=0;
		while($row=$query->fetch(PDO::FETCH_OBJ))
		{
			if($satirNo++%2)
				/*echo "<tr class=\"success\">";
			else*/
				echo "<tr class=\"active\">";


			echo "<td>". $row->ogrenciNo."</td>";
			echo "<td>". $row->adi."</td>";
			echo "<td>". $row->soyadi."</td>";

			?>
			<td>
				<a href="#" class="duzenle" id="<?php echo $row->ogrenciNo;?>" >Düzenle</a>
			</td>
			<td>
				<a href="#" class="sil"  id="<?php echo $row->ogrenciNo;?>">Sil</a>
			</td>
			<?php

			echo "<td>  <a href=\"#\" class=\"ayrinti\" rel=\"pop-up\"  id=\"".$row->ogrenciNo."\">Ayrıntı</a></td>";
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




