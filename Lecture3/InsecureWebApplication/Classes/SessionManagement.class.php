<?php
require_once(__DIR__.'/../Model/AkademikPersonel.class.php');

class SessionManagement {

    protected $userName;
    protected $password;

    protected $database;
    protected $user;     // stores the user data

    public function __construct($db, $userName, $password)
    {
        $this->database = $db;
        $this->userName = $userName;
        $this->password = $password;
    }

    public function login()
    {
        $user = $this->checkCredentials();
        if ($user) {
            $this->user = $user; // store it for further consideration
            //$_SESSION['user'] = $this->user;
            return $user;//$user['id'];
        }
        return false;
    }

    protected function checkCredentials()
    {
        /*$sql="SELECT personelNo, adi, soyadi,sifre FROM AkademikPersonel where personelNo='"
            .$this->userName."' AND sifre='".$this->password."'";//
            //sifre='".md5($this->password)."'";*/

        $sql="SELECT \"personelNo\",\"adi\",\"soyadi\",\"sifre\" FROM \"AkademikPersonel\" where \"personelNo\"= :pn AND \"sifre\"= :sfr";

        $sth = $this->database->prepare($sql);
        $sth->execute(array(':pn' => $this->userName, ':sfr' => $this->password));

        $sth->setFetchMode(PDO::FETCH_CLASS, "\cc\AkademikPersonel");
        $akademikPersonel=$sth->fetchAll();

        if(count($akademikPersonel)>=1)

        {
                return $akademikPersonel[0];

        }
        return false;
    }

    public function getUser()
    {
        return $this->user;
    }

    /*if(mysql_num_rows($result) == 1)
    {
        $_SESSION["user"] = serialize(new User(mysql_fetch_assoc($result)));
        $_SESSION["login_time"] = time();
        $_SESSION["logged_in"] = 1;
        return true;
    }else{
        return false;
    }
}

//Log the user out. Destroy the session variables.
public function logout() {
    unset($_SESSION["user"]);
    unset($_SESSION["login_time"]);
    unset($_SESSION["logged_in"]);
    session_destroy();
}*/



}

