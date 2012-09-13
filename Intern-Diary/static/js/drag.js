var send_button_flag = false;
var send_items = [];
$(".target").draggable({
    helper: "clone",
    start: function (e) {
        document.getElementById('sidebar').style.backgroundImage = "url(/images/sidebar_on.png)";
    },
    stop: function (e) {
        document.getElementById('sidebar').style.backgroundImage = "url(/images/sidebar_off.png)";
    },
});
$("#sidebar").droppable({
    accept: ".target",
    drop: function (e, ui) {
        if(send_button_flag == false){
            var send_button = $('<button class = "btn btn-primary send_button" onClick = "post_item_to_db()" style = "padding:10px 20px; font-size: 140%;">').text("←ボードに貼る");
            send_button.appendTo("#sidebar");
            send_button_flag = true;
        }
        var id = $(ui.draggable[0]).attr("data-id");
        var $title = $(ui.draggable[0]).attr("data-title");
        var well = $('<div class = "well in_sidebar" style = "position:relative;">').text($title);
        well.appendTo("#sidebar");
        well.animate({"left": "-=10px", "top": "-=0px", rotate: '-=20deg', scale: '1.20'}, 100);
        well.animate({"left": "+=10px", "top": "-=0px", rotate: '+=20deg', scale: '1.00'}, 50);
        send_items.push(id);
    },
});

function post_item_to_db(logined_user_name, id) {
    var i = 0;
    for(i=0; i<send_items.length; i++){
        console.log(send_items);
        $.post('/api.post_item_to_db', {item:send_items[i]}).done(function(){
        }).fail(function(){
            console.log("Noooooooooooooo");
        });
    }
    $("#sidebar").animate({"left": "-=300px", "top": "-=0px", rotate: '-=0deg', scale: '1.00'}, 400);
    $("#sidebar").fadeOut(200);
    $(".send_button").fadeOut(0);
    $(".in_sidebar").fadeOut(0);
    $("#sidebar").animate({"left": "+=300px", "top": "+=1000px", rotate: '-=0deg', scale: '1.00'}, 0); 
    $("#sidebar").fadeIn(200);
    $("#sidebar").animate({"left": "-=0px", "top": "-=1000px", rotate: '-=0deg', scale: '1.00'}, 400);
    send_button_flag = false;
};
