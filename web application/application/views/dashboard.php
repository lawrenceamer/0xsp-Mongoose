
        <!-- Begin Page Content -->
        <div class="container-fluid">
        <?php if($this->session->flashdata('passchanged')) : ?>
                <div class="col-md-12 col-12">
                <div class="alert alert-success col-12" role="alert">
                    <?=$this->session->flashdata('passchanged');?>    
                </div>  
                </div>
       <?php endif ; ?>
       <?php if($this->session->flashdata('passerror')) : ?>
                <div class="col-md-8 col-12">
                <div class="alert alert-danger col-12" role="alert">
                    <?=$this->session->flashdata('passerror');?>    
                </div>  
                </div>
       <?php endif ; ?>            
          <!-- Page Heading -->
          <h1 class="h3 mb-4 text-gray-800">Dashboard</h1>
          <div class="row">
          <div class="col-xl-6 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Scanned Hosts</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><?php if($hostsnum > 0){
                        echo $hostsnum;
                      }else{
                        echo "No Hosts Found";
                      }?></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-search fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          <div class="col-xl-6 col-md-6 mb-4">
              <div class="card border-left-danger shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Results Found</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><?php if($resultsnum > 0){
                        echo $resultsnum;
                      }else{
                            echo "No Results Found";   
                      }
                      ?></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-bug fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div> 
        </div>
        <div class="row">
        <div class="col-xl-12 col-md-12 mb-4">
        <nav>
          <div class="nav nav-tabs" id="nav-tab" role="tablist">
            <a class="nav-item nav-link active" id="nav-windows-tab" data-toggle="tab" href="#nav-windows" role="tab" aria-controls="nav-windows" aria-selected="true">Windows <i class="fa fa-windows" aria-hidden="true"></i></a>
            <a class="nav-item nav-link " id="nav-linux-tab" data-toggle="tab" href="#nav-linux" role="tab" aria-controls="nav-linux" aria-selected="false">Linux <i class="fa fa-linux" aria-hidden="true"></i></a>
          </div>
        </nav>
        <h1 class="h3 mb-4 text-gray-800 pt-3">Hosts</h1>
        <div class="tab-content" id="nav-tabContent">
          <div class="tab-pane fade show active" id="nav-windows" role="tabpanel" aria-labelledby="nav-windows-tab">
            <table class=" " id="datatable">
              <thead>
                <tr class="" >
                  <th>Report Key <i class="fa fa-calender"></i></th>
                  <th >Host <i class="fa fa-laptop"></i></th>
                  <th >OS <i class="fa fa-server"></i></th>
                  <th >Results <i class="fa fa-search"></i></th>
                </tr>
              </thead>
              <tbody>

              </tbody>
            </table>
          </div>
          <div class="tab-pane fade active" id="nav-linux" role="tabpanel" aria-labelledby="nav-linux-tab">
            <table class=" " id="datatable2">
              <thead>
                <tr class="" >
                  <th>Report Key <i class="fa fa-calender"></i></th>
                  <th >Host <i class="fa fa-laptop"></i></th>
                  <th >OS <i class="fa fa-server"></i></th>
                  <th >Results <i class="fa fa-search"></i></th>
                </tr>
              </thead>
              <tbody>
          
                     
              </tbody>
            </table>
          </div>
        </div>
        </div>
        </div>
        </div>
        <!-- /.container-fluid -->
      </div>
      <!-- End of Main Content -->
      <!-- Footer -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; 0xsp.com 2019</span>
          </div>
        </div>
      </footer>
      <!-- End of Footer -->
      </div>
    <!-- End of Content Wrapper -->
  </div>
  <!-- End of Page Wrapper -->
