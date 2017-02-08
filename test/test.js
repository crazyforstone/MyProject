var uniqueInteger = (function () {
    var counter = 0;
    console.log("外"+counter);
    return function () {
        console.log("内"+counter)
        return counter++;
    };
}());

uniqueInteger();
console.log("=====1=====");
uniqueInteger();
console.log("=====2=====");
uniqueInteger();
console.log("=====3=====");
uniqueInteger();
console.log("=====4=====");
uniqueInteger();
console.log("=====5=====");

function counter(){
    var a = 0;
    return {
        count:function(){return a++;},
        reset:function(){return a = 0;}
    };
}

var c = counter(), d = counter();
console.log(c.count());
console.log(d.count());
console.log(c.count());
console.log(d.count());
console.log(c.reset());
console.log(c.count());
console.log(d.count());
