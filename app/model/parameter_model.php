<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class ParameterModel
{
    private $db;
    private $table = 'PM_PARametro';
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

			$stm = $this->db->prepare("CALL SP_PARAMETRO_Lista(:l,:p)");
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
    
    public function Get($indice)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("CALL SP_PARAMETRO_Sel(:idParametro)");
			$stm->bindParam(':idParametro', $indice);
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
            if(isset($data['indice']))
            {   
                $stm = $this->db->prepare("CALL SP_PARAMETRO_Upd(:indice,:idParametro,:codigo,:descripcion,:observaciones)");
                
                $stm->bindParam(':indice', $data['indice']);
                $stm->bindParam(':idParametro', $data['idParametro']);
                $stm->bindParam(':codigo', $data['codigo']);
                $stm->bindParam(':descripcion', $data['descripcion']);
                $stm->bindParam(':observaciones', $data['observaciones']);
                $stm->execute();

               
            }
            else
            {   
                $stm = $this->db->prepare("CALL SP_PARAMETRO_Ins(:idParametro,:codigo,:descripcion,:observaciones,:sitioWeb,:fechaCreacion,:fechaModificacion)");
                $stm->bindParam(':idParametro', $data['idParametro']);
                $stm->bindParam(':codigo', $data['codigo']);
                $stm->bindParam(':descripcion', $data['descripcion']);
                $stm->bindParam(':observaciones', $data['observaciones']);
                $stm->execute();
               
            }
            
			$this->response->setResponse(true);
            return $this->response;
		}catch (Exception $e) 
		{
            $this->response->setResponse(false, $e->getMessage());
		}
    }
    
    public function Delete($indice)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_PARAMETRO_Del(:indice)");
            $stm->bindParam(':indice', $indice);
            $stm->execute();
			
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }

    public function GetDropdown($indice)
    {
        try
        {
            $result = array();

            $stm = $this->db->prepare("CALL SP_PARAMETRO_ListaxID(:idParametro)");
            $stm->bindParam(':idParametro', $indice);
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
}