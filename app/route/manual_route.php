<?php
use App\Model\ManualModel;
use App\Lib\Auth;
use App\Lib\AuthCliente;
use App\Middleware\AuthMiddleware;
use App\Middleware\AuthClienteMiddleware;

$app->group('/v1', function () use ($app){
  $app->group('/admin', function () use ($app){
    $app->group('/manual/', function () use ($app){
      
      $this->get('test', function ($req, $res, $args) {
          return $res->getBody()
                     ->write('Hello desde employee');
      });
      
      $this->get('getAll/', function ($req, $res, $args) {
          $um = new ManualModel();
          
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
          $um = new ManualModel();
          
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
          $um = new ManualModel();
          
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
          $um = new ManualModel();
          
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

      
      
      $this->post('delete/{id}', function ($req, $res, $args) {
          $um = new ManualModel();
          
          return $res
             ->withHeader('Content-type', 'application/json')
             ->getBody()
             ->write(
              json_encode(
                  $um->Delete($args['id'])
              )
          );
      });
      
    });
  })->add(new AuthMiddleware($app));
  
  $app->group('/user', function () use ($app){
    $app->group('/manual/', function () use ($app){
      $this->get('getxmod/{id}', function ($req, $res, $args) {
          $um = new ManualModel();
          
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
          $um = new ManualModel();
          
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
