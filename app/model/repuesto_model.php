<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;
use PiramideUploader;

class RepuestoModel
{
    private $db;
    private $table = 'pm_repuesto';
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
			$result = array();

			$stm = $this->db->prepare("CALL SP_REPUESTO_sel()");
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

			$stm = $this->db->prepare("CALL SP_REPUESTO_selxId(:id)");
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
            if(isset($data['id']))
            {   
                $stm = $this->db->prepare("CALL SP_REPUESTO_upd(:nombre,:descripcion,:foto,:fechamodificacion,:id)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':nombre', $data['nombre']);
                $stm->bindParam(':descripcion', $data['descripcion']);
                $stm->bindParam(':foto', $data['foto']);
                $stm->bindParam(':fechamodificacion', $date);
                $stm->bindParam(':id', $data['id']);
                $stm->execute();

               
            }
            else
            {   
                $stm = $this->db->prepare("CALL SP_REPUESTO_ins(:nombre,:descripcion,:foto,:fechacreacion,:fechamodificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':nombre', $data['nombre']);
                $stm->bindParam(':descripcion', $data['descripcion']);
                $stm->bindParam(':foto', $data['foto']);
                $stm->bindParam(':fechacreacion', $date);
                $stm->bindParam(':fechamodificacion', $date);
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
            $stm = $this->db->prepare("CALL SP_REPUESTO_del(:id)");
            $stm->bindParam(':id', $id);
            $stm->execute();
			
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }

    public function uploadFile()
    {
        try 
        { 
            if(isset($_FILES['uploads'])){
                //var_dump($_FILES['uploads']);
                $piramideUploader = new PiramideUploader();

                $upload = $piramideUploader->upload('repuesto', 'uploads', '../uploads/foto-repuestos', array('image/jpeg', 'image/png', 'image/gif'));
                $file = $piramideUploader->getInfoFile();
                $file_name = $file['complete_name'];

                //var_dump($file);

            }
           if(isset($upload) && $upload["uploaded"] == false){
                $this->response->setResponse(false, "Ocurrió un error al subir el archivo");
                //$this->response->result = $result;
                return $this->response;
            }else{
                //$result =
                $this->response->setResponse(true);
                //$this->response->result = array('filename'=>$file_name); 
                $this->response->result = $file_name; 
                //$this->response->result = array(array('filename'=>$file_name)); 
                return $this->response;
            }
        } catch (Exception $e) 
        {
            $this->response->setResponse(false, $e->getMessage());
        }
    }
}