<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/5/15
 * Time: 3:19 AM
 */

require_once 'dao/DB_Connect.php';
require_once 'util/Util.php';

class Auth_DAO{



    function __constructor(){


    }

    function __destructor(){

    }

    //Register an user: Return true if success and false if unsuccess
    public function do_login($username, $password)
    {
        $conn = DB_Connect::connect();
        $query = "select * from tb_users WHERE  (tb_users.email = ? or tb_users.username = ?);";
        $stmt = $conn->prepare($query);
        $stmt->execute(array($username, $username));

        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $conn = null;
        if($result != null) {
            $util = new Util();
            $salt = $result['salt'];
            $encrypted_password = $result['encryp_password'];
            $hash = $util->checkhashSSHA($salt, $password);
            if($hash == $encrypted_password){
                return true;
            } else {
                return false;
            }
        }else{

            return false;
        }
    }



}



?>