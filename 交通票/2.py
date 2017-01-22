#_*_coding:UTF-8_*_


tup_confirm = ('y','Y','')
"""
data_input(flag):
主要处理数据录入
参数作用判断是否开始执行该方法
"""
def data_input(flag):
    f = open('123.txt','a')
    while(flag in tup_confirm):
        name = raw_input("姓名:\n")
        money = raw_input("票额:\n")
        print("你输入的是:\n姓名:" + name + " $票额:" + money)
        flag_confirm = raw_input("确认输入?\n")
        if flag_confirm in tup_confirm:
            f.write(name + '$' + money + '\n')
        else:
            flag_confirm = raw_input("是否重新输入?\n")
            if flag_confirm in tup_confirm:
                print("已记录。\n")
                continue
            else:
                break
        flag = raw_input("是否继续输入?\n")
    print("已存档。\n")
    f.close()


"""
main
程序主流程
"""

flag = raw_input("开始输入?\n")
#data_input(flag)
f = open('123.txt','a+')
c = f.read()
print("1."+str(c))
f.seek(c.find("!@#$%^&*()")+14)
print(f.tell())
c = f.readlines()
print("2."+str(c))


#a = f.readline()
#b = 0
#print(len(a))
#print(c)
"""
for i in a:
    i = i.replace('\n','')
    print("ccccc" + str(c.find("!@#$%^&*()")))
    if i == "!@#$%^&*()":
        print("fen ge xian");
    else:
        b = b + 1;
        print(i)
        print(b)
"""
f.close()


