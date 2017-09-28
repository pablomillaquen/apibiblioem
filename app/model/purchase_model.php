<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class PurchaseModel
{
    private $db;
    private $table = 'PM_COMpra';
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

			$stm = $this->db->prepare("CALL SP_COMPRA_Lista(:l,:p)");
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
    
    public function Get($idCompra)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("CALL SP_COMPRA_Sel(:id)");
			$stm->bindParam(':id', $idCompra);
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
            if(isset($data['idCompra']))
            {   
                $stm = $this->db->prepare("CALL SP_COMPRA_Upd(:idCompra,:idHorario,:idUsuario,:cantidad,:valorTotal,:fechaCompra)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':idCompra', $data['idCompra']);
                $stm->bindParam(':idHorario', $data['idHorario']);
                $stm->bindParam(':idUsuario', $data['idUsuario']);
                $stm->bindParam(':cantidad', $data['cantidad']);
                $stm->bindParam(':valorTotal', $data['valorTotal']);
                $stm->bindParam(':fechaCompra', $date);
                $stm->execute();

               
            }
            else
            {   
                $stm = $this->db->prepare("CALL SP_COMPRA_Ins(:idHorario,:idUsuario,:cantidad,:valorTotal,:fechaCompra)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':idHorario', $data['idHorario']);
                $stm->bindParam(':idUsuario', $data['idUsuario']);
                $stm->bindParam(':cantidad', $data['cantidad']);
                $stm->bindParam(':valorTotal', $data['valorTotal']);
                $stm->bindParam(':fechaCompra', $date);
                $stm->execute();
               
            }
            
			$this->response->setResponse(true);
            return $this->response;
		}catch (Exception $e) 
		{
            $this->response->setResponse(false, $e->getMessage());
		}
    }
    
    public function Delete($idCompra)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_COMPRA_Del(:idCompra)");
            $stm->bindParam(':idCompra', $idCompra);
            $stm->execute();
			
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }
}