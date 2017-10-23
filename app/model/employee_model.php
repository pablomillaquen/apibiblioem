<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

/**
 * @SWG\Definition(type="object")
 */
class EmployeeModel
{
    private $db;
    private $table = 'PM_EMPleado';
    private $response;
    
    public function __CONSTRUCT()
    {
        $this->db = Database::StartUp();
        $this->response = new Response();
    }
    
    public function GetAll()
    {
		try
		{
            $stm = $this->db->prepare("CALL SP_EMPLEADO_sel()");
           $stm->execute();
            
            $this->response->setResponse(true);
            $this->response->result = $stm->fetchAll();
            
            return $this->response;
		}
		catch(Exception $e)
		{
			$this->response->setResponse(false, $e->getMessage());
            return $this->response;
		}
    }
    
    public function Get($id)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("CALL SP_EMPLEADO_Sel(:id)");
			$stm->bindParam(':id', $id);
            $stm->execute();

			$this->response->setResponse(true);
            $this->response->result = $stm->fetch();
            
            return $this->response;
		}
		catch(Exception $e)
		{
			$this->response->setResponse(false, $e->getMessage());
            return $this->response;
		}  
    }
    
    public function InsertOrUpdate($data)
    {
		try 
		{
            $date = date('Y-m-d H:i:s');
            if(isset($data['id']))
            {   
                if($data['pass'] != ''){
                    $contra = sha1('pmti'.$data['pass']);
                }else{
                    $contra = "";
                }

                if(isset($data['pass'])){
                    $contra = sha1('pmti'.$data['pass']);
                    $stm = $this->db->prepare("CALL SP_EMPLEADO_Upd(:nombre,:apellido,:email,:acceso,:usuario,:pass,:fechamodificacion,:id)");
                    $stm->bindParam(':nombre', $data['nombre']);
                    $stm->bindParam(':apellido', $data['apellido']);
                    $stm->bindParam(':email', $data['correo']);
                    $stm->bindParam(':acceso', $data['acceso']);
                    $stm->bindParam(':usuario', $data['usuario']);
                    $stm->bindParam(':pass', $contra);
                    $stm->bindParam(':id', $data['id']);
                    $stm->bindParam(':fechamodificacion', $date);

                }else{
                    $stm = $this->db->prepare("CALL SP_EMPLEADO_UpdSP(:nombre,:apellido,:email,:acceso,:usuario,:fechamodificacion,:id)");
                    $stm->bindParam(':nombre', $data['nombre']);
                    $stm->bindParam(':apellido', $data['apellido']);
                    $stm->bindParam(':email', $data['correo']);
                    $stm->bindParam(':acceso', $data['acceso']);
                    $stm->bindParam(':usuario', $data['usuario']);
                    $stm->bindParam(':id', $data['id']);
                    $stm->bindParam(':fechamodificacion', $date);
                }
                
                $stm->execute();

               
            }
            else
            {   
                
                if(isset($data['pass'])){
                    $contra = sha1('pmti'.$data['pass']);
                    $stm = $this->db->prepare("CALL SP_EMPLEADO_Ins(:nombre,:apellido,:email,:acceso,:usuario,:pass,:fechacreacion,:fechamodificacion)");
                    $stm->bindParam(':nombre', $data['nombre']);
                    $stm->bindParam(':apellido', $data['apellido']);
                    $stm->bindParam(':email', $data['correo']);
                    $stm->bindParam(':acceso', $data['acceso']);
                    $stm->bindParam(':usuario', $data['usuario']);
                    $stm->bindParam(':pass', $contra);
                    $stm->bindParam(':fechacreacion', $date);
                    $stm->bindParam(':fechamodificacion', $date);

                }else{
                    $stm = $this->db->prepare("CALL SP_EMPLEADO_Ins(:nombre,:apellido,:email,:acceso,:usuario,:fechacreacion,:fechamodificacion)");
                    $stm->bindParam(':nombre', $data['nombre']);
                    $stm->bindParam(':apellido', $data['apellido']);
                    $stm->bindParam(':email', $data['correo']);
                    $stm->bindParam(':acceso', $data['acceso']);
                    $stm->bindParam(':usuario', $data['usuario']);
                    $stm->bindParam(':fechacreacion', $date);
                    $stm->bindParam(':fechamodificacion', $date);
                }
                $stm->execute();
               
            }
            
			$this->response->setResponse(true);
            return $this->response;
		}catch (Exception $e) 
		{
            $this->response->setResponse(false, $e->getMessage());
		}
    }
    
    public function Delete($id)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_EMPLEADO_Del(:id)");
            $stm->bindParam(':id', $id);
            $stm->execute();
			
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }

    
}