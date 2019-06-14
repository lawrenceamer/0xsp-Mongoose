<?php

class Auth_model extends CI_Model{

    function do_access($username,$password)
    {
        $this->db->where('username',$username);
        $this->db->where('password',$password);
        $q = $this->db->get('users');
        return $q;
    }

}