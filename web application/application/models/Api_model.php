<?php



class Api_model extends CI_Model{

    private $key = 'test';

    function checkAuth(){
        $key = $this->input->get_request_header('key',TRUE);
        if($key == $this->key){
            return true;
        }else{
            return json_output(401,array('status' => 401,'message' => 'access denied'));
        }
    }

    function do_access($username,$password)
    {
        $this->db->where('username',$username);
        $this->db->where('password',$password);
        $q = $this->db->get('users')->row();
        return $q;
    }

    function getUserId($username)
    {
        // return $this->db->select('id')->where('username',$username)->get()->row();
        $q = $this->db->get('users')->result();
        foreach($q as $row){
            return $row->id;
        }
    }

    function storeData($data)
    {
        $this->db->insert('outputs',$data);
    }
    function insertDownloadCenter($da)
    {
        $this->db->insert('download_center',$da);
    }
    function downloadFile($id)
    {
        $this->db->where('id',$id);
        $q = $this->db->get('download_center');
        $data = $q->result();
        foreach($data as $file){
            return $file->file_name;
        }
    }
    
    function getFileType($id)
    {
        $this->db->where('id',$id);
        $q = $this->db->get('download_center');
        $data = $q->result();
        foreach($data as $file){
            return $file->file_type;
        }
    }
        
    function getHostOsName($host)
    {
        $this->db->where('random_val',$host);
        $q = $this->db->get('outputs');
        foreach($q->result() as $cat){
            return $cat->sys;
        }
    }
    function getWindowsCategories()
    {
        $this->db->where('os','windows');
        return $this->db->get('categories')->result();
    }
    
    function getLinuxCategories()
    {
        $this->db->where('os','Linux');
        return $this->db->get('categories')->result();
    }        
    
    function getCatResult($key,$id)
    {  
        $this->db->select('*');
        $this->db->from('outputs');
        $this->db->where('output_owner',$this->session->userdata('user_id'));
        $this->db->where('output_category',$id);
        $this->db->where('random_val',$key);
        $this->db->group_by('created_at');
        return $this->db->get('')->num_rows();
    }
    function getHostResult($host)
    {
        $this->db->select('*');
        $this->db->from('categories');
        $this->db->join('outputs','outputs.output_category = categories.cat_id');
        $this->db->where('host',$host);
        $this->db->where('output_owner',$this->session->userdata('user_id'));
        $this->db->order_by('id','DESC');
        return $this->db->get('')->result();
    }
    function getSingleHostResult($category)
    {
        $filter = $this->uri->segment(3);
       $this->db->simple_query('SET SESSION group_concat_max_len=10000000');
        $this->db->select('*, DATE_FORMAT(created_at, "%Y-%M-%d %H:%i"), GROUP_CONCAT(DISTINCT(output_body)) AS body',FALSE);
        $this->db->from('outputs');
        $this->db->join('categories','categories.cat_id = outputs.output_category');
        $this->db->where('output_category',$category);
        $this->db->where('output_owner',$this->session->userdata('user_id'));
        $this->db->where('random_val',$filter);
        $this->db->group_by('created_at');
        $q = $this->db->get('');
        return $q->result();
    }
    
    function getCategoryName($category)
    {
        $this->db->select('*');
        $this->db->from('categories');
        $this->db->where('cat_id',$category);
        $q = $this->db->get('')->result();
        foreach($q as $row){
            return $row->cat_name;
        }
    }


    function getAllResults()
    {
        $this->db->select('*');
        $this->db->group_by('created_at');
        $this->db->where('output_owner',$this->session->userdata('user_id'));
        $q = $this->db->get('outputs');
        return $q->num_rows();
    }
        
    function getAllHosts()
    {
        
        $this->db->select('*');
        $this->db->where('output_owner',$this->session->userdata('user_id'));
        $this->db->where('host >',1);
        $this->db->group_by('random_val');
        $q = $this->db->get('outputs');
        return $q->num_rows();
    }
    function getHosts()
    {
        $this->db->select('*, GROUP_CONCAT(id) AS host_id');
        $this->db->from('outputs');
        $this->db->where('output_owner',$this->session->userdata('user_id'));
        $this->db->group_by('random_val');
        $this->db->order_by('id','DESC');
        return $this->db->get('')->result();
    }
    
    
    function updatePass($data)
    {
        $this->db->where('id',$this->session->userdata('user_id'));
        $this->db->set($data);
        $this->db->update('users');
        return true;
    }
    
        

}
?>
