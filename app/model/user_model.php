<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class UserModel
{
    private $db;
    private $table = 'PM_USUario';
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

			//$stm = $this->db->prepare("SELECT * FROM $this->table");
            $stm = $this->db->prepare("CALL SP_USUARIO_Lista(:l,:p)");
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
    
    public function Get($idUsuario)
    {
		try
		{
			$result = array();

			//$stm = $this->db->prepare("SELECT * FROM $this->table WHERE EMP_id = ?");
            $stm = $this->db->prepare("CALL SP_USUARIO_Sel(:id)");
			$stm->bindParam(':id', $idUsuario);
            //$stm->bindParam($idEmpleado);
            //$stm->execute(array($id));
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
            if(isset($data['idUsuario']))
            {   
                $date = date('Y-m-d H:i:s');
                $stm = $this->db->prepare("CALL SP_USUARIO_Upd(:idUsuario,:token,:expires_at)");
                $stm->bindParam(':idUsuario', $data['idUsuario']);
                $stm->bindParam(':token', $data['token']);
                $stm->bindParam(':expires_at', $data['expires_at']);
                $stm->bindParam(':fechacreacion', $date);
                
                $stm->execute();

                //$sql = "UPDATE $this->table SET 
                //            Nombre          = ?, 
                //            Apellido        = ?,
                //            Correo          = ?,
                //            Sexo            = ?,
                //            Sueldo          = ?,
                //            Profesion_id    = ?,
                //            FechaNacimiento = ?
                //        WHERE id = ?";
                //
                //$this->db->prepare($sql)
                //     ->execute(
                //        array(
                //            $data['Nombre'], 
                //            $data['Apellido'],
                //            $data['Correo'],
                //            $data['Sexo'],
                //            $data['Sueldo'],
                //            $data['Profesion_id'],
                //            $data['FechaNacimiento'],
                //            $data['id']
                //        )
                //    );
            }
            else
            {   
                $date = date('Y-m-d H:i:s');
                $stm = $this->db->prepare("CALL SP_USUARIO_Ins(:idUsuario,:token,:expires_at)");
                $stm->bindParam(':idUsuario', $data['idUsuario']);
                $stm->bindParam(':token', $data['token']);
                $stm->bindParam(':expires_at', $data['expires_at']);
                $stm->bindParam(':fechacreacion', $date);
                $stm->execute();
                //$sql = "INSERT INTO $this->table
                //            (Nombre, Apellido, Correo, Sexo, Sueldo, Profesion_id, FechaNacimiento, FechaRegistro)
                //            VALUES (?,?,?,?,?,?,?,?)";
                //
                //$this->db->prepare($sql)
                //     ->execute(
                //        array(
                //            $data['Nombre'], 
                //            $data['Apellido'],
                //            $data['Correo'],
                //            $data['Sexo'],
                //            $data['Sueldo'],
                //            $data['Profesion_id'],
                //            $data['FechaNacimiento'],
                //            date('Y-m-d')
                //        )
                //    ); 
            }
            
			$this->response->setResponse(true);
            return $this->response;
		}catch (Exception $e) 
		{
            $this->response->setResponse(false, $e->getMessage());
		}
    }
    
    public function Delete($idUsuario)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_USUARIO_Del(:idUsuario)");
            $stm->bindParam(':idUsuario', $idUsuario);
            $stm->execute();
			//$stm = $this->db
			//            ->prepare("DELETE FROM $this->table WHERE EMP_id = ?");			          

			//$stm->execute(array($id));
            
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }
}