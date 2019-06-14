<div class="container-fluid">
          <!-- Page Heading -->
    <div class="mb-4 text-gray-800">
    <p>Key: <?=$this->uri->segment(3);?></p>
    <p>Scan Type: <?=$categoryname;?></p>
    </div>
                <?php if($singleresult): ?>
                <?php foreach($singleresult as $result): ?>
                <div class="card shadow mb-4">
                <div class="card-header py-3">
                <div class="float-right">
                        <a data-toggle="collapse" href="#section<?=$result->id;?>" aria-expanded="true" aria-controls="collapse-example" id="heading-example" class="d-block">
                        <i class="fa fa-chevron-down pull-right"></i>
                        </a>
                </div>                    
                        <h6 class="m-0 font-weight-bold text-primary">Report At : <?=date("Y/m/d H:i",strtotime($result->created_at))?></h6>
                    </div>
                    <div id="section<?=$result->id;?>" class="collapse" aria-labelledby="heading-example">
                    <div class="card-body result-card">
                        <div class="report_body" id="#pre">
                            <?=$result->body;?>
                       </div>          
                    </div>
                    </div>
                </div>
                <?php endforeach ;  ?>
                <?php else : ?>
                    <p class="lead">No results found on this category!</p>
                <?php endif ; ?>
        </div>