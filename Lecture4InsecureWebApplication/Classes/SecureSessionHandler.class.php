<?php

/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 11.03.2016
 * Time: 00:45
 */
/*
 *  PHP Session - Using SessionHandler
 *  When a plain instance of SessionHandler is set as the save handler using session_set_save_handler()
 * it will wrap the current save handlers.
 *  A class extending from SessionHandler allows you to override the methods or intercept or filter them
 * by calls the parent class methods which ultimately wrap the interal PHP session handlers.
 * This allows you, for example, to intercept the read and write methods to encrypt/decrypt the session
 * data and then pass the result to and from the parent class.
 * Alternatively one might chose to entirely override a method like the garbage collection callback gc.
 */


class SecureSessionHandler extends SessionHandler
{
    private $key;

    public function __construct($key)
    {
        $this->key = $key;
    }

    public function read($id)
    {
        $data = parent::read($id);

        return mcrypt_decrypt(MCRYPT_3DES, $this->key, $data, MCRYPT_MODE_ECB);
    }

    public function write($id, $data)
    {
        $data = mcrypt_encrypt(MCRYPT_3DES, $this->key, $data, MCRYPT_MODE_ECB);

        return parent::write($id, $data);
    }
}

