<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/16/15
 * Time: 7:34 PM
 */

require_once 'util/Blood.php';

class Transaction_DAO{

    private $str_blood_type;


    function __constructor(){

    }

    public function qnt_blood($blood_type, $cnpj){
        $conn = DB_Connect::connect();

        Transaction_DAO::setStrBloodType($blood_type);

        $query = "select * from tb_blood_stock
                  where tb_blood_stock.cnpj_institute = ?;";

        $stmt = $conn->prepare($query);


        $stmt->execute(array($cnpj));
        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        return $result[$this->str_blood_type];
    }


    //do a blood transaction
    public function do_transaction($cnpj_source, $cnpj_destination, $qnt_blood, $blood_type,$key){
        if(Transaction_DAO::subtractionBloodStock($cnpj_source, $qnt_blood, $blood_type)){
             if(Transaction_DAO::adttionBloodStock($cnpj_destination, $qnt_blood, $blood_type)) {
                 Transaction_DAO::register_history($cnpj_source, $cnpj_destination, $qnt_blood, $blood_type,$key);
                 return true;
             }else{
                 Transaction_DAO::adttionBloodStock($cnpj_source, $qnt_blood, $blood_type);
                 return false;
             }
         }else{

             return false;
         }

    }



    public function listTransactionHistory(){
        $conn = DB_Connect::connect();
        $query1 = "select history.id, history.cnpj_source, history.cnpj_destination, history.blood_type, history.qnt_blood, tb_users.username as responsable_username, tb_users.name as responsable_name
                   from tb_transaction_history as history inner join tb_users
                   where history.responsable_key = tb_users.unique_id;";

        $stmt = $conn->prepare($query1);
        $stmt->execute();

        while ($result = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $json[] = $result;

        }
        return json_encode($json, JSON_NUMERIC_CHECK);
    }


    //Subtraction in Stock
    public function subtractionBloodStock($cnpj, $qnt_blood, $blood_type){

        $conn = DB_Connect::connect();

        Transaction_DAO::setStrBloodType($blood_type);

        $query = "update tb_blood_stock set ".$this->str_blood_type." = ".$this->str_blood_type." - :qnt_blood
                  WHERE tb_blood_stock.cnpj_institute = :cnpj;";

        $stmt = $conn->prepare($query);

        $stmt->bindValue(":qnt_blood", $qnt_blood);
        $stmt->bindValue(":cnpj", $cnpj);

        $result = $stmt->execute();

        return $result;


    }

    //Addition in Stock
    public function adttionBloodStock($cnpj, $qnt_blood, $blood_type){

        $conn = DB_Connect::connect();
        Transaction_DAO::setStrBloodType($blood_type);

        $query = "update tb_blood_stock set ".$this->str_blood_type." = ".$this->str_blood_type." + :qnt_blood
                  WHERE tb_blood_stock.cnpj_institute = :cnpj;";

        $stmt = $conn->prepare($query);

        $stmt->bindValue(":qnt_blood", $qnt_blood);
        $stmt->bindValue(":cnpj", $cnpj);

        $result = $stmt->execute();

        return $result;


    }


    public function register_history($cnpj_source, $cnpj_destination, $qnt_blood, $blood_type, $key){

        $conn = DB_Connect::connect();


        $query = "insert into tb_transaction_history (cnpj_source, cnpj_destination, qnt_blood, blood_type, responsable_key)
                  values (:cnpj_source, :cnpj_destination, :qnt_blood, :blood_type, :key);";

        $stmt = $conn->prepare($query);

        $stmt->bindValue(":cnpj_destination", $cnpj_destination);
        $stmt->bindValue(":cnpj_source", $cnpj_source);
        $stmt->bindValue(":qnt_blood", $qnt_blood);
        $stmt->bindValue(":blood_type", $blood_type);
        $stmt->bindValue(":key", $key);

        $stmt->execute();

    }

    public function setStrBloodType($blood_type){


        switch ($blood_type) {
            case A_POS:
                $this->str_blood_type = 'A_pos';
                break;
            case A_NEG:
                $this->str_blood_type = 'A_neg';
                break;
            case B_POS:
                $this->str_blood_type = 'B_pos';
                break;
            case B_NEG:
                $this->str_blood_type = 'B_neg';
                break;
            case AB_POS:
                $this->str_blood_type = 'AB_pos';
                break;
            case AB_NEG:
                $this->str_blood_type = 'AB_neg';
                break;
            case O_POS:
                $this->str_blood_type = 'O_pos';
                break;
            case O_POS:
                $this->str_blood_type = 'O_neg';
                break;
        }
    }


}



?>