<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/4/15
 * Time: 8:41 PM
 */

require_once 'dao/Giver_DAO.php';

Class Giver{

    private $name;
    private $email;
    private $phone1;
    private $phone2;
    private $cpf;
    private $adress;
    private $type_blood;

    public function __constructor(){


    }


    //Return true if success or false if fail
    public function registerGiver(){

        $dao = new Giver_DAO();

        return $dao->registerGiver($this->name,$this->email,$this->adress, $this->phone1, $this->phone2, $this->cpf, $this->type_blood);

    }

    public function isGiver(){
        $dao = new Giver_DAO();
        return $dao->isGiver($this->cpf);
    }

    public function setData($json_data){


        $this->name = trim($json_data['name']);
        $this->email = trim($json_data['email']);
        $this->phone1 = trim($json_data['phone1']);
        $this->phone2 = trim($json_data['phone2']);
        $this->adress = trim($json_data['adress']);
        $this->cpf = trim($json_data['cpf']);
        $this->type_blood = $json_data['blood_type'];

    }

    public function listAllGivers(){

        return Giver_DAO::listAllGivers();
    }

    public function good_blood_givers(){
        return Giver_DAO::good_blood_givers();
    }

    public function listDonationOfGiver(){
        return Giver_DAO::listDonationOfGiver($this->cpf);
    }


}