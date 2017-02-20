<?php
/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 01.05.2016
 * Time: 00:26
 */

$func = strtolower(trim(str_replace("/",".",$_SERVER['REQUEST_URI'])));
$func=explode(".",$func);
echo end($func);