//这个函数给对象o增加了属性存取器方法
//方法名称位get<name>和set<name>。如果提供了一个判定函数
//setter方法就会用它来检测参数的合法性，然后在存储它
//如果判定函数返回false，setter方法抛出一个异常
//
//这个函数有一个非同寻常之处，就是getter和setter函数
//所操作的属性值并没有存储在对象o中
//相反，这个值仅仅是保存在函数中的局部变量中
//getter和setter方法同样是局部函数，因此可以访问这个局部变量
//也就是说，对于两个存取器方法来说这个变量是私有的
//没有办法绕锅存取器方法来设置或修改这个值
function addPrivateProperty(o, name, predicate) {
    var value; //这是一个属相值

    //getter方法简单的将其返回
    o["get" + name] = function () {
        return value;
    };
    //setter方法首先检查值是否合法，若不合法就抛出异常
    //否则就将其存储起来
    o["set" + name] = function (v) {
        if (predicate && !predicate(v))
            throw Error("set" + name + ":invalid value " + v);
        else
            value = v;
    };
}

//下面代码展示了addPrivateProperty()方法
var o = {}; //设置一个空对象

//增加属性存取器方法getName()和settet()
//确保只允许字符串值
addPrivateProperty(o, "Name", function (x) {
    return typeof x == "string";
});

o.setName("Frank"); //设置属性值
console.log(o.getName()); //得到属性值
o.setName(o); //视图设置一个错误类型的值