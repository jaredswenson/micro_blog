<<<<<<< HEAD
$(document).ready(function() {
    $("#b").animate({left: "+=500"}, 2000);
    $("#b").animate({left: "-=300"}, 1000);
});

function birdLeft() {
    $("#b").animate({left: "-=500"}, 2000, "swing", birdRight);
}
function birdRight() {
    $("#b").animate({left: "+=500"}, 2000, "swing", birdLeft);
}

birdRight();
=======
>>>>>>> master
