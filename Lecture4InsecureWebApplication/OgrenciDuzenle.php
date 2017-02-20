<?php
require_once 'Guvenlik/PersonelDenetim.php';
require_once 'Include/VeritabaniBaglantisi.php';


$sql="SELECT * FROM ogrenciler where ogrenciNo='".$_POST['ogrenciNo']."'";
//echo $sql;
$result = mysqli_query($baglantiNo,$sql);

$kayit=mysqli_fetch_row($result);

$sorguSonucuIl = mysqli_query($baglantiNo, "SELECT * FROM iller");
$sorguSonucuIlce = mysqli_query($baglantiNo, "SELECT * FROM ilceler where il={$kayit[9]}");


mysqli_close($baglantiNo);



?>

<span class="contentBox"> 
<h4>
    Öğrenci İlk Kayıt <a id="oncekiSayfa" ><img align="right" src="../../img/oncekiSayfa.png" width="25" height="25" /></a><br />

</h4>
 </span>




<script type="text/javascript">
    $(document).ready(function(){
        $("#mesaj1, #mesaj2").hide();



        $('#kaydet').click(function() {

            // var form_data = $("#form1").serialize();
            var form_data =
            {
                ogrenciNo: $('#ogrenciNo').val(),
                adi: $('#adi').val(),
                soyadi: $('#soyadi').val(),
                sifre: $('#sifre').val(),
                telefonNo: $('#telefonNo').val()
            };

            $.ajax({
                url: 'OgrenciDuzenle1.php',
                type: 'POST',
                dataType: 'json',
                data:form_data,
                success: function(data)
                {	if(data.sonuc==1)
                {	   $("#mesaj2").html("Kayıt başarıyla eklenmiştir!").slideDown(1500);
                    //$('#ogrenciNo').focus();
                    exit(0);

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




        $('#degistir').click(function() {

            // var form_data = $("#form1").serialize();
            var form_data =
            {
                ogrenciNo: $('#ogrenciNo').val(),
                adi: $('#adi').val(),
                soyadi: $('#soyadi').val(),
                sifre: $('#sifre').val(),
                telefonNo: $('#telefonNo').val(),
                il: $('#il').val(),
                ilKodu: $('#ilKodu').val()
            };

            $.ajax({
                url: 'OgrenciDuzenle1.php',
                type: 'POST',
                dataType: 'json',
                data:form_data,
                success: function(data)
                {	if(data.sonuc==1)
                {	   $("#mesaj2").html("Kayıt başarıyla düzeltilmiştir!").slideDown(1500);
                    //$('#ogrenciNo').focus();
                    exit(0);

                }else
                {
                    $("#mesaj2").html("Kayıt başarıyla düzeltilememiştir!").slideDown("1500");

                }
                },
                error: function()
                {
                    alert("Hatazzzzz meydana geldi. Lütfen tekrar deneyiniz !!!");

                }
            });




        });



        $('#il').change(function()
        {
            var form_data =
            {
                il: $('#il').val()

            };
            $.ajax({
                url: 'Ilceler.php',
                type: 'POST',
                data: form_data,
                success: function(msg)
                {
                    //alert(msg);
                    //$("#ilceDiv").slideDown(1500);
                    $('#ilceler').html(msg);//.fadeOut("slow");
                },
                error: function()
                {
                    alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
                }
            });
            return false;
        });



    });


</script>

<div id="ortaForm">
    <h1 align="center">Öğrenci İlk Kayıt</h1><br />


    <table  border="0" align="center" width="100%">

        <tr>
            <td colspan="3" align="left">

                <h5 class="ui-state-error ui-corner-all"  id="mesaj1" >Öğrenci numarası boş olamaz !!!</h5>

            </td>

        </tr>

        <form id="form1" action="">
            <tr>
                <td>
                    Öğrenci No
                </td>
                <td>
                    <input type="text" id="ogrenciNo"  name="ogrenciNo" maxlength="11" value="<?php echo $kayit[0]; ?>" disabled="disabled" />
                </td>

            </tr>
            <tr>
                <td>
                    Adı
                </td>
                <td>
                    <input type="text" id="adi" name="adi" value="<?php echo $kayit[1]; ?>"  />
                </td>

            </tr>
            <tr>
                <td>
                    Soyadı
                </td>
                <td>
                    <input type="text" id="soyadi" name="soyadi" value="<?php echo $kayit[2]; ?>"  />
                </td>

            </tr>
            <tr>
                <td>
                    Şifre
                </td>
                <td>
                    <input type="text" id="sifre" name="sifre" value="<?php echo $kayit[3]; ?>"   />
                </td>

            </tr>
            <tr>
                <td>
                    Telefon No
                </td>
                <td>
                    <input type="text" id="telefonNo" name="telefonNo" value="<?php echo $kayit[4]; ?>"  />
                </td>

            </tr>



            <tr>
                <td>
                    İl
                </td>
                <td>

                    <?php echo '<select name="il" id="il">';
                    while ($row1 = mysqli_fetch_row($sorguSonucuIl))
                    {
                        if($row1[0]!=$kayit[9])
                            echo '<option  value="'.$row1[0].'" >'.$row1[1].'</option>';
                        else
                            echo '<option selected="selected" value="'.$row1[0].'" >'.$row1[1].'</option>';
                    }
                    echo "</select>";
                    ?>
                </td>
            </tr>

            <tr>
                <td>
                    İlçe
                </td>
                <td id="ilceler">

                    <?php echo '<select name="ilce" id="ilce">';
                    while ($row2 = mysqli_fetch_row($sorguSonucuIlce))
                    {
                        if($row2[0]!=$kayit[10])
                            echo '<option  value="'.$row2[0].'" >'.$row2[2].'</option>';
                        else
                            echo '<option selected="selected" value="'.$row2[0].'" >'.$row2[2].'</option>';
                    }
                    echo "</select>";
                    ?>
                </td>
            </tr>
        </form>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <input type="submit"  id="degistir" value="Değiştir" />
            </td>
            <td colspan="2">
                <h5 class="ui-state-error ui-corner-all"  id="mesaj2" >kaydedildi...</h5>
            </td>

        </tr>
    </table>


</div><!--orta form-