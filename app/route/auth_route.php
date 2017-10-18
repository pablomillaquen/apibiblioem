<?php
use App\Model\AuthModel;
use App\Model\AuthClienteModel;

$app->group('/v1', function () use ($app){
  $app->group('/admin', function () use ($app){
    $app->group('/auth/', function () use ($app){
        
        $this->post('autenticar', function ($req, $res, $args) {
          $um = new AuthModel();
          $parametros = $req->getParsedBody();

            return $res->withHeader('Content-type', 'application/json')
                       ->write(
                          json_encode($um->Autenticar($parametros['email'],$parametros['pass']))
                        );
        });
        
    });
  });
  
  
});