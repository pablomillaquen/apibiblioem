<?php
use App\Model\RepuestoModel;
use App\Lib\Auth;
use App\Lib\AuthCliente;
use App\Middleware\AuthMiddleware;
use App\Middleware\AuthClienteMiddleware;

$app->group('/v1', function () use ($app){
  $app->group('/admin', function () use ($app){
    $app->group('/repuesto/', function ()  use ($app){
        
        $this->get('test', function ($req, $res, $args) {
            return $res->getBody()
                       ->write('Hello desde employee');
        });
        
        $this->get('getAll/', function ($req, $res, $args) {
            $um = new RepuestoModel();
            
            return $res
               ->withHeader('Content-type', 'application/json')
               ->getBody()
               ->write(
                json_encode(
                    $um->GetAll()
                )
            );
        });
        
        $this->get('get/{id}', function ($req, $res, $args) {
            $um = new RepuestoModel();
            
            return $res
               ->withHeader('Content-type', 'application/json')
               ->getBody()
               ->write(
                json_encode(
                    $um->Get($args['id'])
                )
            );
        });
        $this->get('getxmod/{id}', function ($req, $res, $args) {
          $um = new RepuestoModel();
          
          return $res
             ->withHeader('Content-type', 'application/json')
             ->getBody()
             ->write(
              json_encode(
                  $um->GetxMod($args['id'])
              )
          );
      });
        
        $this->post('save', function ($req, $res) {
            $um = new RepuestoModel();
            
            return $res
               ->withHeader('Content-type', 'application/json')
               ->getBody()
               ->write(
                json_encode(
                    $um->InsertOrUpdate(
                        $req->getParsedBody()
                    )
                )
            );
        });

        $this->post('savexmod', function ($req, $res) {
            $um = new RepuestoModel();
            
            return $res
               ->withHeader('Content-type', 'application/json')
               ->getBody()
               ->write(
                json_encode(
                    $um->InsertOrUpdatexmod(
                        $req->getParsedBody()
                    )
                )
            );
        });

        $this->post('delete/{id}', function ($req, $res, $args) {
            $um = new RepuestoModel();
            
            return $res
               ->withHeader('Content-type', 'application/json')
               ->getBody()
               ->write(
                json_encode(
                    $um->Delete($args['id'])
                )
            );
        });

        $this->post('deletexmod/{id}/{idRepuesto}', function ($req, $res, $args) {
            $um = new RepuestoModel();
            
            return $res
               ->withHeader('Content-type', 'application/json')
               ->getBody()
               ->write(
                json_encode(
                    $um->Deletexmod($args['id'],$args['idRepuesto'])
                )
            );
        });
        
    });
  })->add(new AuthMiddleware($app));
  
  $app->group('/user', function () use ($app){
    $app->group('/repuesto/', function ()  use ($app){
        
        $this->get('getxmod/{id}', function ($req, $res, $args) {
          $um = new RepuestoModel();
          
          return $res
             ->withHeader('Content-type', 'application/json')
             ->getBody()
             ->write(
              json_encode(
                  $um->GetxMod($args['id'])
              )
          );
      });

           $this->post('upload-file', function ($req, $res) {
          $um = new RepuestoModel();
          
          return $res
             ->withHeader('Content-type', 'application/json')
             ->getBody()
             ->write(
              json_encode(
                  $um->uploadFile(
                      $req->getParsedBody()
                  )
              )
          );
      });
        
    });
  });
});