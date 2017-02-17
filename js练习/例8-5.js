if (!Function.prototype.bind) {
    Function.prototype.bind = function (o /*, args*/ ) {
        //将this和arguments的值保存至变量中
        //以便在后面嵌套的函数中可以使用它们
        var self = this,
            boundArgs = arguments;
        //bind()方法的返回值是一个函数
        return function () {
            //创建一个实参列表，将传入bind()的第二个及后续的实参都传入这个函数
            var args = [],
                i;
            for (i = 1; i < boundArgs.length; i++) args.push(boundArgs[i]);
            for (i = 0; i < boundArgs.length; i++) args.push(arguments[i]);
            //现在将self作为o的方法来调用，传入这些参数
            return self.apply(o, args);
        };
    };
}