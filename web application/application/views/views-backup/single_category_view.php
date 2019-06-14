<?php $this->load->view("header"); ?>
      <div class="container">
        <div class="row">
        </div>
      </div>
      <div class="wrapper">
            <nav id="sidebar">
            <ul class="list-unstyled components">
                <div id="ibug" style="text-align:center;padding:30px;">
                    <i class="fa fa-bug" style="font-size:100px;"></i>
                </div>
                <?php foreach($categories as $category): ?>
                <li class="">
                    <a href="<?=base_url('results/');?><?=$category->cat_id;?>"><i class="fa fa-file"></i>  <?=$category->cat_name;?></a>
                </li>
                <?php endforeach; ?>
                <li>
                    <a href="<?=base_url('dashboard/logout'); ?>"><i class="fa fa-power-off"></i>  Logout</a>    
                </li>
            </ul>
        </nav>
        <div class="contanier">
            <div class="row">
            <div id="content">
            <?php if($singlecat): ?>
            <?php foreach($singlecat as $data): ?>
                <div class="col-12 mt-3">
                    <div class="card">
                    <div class="card-header lead">
                        Report at | <span style="color:#00508B;"><?php echo $data->created_at; ?></span>
                    </div>
                    <div class="card-body">
                        <p class="card-text">
                            <?php 
                                echo $data->output_body;
                            ?>
                        </p>
                    </div>
                    </div>
                </div>
                <?php endforeach ; ?>
                <?php else : ?>
                    <p class="p-3 lead">no result found on this page! <i class=""></i></p>
                <?php endif ;?>
            </div>
            </div>
        </div>
<?php $this->load->view("footer"); ?>