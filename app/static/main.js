$(document).ready(function () {
    "use strict";
    var scripts = ["colors"];
    scripts.forEach(function (script) {
        $.getScript("./static/" + script + ".js").done(function (script, textStatus) {
            console.log(textStatus);
        }).fail(function (jqxhr, settings, exception) {
            console.log(jqxhr, settings, exception);
        });
    });
});
