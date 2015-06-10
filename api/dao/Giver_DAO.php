<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/5/15
 * Time: 3:12 AM
 */


class Giver_DAO{


    function __constructor(){

    }



    //Register an Giver: Return true if success and false if unsuccess
    public function registerGiver($name, $email, $adress, $phone1, $phone2, $cpf, $blood_type)
    {
        $conn = DB_Connect::connect();
        $query = "insert into tb_giver (name, email, adress, phone1, phone2, cpf, blood_type) VALUES (?, ?, ?, ?, ?, ?, ?);";

        $stmt = $conn->prepare($query);
        $result = $stmt->execute(array($name,$email,$adress,$phone1,$phone2,$cpf, $blood_type));

        $conn = null;
        if ($result) {
            return true;
        } else {
            return false;
        }

    }


}


?>