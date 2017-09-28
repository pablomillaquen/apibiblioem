<?php
use App\Model\ParameterModel;
use App\Lib\Auth;
use App\Lib\AuthCliente;
use App\Middleware\AuthMiddleware;
use App\Middleware\AuthClienteMiddleware;

$app->group('/v1', function () use ($app){
  $app->group('/admin', function () use ($app){
    $app->group('/parameter/', function ()  use ($app){
      
      $this->get('test', function ($req, $res, $args) {
          return $res->getBody()
                     ->write('Hello desde employee');
      });
      
      $this->get('getAll/{l}/{p}', function ($req, $res, $args) {
          $um = new ParameterModel();
          
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
          $um = new ParameterModel();
          
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
          $um = new ParameterModel();
          
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
          $um = new ParameterModel();
          
          return $res
             ->withHeader('Content-type', 'application/json')
             ->getBody()
             ->write(
              json_encode(
                  $um->Delete($args['id'])
              )
          );
      });

      $this->get('getdropdown/{id}', function ($req, $res, $args) {
          $um = new ParameterModel();
          
          return $res
             ->withHeader('Content-type', 'application/json')
             ->getBody()
             ->write(
              json_encode(
                  $um->GetDropdown($args['id'])
              )
          );
      });
      
    });
  })->add(new AuthMiddleware($app));
  
  $app->group('/user', function () use ($app){
    $app->group('/parameter/', function ()  use ($app){
      
      $this->get('getAll/{l}/{p}', function ($req, $res, $args) {
          $um = new ParameterModel();
          
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
          $um = new ParameterModel();
          
          return $res
             ->withHeader('Content-type', 'application/json')
             ->getBody()
             ->write(
              json_encode(
                  $um->Get($args['id'])
              )
          );
      });
      
      // $this->post('save', function ($req, $res) {
      //     $um = new ParameterModel();
          
      //     return $res
      //        ->withHeader('Content-type', 'application/json')
      //        ->getBody()
      //        ->write(
      //         json_encode(
      //             $um->InsertOrUpdate(
      //                 $req->getParsedBody()
      //             )
      //         )
      //     );
      // });
      
      // $this->post('delete/{id}', function ($req, $res, $args) {
      //     $um = new ParameterModel();
          
      //     return $res
      //        ->withHeader('Content-type', 'application/json')
      //        ->getBody()
      //        ->write(
      //         json_encode(
      //             $um->Delete($args['id'])
      //         )
      //     );
      // });

      $this->get('getdropdown/{id}', function ($req, $res, $args) {
          $um = new ParameterModel();
          
          return $res
             ->withHeader('Content-type', 'application/json')
             ->getBody()
             ->write(
              json_encode(
                  $um->GetDropdown($args['id'])
              )
          );
      });
      
    });
  })->add(new AuthClienteMiddleware($app));
});