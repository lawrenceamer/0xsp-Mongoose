<?php

class Dashboard extends CI_Controller{

    function __construct(){
        parent::__construct();
        
        $this->load->library('Datatables');  
        $this->load->model('api_model');
        $this->load->helper('download');
        

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

    function downloadcenter()
    {
        $data['title'] = 'Download Center';
        $data['content'] = "download_center_view";
        $this->load->view('layout',$data);
    }
    function getDownloadCenter()
    {
        $this->datatables->select('id,file_name,file_type');
        $this->datatables->from('download_center');
        echo $this->datatables->generate();
    }
    
    function downloadFile($id)
    {
        $res = $this->api_model->downloadFile($id);
        $mime = $this->api_model->getFileType($id);
        if(!$res)
        {
            echo "id not found on our records";
        }
        else{
            if(!force_download('./uploads/'.$res,NULL))
            {
                echo "please try again";
            }else{
                force_download('./uploads/'.$res,NULL);      
                exit;
            }
        }
    }
    public function dashboard()
    {
        $data['title'] = "Dashboard";
        $data['resultsnum'] = $this->api_model->getAllResults();
        $data['hostsnum'] = $this->api_model->getAllHosts();
        $dd = $this->api_model->getHostOsName($host=null);
            if(strpos($dd,'windows') == true || strpos($dd,'Windows') == true){
                $data['categories'] = $this->api_model->getWindowsCategories();
            }else{
                $data['categories'] = $this->api_model->getLinuxCategories();
            }        
        $data['content'] = "dashboard";
        $this->load->view('layout',$data);
    }

    public function getlinuxhosts()
    {
        
        $this->datatables->select('random_val,sys,created_at,host,GROUP_CONCAT(id) AS host_id');
        $this->datatables->from('outputs');
        $this->datatables->where('output_owner',$this->session->userdata('user_id'));
        $this->db->not_like('sys','Windows');    
        $this->db->or_not_like('sys','windows');
        $this->datatables->group_by('random_val');
        $this->db->order_by('created_at','DESC');
        echo $this->datatables->generate();    
    }

    public function getwindowshosts()
    {
        $this->datatables->select('random_val,sys,created_at,host,GROUP_CONCAT(id) AS host_id');
        //$this->datatables->select('host,GROUP_CONCAT(id) AS host_id');
        $this->datatables->from('outputs');
        $this->datatables->like('sys','windows');
        $this->datatables->or_like('sys','Windows');
        $this->datatables->where('output_owner',$this->session->userdata('user_id'));
        $this->datatables->group_by('random_val');
        $this->db->order_by('created_at','DESC');
        echo $this->datatables->generate();    
    }
    
 
    public function scanresult($host = null,$category = null)
    {
        if($host == null){
            redirect('dashboard');
        }
        else if($host != null && $category != null){
            $dd = $this->api_model->getHostOsName($host);
            if(strpos($dd,'windows') !== false || strpos($dd,'Windows') !== false){
                $data['categories'] = $this->api_model->getWindowsCategories();
            }else{
                $data['categories'] = $this->api_model->getLinuxCategories();
            }            
            $data['title'] = "Scan Results";
            $data['results'] = $this->api_model->getHostResult($host);
            $data['singleresult'] = $this->api_model->getSingleHostResult($category);
            $data['categoryname'] = $this->api_model->getCategoryName($category);
            $data['content'] = "single_scanresult";
            $this->load->view('layout',$data);
        }
        else{
            $data['title'] = "Scan Results";
            $dd = $this->api_model->getHostOsName($host);
            if(strpos($dd,'windows') !== false || strpos($dd,'Windows') !== false){
                $data['categories'] = $this->api_model->getWindowsCategories();
            }else{
                $data['categories'] = $this->api_model->getLinuxCategories();
            }
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
