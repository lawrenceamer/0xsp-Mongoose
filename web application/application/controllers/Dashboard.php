<?php

class Dashboard extends CI_Controller{

    function __construct(){
        parent::__construct();

        $this->load->model('api_model');

      $this->_cAuth();
    }

    private function _cAuth()
    {
        if(!$this->session->logged_in){
            redirect('login');
        }
    }

    public function index()
    {
        $this->dashboard();
    }


    public function dashboard()
    {
        $data['title'] = "Dashboard";
        $data['resultsnum'] = $this->api_model->getAllResults();
        $data['hostsnum'] = $this->api_model->getAllHosts();
        $data['categories'] = $this->api_model->getCategories();
        $data['content'] = "dashboard";
        $this->load->view('layout',$data);
    }
    public function allhosts()
    {
        $this->load->library('Datatables');
        $this->datatables->select('random_val,sys,created_at,host,GROUP_CONCAT(id) AS host_id');
        //$this->datatables->select('host,GROUP_CONCAT(id) AS host_id');
        $this->datatables->from('outputs');
        $this->datatables->where('output_owner',$this->session->userdata('user_id'));
        $this->datatables->group_by('random_val');
        $this->db->order_by('created_at','DESC');
        echo $this->datatables->generate();    
    }

    public function scanreshost($host=null,$category=null)
    {
        $singleresult = $this->api_model->getSingleHostResult($category);
        echo json_encode($singleresult);
    }

    public function scanresult($host = null,$category = null)
    {
        if($host == null){
            redirect('dashboard');
        }
        else if($host != null && $category != null){
            $data['title'] = "Scan Results";
            $data['categories'] = $this->api_model->getCategories();
            $data['results'] = $this->api_model->getHostResult($host);
            $data['singleresult'] = $this->api_model->getSingleHostResult($category);
            $data['categoryname'] = $this->api_model->getCategoryName($category);
            $data['content'] = "single_scanresult";
            $this->load->view('layout',$data);
        }
        else{
            $data['title'] = "Scan Results";
            $data['categories'] = $this->api_model->getCategories();
            $data['results'] = $this->api_model->getHostResult($host);
            $data['content'] = "scanresults";
            $this->load->view('layout',$data);
        }
    }
    function getResult($key=null,$id=null)
    {
        $data = $this->api_model->getCatResult($key,$id);
        echo json_encode($data);     
    }

    function resetpass()
    {
        $this->load->library('form_validation');

        $this->form_validation->set_rules('newpassword','New Password','required|trim');
        if($this->form_validation->run()){
            $data = array(
                'password' => $this->input->post('newpassword')
            );
            $this->api_model->updatePass($data);
            $this->session->set_flashdata('passchanged','Password Changed Successfully');
            redirect('dashboard');
        }else{
            $this->session->set_flashdata('passerror','please check input & try again!');
            redirect('dashboard');
        }
    }
    function logout()
    {
        $this->session->sess_destroy();
        redirect('login');
    }
}