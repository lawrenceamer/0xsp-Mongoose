$(document).ready(function() {
    for(var i = 1; i < 9;i++){
        let a = $('.cat'+i);
        $.get('http://testtesttest234.com/0xsp/dashboard/getResult/'+key+'/'+i,function(data){
            a.text("Total Results: "+data);
        });
    }
});
