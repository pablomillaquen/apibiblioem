<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;
use PiramideUploader;

/**
 * @SWG\Definition(type="object")
 */
class ProtocoloModel
{
    private $db;
    private $table = 'pm_protocolo';
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

			$stm = $this->db->prepare("CALL SP_PROTOCOLO_sel()");
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

			$stm = $this->db->prepare("CALL SP_PROTOCOLO_sel1(:id)");
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

    public function GetxMod($id)
    {
        try
        {
            $result = array();

            $stm = $this->db->prepare("CALL SP_PROTOCOLO_selxmodelo(:id)");
            $stm->bindParam(':id', $id);
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
    
    public function InsertOrUpdate($data)
    {
		try 
		{   
            
             if(isset($data['id']))
            {   
                $stm = $this->db->prepare("CALL SP_PROTOCOLO_upd(:nombre,:url,:idModelo,:FechaModificacion,:id)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':nombre', $data['nombre']);
                $stm->bindParam(':url', $data['url']);
                $stm->bindParam(':idModelo', $data['idModelo']);
                $stm->bindParam(':FechaModificacion', $date);
                $stm->bindParam(':id', $data['id']);
                $stm->execute();
                $this->response->setResponse(true);
                
                return $this->response;

               
            }
            else
            {   
                
                $stm = $this->db->prepare("CALL SP_PROTOCOLO_ins(:nombre,:url,:idModelo,:FechaCreacion,:FechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':nombre', $data['nombre']);
                $stm->bindParam(':url', $data['url']);
                $stm->bindParam(':idModelo', $data['idModelo']);
                $stm->bindParam(':FechaCreacion', $date);
                $stm->bindParam(':FechaModificacion', $date);
                $stm->execute();
                $this->response->setResponse(true);
                
                return $this->response;
               
            }
            
            
		}catch (Exception $e) 
		{
            $this->response->setResponse(false, $e->getMessage());
		}
    }
    
    public function Delete($id)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_PROTOCOLO_del(:id)");
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

                $upload = $piramideUploader->upload('protocolo', 'uploads', '../uploads/protocolos', array('application/msword', 'application/excel', 'application/pdf','application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'));
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