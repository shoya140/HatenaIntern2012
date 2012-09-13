$(".target").draggable({
    helper: "clone",
    start: function (e) {
        document.getElementById('sidebar_edit').style.backgroundImage = "url(/images/sidebar_edit_on.png)";
    },
    stop: function (e) {
        document.getElementById('sidebar_edit').style.backgroundImage = "url(/images/sidebar_edit_off.png)";
    },
});
$("#sidebar_edit").droppable({
    accept: ".target",
    drop: function (e, ui) {
        var id = $(ui.draggable[0]).attr("data-id");
        console.log(id)
        $.post('/api.delete_item_from_db', {item:id}).done(function(){
            $("#item"+id).remove();
//            $("#item"+id).fadeOut(600);
            $(function(){  
                $(".grid-content").vgrid({
                easeing:"easeOutQuint",
                useLoadImageEvent: true, 
                time:400,
                delay:20,
                    fadeIn:{
                    time: 200,
                    delay: 50
                }
            });
        });
        }).fail(function(){
            console.log("Noooooooooooooo");
        });
    },
});

$(function(){

});
