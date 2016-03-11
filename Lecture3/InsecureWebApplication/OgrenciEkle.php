<?php  require_once 'Guvenlik/PersonelDenetim.php';
	   //require_once 'Genel/VeritabaniBaglantisi.php';
	
	?>

<span class="contentBox"> 
<h4>
			 	Öğrenci İlk Kayıt <a id="oncekiSayfa" ><img align="right" src="img/oncekiSayfa.png" width="25" height="25" /></a><br />

               </h4>
 </span>
 

 
 
<script type="text/javascript"> 
$(document).ready(function(){
	$("#mesaj1, #mesaj2").hide();
	$('#ogrenciNo').blur(function() {
		var adres= 'OgrenciDogrula.php?ogrenciNo='+$('#ogrenciNo').val();
		$.ajax({
			url: adres,
			type: 'POST',
			dataType: 'json',
			
			success: function(data) 
			{	if(data.sonuc==1)
				{	   $("#mesaj1").html("Öğrenci zaten kayıtlı!!!").slideDown("1500");
						$('#ogrenciNo').focus();
						return;
					  
				}else
				{
					  $("#mesaj1").hide();
				}
			},
			error: function()
			{
				alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
				
			}
		});	
   	});
   	
   	
   	
   	
   	
   	$('#kaydet').click(function() {

        var form_data=$('#form :input').serialize();
       // var form_data=$("form").serialize();
        alert (form_data);
		/*var form_data =
		{
			ogrenciNo: $('#ogrenciNo').val(),
			adi: $('#adi').val(),
			soyadi: $('#soyadi').val(),	
			sifre: $('#sifre').val(),	
			telefonNo: $('#telefonNo').val()	
		};*/
		
		$.ajax({
			url: 'OgrenciEkle1.php',
			type: 'POST',
			dataType: 'json',
			data:form_data,
			success: function(data) 
			{	if(data.sonuc==1)
				{	   $("#mesaj2").html("Kayıt başarıyla eklenmiştir!").slideDown(1500);
						//$('#ogrenciNo').focus();
						return;
					  
				}else
				{
					  $("#mesaj2").html("Kayıt başarıyla eklenememiştir!").slideDown("1500");
					  
				}
			},
			error: function()
			{
				alert("Hatazzzzz meydana geldi. Lütfen tekrar deneyiniz !!!");
				
			}
		});	
   	});
   	
   	
   	
});
 
	
</script>
 
<div id="ortaForm">  
	<h1 align="center">Öğrenci İlk Kayıt</h1><br />


    <div id="form">
	<table  border="0" align="center" width="100%">
         
         <tr>
             <td colspan="3" align="left">
             
             	<h5 class="ui-state-error ui-corner-all"  id="mesaj1" >Öğrenci numarası boş olamaz !!!</h5> 
             	
             </td>
              
         </tr> 
         
         
          <tr>
        	<td>
        		Öğrenci No
        	</td>
        	<td>
        		<input type="text" id="ogrenciNo" name="ogrenciNo" maxlength="11" />
        	</td>
			 
		 </tr>
		 <tr>
        	<td>
        		Adı
        	</td>
        	<td>
        		<input type="text" id="adi" name="adi"  />
        	</td>
			 
		 </tr>
		 <tr>
        	<td>
        		Soyadı
        	</td>
        	<td>
        		<input type="text" id="soyadi" name="soyadi"  />
        	</td>
			 
		 </tr>
		 <tr>
        	<td>
        		Şifre
        	</td>
        	<td>
        		<input type="password" id="sifre" name="sifre"  />
        	</td>
			 
		 </tr>
		 <tr>
        	<td>
        		Telefon No
        	</td>
        	<td>
        		<input type="text" id="telefonNo" name="telefonNo"  />
        	</td>
			 
		 </tr>
		 
		 <tr>
        	<td>
        		&nbsp;
        	</td>
        	<td>
        		<input type="submit"  id="kaydet" value="Kaydet" />
        	</td>
			 <td colspan="2">
        		<h5 class="ui-state-error ui-corner-all"  id="mesaj2" >kaydedildi...</h5> 
        	</td>
			 
		 </tr>
     </table>
        </div>

</div><!--orta form-