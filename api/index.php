<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/3/15
 * Time: 2:34 AM
 */
   require_once 'user/User.php';
   require_once 'authentication/Login.php';
   require_once 'authentication/Auth.php';
   require_once 'attend/Giver.php';

    $obj = file_get_contents('php://input');

    //$obj = '{"operation":1,"username":"admin@hemocentro.com.br","password":"admin"}';
    $obj = '{"operation":2,"name":"Alberto Pereira","email":"alberto.prereira@hotmail.com","adress":"Rua Dr. Flores, Porto Alegre","phone1":12344123,"phone2":1234123,"blood_type":2,"cpf":1234123123,"key":"557633641170e8.83239823"}';
    $data = json_decode($obj, true);

    $auth = new Auth();

    switch($data['operation']){
        //Fazer login
        case 1:

            $do_op = new Login();
            $do_op->setData($data);


            $result = $do_op->do_login();

            if($result['status']){
                echo '{
                        "key" : "'.$result['key'].'",
                        "status" : 1,
                        "msg" : "success login."
                       }';
            }else{
                echo '{
                        "status":0,
                        "msg":"User or password are not valid."
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
                            "msg" : "Success insert Giver."
                          }';
                }else{
                    echo '{
                            "status" : 0,
                            "msg" : "Fail insert Giver."}';
                }
            }else{
                echo '{ "status" : 0,
                        "msg" : "Not is an user."}';
            }

            break;

        //Registrar doação
        case 3:

            break;

        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
        case 8:
            break;
        case 9:
            break;
        case 10:

            $do_op = new User();
            $do_op->setData($data);

            if($do_op->registerUser()){

                echo '{"status" : "success"}';
            }else{

                echo '{"status" : "error"}';
            }
            break;
        default:
            echo '{"status" : "Sorry, An unexpected error occurred"}';
            break;

    }







?>