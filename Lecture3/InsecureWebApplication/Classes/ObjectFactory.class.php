<?php
/**
 * Created by PhpStorm.
 * User: root
 * Date: 11/19/13
 * Time: 6:33 PM
 */



class NesneOlusturucu {

    public static function nesneOlustur($class)
    {
        try
        {
            $dir = 'Classes/' . $class . '.php';

            if(file_exists($dir))
            {
                include_once $dir;
                return new $class;
            }
            else
            {
                throw new Exception('<p>Sınıf Bulunamadı</p>');
            }
        }
        catch(Exception $e)
        {
            echo $e->getMessage();
        }
    }
} 