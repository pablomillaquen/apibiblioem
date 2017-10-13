<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;
use PiramideUploader;

class ModRepModel
{
    private $db;
    private $table = 'pm_mod_rep';
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

            $stm = $this->db->prepare("CALL SP_MOD_REP_sel()");
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

            $stm = $this->db->prepare("CALL SP_MOD_REP_sel1(:id)");
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

            $stm = $this->db->prepare("CALL SP_MOD_REP_selxmodelo(:id)");
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
                $stm = $this->db->prepare("CALL SP_MOD_REP_upd(:idModeloorg,:idRepuestoorg,:idModelocamb,:idRepuestocamb,:FechaModificacion,:id)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':idModeloorg', $data['idModeloorg']);
                $stm->bindParam(':idRepuestoorg', $data['idRepuestoorg']);
                $stm->bindParam(':idModelocamb', $data['idModelocamb']);
                $stm->bindParam(':idRepuestocamb', $data['idRepuestocamb']);
                $stm->bindParam(':FechaModificacion', $date);
                $stm->bindParam(':id', $data['id']);
                $stm->execute();
                $this->response->setResponse(true);
                
                return $this->response;

               
            }
            else
            {   
                
                $stm = $this->db->prepare("CALL SP_MOD_REP_ins(:idModeloorg,:idRepuestoorg,:idModelocamb,:idRepuestocamb,:FechaCreacion,:FechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':idModeloorg', $data['idModeloorg']);
                $stm->bindParam(':idRepuestoorg', $data['idRepuestoorg']);
                $stm->bindParam(':idModelocamb', $data['idModelocamb']);
                $stm->bindParam(':idRepuestocamb', $data['idRepuestocamb']);
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
    
    public function Delete($data)
    {
        try 
        {
            $stm = $this->db->prepare("CALL SP_MOD_REP_del(:idModelo, :idRepuesto)");
            $stm->bindParam(':idModelo', $data['idModelo']);
            $stm->bindParam(':idRepuesto', $data['idRepuesto']);
            $stm->execute();
            
            $this->response->setResponse(true);
            return $this->response;
        } catch (Exception $e) 
        {
            $this->response->setResponse(false, $e->getMessage());
        }
    }

    // public function uploadFile()
    // {
    //     try 
    //     { 
    //         if(isset($_FILES['uploads'])){
    //             //var_dump($_FILES['uploads']);
    //             $piramideUploader = new PiramideUploader();

    //             $upload = $piramideUploader->upload('protocolo', 'uploads', '../uploads/protocolos', array('application/msword', 'application/excel', 'application/pdf','application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'));
    //             $file = $piramideUploader->getInfoFile();
    //             $file_name = $file['complete_name'];

    //             //var_dump($file);

    //         }
    //        if(isset($upload) && $upload["uploaded"] == false){
    //             $this->response->setResponse(false, "Ocurrió un error al subir el archivo");
    //             //$this->response->result = $result;
    //             return $this->response;
    //         }else{
    //             //$result =
    //             $this->response->setResponse(true);
    //             //$this->response->result = array('filename'=>$file_name); 
    //             $this->response->result = $file_name; 
    //             //$this->response->result = array(array('filename'=>$file_name)); 
    //             return $this->response;
    //         }
    //     } catch (Exception $e) 
    //     {
    //         $this->response->setResponse(false, $e->getMessage());
    //     }
    // }
}