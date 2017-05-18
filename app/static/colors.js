"use strict";

var $user_window = $(window),
    width = 0,
    height = 0,
    rgb = [],
    getWidth = function () {
        width = $user_window.width();
        height = $user_window.height();
    };
var setColor = function (event) {
    rgb = [
        Math.round(event.pageX / width * 255),
        Math.round(event.pageY / height * 255),
        150
    ];
    $(".jumbotron").css('background-color', 'rgb(' + rgb.join(',') + ')');
};
$user_window.resize(getWidth).mousemove(setColor).resize();

// TODO: Get working for mobile "touchmove"
//$user_window.resize(getWidth).bind('touchmove', setColor).resize();
