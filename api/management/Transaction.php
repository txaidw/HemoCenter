<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/16/15
 * Time: 7:27 PM
 */
require_once 'dao/Transaction_DAO.php';
define('User_Limit_Transaction', 250000);


Class Transaction {
    private $cnpj_source;
    private $cnpj_destination;
    private $qnt_blood;
    private $blood_type;
    private $key;



    public function __constructor(){

    }


    public function setData($json_data){
        $this->cnpj_source = $json_data['cnpj_source'];
        $this->cnpj_destination = $json_data['cnpj_destination'];
        $this->blood_type = $json_data['blood_type'];
        $this->key = $json_data['key'];
        $this->qnt_blood = $json_data['qnt_blood'];
    }


    public function do_transaction(){
        $dao = new Transaction_DAO();
        return $dao->do_transaction($this->cnpj_source, $this->cnpj_destination, $this->qnt_blood, $this->blood_type,$this->key);
    }

    public function listTransactionHistory(){
        return Transaction_DAO::listTransactionHistory();
    }

    public function qnt_blood_source(){
        $dao = new Transaction_DAO();
        return $dao->qnt_blood($this->blood_type, $this->cnpj_source);
    }


}






?>