/**
 * 以字符串形式返回o的类型：
 * -如果o是null，则返回“null”；如果o是NaN，返回“NaN”
 * -如果typeof所返回的值不是“object”，则返回这个值
 * （注意，有一些JavaScript的实现将正则表达式识别为函数）
 * -如果o的类不是“Object”，则返回这个值
 * -如果o包含构造函数并且这个构造函数具有名称，则返回这个名称
 * -否则，一律返回“Object”
 **/
function type(o){
    var t,c,n;//type,class,name
    //处理null值的特殊情形
    if(o===null) return "null";
    //另一种特殊情况：NaN和它自身不相等
    if(o!==o)return "NaN";
    //如果typeof的值不是“object”，则使用这个值
    //这可以识别出原始值的类型函数
    if((t=typeof o)!=="object")return t;
    //返回对象的类名，除非值为“Object”
    //这种方式可以识别出大多数的内置对象
    if((c=classof(o))!=="Object")return c;
    //如果对象构造函数的名字存在的话，则返回它
    if(o.cinstructor &&typeof o.constructor ==="function"&&(n=o.constructor.getName()))return n;
    //其他的类型都无法判别，一律返回“Object”
    return "Object";
}

//返回对象的类
function classof(o){
    return Object.prototype.toString.call(o).slice(8,-1);
};

//返回函数的名字（可能是空字符串），不是函数的话返回null
Function.prototype.getName=function(){
    if("name"in this)return this.name;
    return this.name=this.toString().match(/function\s*([^(]*)\(/)[1];
};