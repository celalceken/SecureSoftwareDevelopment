<?php
    
	/* 
		This is an example class script proceeding secured API
		To use this class you should keep same as query string and function name
		Ex: If the query string value rquest=delete_user Access modifiers doesn't matter but function should be
		     function delete_user(){
				 You code goes here
			 }
		Class will execute the function dynamically;
		
		usage :
		
		    $object->response(output_data, status_code);
			$object->_request	- to get santinized input 	
			
			output_data : JSON (I am using)
			status_code : Send status message for headers
			
		Add This extension for localhost checking :
			Chrome Extension : Advanced REST client Application
			URL : https://chrome.google.com/webstore/detail/hgmloofddffdnphfgcellkdfbfbjeloo
		
		I used the below table for demo purpose.
		
		CREATE TABLE IF NOT EXISTS `users` (
		  `user_id` int(11) NOT NULL AUTO_INCREMENT,
		  `user_fullname` varchar(25) NOT NULL,
		  `user_email` varchar(50) NOT NULL,
		  `user_password` varchar(50) NOT NULL,
		  `user_status` tinyint(1) NOT NULL DEFAULT '0',
		  PRIMARY KEY (`user_id`)
		) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
 	*/
	
	require_once("Rest.inc.php");

require_once("Ogrenci.class.php");
require_once ("OgrenciGoruntuleJSON.class.php");

	class API extends REST {
	
		public $data = "";

		
		private $db = NULL;
	
		public function __construct(){
			parent::__construct();				// Init parent contructor
			include(__DIR__.'/DatabaseConnection.php');
			$this->db=$veritabaniBaglantisi;// Initiate Database connection
		}
		

		/*
		 * Public method for access api.
		 * This method dynmically call the method based on the query string
		 *
		 */
		public function processApi(){
			//echo $_REQUEST['request'];
			$func = strtolower(trim(str_replace("/",".",$_SERVER['REQUEST_URI'])));
			$func=explode(".",$func);
			$func=end($func);
			//if((int)method_exists($func) > 0)
				$this->$func();
			//else
			//	$this->response('',404);				// If the method not exist with in this class, response would be "Page not found".
		}
		
		/* 
		 *	Simple login API
		 *  Login must be POST method
		 *  email : <USER EMAIL>
		 *  pwd : <USER PASSWORD>
		 */
		
		private function login(){
			// Cross validation if the request method is POST else it will return "Not Acceptable" status
			if($this->get_request_method() != "POST"){
				$this->response('',406);
			}
			
			$email = $this->_request['email'];		
			$password = $this->_request['pwd'];
			
			// Input validations
			if(!empty($email) and !empty($password)){
				if(filter_var($email, FILTER_VALIDATE_EMAIL)){
					$sql = mysql_query("SELECT * FROM personel WHERE personelNo = '$email' AND sifre = '$password' LIMIT 1", $this->db);
					if(mysql_num_rows($sql) > 0){
						$result = mysql_fetch_array($sql,MYSQL_ASSOC);
						
						// If success everythig is good send header as "OK" and user details
						$this->response($this->json($result), 200);
					}
					$this->response('', 204);	// If no records "No Content" status
				}
			}
			
			// If invalid inputs "Bad Request" status message and reason
			$error = array('status' => "Failed", "msg" => "Invalid Email address or Password");
			$this->response($this->json($error), 400);
		}
		
		private function users(){


			if($this->get_request_method() != "GET"){
				$this->response('',406);
			}

			$sql="SELECT \"ogrenciNo\", \"adi\", \"soyadi\" FROM \"Ogrenci\"";
			$query = $this->db->prepare($sql);
			if($query->execute()> 0)
			{
				$query->setFetchMode(PDO::FETCH_CLASS, "\cc\Ogrenci");
				$ogrenciler=$query->fetchAll();
				$jsonGoruntuleyici= new \cc\OgrenciGoruntuleJSON();
				$str='[';
				foreach($ogrenciler as $ogrenci)
					$str.=$jsonGoruntuleyici->getKisi($ogrenci).',';
				$str=$str.']';

				//echo $str;
				$this->response($str, 200);
			} else
			$this->response('',204);	// If no records "No Content" status*/
		}


        private function user(){


            if($this->get_request_method() != "GET"){
                $this->response('',406);
            }
            //$id = (int)$this->_request['id'];
            $id = $this->_request['id'];

            $this->response($id,200);

           /* $sql="SELECT \"ogrenciNo\", \"adi\", \"soyadi\" FROM \"Ogrenci\" WHERE \"ogrenciNo\"=$id ";
            $query = $this->db->prepare($sql);
            if($query->execute()> 0)
            {
                $query->setFetchMode(PDO::FETCH_CLASS, "\cc\Ogrenci");
                $ogrenciler=$query->fetchAll();
                $jsonGoruntuleyici= new \cc\OgrenciGoruntuleJSON();
                $str='[';
                foreach($ogrenciler as $ogrenci)
                    $str.=$jsonGoruntuleyici->getKisi($ogrenci).',';
                $str=$str.']';

                //echo $str;
                $this->response($str, 200);
            } else
                $this->response('',204);	// If no records "No Content" status*/
        }


		
		private function deleteUser(){
			// Cross validation if the request method is DELETE else it will return "Not Acceptable" status
			if($this->get_request_method() != "DELETE"){
				$this->response('',406);
			}
			$id = (int)$this->_request['id'];
			if($id > 0){				
				mysql_query("DELETE FROM personel WHERE personelNo = $id");
				$success = array('status' => "Success", "msg" => "Successfully one record deleted.");
				$this->response($this->json($success),200);
			}else
				$this->response('',204);	// If no records "No Content" status
		}
		
		/*
		 *	Encode array into JSON
		*/
		private function json($data){
			if(is_array($data)){
				return json_encode($data);
			}
		}
	}
	
	// Initiiate Library
	
	$api = new API;
	$api->processApi();