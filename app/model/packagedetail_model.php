<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class PackageDetailModel
{
    private $db;
    private $table = 'PM_DEtallePaquete';
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

			$stm = $this->db->prepare("CALL SP_DETALLEPAQUETE_Lista(:l,:p)");
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
    
    public function Get($idDetallePaquete)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("CALL SP_DETALLEPAQUETE_Sel(:id)");
			$stm->bindParam(':id', $idDetallePaquete);
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
            if(isset($data['idDetallePaquete']))
            {   
                $stm = $this->db->prepare("CALL SP_DETALLEPAQUETE_Upd(:idDetallePaquete,:Nombre,:NombreEN,:idPaquete,:PrecioPesos,:PrecioDolares,:fechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':idDetallePaquete', $data['idDetallePaquete']);
                $stm->bindParam(':Nombre', $data['Nombre']);
                $stm->bindParam(':NombreEN', $data['NombreEN']);
                $stm->bindParam(':idPaquete', $data['idPaquete']);
                $stm->bindParam(':PrecioPesos', $data['PrecioPesos']);
                $stm->bindParam(':PrecioDolares', $data['PrecioDolares']);
                $stm->bindParam(':fechaModificacion', $date);
                $stm->execute();

               
            }
            else
            {   
                $stm = $this->db->prepare("CALL SP_DETALLEPAQUETE_Ins(:Nombre,:NombreEN,:idPaquete,:PrecioPesos,:PrecioDolares,:fechaCreacion,:fechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':Nombre', $data['Nombre']);
                $stm->bindParam(':NombreEN', $data['NombreEN']);
                $stm->bindParam(':idPaquete', $data['idPaquete']);
                $stm->bindParam(':PrecioPesos', $data['PrecioPesos']);
                $stm->bindParam(':PrecioDolares', $data['PrecioDolares']);
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
    
    public function Delete($idDetallePaquete)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_DETALLEPAQUETE_Del(:idDetallePaquete)");
            $stm->bindParam(':IdDetallePaquete', $idDetallePaquete);
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

            $stm = $this->db->prepare("CALL SP_DETALLEPAQUETE_ListaxPaquete(:id)");
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