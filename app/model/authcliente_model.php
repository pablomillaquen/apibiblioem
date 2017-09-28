<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;
use App\Lib\AuthCliente;

class AuthClienteModel
{
    private $response;
    
    public function __CONSTRUCT()
    {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }
    
    public function AutenticarCliente()
    {
	   
        try
        {
            $result = array();
            // $contra = sha1('pmti'.$pass);
            // $stm = $this->db->prepare("CALL SP_AUTH_Sel(:nombre,:pass)");
            // $stm->bindParam(':nombre', $nombre);
            // $stm->bindParam(':pass', $contra);
            // $stm->execute();

            //$empleado = $stm->fetch();

            //if(is_object($empleado)){
            $fecha = microtime();
            
            $token = AuthCliente::SignIn([
                'id' => sha1($fecha),
                'acceso' => 'cliente'

                ]);
            $this->response->result = $token;
            return $this->response->setResponse(true);

            // }else{
            //     return $this->response->setResponse(false, "Credenciales no válidas");
            // }
            
         
        }
        catch(Exception $e)
        {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }  	
    }
    
}