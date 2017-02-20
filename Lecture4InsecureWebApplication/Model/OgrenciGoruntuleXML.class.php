<?php
/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 15.03.2016
 * Time: 11:24
 */

namespace cc;

require_once (__DIR__.'/Ogrenci.class.php');
require_once (__DIR__.'/KisiGoruntuleyici.class.php');


class OgrenciGoruntuleXML extends \cc\KisiGoruntuleyici
{
    public function getKisiler()
    {
        $str = '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
        $str .= "<ogrenciler>\n";
        foreach ($this->kisiler as $ogrenci)
        {
            $str .= "<ogrenci>\n";
            $str .= "\t<ogrenciNo=\"{$ogrenci->getOgrenciNo()}\">\n";
            $str .= "\t</ogrenciNo>\n";
            $str .= "</ogrenci>\n";
        }
        $str .= "</ogrenciler>\n";
        print ($str);
    }
    public function getKisi($ogr)
    {
        return "XML : ". $ogr->getOgrenciNo();
    }
}