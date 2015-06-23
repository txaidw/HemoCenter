<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/5/15
 * Time: 3:12 AM
 */

require_once 'util/Util.php';
class Giver_DAO
{


    function __constructor()
    {

    }


    //Register an Giver: Return true if success and false if unsuccess
    public function registerGiver($name, $email, $adress, $phone1, $phone2, $cpf, $blood_type)
    {
        if ($name == "" || $email == "" || $adress == "" || !Util::valida_Cpf($cpf)) {
            return false;
        } else {

            $conn = DB_Connect::connect();
            $query = "insert into tb_giver (name, email, adress, phone1, phone2, cpf, blood_type) VALUES (?, ?, ?, ?, ?, ?, ?);";

            $stmt = $conn->prepare($query);

            $result = $stmt->execute(array($name, $email, $adress, $phone1, $phone2, $cpf, $blood_type));

            $conn = null;
            if ($result) {
                return true;
            } else {
                return false;
            }

        }
    }


    public function isGiver($cpf)
    {
        if (!Util::valida_Cpf($cpf)) {
            return false;
        } else {
            $conn = DB_Connect::connect();
            $query = "select * from tb_giver where tb_giver.cpf LIKE ?;";

            $stmt = $conn->prepare($query);

            $stmt->execute(array($cpf));
            $result = $stmt->fetch(PDO::FETCH_ASSOC);


            $conn = null;
            if ($result != null) {
                return true;
            } else {
                return false;
            }

        }
    }

    public function listAllGivers()
    {
        $conn = DB_Connect::connect();
        $query = "select *
                  from tb_giver;";

        $stmt = $conn->prepare($query);
        $stmt->execute();

        while ($result = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $json[] = $result;

            }
        return json_encode($json, JSON_NUMERIC_CHECK);
    }


    public function good_blood_givers(){

        $conn = DB_Connect::connect();
        $query = "select count(tb_donation.id) as total_donations, tb_giver.id, tb_giver.name, tb_giver.adress, tb_giver.phone1, tb_giver.phone2, tb_giver.email, tb_giver.cpf, tb_giver.blood_type
                  from tb_giver inner join tb_donation
                  where (tb_giver.cpf = tb_donation.cpf_giver)
                  and year(tb_donation.donation_date) = year(curdate())
                  group by tb_donation.cpf_giver
                  having total_donations >= 4";

        $stmt = $conn->prepare($query);

        $stmt->execute(array());

        while ($result = $stmt->fetch(PDO::FETCH_ASSOC)) {

            $json[] = $result;

        }
        return json_encode($json, JSON_NUMERIC_CHECK);
    }

    public function listDonationOfGiver($cpf){
        $conn = DB_Connect::connect();
        $query = "select donation.id, donation.cnpj_institute, tb_institute.name as institute_name, donation.qnt_blood, donation.cpf_giver, tb_giver.name as giver_name, donation.donation_date
                  from tb_donation as donation inner join tb_institute inner join tb_giver
                  where (donation.cnpj_institute = tb_institute.cnpj)
                    and (donation.cpf_giver = :cpf)
                    and (tb_giver.cpf = :cpf);";


        $stmt = $conn->prepare($query);
        $stmt->bindValue(":cpf", $cpf);

        $stmt->execute();

        while($result = $stmt->fetch(PDO::FETCH_ASSOC)){

            $json[] = $result;

        }
        return json_encode($json, JSON_NUMERIC_CHECK);
    }


}


?>