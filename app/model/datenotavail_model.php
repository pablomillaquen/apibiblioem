<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class DatenotavailModel
{
    private $db;
    private $table = 'PM_FechaNoDisp';
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

			$stm = $this->db->prepare("CALL SP_FECHANODISP_Lista(:l,:p)");
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
    
    public function Get($idFecha)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("CALL SP_FECHANODISP_Sel(:id)");
			$stm->bindParam(':id', $idFecha);
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
            if(isset($data['idFecha']))
            {   
                $stm = $this->db->prepare("CALL SP_FECHANODISP_Upd(:idFecha,:Dia,:idPaquete)");
                $stm->bindParam(':idFecha', $data['idFecha']);
                $stm->bindParam(':Dia', $data['Dia']);
                $stm->bindParam(':idPaquete', $data['idPaquete']);
                $stm->execute();

               
            }
            else
            {   
                $stm = $this->db->prepare("CALL SP_FECHANODISP_Ins(:Dia,:idPaquete,:Email,:Acceso,:Usuario,:Pass)");
                $stm->bindParam(':Dia', $data['Dia']);
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
    
    public function Delete($idFecha)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_FECHANODISP_Del(:idFecha)");
            $stm->bindParam(':idFecha', $idFecha);
            $stm->execute();
			
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }
}