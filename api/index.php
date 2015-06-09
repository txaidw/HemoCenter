<?php
/**
 * Created by PhpStorm.
 * User: alyssonzanette
 * Date: 6/3/15
 * Time: 2:34 AM
 */
   require_once 'user/User.php';
   require_once 'authentication/Auth.php';

    $obj = file_get_contents('php://input');

   // $obj = '{"operation":2,"name":"Administrador padrao","username":"admin","password":"admin","type":1, "email":"admin@hemocentro.com.br"}';
  //  $obj = '{"operation":1,"username":"admin@hemocentro.com.br","password":"admin"}';
    $data = json_decode($obj, true);


    switch($data['operation']){
        case 1:
            $do_op = new Auth();
            $do_op->setData($data);

            if($do_op->do_login()){
                echo '{"status" : "success"}';
            }else{
                echo '{"status" : "error"}';
            }
            break;
        case 2:

            break;
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