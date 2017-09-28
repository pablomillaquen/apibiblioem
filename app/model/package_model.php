<?php
namespace App\Model;

use App\Lib\Database;
use App\Lib\Response;

class PackageModel
{
    private $db;
    private $table = 'PM_PAQuete';
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

			$stm = $this->db->prepare("CALL SP_PAQUETE_Lista(:l,:p)");
            $stm->bindParam(':l', $l);
            $stm->bindParam(':p', $p);
			$stm->execute();
            $data = $stm->fetchAll();
            unset($stm);

            $stm = $this->db->prepare("CALL SP_PAQUETE_Count");
            $stm->execute();
            $total = $stm->fetch();
            
            
            return [
                'data'  => $data,
                'total' => $total->total
            ];
			// $this->response->setResponse(true);
   //          $this->response->result = $stm->fetchAll();
            
   //          return $this->response;
		}
		catch(Exception $e)
		{
			$this->response->setResponse(false, $e->getMessage());
            return $this->response;
		}
    }
    
    public function Get($idPaquete)
    {
		try
		{
			$result = array();

			$stm = $this->db->prepare("CALL SP_PAQUETE_Sel(:id)");
			$stm->bindParam(':id', $idPaquete);
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
            
             if(isset($data['idPaquete']))
            {   
                $stm = $this->db->prepare("CALL SP_PAQUETE_Upd(:idPaquete,:NombreEs,:NombreEn,:LugarSalidaEs,:LugarSalidaEn,:PrecioPesos,:PrecioDolares,:DetalleEs,:DetalleEn,:idOperador,:idTipoTour,:idCiudad,:ObservacionesEs,:ObservacionesEn,:Latitud,:Longitud,:Cupos,:FechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':idPaquete', $data['idPaquete']);
                $stm->bindParam(':NombreEs', $data['NombreEs']);
                $stm->bindParam(':NombreEn', $data['NombreEn']);
                $stm->bindParam(':LugarSalidaEs', $data['LugarSalidaEs']);
                $stm->bindParam(':LugarSalidaEn', $data['LugarSalidaEn']);
                $stm->bindParam(':PrecioPesos', $data['PrecioPesos']);
                $stm->bindParam(':PrecioDolares', $data['PrecioDolares']);
                $stm->bindParam(':DetalleEs', $data['DetalleEs']);
                $stm->bindParam(':DetalleEn', $data['DetalleEn']);
                $stm->bindParam(':idOperador', $data['idOperador']);
                $stm->bindParam(':idTipoTour', $data['idTipoTour']);
                $stm->bindParam(':idCiudad', $data['idCiudad']);
                $stm->bindParam(':ObservacionesEs', $data['ObservacionesEs']);
                $stm->bindParam(':ObservacionesEn', $data['ObservacionesEn']);
                $stm->bindParam(':Latitud', $data['Latitud']);
                $stm->bindParam(':Longitud', $data['Longitud']);
                $stm->bindParam(':Cupos', $data['Cupos']);
                $stm->bindParam(':FechaModificacion', $date);
                $stm->execute();
                $this->response->setResponse(true);
                
                return $this->response;

               
            }
            else
            {   

                $stm = $this->db->prepare("CALL SP_PAQUETE_Ins(:NombreEs,:NombreEn,:LugarSalidaEs,:LugarSalidaEn,:PrecioPesos,:PrecioDolares,:DetalleEs,:DetalleEn,:idOperador,:idTipoTour,:idCiudad,:ObservacionesEs,:ObservacionesEn,:Latitud,:Longitud,:Cupos,:FechaCreacion,:FechaModificacion)");
                $date = date('Y-m-d H:i:s');
                $stm->bindParam(':NombreEs', $data['NombreEs']);
                $stm->bindParam(':NombreEn', $data['NombreEn']);
                $stm->bindParam(':LugarSalidaEs', $data['LugarSalidaEs']);
                $stm->bindParam(':LugarSalidaEn', $data['LugarSalidaEn']);
                $stm->bindParam(':PrecioPesos', $data['PrecioPesos']);
                $stm->bindParam(':PrecioDolares', $data['PrecioDolares']);
                $stm->bindParam(':DetalleEs', $data['DetalleEs']);
                $stm->bindParam(':DetalleEn', $data['DetalleEn']);
                $stm->bindParam(':idOperador', $data['idOperador']);
                $stm->bindParam(':idTipoTour', $data['idTipoTour']);
                $stm->bindParam(':idCiudad', $data['idCiudad']);
                $stm->bindParam(':ObservacionesEs', $data['ObservacionesEs']);
                $stm->bindParam(':ObservacionesEn', $data['ObservacionesEn']);
                $stm->bindParam(':Latitud', $data['Latitud']);
                $stm->bindParam(':Longitud', $data['Longitud']);
                $stm->bindParam(':Cupos', $data['Cupos']);
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
    
    public function Delete($idPaquete)
    {
		try 
		{
            $stm = $this->db->prepare("CALL SP_PAQUETE_Del(:idPaquete)");
            $stm->bindParam(':idPaquete', $idPaquete);
            $stm->execute();
			
			$this->response->setResponse(true);
            return $this->response;
		} catch (Exception $e) 
		{
			$this->response->setResponse(false, $e->getMessage());
		}
    }

    public function getPackages($data)
    {
        try 
        {   
               
                // $stm = $this->db->prepare("CALL SP_PAQUETE_Seleccion(:ciudades,:intereses,:presupuesto)");
                // $stm->bindParam(':ciudades', $data['ciudades']);
                // $stm->bindParam(':intereses', $data['intereses']);
                // $stm->bindParam(':presupuesto', $data['presupuesto']);
                // $stm->execute();
                // $this->response->setResponse(true);
                // $this->response->result = $stm->fetchAll();
                // $listaPaquetes = $stm->fetchAll();
                $stm = $this->db->prepare("CALL SP_PAQUETE_Seleccion(:ciudades,:intereses,:presupuesto)");
                $stm->bindParam(':ciudades', $data['ciudades']);
                $stm->bindParam(':intereses', $data['intereses']);
                $stm->bindParam(':presupuesto', $data['presupuesto']);
                $stm->execute();
                $data = $stm->fetchAll();
                unset($stm);
                //print_r($data);
               
                $stm = $this->db->prepare("CALL SP_IMAGENES_ListaCompleta");
                
                $stm->execute();
                $imagenes = $stm->fetchAll();
                //print_r($imagenes);
                
                $res = [];
                $tres=[];
                $cuatro =[];
                $resultado = [];
                //LOOP UNO
                foreach($data as $unos){
                    //valor inicial
                    $arraypq =  (array) $unos;
                    $tres = $arraypq;
                    foreach($unos as $lista=>$ide){
                        //LOOP DOS
                        $i= 1;
                        foreach ($imagenes as $d){
                            $arrayimg =  (array) $d;
                            foreach($arrayimg as $lista2=>$ides){
                            //Si las condiciones se cumplen
                                if($lista=="PAQ_id" && $lista2=="PAQ_id" && $ide === $ides){
                                    //se obtiene el valor a unir
                                    $res = array_slice($arrayimg, 1,1);
                                    //var_dump($arrayimg);
                                    //Se le cambia el nombre
                                    $n["IMA_imagen_".$i] = $res["IMA_Nombre"];
                                    //Se une al valor actual de $tres
                                    $tres = array_merge($tres,$n);
                                    //Se aumenta el valor de $i
                                    unset($n);
                                    unset($res["IMA_Nombre"]);
                                    $i++;
                                };
                            }
                        }
                        //FIN LOOP DOS
                    }

                    //$tres = array_map('utf8_encode', $tres);
                    array_push($cuatro, $tres);
                }

                //print_r($cuatro);
                // echo "<pre>";
                // echo json_encode($cuatro, JSON_PRETTY_PRINT);
                // echo "</pre>";
                // //FIN LOOP UNO

                return [
                    'data'  => $cuatro
                ];
                
               

            
            
            
        }catch (Exception $e) 
        {
            $this->response->setResponse(false, $e->getMessage());
        }
    }
}