<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class QuotaModel
{
    private $db;
    private $table = 'PM_CUPos';
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
			$result = array();

			$stm = $this->db->prepare("CALL SP_CUPOS_Lista(:l,:p)");
            $stm->bindParam(':l', $l);
            $stm->bindParam(':p', $p);
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
    
    public function Get($idCupos)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("CALL SP_CUPOS_Sel(:id)");
			$stm->bindParam(':id', $idCupos);
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
            if(isset($data['idCupos']))
            {   
                $stm = $this->db->prepare("CALL SP_CUPOS_Upd(:idCupos,:fecha,:cantidadActual,:idPaquete)");
                $stm->bindParam(':idCupos', $data['idCupos']);
                $stm->bindParam(':fecha', $data['fecha']);
                $stm->bindParam(':cantidadActual', $data['cantidadActual']);
                $stm->bindParam(':idPaquete', $data['idPaquete']);
                $stm->execute();

               
            }
            else
            {   
                $stm = $this->db->prepare("CALL SP_CUPOS_Ins(:fecha,:cantidadActual,:idPaquete)");
                $stm->bindParam(':fecha', $data['fecha']);
                $stm->bindParam(':cantidadActual', $data['cantidadActual']);
                $stm->bindParam(':idPaquete', $data['idPaquete']);
                $stm->execute();
               
            }
            
			$this->response->setResponse(true);
            return $this->response;
		}catch (Exception $e) 
		{
            $this->response->setResponse(false, $e->getMessage());
		}
    }
    
    public function Delete($idCupos)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_CUPOS_Del(:idCupos)");
            $stm->bindParam(':idCupos', $idCupos);
            $stm->execute();
			
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }
}