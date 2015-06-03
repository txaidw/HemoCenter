<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/3/15
 * Time: 1:44 AM
 */

class DB_Functions
{

    private $db;

    function __constructor()
    {
        $this->db = new DB_Connect();
        $this->db->connect();
    }

    function __destructor()
    {
    }


//Register an user: Return true if success and false if unsuccess
    public function registerUser($name, $email, $password, $type)
    {
        $query = "insert into tb_users (unique_id, name, email, encryp_password, salt, user_type) VALUES (':unique_id', ':name', ':email', ':encryp_password', ':salt', ':type');";

        $uid = uniqid('', true);
        $hash = $this->hashSSHA($password);
        $encryp_pass = $hash["encrypted"];
        $salt = $hash["salt"];

        $stmt = $db->prepare($query);
        $stmt->bindParam(':unique_id', $uid);
        $stmt->bindParam(':name', $name);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':encryp_password', $encryp_pass);
        $stmt->bindParam(':unique_id', $uid);
        $stmt->bindParam(':salt', $salt);
        $stmt->bindParam(':type', $type);

        $result = $stmt->execute();
        if($result){
            return true;
        }else{
            return false;
        }

    }




    


//Encrypti password
    public function hashSSHA($password)
    {

        $salt = sha1(rand());
        $salt = substr($salt, 0, 10);
        $encrypted = base64_encode(sha1($password . $salt, true) . $salt);
        $hash = array("salt" => $salt, "encrypted" => $encrypted);
        return $hash;
    }

//Dencrypti password
    public function checkhashSSHA($salt, $password)
    {

        $hash = base64_encode(sha1($password . $salt, true) . $salt);

        return $hash;
    }
}

?>