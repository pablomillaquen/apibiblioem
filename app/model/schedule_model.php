<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class ScheduleModel
{
    private $db;
    private $table = 'PM_Horario';
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

			$stm = $this->db->prepare("CALL SP_HORARIO_Lista(:l,:p)");
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
    
    public function Get($idHorario)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("CALL SP_HORARIO_Sel(:id)");
			$stm->bindParam(':id', $idHorario);
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
            if(isset($data['idHorario']))
            {   
                $stm = $this->db->prepare("CALL SP_HORARIO_Upd(:idHorario,:dia,:desde,:hasta,:idPaquete,:fechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':idHorario', $data['idHorario']);
                $stm->bindParam(':dia', $data['dia']);
                $stm->bindParam(':desde', $data['desde']);
                $stm->bindParam(':hasta', $data['hasta']);
                $stm->bindParam(':idPaquete', $data['idPaquete']);
                $stm->bindParam(':fechaModificacion', $date);
                $stm->execute();

               
            }
            else
            {   
                $stm = $this->db->prepare("CALL SP_HORARIO_Ins(:dia,:desde,:hasta,:idPaquete,:fechaCreacion,:fechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':dia', $data['dia']);
                $stm->bindParam(':desde', $data['desde']);
                $stm->bindParam(':hasta', $data['hasta']);
                $stm->bindParam(':idPaquete', $data['idPaquete']);
                $stm->bindParam(':fechaCreacion', $date);
                $stm->bindParam(':fechaModificacion', $date);
                $stm->execute();
               
            }
            
			$this->response->setResponse(true);
            return $this->response;
		}catch (Exception $e) 
		{
            $this->response->setResponse(false, $e->getMessage());
		}
    }
    
    public function Delete($idHorario)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_HORARIO_Del(:idHorario)");
            $stm->bindParam(':idHorario', $idHorario);
            $stm->execute();
			
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }
}