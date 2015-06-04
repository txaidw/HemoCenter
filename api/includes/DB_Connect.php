<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/3/15
 * Time: 1:43 AM
 */

class DB_Connect{
    function __constructor(){

    }
    function __destructor(){

    }

    //Connect on database
    public function connect(){
        require_once 'includes/Config.php';

        $conn =  new PDO('mysql:dbname='.DB_DATABASE.';host='.DB_HOST.';charset=utf8', DB_USER, DB_PASSWORD) or die(mysql_error());

        return $conn;

    }

    //close database
    public function close(){
        mysql_close();
    }





}




?>