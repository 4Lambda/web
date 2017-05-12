"use strict";

var $user_window = $(window),
    width = 0,
    height = 0,
    rgb = [],
    getWidth = function() {
        width = $user_window.width();
        height = $user_window.height();
    };

$user_window.resize(getWidth).mousemove(function(e) {
    rgb = [
        Math.round(e.pageX/width * 255),
        Math.round(e.pageY/height * 255),
        150
    ];
    $(".jumbotron").css('background-color','rgb('+rgb.join(',')+')');
}).resize();
// TODO: Get working for mobile "touchmove"
//$user_window.resize(getWidth).on('touches', function(e) {
//    rgb = [
//        Math.round(e.pageX/width * 255),
//        Math.round(e.pageY/height * 255),
//        150
//    ];
//    $(".jumbotron").css('background-color','rgb('+rgb.join(',')+')');
//}).resize();
