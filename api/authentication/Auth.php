<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/5/15
 * Time: 2:51 AM
 */


require_once 'dao/Auth_DAO.php';
class Auth{

    private $key;

    public function __constructor(){


    }

    //Set the data
    public function setData($data_key){
        $this->key = $data_key;
    }


    //Check if an user is a management. Return true if yes or false if not
    public function isManagement(){
        $auth = new Auth_DAO();
        return $auth->isManagement($this->key);

    }

    //Check if an user is on database
    public function isAuthenticUser(){
        $auth = new Auth_DAO();
        return $auth->isUser($this->key);

    }



}