<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/3/15
 * Time: 1:43 AM
 */
require_once 'dao/Config.php';

class DB_Connect{

    function __constructor(){

    }

    function __destructor(){

    }

    public function connect(){
        return new PDO('mysql:host=' . DB_HOST . ';port=' . DB_PORT . ';dbname=' . DB_DATABASE, DB_USER, DB_PASSWORD);
    }

    //close database
    public function close(){
        $this->conn = null;
    }


}






?>