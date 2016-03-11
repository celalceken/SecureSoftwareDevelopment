<?php
	$title="Personel Girişi";
require_once 'Include/Baslik.php';
?>

<!--Personel Doğrulama -->

<script   type="text/javascript">
    $(function()
    {

        //alert("Merhaba");
        $('#mesaj1').hide();
        $('#mesaj2').hide();

        $("#giris").click(function()
        {
            $('#mesaj1').hide();
            $('#mesaj2').hide();

            var personelNo = $('#personelNo').val();
            var sifre = $('#sifre').val();
            if (!personelNo || !sifre)
            {
                //$('.error').show();
                if ($("#mesaj1").is(":hidden"))
                {
                    $("#mesaj1").slideDown("1500");
                    if (!personelNo)
                        $("#personelNo").focus();
                    else
                        $("#sifre").focus();
                }
                else
                {
                    $("#mesaj1").slideUp("1500");

                }
                //alert('Öğrenci Numarası ve Şifre  Girilmeli');
                return false;
            }

            var form_data =
            {
                personelNo : $('#personelNo').val(),
                sifre : $('#sifre').val()
                //login : $('#login').val(),
                //ajax: '1'
            };

            $.ajax(
                {
                    url : "Dogrula.php",
                    type : 'POST',
                    dataType : 'json',
                    data : form_data,
                    success : function(data)
                    {
                        //alert(data);
                        var sonuc = data['sonuc'];
                        if (sonuc == '1')
                        {
                            go_to_private_page();
                            //alert("aaasonuc 1 mis");
                            return false;
                        }
                        else
                        {
                            if ($("#mesaj2").is(":hidden"))
                            {
                                $("#mesaj2").html("Kayıt bulunamadı!!!").slideDown("1500");
                            }
                            else
                            {
                                $("#mesaj2").slideUp("1500");
                            }

                            return false;
                        }

                    },
                    error : function()
                    {
                        alert("Hata meydana geldi. Lütfen tekrar deneyinizzzzz !!!");
                    }
                });

            return false;
        });
    });
    function go_to_private_page()
    {
        window.location = 'PersonelAnaSayfa.php';
        // Kayıtlı öğrenci
    }

</script>
<div id="topNavigation"></div>

<div id="content">
	<div id="loginForm">
		<h1 align="center">Personel Girişi</h1>
		<br />

		<table  border="0" align="center" width="100%">

			<tr>
				<td colspan="3" align="left"><h5 class="ui-state-error ui-corner-all"  id="mesaj1" >Personel Numarası ve Şifre  Girilmeli !!!</h5><!--<div class="mesaj" id="mesaj" >Content for  class "mesaj" id "mesaj" Goes Here</div>--></td>

			</tr>
			<tr>

				<td>Personel No:</td>

				<td>
				<input type="text" id="personelNo" name="personelNo" maxlength="11" />
				</td>
			</tr>
			<tr>

				<td>Şifre:</td>

				<td>
				<input type="password"  id="sifre" name="sifre"/>
				</td>
			</tr>
			<tr>

				<td></td>

				<td>
				<input type="submit"  id="giris" name="giris" value="Giriş" />
				</td>
			</tr>
			<tr>
				<td colspan="3" align="centre"><h5 class="ui-state-error ui-corner-all"  id="mesaj2" align="center" >Kayıt bulunamadı !!!</h5><!--<div class="mesaj" id="mesaj" >Content for  class "mesaj" id "mesaj" Goes Here</div>--></td>

			</tr>
		</table>
	</div>

</div><!-- end login_form-->



<?php
	include 'Include/Altlik.php';
?>
