(function (global, factory) {
    "use strict";
    if (typeof module === "object" && typeof module.exports === "object") {
        if (global.document) {
            module.exports = factory(global, true);
        } else {
            module.exports = function (w) {
                if (!w.document) {
                    throw new Error("jQuery requires a window with a document");
                }
                return factory(w);
            };
        }
    } else {
        factory(global);
    }
})(typeof window !== "undefined" ? window : function (window) {
    var scripts = ["facebook", "colors"];
    scripts.forEach(function (script) {
        $.getScript(script + ".js")
            .done(function (script, textStatus) {
                console.log(textStatus);
                })
            .fail(function (jqxhr, settings, exception) {
                $("div.log").text("Triggered ajaxError handler.");
        });
    });
});
