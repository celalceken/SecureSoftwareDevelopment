<?php
/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 10.03.2016
 * Time: 17:02
 */

namespace cc;

require_once 'Kisi.class.php';

class AkademikPersonel extends \cc\Kisi
{
    protected $personelNo;


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