<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/5/15
 * Time: 2:13 AM
 */

require_once 'dao/User_DAO.php';

class User
{


    private $name;
    private $email;
    private $password;
    private $type;
    private $username;


   public function __constructor($json_data){



    }


    //Return true if success or false if fail
    public function registerUser(){

        $dao = new User_DAO();

        return $dao->registerUser($this->name, $this->email, $this->password, $this->type, $this->username);

    }
    public function setData($json_data){
        $this->name = $json_data['name'];
        $this->email = $json_data['email'];
        $this->password = $json_data['password'];
        $this->type = $json_data['type'];
        $this->username = $json_data['username'];

    }


}



?>