<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/5/15
 * Time: 3:12 AM
 */

require_once 'util/Util.php';
require_once 'dao/Giver_DAO.php';

class Donation_DAO{


    function __constructor(){

    }



    //Register an Giver: Return true if success and false if unsuccess
    public function registerDonation($qnt_blood, $cpf, $cnpj)
    {


        if ($qnt_blood <= 0 || /*!Util::valida_cnpj($cnpj) ||*/ !Giver_DAO::isGiver($cpf)) {

            return false;
        }else {
            $conn = DB_Connect::connect();
            $query = "insert into tb_donation (qnt_blood,cpf_giver, cnpj_institute) VALUES (?,?,?);";

            $stmt = $conn->prepare($query);

            $result = $stmt->execute(array($qnt_blood, $cpf, $cnpj));

            $conn = null;
            if ($result) {
                return true;
            } else {
                return false;
            }

        }
    }

    public function listAllDonation(){
        $conn = DB_Connect::connect();
        $query = "select donation.id, donation.cpf_giver, giver.name, donation.qnt_blood, donation.cnpj_institute
                  from tb_donation as donation inner JOIN tb_giver as giver
                  where donation.cpf_giver = giver.cpf;";

        $stmt = $conn->prepare($query);
        $stmt->execute();

        while ($result = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $json[] = $result;

        }
        return json_encode($json, JSON_NUMERIC_CHECK);
    }


}


?>