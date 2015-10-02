<?php //include 'includes/PersonelDenetim';?>
<?php
 require_once '../Guvenlik/PersonelDenetim.php';

 ?>
	
	<span class="contentBox"> 
                   <h4>
                    Öğrenci Arama/Silme/Düzenleme <a id="oncekiSayfa" ><img align="right" src="../../img/oncekiSayfa.png" width="25" height="25" /></a><br />

                   </h4>
    </span>
    <div id="ortaForm">
	
	    <h1 align="center">Öğrenci Arama</h1><br />


		<table  border="0" align="center" width="100%">
        <tr>
             <td colspan="3" align="left">
             
             	<h5 class="ui-state-error ui-corner-all"  id="mesaj11" >TC Kimlik No, Ad yada Soyad  Girmelisiniz !!!</h5> 
             	<!--<div class="mesaj" id="mesaj" >Content for  class "mesaj" id "mesaj" Goes Here</div>-->
             </td>
              
         </tr>  
         <tr>
         	<td>Öğrenci No  </td>
           	<td><input name="ogrenciNo1" id="ogrenciNo1" type="text" />  </td>
		 </tr>
         <tr>
			<td>Adı </td>
           	<td><input name="adi" id="adi" type="text" />  </td>
		</tr>
		<tr>
			<td>Soyadı </td>
           	<td><input name="soyadi" id="soyadi" type="text" />  </td>
		</tr>
        <tr>
			<td colspan="2"><input name="ara" id="ara" type="submit" value="Ara" />  
           	<input name="tumKayitlar" id="tumKayitlar" type="submit" value="Tüm Kayıtlar" />  </td>
		</tr>
       
        
    <tr>
             <td colspan="2" align="centre">
             
             	<h5 class="ui-state-error ui-corner-all"  id="mesaj22" align="center" >Kayıt bulunamadı !!!</h5> 
             	<!--<div class="mesaj" id="mesaj" >Content for  class "mesaj" id "mesaj" Goes Here</div>-->
             </td>
              
      </tr>    
    </table>
 
</div> 
<br />
<!-- <h4 id="listele1" align="center">Arama Sonucu</h4><br /> -->
<div id="listele2">
	

</div>
<!--Kişiselbilgiler --> 
  
  <script type="text/javascript">
$(function() {  
  $('#mesaj11').hide();
  $('#mesaj22').hide();
  $('#listele2').hide();
	
	
	$('#adi').keyup(function() {
	$('#mesaj11').hide();
    $('#mesaj22').hide();
	var ogrenciNo1 = $('#ogrenciNo1').val();
	var adi = $('#adi').val();
	var soyadi = $('#soyadi').val();
	if (!ogrenciNo1 && !adi && !soyadi) {
		//$('#mesaj2').hide();
		if ($("#mesaj11").is(":hidden"))
		{
           $("#mesaj11").slideDown("1500");
		   $("#ogrenciNo1").focus();
		}
		else
		{
			$("#mesaj11").slideUp("1500");
			
		}
		return false;
	}
	
	
		var form_data = 
		{
			ogrenciNo: $('#ogrenciNo1').val(),
			adi: $('#adi').val(),
			soyadi: $('#soyadi').val()
		};
	
	
		$.ajax({
			url: 'OgrenciArama1.php',
			type: 'POST',
			//dataType: 'json',
			data: form_data,
			success: function(msg) 
			{	 //$("#listele").slideDown("1500");
				$('#listele2').html(msg).fadeIn("slow");//.fadeOut("slow");
			},
			error: function()
			{
				alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
			}
		});
		
		return false;
	});
	
	
	$('#tumKayitlar').click(function() {
	$('#mesaj11').hide();
    $('#mesaj22').hide();
	
	
	
		var form_data = 
		{
			ogrenciNo1: $('#ogrenciNo1').val(),
			adi: $('#adi').val(),
			soyadi: $('#soyadi').val()
		};
	
	
		$.ajax({
			url: 'OgrenciArama1.php?mod=tumu)',
			type: 'POST',
			//dataType: 'json',
			data: form_data,
			success: function(msg) 
			{	 //$("#listele").slideDown("1500");
				$('#listele2').html(msg).fadeIn("slow");//.fadeOut("slow");
			},
			error: function()
			{
				alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
			}
		});
		
		return false;
	});
	
	
		<!--Önceki Sayfa--> 
	$('#oncekiSayfa').click(function() {
		$.ajax({
			url: "<?php // echo site_url('PersonelDenetim/sayfaGoster1/PersonelAnaSayfaSiteHaritasi/0');?>",
			type: 'POST',
			//data: form_data,
			success: function(msg) {
				$('#liste').html(msg).fadeIn("slow");//.fadeOut("slow");
			},
		  error: function(){
			alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
		  }
      
		});
		return false;
 	 });
	
	
});	
	

  </script>

