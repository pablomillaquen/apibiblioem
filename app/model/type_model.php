<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

/**
 * @SWG\Definition(type="object")
 */
class TypeModel
{
    private $db;
    private $table = 'pm_tipoequipo';
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

			$stm = $this->db->prepare("CALL SP_TIPOEQUIPO_sel()");
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

			$stm = $this->db->prepare("CALL SP_TIPOEQUIPO_sel1(:id)");
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
                $stm = $this->db->prepare("CALL SP_TIPOEQUIPO_upd(:nombre,:fechamodificacion,:id)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':id', $data['id']);
                $stm->bindParam(':nombre', $data['nombre']);
                $stm->bindParam(':fechamodificacion', $date);
                $stm->execute();

               
            }
            else
            {   
                $stm = $this->db->prepare("CALL SP_TIPOEQUIPO_ins(:nombre,:fechaCreacion,:fechamodificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':nombre', $data['nombre']);
                $stm->bindParam(':fechaCreacion', $date);
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
            $stm = $this->db->prepare("CALL SP_TIPOEQUIPO_del(:id)");
            $stm->bindParam(':id', $id);
            $stm->execute();
			
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }

    //  public function GetDropdown()
    // {
    //     try
    //     {
    //         $result = array();

    //         $stm = $this->db->prepare("CALL SP_TIPOEQUIPO_ListaCompleta()");
    //         $stm->execute();

    //         $this->response->setResponse(true);
    //         $this->response->result = $stm->fetchAll();
            
    //         return $this->response;
    //     }
    //     catch(Exception $e)
    //     {
    //         $this->response->setResponse(false, $e->getMessage());
    //         return $this->response;
    //     }  
    // }
}