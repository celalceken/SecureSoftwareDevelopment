<?php
/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 10.03.2016
 * Time: 17:02
 */

namespace cc;

require_once (__DIR__.'/Kisi.class.php');

class AkademikPersonel extends \cc\Kisi
{
    protected $personelNo;
    protected $adres;

    /**
     * @return mixed
     */
    public function getAdres()
    {
        return $this->adres;
    }

    /**
     * @param mixed $adres
     */
    public function setAdres($adres)
    {
        $this->adres = $adres;
    }


    /**
     * @return mixed
     */
    public function getPersonelNo()
    {
        return $this->personelNo;
    }

    /**
     * @param mixed $ogrenciNo
     */
    public function setPersonelNo($personelNo)
    {
        $this->personelNo = $personelNo;
    }



}