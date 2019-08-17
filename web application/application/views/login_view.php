<?php $this->load->view("header"); ?>
<div class="container">
<!-- Outer Row -->
<div class="row justify-content-center">
  <div class="col-xl-6 col-lg-12 col-md-9">
    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-12">
            <div class="p-5">
              <div class="text-center">
                <!--<h4 class="mb-4" id="ibug"><i class="fa fa-bug" style="font-size:100px;color:#4e73df;"></i></h4>-->
                <img id="ibug" src="<?=base_url('storage/');?>images/trans.png" class="fa-bug" width="140" >
                <h1 class="h3 text-gray-900 mb-4">0xsp Portal</h1>
              </div>
            <?php if($this->session->flashdata('usercheck')) : ?>
                  <div class="alert alert-danger">
                        <?=$this->session->flashdata('usercheck');?>    
                    </div>
                <?php endif; ?>  

              <form class="user" action="<?=base_url('login/dologin'); ?>" method="post">
                <div class="form-group">
                  <input type="username" class="form-control form-control-user" id="inputUsername" name="username"  placeholder="Username" required>
                </div>
                <div class="form-group">
                  <input type="password" class="form-control form-control-user" id="inputPassword" name="password" placeholder="Password" required>
                </div>
                <div class="form-group">
                  <!-- <div class="custom-control custom-checkbox small">
                    <input type="checkbox" class="custom-control-input" id="customCheck">
                    <label class="custom-control-label" for="customCheck">Remember Me</label>
                  </div> -->
                </div>
                <input type="submit" class="btn btn-primary btn-user btn-block" value="Login">
                <hr>
          </form>
<!--
              <div class="text-center">
                <a class="small" href="" data-toggle="modal" data-target="#resetPass">Forgot Password?</a>
              </div>
-->
            </div>
          </div>
          
        </div>
      </div>
    </div>
  </div>
</div>
</div>
<div class="modal fade" id="resetPass" tabindex="-1" role="dialog" aria-labelledby="resetPassLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="resetPassLabel">Reset Password</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
              <div class="text-center">
                <h4 class="mb-4" id="ibug"><i class="fa fa-bug" style="font-size:100px;color:#4e73df;"></i></h4>
                <h3 class="h3 text-gray-900 mb-4">Reset Your 0xsp Account Password</h3>
              </div>
         
        <form action="#" method="">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="uname">Please Enter Your Username: </label>
                    <input type="uname" name="uname" class="form-control" placeholder="johndoe13" value="" required>
                </div></div>
                <div class="form-group float-right">
                    <input type="submit" name="reset" class="btn btn-primary" value="Send Reset Link">
                </div>
            </form>
        </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<?php $this->load->view("footer"); ?>
