<?php
class Api extends CI_Controller {
    function __construct(){
        parent::__construct();
        // opensource helper from github/restapi
        $this->load->helper('json_output');
        $this->load->model('api_model');
    }
    function postReq()
    {
        if($_SERVER['REQUEST_METHOD'] != 'POST'){
            json_output(400,array('status'=>400,'message'=>'bad request'));
        }else{
            $checkAuth = $this->api_model->checkAuth();
            if($checkAuth == true){
                $username = $_REQUEST['username'];
                $password = $_REQUEST['password'];
                $output = $_REQUEST['output'];
                $category = $_REQUEST['category'];
                $host = $_REQUEST['host'];
                $sys = $_REQUEST['sys'];
                $random = $_REQUEST['random_string'];
                $auth = $this->api_model->do_access($username,$password);
                $id = $this->api_model->getUserId($username);
                // $stringCheck = $this->api_model->requestCheck($host);
                if($auth == true){
                    $data = array(
                      //  'output_body'=>$this->security->xss_clean($output),
                        'output_body' =>$output,
                        'output_owner'=>$id,
                        'output_category'=>$category,
                        'host'    => $host,
                        'sys'     => $sys,
                        'random_val' => $random,
                        'created_at'=> date("Y-m-d H:i")
                    );
                    $this->api_model->storeData($data);
                    json_output(200,array('status'=>200,'message'=>'data stored successfully'));          
                }else{
                        json_output(204,array('status'=>204,'message'=>'please check username & password and try again!'));
                }
            }

        }
    }
    public function dashboard($cat=null)
    {
        if($cat == null){
            $dd['title'] = "0xsp | Dashboard";
            $dd['categories'] = $this->api_model->getCategories();
            $this->load->view('dashboard_view',$dd);    
        }else{
            $dd['title'] = "0xsp | Results";
            $dd['categories'] = $this->api_model->getCategories();
            $dd["singlecat"] = $this->api_model->getCategory($cat);
            $this->load->view('single_category_view',$dd);    
        }
    }
}