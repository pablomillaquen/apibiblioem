<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

/**
 * @SWG\Definition(type="object")
 */
class MarkModel
{
    private $db;
    private $table = 'pm_marca';
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

			$stm = $this->db->prepare("CALL SP_MARCA_sel()");
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

			$stm = $this->db->prepare("CALL SP_MARCA_sel1(:id)");
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
                $stm = $this->db->prepare("CALL SP_MARCA_upd(:id,:nombre,:fechamodificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':id', $data['id']);
                $stm->bindParam(':nombre', $data['nombre']);
                $stm->bindParam(':fechamodificacion', $date);
                $stm->execute();

               
            }
            else
            {   
                $stm = $this->db->prepare("CALL SP_MARCA_ins(:nombre,:fechacreacion,:fechamodificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':nombre', $data['nombre']);
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
            $stm = $this->db->prepare("CALL SP_MARCA_del(:id)");
            $stm->bindParam(':id', $id);
            $stm->execute();
			
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }
}