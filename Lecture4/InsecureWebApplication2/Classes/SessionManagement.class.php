<?php
require_once(__DIR__.'/../Model/AkademikPersonel.class.php');
//require_once 'Classes/ObjectFactory.class.php';



class SessionManagement {



   /* public function __construct()
    {

    }*/

    public function login($userName,$password)
    {
        require_once (__DIR__.'/../Include/Logger.php');
        if($akademikPersonel=$this->checkCredentials($userName,$password))
        {

            session_start();




            $_SESSION['baglandi'] =TRUE;

            $_SESSION['baslangicZamani']=time();

            $_SESSION['akademikPersonel']=  $akademikPersonel;
            $logger->log($akademikPersonel->getPersonelNo().' baglandi...',LOGGER::INFO);
            //serialize(new User(mysqli_fetch_assoc($result)));

            // Yetki düzeyi de eklenmeli...

            // var_dump($_SESSION);

            //echo  $_SESSION['personelNo'];
            return TRUE;
        }
        $logger->log($_POST['personelNo'].' hatali kimlik bilgisi',LOGGER::WARNING);
        return FALSE;
    }

    protected function checkCredentials($userName,$password)
    {
        /*$sql="SELECT personelNo, adi, soyadi,sifre FROM AkademikPersonel where personelNo='"
            .$this->userName."' AND sifre='".$this->password."'";//
            //sifre='".md5($this->password)."'";*/

        include(__DIR__.'/../Include/DatabaseConnection.php');

        //A2' or '1'='1';--
        // A2' or '1';--


        //$sql="SELECT \"personelNo\",\"adi\",\"soyadi\",\"sifre\" FROM \"AkademikPersonel\" where \"personelNo\"='".$userName."' AND \"sifre\"='".md5($password)."'";
       // echo $sql;

        $sql="SELECT \"personelNo\",\"adi\",\"soyadi\",\"sifre\" FROM \"AkademikPersonel\" where \"personelNo\"= :pn AND \"sifre\"= :sfr";
        //$sth = $veritabaniBaglantisi->query($sql);
        $sth = $veritabaniBaglantisi->prepare($sql);
        $sth->execute(array(':pn' => $userName, ':sfr' => md5($password)));
        $sth->setFetchMode(PDO::FETCH_CLASS, "\cc\AkademikPersonel");
        $akademikPersonel=$sth->fetchAll();
        //var_dump($akademikPersonel);
        if(count($akademikPersonel)>=1)

        {
                return $akademikPersonel[0];

        }
        return false;
    }

    public function logout()
    {
        session_start();

        session_destroy();
        //echo "deneme";
        //$adres=__DIR__.'/../index.html';
        header("Location: ../index.html");
        die();
    }


}

