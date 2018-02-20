<?php
/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 15.03.2016
 * Time: 11:24
 */

namespace cc;

require_once (__DIR__.'/AkademikPersonel.class.php');
require_once (__DIR__.'/KisiGoruntuleyici.class.php');


class AkademikPersonelGoruntuleJSON extends \cc\KisiGoruntuleyici
{
    public function getKisiler()
    {

        foreach ($this->kisiler as $akademikPersonel)
        {
            $str[]= array('personelNo' => $akademikPersonel->getPersonelNo(),'adi' => $akademikPersonel->getAdi(), 'soyadi' => $akademikPersonel->getSoyadi());
            //print json_encode($urun);
            //print_r($urun);
        }

        print json_encode($str);
    }

    public function getKisi($akademikPersonel)
    {
        $arr = array('personelNo' => $akademikPersonel->getPersonelNo(),'adi' => $akademikPersonel->getAdi(), 'soyadi' => $akademikPersonel->getSoyadi());

        return json_encode($arr);


    }

}