<?php $this->load->view("header"); ?>

<div class="container">
    <div class="top-content">
        <i class="fa fa-bug" style="font-size:100px"></i>
        <p class="lead">0xsp | Login</p>
    </div>
        <div id="login">
            <form class="" action="<?=base_url('login/dologin');?>" method="post">
  
            <div class="row">
            <?php if($this->session->flashdata('usercheck')) : ?>
                <div class="col-md-8 col-12">
                <div class="alert alert-danger col-12" role="alert">
                    <?=$this->session->flashdata('usercheck');?>    
                </div>  
                </div>
            <?php endif; ?>  

                <div class="col-md-8 col-12">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" class="form-control" name="username">
                </div>
                </div>
     
                <div class="col-md-8 col-12">
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" name="password">
                </div>
                </div>
                              
                <div class="col-12">
                <div class="form-group">
                    <input type="submit" id="submit" class="btn " name="submit" value="Login">
                </div>
                </div>
                </div>
            </form>
    </div>    
</div>

<?php $this->load->view("footer"); ?>