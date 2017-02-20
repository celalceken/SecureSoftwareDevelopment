<?php

/**
 * Created by PhpStorm.
 * User: wsan
 * Date: 22.03.2016
 * Time: 23:27
 */
class SessionHandlerRedis implements SessionHandlerInterface
{
    public $ttl = 1800; // 30 minutes default
    protected $db;
    protected $prefix;

    public function __construct(PredisClient $db, $prefix = 'PHPSESSID:') {
        $this->db = $db;
        $this->prefix = $prefix;
    }

    public function open($savePath, $sessionName) {
        // No action necessary because connection is injected
        // in constructor and arguments are not applicable.
    }

    public function close() {
        $this->db = null;
        unset($this->db);
    }

    public function read($id) {
        $id = $this->prefix . $id;
        $sessData = $this->db->get($id);
        $this->db->expire($id, $this->ttl);
        return $sessData;
    }

    public function write($id, $data) {
        $id = $this->prefix . $id;
        $this->db->set($id, $data);
        $this->db->expire($id, $this->ttl);
    }

    public function destroy($id) {
        $this->db->del($this->prefix . $id);
    }

    public function gc($maxLifetime) {
        // no action necessary because using EXPIRE
    }
}