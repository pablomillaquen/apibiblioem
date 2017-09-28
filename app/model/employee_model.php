<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

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
    
    public function GetAll($l,$p)
    {
		try
		{
            $stm = $this->db->prepare("CALL SP_EMPLEADO_Lista(:l,:p)");
            $stm->bindParam(':l', $l);
            $stm->bindParam(':p', $p);
            $stm->execute();
            $data = $stm->fetchAll();
            unset($stm);

            $stm = $this->db->prepare("CALL SP_EMPLEADO_Count");
            $stm->execute();
            $total = $stm->fetch();
            
            
            return [
                'data'  => $data,
                'total' => $total->total
            ];
		}
		catch(Exception $e)
		{
			$this->response->setResponse(false, $e->getMessage());
            return $this->response;
		}
    }
    
    public function Get($idEmpleado)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("CALL SP_EMPLEADO_Sel(:id)");
			$stm->bindParam(':id', $idEmpleado);
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
            if(isset($data['idEmpleado']))
            {   
                if($data['Pass'] != ''){
                    $contra = sha1('pmti'.$data['Pass']);
                }else{
                    $contra = "";
                }

                $stm = $this->db->prepare("CALL SP_EMPLEADO_Upd(:idEmpleado,:Nombre,:Apellido,:Email,:Acceso,:Usuario,:Pass)");
                $stm->bindParam(':idEmpleado', $data['idEmpleado']);
                $stm->bindParam(':Nombre', $data['Nombre']);
                $stm->bindParam(':Apellido', $data['Apellido']);
                $stm->bindParam(':Email', $data['Email']);
                $stm->bindParam(':Acceso', $data['Acceso']);
                $stm->bindParam(':Usuario', $data['Usuario']);
                $stm->bindParam(':Pass', $contra);
                
                
                $stm->execute();

               
            }
            else
            {   
                
                if(isset($data['Pass'])){
                    $contra = sha1('pmti'.$data['Pass']);
                    $stm = $this->db->prepare("CALL SP_EMPLEADO_Ins(:Nombre,:Apellido,:Email,:Acceso,:Usuario,:Pass)");
                    $stm->bindParam(':Nombre', $data['Nombre']);
                    $stm->bindParam(':Apellido', $data['Apellido']);
                    $stm->bindParam(':Email', $data['Email']);
                    $stm->bindParam(':Acceso', $data['Acceso']);
                    $stm->bindParam(':Usuario', $data['Usuario']);
                    $stm->bindParam(':Pass', $contra);
                }else{
                    $stm = $this->db->prepare("CALL SP_EMPLEADO_Ins(:Nombre,:Apellido,:Email,:Acceso,:Usuario)");
                    $stm->bindParam(':Nombre', $data['Nombre']);
                    $stm->bindParam(':Apellido', $data['Apellido']);
                    $stm->bindParam(':Email', $data['Email']);
                    $stm->bindParam(':Acceso', $data['Acceso']);
                    $stm->bindParam(':Usuario', $data['Usuario']);
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
    
    public function Delete($idEmpleado)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_EMPLEADO_Del(:idEmpleado)");
            $stm->bindParam(':idEmpleado', $idEmpleado);
            $stm->execute();
			
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }

    
}