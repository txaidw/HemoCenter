<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/5/15
 * Time: 2:51 AM
 */


require_once 'dao/Auth_DAO.php';
class Login{

    private $username;
    private $password;

    public function __constructor(){


    }

    //Set the data
    public function setData($json_data){
        $this->username = $json_data['username'];
        $this->password = $json_data['password'];
    }

    //Return true if success  or false if fail
    public function do_login(){

        $dao = new Auth_DAO();
        return $dao->do_login($this->username, $this->password);

    }


    public function isManagement(){


    }






}