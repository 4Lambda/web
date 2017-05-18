(function (global, factory) {
    "use strict";
    if (typeof module === "object" && typeof module.exports === "object") {
        module.exports = global.document ?
            factory(global, true) :
            function (w) {
                if (!w.document) {
                    throw new Error("jQuery requires a window with a document");
                }
                return factory(w);
            };
    } else {
        factory(global);
    }
})(typeof window !== "undefined" ? window : this, function (window) {
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
});
