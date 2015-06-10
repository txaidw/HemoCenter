<?php

/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/3/15
 * Time: 1:44 AM
 */


require_once 'util/Util.php';
require_once 'dao/DB_Connect.php';


class User_DAO
{




    function __constructor()
    {


    }

    function __destructor()
    {

    }

    //Register an user: Return true if success and false if unsuccess
    public function registerUser($name, $email, $password, $type, $username)
    {
        $conn = DB_Connect::connect();
        $util = new Util();

        $query = "insert into tb_users (unique_id, name, email, encryp_password, salt, user_type, username) VALUES (?, ?, ?, ?, ?, ?, ?);";

        $uid = uniqid('', true);
        $hash = $util->hashSSHA($password);
        $encryp_pass = $hash["encrypted"];
        $salt = $hash["salt"];

        $stmt = $conn->prepare($query);
        $result = $stmt->execute(array($uid,$name,$email, $encryp_pass, $salt,$type, $username));

        $conn = null;
        if ($result) {
            return true;
        } else {
            return false;
        }



    }





}



?>