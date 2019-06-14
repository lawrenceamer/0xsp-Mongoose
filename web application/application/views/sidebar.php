<?php
        $csrf = array(
            'name' => $this->security->get_csrf_token_name(),
            'hash' => $this->security->get_csrf_hash()
        );
?>
  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<?=base_url('dashboard');?>">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-bug"></i>
        </div>
        <div class="sidebar-brand-text mx-3">0xsp</div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item">
        <a class="nav-link" href="<?=base_url('dashboard');?>">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Dashboard</span></a>
      </li>
      <!-- Divider -->
      <?php if($this->uri->segment(3)): ?>
      <hr class="sidebar-divider">
      <li class="nav-item">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#collapseUtilities">
          <i class="fas fa-fw fa-wrench"></i>
          <span>Scans Categories</span>
        </a>
        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar" style="">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">My Scans:</h6>
            <?php foreach($categories as $category): ?>
                <a class="collapse-item" href="<?=base_url('dashboard/scanresult/');?><?=$this->uri->segment(3).'/'.$category->cat_id;?>"><?=$category->cat_name?></a>
            <?php endforeach ; ?>
          </div>
        </div>
      </li>
      <?php endif ; ?>
      <hr class="sidebar-divider">
      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>
    </ul>
    <!-- End of Sidebar -->
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Topbar Search
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
            <div class="input-group">
              <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
              <div class="input-group-append">
                <button class="btn btn-primary" type="button">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form>
            -->
          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">



            <!-- <div class="topbar-divider d-none d-sm-block"></div> -->

            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><?=$this->session->userdata('user_name');?></span>
                <img class="img-profile rounded-circle" src="https://cdn2.iconfinder.com/data/icons/hacker-solid/100/hacker_hacker_human_-512.png">
              </a>

              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">


                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#resetPassModal">
                  <i class="fas fa-lock-open fa-sm fa-fw mr-2 text-gray-400"></i>
                  Change Password
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>
          </ul>

        </nav>
        <!-- End of Topbar -->

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">are you sure to log out ?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are sure to log out.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="<?=base_url('dashboard/logout');?>">Logout</a>
        </div>
      </div>
    </div>
  </div>


<!-- Modal -->
<div class="modal fade" id="resetPassModal" tabindex="-1" role="dialog" aria-labelledby="resetPassModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="resetPassModalLabel">Change Password</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div clas="row">
          <form class="" method="post" action="<?php echo base_url('dashboard/resetpass');?>">
          <input type="hidden" name="<?=$csrf['name'];?>" value="<?=$csrf['hash'];?>" />

              <div class="col-md-12 col-12">
                  <div class="form-group">
                      <label for="newpassword">New Password</label>
                      <input type="password" name="newpassword" id="newpassword" class="form-control">
                  </div>
              </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Save changes</button>
      </div>
      </form>

    </div>
  </div>
</div>

