
<?php

require_once 'Include/DatabaseConnection.php';
require_once 'Classes/SessionManagement.class.php';
require_once 'Classes/SecureSessionHandler.class.php';
//require_once 'Classes/ObjectFactory.class.php';

// require_once 'Guvenlik/PersonelDenetim.php';

//$sql="SELECT personelNo,sifre FROM personel where personelNo='".$_POST['personelNo']."' AND sifre='".md5($_POST['sifre'])."'";
//$sql="SELECT personelNo,sifre FROM personel where personelNo='".$_POST['personelNo']."' AND sifre='".$_POST['sifre']."'";
//md5() 128 bitlik şifrelenmiş hash üretir
// $hash = hash('sha256', $pass); 256 bitlik şifrelenmiş hash üretir

//$result = $veritabani->query($sql);

//$kisi1=NesneOlusturucu::nesneOlustur('Kisi');

//var_dump($veritabani);


$userService = new SessionManagement($veritabani, $_POST['personelNo'], $_POST['sifre']);
//var_dump($userService);

if ($akademikPersonel=$userService->login())
{   //var_dump($akademikPersonel);


    /*ini_set('session.save_handler', 'files');
    $handler = new SessionHandler();
    session_set_save_handler($handler, true);

    $handler->write()*/

    session_start();

    $_SESSION['personelNo'] = $akademikPersonel->getPersonelNo(); //$_POST['personelNo'];

    $_SESSION['baglandi'] =TRUE;

    $_SESSION['baslangicZamani']=time();
    $_SESSION['akademikPersonel']=$akademikPersonel;
    //serialize(new User(mysqli_fetch_assoc($result)));

    // Yetki düzeyi de eklenmeli...

    //var_dump($_SESSION);


    $data= array ('sonuc'=>'1');
    //print_r($user);
}
else
{
    $data= array ('sonuc'=>'0');
    //print_r($data);

}

echo json_encode($data);
//  JavaScript Object Notation yalnızca veri alış-verişi amacıyla oluşturulmuş bir veri biçimlendirme yöntemidir
// XML e göre daha az yer kaplar. json verilerini java script ile erişmek XML e (parsing is necessary)
// göre çok daha kolaydır.
// $.getJSON(), ve $.ajax({ dataType: 'json'}) fonksiyonlarıyla verilere erişilebilir.
