<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/4/15
 * Time: 8:41 PM
 */

require_once 'dao/Donation_DAO.php';
require_once 'dao/Config.php';
Class Donation{

    private $qnt_blood;
    private $cpf;
    private $cnpj;


    public function __constructor(){


    }


    //Return true if success or false if fail
    public function registerDonation(){

        $dao = new Donation_DAO();

        return $dao->registerDonation($this->qnt_blood,$this->cpf,$this->cnpj, $this->blood_type);

    }

    public function setData($json_data){


        $this->qnt_blood = $json_data['qnt_blood'];
        $this->cpf = trim($json_data['cpf']);
        if($json_data['cnpj'] == "null")
            $this->cnpj = CNPJ_HEMOCENTRO;
        else
            $this->cnpj = trim($json_data['cnpj']);


    }

    public function listAllDonation()
    {
        return Donation_DAO::listAllDonation();
    }


}
?>