<?php
use App\Model\ImageModel;
use App\Lib\Auth;
use App\Lib\AuthCliente;
use App\Middleware\AuthMiddleware;
use App\Middleware\AuthClienteMiddleware;

$app->group('/v1', function () use ($app){
  $app->group('/admin', function () use ($app){
    $app->group('/image/', function ()  use ($app){
        
        $this->get('getAll/{l}/{p}', function ($req, $res, $args) {
            $um = new ImageModel();
            
            return $res
               ->withHeader('Content-type', 'application/json')
               ->getBody()
               ->write(
                json_encode(
                    $um->GetAll($args['l'],$args['p'])
                )
            );
        });
        
        $this->get('get/{id}', function ($req, $res, $args) {
            $um = new ImageModel();
            
            return $res
               ->withHeader('Content-type', 'application/json')
               ->getBody()
               ->write(
                json_encode(
                    $um->Get($args['id'])
                )
            );
        });
        
        $this->post('save', function ($req, $res) {
            $um = new ImageModel();
            
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
        
        $this->delete('delete/{id}', function ($req, $res, $args) {
            $um = new ImageModel();
            
            return $res
               ->withHeader('Content-type', 'application/json')
               ->getBody()
               ->write(
                json_encode(
                    $um->Delete($args['id'])
                )
            );
        });

        $this->get('getxPaq/{id}', function ($req, $res, $args) {
            $um = new ImageModel();
            
            return $res
               ->withHeader('Content-type', 'application/json')
               ->getBody()
               ->write(
                json_encode(
                    $um->GetxPaq($args['id'])
                )
            );
        });
        
    });
  })->add(new AuthMiddleware($app));
});