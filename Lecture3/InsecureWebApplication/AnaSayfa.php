<?php
/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 09.03.2016
 * Time: 17:48
 */

$title="Personel Ana Sayfası";
//require_once 'Include/Baslik.php';
require_once 'Guvenlik/PersonelDenetim.php'; //Site içerisindeki tüm sayfalara eklenmeli...
?>

<!DOCTYPE html>
<head>
    <title>Öğrenci Bilgi Sistemi</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://getbootstrap.com/examples/sticky-footer-navbar/sticky-footer-navbar.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

    <link rel="stylesheet" type="text/css" hrf="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/smoothness/jquery-ui.css" />
    <!--<style>
    html,
    body {
    height: 100%;
    /* The html and body elements cannot have any padding or margin. */
    }

    /* Wrapper for page content to push down footer */
    #wrap {
    min-height: 90%;
    height: auto !important;
    height: 80%;
    /* Negative indent footer by its height */
    margin: 0 auto -60px;
    /* Pad bottom by footer height */
    padding: 0 0 60px;
    }

    /* Set the fixed height of the footer here */
    #footer {
    height: 20px;
    background-color: #f5f5f5;
    }
    </style>-->


</head>
<body >
<!--<div id="wrap">-->
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">Öğrenci Bilgi Sistemi</a>
        </div>
        <ul class="nav navbar-nav">
            <li class="active"><a href="#">Giriş Sayfası</a></li>

            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Öğrenci İşlemleri <span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="#" id="ogrenciArama">Arama</a></li>
                    <li><a href="#" id="ogrenciEkleme">Ekleme</a></li>
                    <li><a href="#">Silme</a></li>
                    <li role="separator" class="divider"></li>
                    <li class="dropdown-header">Ders İşlemleri</li>
                    <li><a href="#">Ders Kayıt</a></li>
                    <li><a href="#">Not Girişi</a></li>
                </ul>
            </li>
            <li><a href="#">Page 2</a></li>
            <li><a href="#">Page 3</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <!--<div class="page-header">
        <h3>Ana Sayfa</h3>
    </div>-->
    <div class="row" >
        <div class="col-md-10 ">
            <div class="panel panel-default" id="icerik">
                <div class="panel-heading" >Giriş Sayfası
                </div>

                <div class="panel-body" >
                    Gövde...
                </div>
            </div>
        </div>

        <div class="col-md-2">
            <div class="panel panel-default">
                <div class="panel-heading">Duyurular</div>

                <div class="panel-body" id="messages1" style="max-height: 200px">
                    <ol>
                        <li>Duyuru1</li>
                        <li>Duyuru2</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>


</div>
<!--</div>
-->
<footer id="footer" class="footer">
    <div class="container">
        <p class="text-muted">Öğrenci Bilgi Sistemi</p>
    </div>
</footer>

<script>
    $(function()
    {

        $('#ogrenciArama,#ogrenciSilme,#ogrenciDuzenleme').click(function()
        {


            $.ajax({
                url: 'OgrenciArama.php',
                type: 'POST',
                //data: form_data,
                success: function(msg)
                {
                    // $("#listele").slideDown("500");
                    $("#icerik").html(msg).fadeIn("slow");//.fadeOut("slow");
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
                    $("#icerik").html(msg).fadeIn("slow");//.fadeOut("slow");
                },
                error: function()
                {
                    alert("Hata meydana geldi. Lütfen tekrar deneyiniz !!!");
                }

            });

        });



    });
</script>





</body>
</html>