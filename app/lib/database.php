<?php
namespace App\Lib;

use PDO;

/**
 * @SWG\Definition(type="object")
 */
class Database
{
    public static function StartUp()
    {
        $pdo = new PDO('mysql:host=localhost;dbname=biblioem;charset=utf8', 'root', 'M1q53t1b2b27270');
        
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_OBJ);
        
        return $pdo;
    }
}