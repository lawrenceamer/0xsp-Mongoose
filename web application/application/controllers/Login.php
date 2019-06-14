<?php

class Login extends CI_Controller{

    function __construct(){
        parent::__construct();
        
        $this->load->model('auth_model');
        $this->load->library('form_validation');
        $this->_cAuth();
    }

    private function _cAuth()
    {
        if($this->session->logged_in){
            redirect('dashboard');
        }
    }

    function index()
    {
        $this->login();
    }

    public function login()
    {
        $dd['title'] = "0xsp | Login";
        $this->load->view('login_view',$dd);
    }

    public function dologin()
    {
        $this->form_validation->set_rules('username','username','required|trim');
        $this->form_validation->set_rules('password','password','required|trim');

        if($this->form_validation->run()){
            $username = $this->input->post('username');
            $password = $this->input->post('password');

            $user_details = $this->auth_model->do_access($username,$password);

            if($user_details->num_rows() > 0){
                $userdata = $user_details->row();
                $uname = $userdata->username;
                $uid = $userdata->id;
                $sess = array(
                    'logged_in' =>TRUE,
                    'user_name' => $uname,
                    'user_id'   => $uid
                );
                $this->session->set_userdata($sess);
                redirect('dashboard');
            }else{
                $this->session->set_flashdata('usercheck','please check username or password and try again!');
                redirect('login');
            }

        }else{
            $this->session->set_flashdata('usercheck','please check username or password and try again!');
            redirect('login');
        }
    }

    
}