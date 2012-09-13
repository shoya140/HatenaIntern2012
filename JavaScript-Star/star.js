if(window.addEventListener) {
    window.addEventListener("load",new_image,false);
    window.addEventListener("mousemove",move_image,false);
}

//マウスポインタとの距離をランダムに生成
var argX = 0;
var argY = 0;

function new_image() {
    var image = document.createElement("img");
    image.src = "image.png";
    image.width = "100";
    image.style.position = "absolute";
    image.setAttribute("id","img_image");
    document.body.appendChild(image);
}

function move_image(e) {
    var image = document.getElementById("img_image");
    image.style.left=e.pageX-50+argX+"px";
    image.style.top=e.pageY-50+argY+"px";
    if(Math.random() >0.5){
        argX ++;
    }else{
        argX --;
    }
    if(Math.random() >0.5){
        argY ++;
    }else{
        argY --;
    }

}
