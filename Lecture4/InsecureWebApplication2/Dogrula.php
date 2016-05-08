
<?php

//require_once 'Include/DatabaseConnection.php';


//require_once 'Classes/SessionManagement.class.php';
//require_once 'Classes/SecureSessionHandler.class.php';
require_once 'Classes/ObjectFactory.class.php';






// require_once 'Guvenlik/PersonelDenetim.php';

//$sql="SELECT personelNo,sifre FROM personel where personelNo='".$_POST['personelNo']."' AND sifre='".md5($_POST['sifre'])."'";
//$sql="SELECT personelNo,sifre FROM personel where personelNo='".$_POST['personelNo']."' AND sifre='".$_POST['sifre']."'";
//md5() 128 bitlik şifrelenmiş hash üretir
// $hash = hash('sha256', $pass); 256 bitlik şifrelenmiş hash üretir

//$result = $veritabani->query($sql);


$userSession = ObjectFactory::getObject('SessionManagement');

//$userService = new SessionManagement($veritabani, $_POST['personelNo'], $_POST['sifre']);
//var_dump($userService);

if ($userSession->login($_POST['personelNo'], $_POST['sifre']))
{
    $data= array ('sonuc'=>'1');

    //print_r($user);

    //$logger->log($akademikPersonel->getPersonelNo().' baglandi...',LOGGER::INFO);

}
else
{
    $data= array ('sonuc'=>'0');
    //print_r($data);
    //$logger->log($_POST['personelNo'].' hatali kimlik bilgisi',LOGGER::WARNING);

}

echo json_encode($data);
//  JavaScript Object Notation yalnızca veri alış-verişi amacıyla oluşturulmuş bir veri biçimlendirme yöntemidir
// XML e göre daha az yer kaplar. json verilerini java script ile erişmek XML e (parsing is necessary)
// göre çok daha kolaydır.
// $.getJSON(), ve $.ajax({ dataType: 'json'}) fonksiyonlarıyla verilere erişilebilir.
