<?php
if (PHP_SAPI == 'cli-server') {
    // To help the built-in PHP dev server, check if the request was actually for
    // something which should probably be served as a static file
    $file = __DIR__ . $_SERVER['REQUEST_URI'];
    if (is_file($file)) {
        return false;
    }
}

require __DIR__ . '/../vendor/autoload.php';

session_start();

// Instantiate the app
$settings = require __DIR__ . '/../src/settings.php';
$app = new \Slim\App($settings);

$app->add(new \Tuupola\Middleware\Cors([
    "origin" => ["*"],
    "secure" => false,
    "methods" => ["GET","OPTIONS", "POST", "PUT", "PATCH", "DELETE"],
    "headers.allow" => ["Authorization", "X-Requested-With", "content-type","accept"],
    "headers.expose" => ["Etag"],
    "credentials" => true,
    "cache" => 86400
]));

// Set up dependencies
require __DIR__ . '/../src/dependencies.php';

// Register middleware
require __DIR__ . '/../src/middleware.php';

// Register routes
require __DIR__ . '/../src/routes.php';

// Register my App
require __DIR__ . '/../app/app_loader.php';

// Run app
$app->run();
