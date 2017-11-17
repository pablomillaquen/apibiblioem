<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;
use PiramideUploader;

/**
 * @SWG\Definition(type="object")
 */
class ModeloModel
{
    private $db;
    private $table = 'pm_modelo';
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

			$stm = $this->db->prepare("CALL SP_MODELO_sel()");
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

			$stm = $this->db->prepare("CALL SP_MODELO_sel1(:id)");
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
                $stm = $this->db->prepare("CALL SP_MODELO_upd(:nombre,:idTipo,:idMarca,:foto,:FechaModificacion,:id)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':id', $data['id']);
                $stm->bindParam(':nombre', $data['nombre']);
                $stm->bindParam(':idTipo', $data['idTipo']);
                $stm->bindParam(':idMarca', $data['idMarca']);
                $stm->bindParam(':foto', $data['foto']);
                $stm->bindParam(':FechaModificacion', $date);
                $stm->execute();
                $this->response->setResponse(true);
                
                return $this->response;

               
            }
            else
            {   
                
                $stm = $this->db->prepare("CALL SP_MODELO_Ins(:nombre,:idTipo,:idMarca,:foto,:FechaCreacion,:FechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':nombre', $data['nombre']);
                $stm->bindParam(':idTipo', $data['idTipo']);
                $stm->bindParam(':idMarca', $data['idMarca']);
                $stm->bindParam(':foto', $data['foto']);
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
            $stm = $this->db->prepare("CALL SP_MODELO_del(:id)");
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

                $upload = $piramideUploader->upload('image', 'uploads', '../uploads/fotos', array('image/jpeg', 'image/png', 'image/gif'));
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


    public function GetAllDropdown()
    {
        try
        {
            $result = array();

            $stm = $this->db->prepare("CALL SP_MODELO_seldrop()");
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