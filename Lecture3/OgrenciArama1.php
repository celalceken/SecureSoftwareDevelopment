<?php  require_once 'Guvenlik/PersonelDenetim.php';


	require_once 'Genel/VeritabaniBaglantisi.php';
	
	if(!isset($_GET['mod']))
		$sql="SELECT * FROM ogrenciler where ogrenciNo='".$_POST['ogrenciNo']."' 
			OR adi like '".$_POST['adi']."%' OR soyadi='".$_POST['soyadi']."'";
	else
		$sql="SELECT * FROM ogrenciler";
	$result = mysqli_query($baglantiNo,$sql);
	
	mysqli_close($baglantiNo);
?>
<table id="mytable" border='1' width="100%">
    <tr>
      <th>Öğrenci No</th>
      <th> Adı</th>
      <th>Soyadi</th>
      <th>Düzenle</th>
      <th>Sil</th>
      <th>Ayrıntı</th>
     
    </tr>
    <?php $i=0; 
    
	
	
   
  	while( $entry=mysqli_fetch_array($result))
	{
		if($i++%2)
			echo "<tr>";
		else
			echo "<tr class=\"alt\">";
		echo "<td>". $entry['ogrenciNo']."</td>";
		echo "<td>". $entry['adi']."</td>";
        echo "<td>". $entry['soyadi']."</td>";
		
		?>
		 <td>
                 <a href="#" class="duzenle" id="<?php echo $entry['ogrenciNo'];?>" >Düzenle</a>
             </td>
              <td> 
                    <a href="#" class="sil"  id="<?php echo $entry['ogrenciNo'];?>">Sil</a>
             </td>
             <?php 
			
				echo "<td>  <a href=\"#\" class=\"ayrinti\" rel=\"pop-up\"  id=\"".$entry['ogrenciNo']."\">Ayrıntı</a></td>";			
         	 ?>	
		
		</tr>
       
   <?php } ?>
</table>

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




