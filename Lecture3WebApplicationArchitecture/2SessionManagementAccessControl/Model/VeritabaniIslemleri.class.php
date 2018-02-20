<?php
/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 27.03.2016
 * Time: 01:32
 */

namespace cc;

require_once (__DIR__.'/VeritabaniArayuzu.interface.php');

class VeritabaniIslemleri implements \cc\VeritabaniArayuzu //Arayüzler ile bir sınıfın hangi yeteneklere sahip olması gerektiği belirtilir
{

    public static function insert($table, $entity)
    {
        $columns = "";
        $values = "";
        foreach ($entity as $column => $value)
        {
            $columns .= ($columns == "") ? "" : ", ";
            $columns .="\"".$column."\"";
            $values .= ($values == "") ? "" : ", ";
            $values .= $value;
        }

        try
        {   include(__DIR__.'/../Include/DatabaseConnection.php');
            $sql="INSERT INTO \"$table\" ($columns) VALUES($values)";
           // echo $sql;

            $stmt = $veritabaniBaglantisi->prepare($sql);

            return ($stmt->execute());
        }
        catch(PDOException $e)
        {
            echo $e->getMessage();
            return false;
        }

    }

}