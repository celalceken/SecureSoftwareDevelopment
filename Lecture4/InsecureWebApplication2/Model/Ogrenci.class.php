<?php
/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 10.03.2016
 * Time: 17:02
 */

namespace cc;

require_once 'Kisi.class.php';

class Ogrenci extends \cc\Kisi
{
    protected $ogrenciNo;


    /**
     * @return mixed
     */
    public function getOgrenciNo()
    {
        return $this->ogrenciNo;
    }

    /**
     * @param mixed $ogrenciNo
     */
    public function setOgrenciNo($ogrenciNo)
    {
        $this->ogrenciNo = $ogrenciNo;
    }



}