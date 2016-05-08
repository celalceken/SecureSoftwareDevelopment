<?php
/**
 * Created by PhpStorm.
 * User: root
 * Date: 11/19/13
 * Time: 6:33 PM
 */



class ObjectFactory {

    public static function getObject($class,$param1,$param2,$param3,$param4)
    {
        try
        {
            //$dir = 'Classes/' . $class.'.class.php';
            $dir = __DIR__.'/' . $class.'.class.php';
            //echo $dir;
            if(file_exists($dir))
            {
                include_once $dir;
                return new $class($param1,$param2,$param3,$param4);
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