<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class TypeModel
{
    private $db;
    private $table = 'PM_TIPopaquete';
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

			$stm = $this->db->prepare("CALL SP_TIPO_Lista(:l,:p)");
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
    
    public function Get($idTipo)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("CALL SP_TIPO_Sel(:id)");
			$stm->bindParam(':id', $idTipo);
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
            if(isset($data['idTipo']))
            {   
                $stm = $this->db->prepare("CALL SP_TIPO_Upd(:idTipo,:NombreEs,:NombreEn,:fechaCreacion,:fechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':idTipo', $data['idTipo']);
                $stm->bindParam(':NombreEs', $data['NombreEs']);
                $stm->bindParam(':NombreEn', $data['NombreEn']);
                $stm->bindParam(':fechaModificacion', $date);
                $stm->execute();

               
            }
            else
            {   
                $stm = $this->db->prepare("CALL SP_TIPO_Ins(:NombreEs,:NombreEn,:fechaCreacion,:fechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':NombreEs', $data['NombreEs']);
                $stm->bindParam(':NombreEn', $data['NombreEn']);
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
    
    public function Delete($idTipo)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_TIPO_Del(:idTipo)");
            $stm->bindParam(':idTipo', $idTipo);
            $stm->execute();
			
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }

     public function GetDropdown()
    {
        try
        {
            $result = array();

            $stm = $this->db->prepare("CALL SP_TIPO_ListaCompleta()");
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