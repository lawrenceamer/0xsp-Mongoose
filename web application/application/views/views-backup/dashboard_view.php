<?php $this->load->view("header"); ?>
      <div class="container">
        <div class="row">
            <!-- <header class="col-12 text-center text-white bg-dark mt-4 p-2">
                <h2><i class="fa fa-bug"></i> 0xsp | Dashboard <i class="fa fa-dashboard"></i></h2>
            </header> -->
        </div>
      </div>
      <div class="wrapper">
            <nav id="sidebar">
            <ul class="list-unstyled components">
                <div id="ibug" style="text-align:center;padding:30px;">
                    <i class="fa fa-bug" style="font-size:100px;"></i>
                </div>
                <?php if($categories): ?>
                <?php foreach($categories as $category): ?>
                <li class="">
                    <a href="<?=base_url('results/');?><?=$category->cat_id;?>"><i class="fa fa-file"></i> <?=$category->cat_name;?></a>
                </li>
                <?php endforeach; ?>
                <?php else: ?>
                    <p>There's no result</p>
                <?php endif ; ?>
                <li>
                    <a href="<?=base_url('dashboard/logout'); ?>"><i class="fa fa-power-off"> </i> Logout</a>    
                </li>                
            </ul>
        </nav>

        <!-- Page Content  -->
        <div class="contanier">
            <div class="row">
            <div id="content">
                <div class="col-12">
                    <div class="text-center mt-5">
                        <img src="https://svgsilh.com/svg/150097.svg" width="200">
                        <p>Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups. <i style="color:red;" class="fa fa-heart"></i></p>
                    </div>
                </div>
            </div>
            </div>
        </div>
        <?php $this->load->view("footer"); ?>
