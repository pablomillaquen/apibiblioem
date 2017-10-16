<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;
use App\Lib\Auth;

class AuthModel
{
    private $db;
    private $table = 'pm_empleado';
    private $response;
    
    public function __CONSTRUCT()
    {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }
    
    public function Autenticar($email,$pass)
    {
	   
        try
        {
            $result = array();
            $contra = sha1('pmti'.$pass);
            $stm = $this->db->prepare("CALL SP_AUTH_Sel(:email,:pass)");
            $stm->bindParam(':email', $email);
            $stm->bindParam(':pass', $contra);
            $stm->execute();

            $empleado = $stm->fetch();

            if(is_object($empleado)){
                
                $token = Auth::SignIn([
                    'id' => $empleado->id,
                    'nombre' => $empleado->nombre,
                    'apellido' => $empleado->apellido,
                    'email' => $empleado->email,
                    'acceso' => $empleado->acceso,
                    'user' => $empleado->usuario
                    ]);
            $this->response->result = $token;
            return $this->response->setResponse(true);

            }else{
                return $this->response->setResponse(false, "Credenciales no válidas");
            }
            
         
        }
        catch(Exception $e)
        {
            $this->response->setResponse(false, $e->getMessage());
            return $this->response;
        }  	
    }
    
}