<?php
require_once 'Guvenlik/PersonelDenetim.php';

?>


<div class="panel-heading" >
	Öğrenci Arama/Silme/Düzenleme
</div>

<div class="panel-body" >

	<form class="form-inline">
		<fieldset>
			<label class="control-label"><strong>Öğrenci No</strong></label>
			<input id="ogrenciNo" type="text" class="input-mini" placeholder="Öğrenci Numarasını Giriniz" >
			<input id="ara" value="Ara" class="btn btn-primary">
			<label class="control-label"><strong>Öğrenci Adı</strong></label>
			<input id="adi" type="text" class="input-mini" placeholder="Öğrenci Adını Giriniz" >
		</fieldset>
	</form>

	<div  class="panel panel-success" id="sonucPaneli">
		<div class="panel-heading">Arama Sonucu</div>
		<div id="aramaSonucu" class="panel-body" style="max-height: 250px;overflow-y: scroll;" ></div>

	</div>

</div>



<!--Kişiselbilgiler -->

<script type="text/javascript">
	$(function() {

		$('#mesaj').hide();
		$('#sonucPaneli').hide();

		var veritabaniSorgula = function(mod)
		{

			var form_data =
			{
				ogrenciNo: $('#ogrenciNo').val(),
				adi : $('#adi').val(),
				soyadi: $('#soyadi').val(),
				mod:mod
			};


			$.ajax({
				url: 'OgrenciArama1.php',
				type: 'POST',
				//dataType: 'json',
				data: form_data,
				success: function(msg)
				{	 $('#sonucPaneli').slideDown("1500");
					//alert(msg);
					$('#aramaSonucu').html(msg).fadeIn("slow");//.fadeOut("slow");
				},
				error: function()
				{
					alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
				}
			});

			return false;

		}

		$('#ogrenciNo').blur(function(e){
			if(e.which==16) // ignore shift key
				return;
			veritabaniSorgula(2);
		});

		$('#ara').click(function(e){
			if(e.which==16) // ignore shift key
				return;
			veritabaniSorgula(2);
		});

		$('#adi').keyup(function(e){
			if(e.which==16) // ignore shift key
				return;
			veritabaniSorgula(1);
		});

	});

</script>

