<?php
/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 22.03.2016
 * Time: 14:39
 */
require_once(__DIR__.'/../Classes/ObjectFactory.class.php');

$userSession = ObjectFactory::getObject('SessionManagement');
$userSession->logout();