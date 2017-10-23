<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

/**
 * @SWG\Definition(type="object")
 */
class ImageModel
{
    private $db;
    private $table = 'PM_IMAgenes';
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

			$stm = $this->db->prepare("CALL SP_IMAGENES_Lista(:l,:p)");
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
    
    public function Get($idImagen)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("CALL SP_IMAGENES_Sel(:id)");
			$stm->bindParam(':id', $idImagen);
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
            if(isset($data['idImagen']))
            {   
                $stm = $this->db->prepare("CALL SP_IMAGENES_Upd(:idImagen,:Nombre,:idPaquete,:fechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':idImagen', $data['idImagen']);
                $stm->bindParam(':Nombre', $data['Nombre']);
                $stm->bindParam(':idPaquete', $data['idPaquete']);
                $stm->bindParam(':fechaModificacion', $date);
                $stm->execute();

               
            }
            else
            {   
                $stm = $this->db->prepare("CALL SP_IMAGENES_Ins(:Nombre,:idPaquete,:fechaCreacion,:fechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':Nombre', $data['Nombre']);
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
    
    public function Delete($IdImagen)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_IMAGENES_Del(:IdImagen)");
            $stm->bindParam(':IdImagen', $IdImagen);
            $stm->execute();
			
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }

     public function GetxPaq($idPaquete)
    {
        try
        {
            $result = array();

            $stm = $this->db->prepare("CALL SP_IMAGENES_ListaxPaquete(:id)");
            $stm->bindParam(':id', $idPaquete);
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