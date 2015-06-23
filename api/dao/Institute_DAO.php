<?php

/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/3/15
 * Time: 1:44 AM
 */



require_once 'dao/DB_Connect.php';
require_once 'util/Util.php';
require_once 'dao/Config.php';

class Institute_DAO
{




    function __constructor()
    {


    }

    function __destructor()
    {

    }

    //Register an user: Return true if success and false if unsuccess
    public function registerInstitute($name, $cnpj)
    {
        if(!isset($name) || $name == "" /*|| Util::valida_cnpj($cnpj)*/){
            return false;
        }else {

            $conn = DB_Connect::connect();

            $query = "insert into tb_institute (name, cnpj) VALUES (?, ?);";


            $stmt = $conn->prepare($query);
            $result = $stmt->execute(array($name, $cnpj));

            $conn = null;
            if ($result) {
                return true;
            } else {
                return false;
            }
        }

    }

    public function listAllHospital(){
        $hemocentro = CNPJ_HEMOCENTRO;
        $conn = DB_Connect::connect();
        $query = "select * from tb_institute where tb_institute.cnpj <> ?";

        $stmt = $conn->prepare($query);

        $stmt->execute(array($hemocentro));

        while($result = $stmt->fetch(PDO::FETCH_ASSOC)){

            $json[] = $result;

        }
        return json_encode($json, JSON_NUMERIC_CHECK);

    }

    public function listHemocenterData(){
        $hemocentro = CNPJ_HEMOCENTRO;
        $conn = DB_Connect::connect();
        $query = "select * from tb_institute where tb_institute.cnpj = ?";

        $stmt = $conn->prepare($query);

        $stmt->execute(array($hemocentro));

        while($result = $stmt->fetch(PDO::FETCH_ASSOC)){

            $json[] = $result;

        }
        return json_encode($json, JSON_NUMERIC_CHECK);

    }


    public function listStock($cnpj){
        $conn = DB_Connect::connect();
        $query = "select stock.id, stock.A_pos, stock.A_neg, stock.B_pos, stock.B_neg, stock.AB_pos, stock.AB_neg, stock.O_pos, stock.O_neg, stock.cnpj_institute, tb_institute.name
                  from tb_blood_stock as stock inner join tb_institute
                  where (tb_institute.cnpj = :cnpj) and (stock.cnpj_institute = :cnpj)";

        $stmt = $conn->prepare($query);
        $stmt->bindValue(":cnpj", $cnpj);

        $stmt->execute();

        while($result = $stmt->fetch(PDO::FETCH_ASSOC)){

            $json[] = $result;

        }
        return json_encode($json, JSON_NUMERIC_CHECK);
    }



}



?>