<?php

// Helper method to get a string description for an HTTP status code
// From http://www.gen-x-design.com/archives/create-a-rest-api-with-php/ 
function getStatusCodeMessage($status)
{
    // these could be stored in a .ini file and loaded
    // via parse_ini_file()... however, this will suffice
    // for an example
    $codes = Array(
        100 => 'Continue',
        101 => 'Switching Protocols',
        200 => 'OK',
        201 => 'Created',
        202 => 'Accepted',
        203 => 'Non-Authoritative Information',
        204 => 'No Content',
        205 => 'Reset Content',
        206 => 'Partial Content',
        300 => 'Multiple Choices',
        301 => 'Moved Permanently',
        302 => 'Found',
        303 => 'See Other',
        304 => 'Not Modified',
        305 => 'Use Proxy',
        306 => '(Unused)',
        307 => 'Temporary Redirect',
        400 => 'Bad Request',
        401 => 'Unauthorized',
        402 => 'Payment Required',
        403 => 'Forbidden',
        404 => 'Not Found',
        405 => 'Method Not Allowed',
        406 => 'Not Acceptable',
        407 => 'Proxy Authentication Required',
        408 => 'Request Timeout',
        409 => 'Conflict',
        410 => 'Gone',
        411 => 'Length Required',
        412 => 'Precondition Failed',
        413 => 'Request Entity Too Large',
        414 => 'Request-URI Too Long',
        415 => 'Unsupported Media Type',
        416 => 'Requested Range Not Satisfiable',
        417 => 'Expectation Failed',
        500 => 'Internal Server Error',
        501 => 'Not Implemented',
        502 => 'Bad Gateway',
        503 => 'Service Unavailable',
        504 => 'Gateway Timeout',
        505 => 'HTTP Version Not Supported'
    );
 
    return (isset($codes[$status])) ? $codes[$status] : '';
}
 
// Helper method to send a HTTP response code/message
function sendResponse($status = 200, $body = '', $content_type = 'text/html')
{
    $status_header = 'HTTP/1.1 ' . $status . ' ' . getStatusCodeMessage($status);
    header($status_header);
    header('Content-type: ' . $content_type);
    echo $body;
}






class RedeemAPI {
    private $db;
 
    // Constructor - open DB connection
    function __construct() {
        $this->db = new mysqli('localhost', 'chandhooguy', 'Thedarkness1', 'Fashion_Database');
        $this->db->autocommit(FALSE);
    }
 
    // Destructor - close DB connection
    function __destruct() {
        $this->db->close();
    }
 
    // Main method to redeem a code
    function redeem() {
        // Print all codes in database
        
        if(isset($_POST["Username"]) && isset($_POST["Password"])){
        $stmt = $this->db->prepare('SELECT * FROM User WHERE Username='.htmlspecialchars($_POST["Username"]));
        $stmt->execute();
        $stmt->bind_result($imageLink,$Username, $Password, $UserID, $Posts, $Groups);
        while ($stmt->fetch()) {
            break;
        }
        $stmt->close();
        
        if($_POST["Password"] == $Password){
        $imageLink = $_POST["imageLink"];
        $Username = $_POST["Username"];
        $Password = $_POST["Password"];
        $Posts = $_POST["Posts"];
        $Groups = $_POST["Groups"];
        $this->db->query("UPDATE User SET imageLink=$imageLink,Username=$Username,Password=$Password,Posts=$Posts,Groups=$Groups WHERE UserID=$UserID");
        $this->db->commit();
        }
        else{
        sendResponse(401, 'Wrong Password!');
        return false;
        }
        
       
        echo "Successful!";
        return true;
        }
    sendResponse(400, 'Invalid request');
    return false;
    }
}

 
// This is the first thing that gets called when this page is loaded
// Creates a new instance of the RedeemAPI class and calls the redeem method
$api = new RedeemAPI;
$api->redeem();
 
 
 






?>