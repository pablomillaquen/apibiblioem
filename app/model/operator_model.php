<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class OperatorModel
{
    private $db;
    private $table = 'PM_OPErador';
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

			$stm = $this->db->prepare("CALL SP_OPERADOR_Lista(:l,:p)");
            $stm->bindParam(':l', $l);
            $stm->bindParam(':p', $p);
			$stm->execute();
            
            $data = $stm->fetchAll();
            unset($stm);

            $stm = $this->db->prepare("CALL SP_OPERADOR_Count");
            $stm->execute();
            $total = $stm->fetch();
            
            
            return [
                'data'  => $data,
                'total' => $total->total
            ];
			// $this->response->setResponse(true);
   //          $this->response->result = $stm->fetchAll();
            
   //          return $this->response;
		}
		catch(Exception $e)
		{
			$this->response->setResponse(false, $e->getMessage());
            return $this->response;
		}
    }
    
    public function Get($idOperador)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("CALL SP_OPERADOR_Sel(:id)");
			$stm->bindParam(':id', $idOperador);
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
            if(isset($data['idOperador']))
            {   
                $stm = $this->db->prepare("CALL SP_OPERADOR_Upd(:idOperador,:Nombre,:Rut,:Direccion,:NumContacto,:SitioWeb,:fechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':idOperador', $data['idOperador']);
                $stm->bindParam(':Nombre', $data['Nombre']);
                $stm->bindParam(':Rut', $data['Rut']);
                $stm->bindParam(':Direccion', $data['Direccion']);
                $stm->bindParam(':NumContacto', $data['NumContacto']);
                $stm->bindParam(':SitioWeb', $data['SitioWeb']);
                $stm->bindParam(':fechaModificacion', $date);
                $stm->execute();

               
            }
            else
            {   
                $stm = $this->db->prepare("CALL SP_OPERADOR_Ins(:Nombre,:Rut,:Direccion,:NumContacto,:SitioWeb,:fechaCreacion,:fechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':Nombre', $data['Nombre']);
                $stm->bindParam(':Rut', $data['Rut']);
                $stm->bindParam(':Direccion', $data['Direccion']);
                $stm->bindParam(':NumContacto', $data['NumContacto']);
                $stm->bindParam(':SitioWeb', $data['SitioWeb']);
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
    
    public function Delete($idOperador)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_OPERADOR_Del(:idOperador)");
            $stm->bindParam(':idOperador', $idOperador);
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

            $stm = $this->db->prepare("CALL SP_OPERADOR_ListaCompleta()");
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