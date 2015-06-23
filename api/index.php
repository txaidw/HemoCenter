<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/3/15
 * Time: 2:34 AM
 */
;

   require_once 'user/User.php';
   require_once 'authentication/Login.php';
   require_once 'authentication/Auth.php';
   require_once 'attend/Giver.php';
   require_once 'attend/Donation.php';
   require_once 'management/Institute.php';
   require_once 'management/Transaction.php';
   require_once 'dao/Config.php';
   require_once 'dao/Transaction_DAO.php';


    $obj = file_get_contents('php://input');

                 /*=====================> Debug to test somethings... <========================*/

    //$obj = '{"operation":1,"username":"user","password":"user"}';
   //$obj = '{"operation":2,"name":"Alberto Pereira","email":"alberto.prereira@hotmail.com","adress":"Rua Dr. Flores, Porto Alegre","phone1":12344123,"phone2":1234123,"blood_type":2,"cpf":"023.284.660-01","key":"557633641170e8.83239823"}';
    //$obj = '{"operation":10,"name":"Alysson Zanette","username":"zzanette","email":"alysson.prereira@hotmail.com","key":"5576339ad8f747.18888660","password":"alysson","type":1}';
    //$obj = '{"operation":3,"cpf":"023.284.660-01","qnt_blood":500,"cnpj":"null","key":"5576339ad8f747.18888660"}';
  // $obj = '{"operation":12,"key":"5576339ad8f747.18888660"}';
    //10:Cadastrar usuário"key":"5576339ad8f747.18888660"}';
    //$obj = '{"operation":9,"key":"5576339ad8f747.18888660","cnpj_source":"00.000.000/0001-00","cnpj_destination":"00.000.000/0001-03", "qnt_blood": 100000000000,"blood_type":6}';
//$obj = '{"operation":14,"key":"5576339ad8f747.18888660", "cpf":"023.284.660-01"}';
$data = json_decode($obj, true);

    $auth = new Auth();

    switch($data['operation']){
        //Fazer login
        case 1:

            $do_op = new Login();
            $do_op->setData($data);


            $result = $do_op->do_login();

            if($result['status']){
                echo $result['name'];
                echo '{
                        "key" : "'.$result['key'].'",
                        "user_type":'.$result['user_type'].',
                        "name":"'.$result['name'].'",
                        "status" : 1,
                        "msg" : "Login realizado com sucesso."
                       }';
            }else{
                echo '{
                        "status":0,
                        "msg":"Usuario ou senha não conferem."
                      }';
            }
            break;

        //Cadastrar doador
        case 2:
            $auth->setData($data['key']);
            if($auth->isAuthenticUser()){
                $give = new Giver();

                $give->setData($data);

                if($give->registerGiver()) {
                    echo '{
                            "status" : 1,
                            "msg" : "Doador inserido com sucesso."
                          }';
                }else{
                    echo '{
                            "status" : 0,
                            "msg" : "Falha ao inserir doador."}';
                }
            }else{
                echo '{ "status" : 0,
                        "msg" : "Erro, você não é um usuário do sistema."}';
            }

            break;

        //Registrar doação
        case 3:
            $auth->setData($data['key']);

            if($auth->isAuthenticUser()) {

                $do_op = new Donation();
                $do_op->setData($data);

                if ($do_op->registerDonation()){

                    echo '{ "status" : 1,
                            "msg" : "Doação registrada com sucesso."}';
                } else {

                    echo '{ "status" : 0,
                            "msg" : "Erro: Nao foi possivel registrar doação."}';
                }
            }else{
                echo '{ "status" : 0,
                        "msg" : "Erro: Usuario nao eh autentivo."}';
            }

            break;
        //Listar todos doadores
        case 4:
            $auth->setData($data['key']);

            if($auth->isAuthenticUser()) {

                $do_op = new Giver();

                echo $do_op->listAllGivers();
            }else{
                echo '{ "status" : 0,
                        "msg" : "Erro: Usuario nao eh autentico."}';
            }
            break;
        //Listar todos hospitais
        case 5:
            $auth->setData($data['key']);

            if($auth->isAuthenticUser()) {

                $do_op = new Institute();

                echo $do_op->listAllHospital();

            }else{
                echo '{ "status" : 0,
                        "msg" : "Erro: Usuario nao eh autentico."}';
            }
            break;
        //Listar dados do hemocentro
        case 6:
            $auth->setData($data['key']);

            if($auth->isAuthenticUser()) {

                $do_op = new Institute();

                echo $do_op->listHemocenterData();

            }else{
                echo '{ "status" : 0,
                        "msg" : "Erro: Usuario nao eh autentico."}';
            }
            break;
            break;
        //Listar usuarios programa sangue bom
        case 7:
            $auth->setData($data['key']);

            if($auth->isAuthenticUser()) {

                $do_op = new Giver();

                echo $do_op->good_blood_givers();

            }else{
                echo '{ "status" : 0,
                        "msg" : "Erro: Usuario nao eh autentico."}';
            }
            break;
        //Cadastrar hospital
        case 8:
            $auth->setData($data['key']);

            if($auth->isManagement()) {

                $do_op = new Institute();

                $do_op->setData($data);

                if ($do_op->registerInstitute()){

                    echo '{ "status" : 1,
                            "msg" : "Hospital registrado com sucesso."}';
                } else {

                    echo '{ "status" : 0,
                            "msg" : "Erro: Nao foi possivel registrar Hospital."}';
                }
            }else{
                echo '{ "status" : 0,
                        "msg" : "Erro: Usuario nao eh gerente."}';
            }
            break;
        //Realizar transação
        case 9:
            $auth->setData($data['key']);


            if($auth->isAuthenticUser()){
                $do_op = new Transaction();

                $do_op->setData($data);
                if($do_op->qnt_blood_source() >= $data['qnt_blood']) {
                    if ($data['cnpj_source'] != CNPJ_HEMOCENTRO && $data['qnt_blood'] > User_Limit_Transaction) {
                        if ($auth->isManagement()) {

                            if ($do_op->do_transaction()) {
                                echo '{ "status" : 1,
                        "msg" 0: "Transação realizada com sucesso."}';
                            } else {
                                echo '{ "status" : 0,
                        "msg" : "Não foi possível realizar ransação, usuario necessita ser administrador."}';
                            }
                        }
                    } else {
                        if ($do_op->do_transaction()) {
                            echo '{ "status" : 1,
                            "msg" : "Transação realizada com sucesso."}';
                        } else {
                            echo '{ "status" : 0,
                            "msg" : "Não foi possível realizar ransação."}';
                        }
                    }
                }else{
                    echo '{ "status" : 0,
                    "msg" : "Quantidade de sangue a ser doado é maior que quantidade de sangue em estoque."}';
                }
            }else {

                echo '{ "status" : 0,
                    "msg" : "Você precisa ser um usuario do sistema."}';
            }
            break;
        //Cadastrar usuario
        case 10:
            $auth->setData($data['key']);
            if($auth->isManagement()) {
                $do_op = new User();
                $do_op->setData($data);

                if ($do_op->registerUser()) {

                    echo '{ "status" : 1,
                            "msg" : "Usuario inserido com sucesso."}';
                } else {

                    echo '{ "status" : 0,
                            "msg" : "Erro: Nao foi possivel inserir usuario."}';
                }
            }else{
                echo '{ "status" : 0,
                        "msg" : "Erro: Usuario nao e administrador."}';
            }
            break;
        //Listar Doações
        case 11:


            $auth->setData($data['key']);

            if($auth->isAuthenticUser()) {

                $do_op = new Donation();
                echo $do_op->listAllDonation();

            }else{
                echo '{ "status" : 0,
                        "msg" : "Erro: Usuario nao eh autentico."}';
            }
            break;
        //Listar historico transações
        case 12:
            $auth->setData($data['key']);

            if($auth->isAuthenticUser()) {

                $do_op = new Transaction();

                echo $do_op->listTransactionHistory();

            }else{
                echo '{ "status" : 0,
                        "msg" : "Erro: Usuario nao eh autentico."}';
            }
            break;
        //Listar estoque de uma instituição
        case 13:
            $auth->setData($data['key']);

            if($auth->isAuthenticUser()) {

                $do_op = new Institute();
                $do_op->setData($data);
                echo $do_op->listStock();

            }else{
                echo '{ "status" : 0,
                        "msg" : "Erro: Usuario nao eh autentico."}';
            }
            break;
        //Listar doações de um doador
        case 14:
            $auth->setData($data['key']);

            if($auth->isAuthenticUser()) {

                $do_op = new Giver();
                $do_op->setData($data);
                echo $do_op->listDonationOfGiver();

            }else{
                echo '{ "status" : 0,
                        "msg" : "Erro: Usuario nao eh autentico."}';
            }
            break;
        default:
            echo '{"status" : "Desculpe, erro no código da operação"}';
            break;

    }







?>