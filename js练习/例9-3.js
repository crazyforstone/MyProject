/*
 *Complex.js:
 *这个文件定义了Complex类，用来描述复数
 *回忆一下，复数是实数和虚数的和，并且虚数i是-1的平方根
 */

/*
 *这个构造函数为它所创建的每个实例定义了实例字段r和i
 *这两个字段分别保存复数的实部和虚部
 *它们是对象的状态
 */
function Complex(real, imaginary) {
    if (isNaN(real) || isNaN(imaginary)) //确保两个实参都是数字
        throw new TypeError(); //如果不都是数字则抛出错误
    this.r = real; //复数的实部
    this.i = imaginary; //复数的虚部
}

/*
 *类的实例方法定义为原型对象的函数值属性
 *这里定义的方法可以被所有实例继承，并未它们提供共享的行为
 *需要注意的是，JavaScript的实例方法必须使用关键字this
 *来存取实例的字段
 */

//当前复数对象加上另外一个复数，并返回一个新的计算和值后的复数对象
Complex.prototype.add = function (that) {
    return new Complex(this.r + that.r, this.i + that.i);
};

//当前复数乘以另外一个复数，并返回一个新的计算乘积之后的复数对象
Complex.prototype.mul = function (that) {
    return new Complex(this.r * that.r - this.i * that.i, this.r * that.i + this.i * that.r);
};

//计算复数的模，复数的模定义为原点（0，0）到复平面的距离
Complex.prototype.mag = function () {
    return Math.sqrt(this.r * this.r + this.i * this.i);
};

//复数的求负运算
Complex.prototype.neg = function () {
    return new Complex(-this.r, -this.i);
};

//将复数对象转换为一个字符串
Complex.prototype.toString = function () {
    return "{" + this.r + "," + this.i + "}";
};

//检测当前复数对象是否和另一个复数值相等
Complex.prototype.equals = function (that) {
    return that != null && //必须有定义且不能是null
        that.constructor === Complex && //并且必须是Complex的实例
        this.r === that.r && this.i === that.i; //并且必须包含相同的值
};

/*
 *类字段（比如常量）和类方法直接定义为构造函数的属性
 *需要注意的是，类的方法通常不使用关键字this，
 *它们只对其参数进行操作
 */

//这里预定义了一些对复数运算有帮助的类字段
//它们的命名全都是大写，用以表明它们是常量
//（在ECMAScript5中，还能设置这些类字段的属性为只读）
Complex.ZERO = new Complex(0, 0);
Complex.ONE = new Complex(1, 0);
Complex.I = new Complex(0, 1);

//这个类方法将有实例对象的toString方法返回的字符串格式解析为一个Complex对象
//或者抛出一个类型错误异常
Complex.parse = function (s) {
    try { //假设解析成功
        var m = Complex._format.exec(s); //利用正则表达式进行匹配
        return new Complex(parseFloat(m[1]), parseFloat(m[2]));
    } catch (x) { //如果解析失败则抛出异常
        throw new TypeError("can't parse '" + s + "'as a complex number.");
    }
};

//定义类的“私有”字段，这个字段在Complex.parse()中用到了
//下划线前缀表明它是类内部使用的，而不属于类的公有API的部分
Complex._format = /^\{([^,]+),([^]+)\}$/;

//返回当前复数的共轭复数
Complex.prototype.conj=function(){
    return new Complex(this.r,-this.i);
};
