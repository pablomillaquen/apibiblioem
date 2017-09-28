<?php
namespace App\Middleware;

use Exception,
    App\Lib\AuthCliente;

class AuthClienteMiddleware
{
    private $app = null;
    
    public function __construct($app){
        $this->app = $app;    
    }
    
    public function __invoke($request, $response, $next){
        
        $c = $this->app->getContainer();
        $app_token_name = $c->settings['app_token_name_client'];

        $token = $request->getHeader($app_token_name);
        if(isset($token[0])) $token = $token[0];
    
        try {
            AuthCliente::Check($token);                
        } catch(Exception $e) {
            return $response->withStatus(401)
                            ->write('Unauthorized');
        }
        
        return $next($request, $response);
    }
}