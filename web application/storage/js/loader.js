$(document).ready(function() {
    for(var i = 1; i < categories;i++){
        let a = $('.cat'+i);
        $.get(host+key+'/'+i,function(data){
            a.text("Total Results: "+data);
        });
    }
});
