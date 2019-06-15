
        <!-- Begin Page Content -->
        <div class="container-fluid">
          <!-- Page Heading -->

          <h1 class="h3 mb-4 text-gray-800">Scan Results</h1>
          <div class="row">
          <?php foreach($categories as $category): ?>
          <div class="col-sm-3 p-2">
          <div class="card mb-4">
                <div class="card-header text-white" style="background:#4e73df;">
                    <?=$category->cat_name?>
                </div>
                <a href="<?=base_url('dashboard/scanresult/');?><?=$this->uri->segment(3).'/'.$this->uri->segment(4).'/'.$category->cat_id.'/';?>">
                <div class="card-body text-center">
                  <div class="ibug display-1">
                      <img src="<?=base_url('storage/icons/').$category->cat_icon?>" width="100">
                  </div>
                </div>
                </a>
                <div class="card-footer" >
                      <div class="cat<?=$category->cat_id; ?>"></div>
                </div>
              </div>
              </div>
          <?php endforeach ; ?>

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
 <script type="text/javascript">
    var key = "<?=$this->uri->segment(3); ?>";
    var host = "<?=base_url('dashboard/getResult/');?>";
    
</script>
 
