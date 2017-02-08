function printprops(o) {
    for (var p in o) {
        console.log(p + ":" + o[p] + "\n");
    }
}

function distance(x1, y1, x2, y2) {
    var dx = x2 - x1;
    var dy = y2 - y1;
    return Math.sqrt(dx * dx + dy * dy);
}

function favtorial(x) {
    if (a <= 1) return 1;
    return x * factorial(x - 1);
}

var square = function(x) {
    return x * x;
}

var f = function fact(x) {
    if (x <= 1) return 1;
    else return x * fact(x - 1);
};

data.sort(function(a, b) {
    return a - b;
});

var tensquared = (function(x) {
    return x * x;
}(10));

