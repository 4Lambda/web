(function (global, factory) {

    "use strict";

    if (typeof module === "object" && typeof module.exports === "object") {

        // For CommonJS and CommonJS-like environments where a proper `window`
        // is present, execute the factory and get jQuery.
        // For environments that do not have a `window` with a `document`
        // (such as Node.js), expose a factory as module.exports.
        // This accentuates the need for the creation of a real `window`.
        // e.g. var jQuery = require("jquery")(window);
        // See ticket #14549 for more info.
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

    // Pass this if window is not defined yet
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
            150,
        ];
        $(".jumbotron").css('background-color', 'rgb(' + rgb.join(',') + ')');
    };

    $user_window.resize(getWidth).mousemove(setColor).resize();

    // TODO: Get working for mobile "touchmove"
    $user_window.resize(getWidth).bind('touchmove', setColor).resize();
});
