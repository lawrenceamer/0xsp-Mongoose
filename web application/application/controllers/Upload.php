<?php

class Upload extends CI_Controller{

    function __construct()
    {
        parent::__construct();
        $this->load->helper('json_output');
        $this->load->model('api_model');
    }
    
    function uploadFile()
    {
      if($_SERVER['REQUEST_METHOD'] != 'POST'){
            json_output(400,array('status'=>400,'message'=>'bad request'));
      }else{
      $username = $_REQUEST['username'];
      $password = $_REQUEST['password'];
      $auth = $this->api_model->do_access($username,$password);
      if($auth == true)
     {
          $config['upload_path'] = './uploads/';
          $config['allowed_types'] = '*';
    
          $this->load->library('upload');
          $this->upload->initialize($config);
    
          if ( ! $this->upload->do_upload('file'))
          {
            $error = array('error' => $this->upload->display_errors());
            print_r($error);
          }
          else
          { 
            json_output(200,array('status'=>200,'message'=>'files uploaded successfully'));          
            $data = array('upload_data' => $this->upload->data());
            $file_name = $data['upload_data']['file_name'];
            $file_ext  = $data['upload_data']['file_type'];
            $data = array(
                'file_name' => $file_name,
                'file_type' => $file_ext
            );
            $this->api_model->insertDownloadCenter($data);
          }
      }else{
            json_output(204,array('status'=>204,'message'=>'please check username & password and try again!'));
      }
    }
    }
}

?>