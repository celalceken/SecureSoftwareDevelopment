<?php  require_once 'Guvenlik/PersonelDenetim.php';
//require_once 'Genel/VeritabaniBaglantisi.php';

?>

<script type="text/javascript">
	$(document).ready(function(){
		$("#mesaj,#mesaj1, #mesaj2").hide();

		$('#ogrenciNo').focus(function()
		{
			$('#mesaj').hide();
		});

		$('#ogrenciNo').blur(function() {

			// var form_data= $("#form1").serialize();

			var form_data =
			{
				ogrenciNo: $('#ogrenciNo').val()
			};



			$.ajax({
				url: "OgrenciDogrula.php",
				type: 'POST',
				dataType: 'json',
				data: form_data,
				success: function(data)
				{	//alert(data);

					var sonuc = data['sonuc'];
					if (sonuc == '1')
					{
						$("#mesaj").html("<h5><strong>Uyarı!</strong> Öğrenci Zaten Kayıtlı.</h5>").slideDown("1500");
					}
					else
					{

						//$("#mesaj").html("Kayıt bulunamadı!!!").slideDown("1500");

					}



					//$("#ortaForm").append(msg);
					//$('#listele2').html(msg).fadeIn("slow");//.fadeOut("slow");
				},
				error: function()
				{
					alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
				}
			});

			return false;

		});


		$('#kaydet').click(function() {

			var form_data=$('#form :input').serialize();
			// var form_data=$("form").serialize();
			//alert (form_data);

			$.ajax({
				url: 'OgrenciEkle1.php',
				type: 'POST',
				dataType: 'json',
				data:form_data,
				success: function(data)
				{	if(data.sonuc==1)
				{	   $("#mesaj").html("<h5><strong>Bilgi!</strong> Öğrenci Başarıyla Eklenmiştir.</h5>").slideDown(1500);
					//$('#ogrenciNo').focus();
					//return;

				}else
				{
					$("#mesaj").html("<h5><strong>Bilgi!</strong> İşlem Başarısız...</h5>").slideDown(1500);
					//$('#ogrenciNo').focus();

				}
				},
				error: function()
				{
					alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");

				}
			});
		});



	});


</script>



<div class="panel-heading" >
	Öğrenci İlk Kayıt
</div>

<div class="panel-body" >

	<form  id="form">
		<div id="mesaj" class="alert alert-warning">
		</div>

		<table class="table-responsive">
			<tr>
				<td>
					<label for="ogrenciNo"><strong>Öğrenci No</strong></label>
				</td>
				<td>
					<input id="ogrenciNo" name="ogrenciNo" type="text" class="input-mini" placeholder="Öğrenci Numarasını Giriniz" required>
				</td>
			</tr>
			<tr>
				<td>
					<label for="adi" ><strong>Adi</strong></label>
				</td>
				<td>
				<input id="adi" name="adi" type="text" class="input-mini" placeholder="Öğrenci Adını Giriniz" >
				</td>
			</tr>
			<tr>
				<td>
					<label for="soyadi" ><strong>Soyadi</strong></label>
				</td>
				<td>
					<input id="soyadi" name="soyadi" type="text" class="input-mini" placeholder="Öğrenci Soyadını Giriniz" >
				</td>
			</tr>
			<tr>
				<td>

					<input id="kaydet" value="Kaydet" class="btn btn-primary">
				</td>
				<td> &nbsp;
				</td>
			</tr>
		</table>
	</form>


</div>


