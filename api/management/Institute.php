<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/11/15
 * Time: 2:00 AM
 */

require_once 'dao/Institute_DAO.php';
require_once 'dao/Config.php';

class Institute
{



    private $name;
    private $cnpj;


    public function __constructor(){



    }


    //Return true if success or false if fail
    public function registerInstitute(){

        $dao = new Institute_DAO();

        return $dao->registerInstitute($this->name, $this->cnpj);

    }
    public function setData($json_data){

        $this->name = trim($json_data['name']);
        if($json_data['cnpj'] == "null")
            $this->cnpj = CNPJ_HEMOCENTRO;
        else
            $this->cnpj = $json_data['cnpj'];


    }

    public function listAllHospital(){

            return Institute_DAO::listAllHospital();
    }

    public function listHemocenterData(){
        return Institute_DAO::listHemocenterData();
    }

    public function listStock(){
        return Institute_DAO::listStock($this->cnpj);
    }


}





?>