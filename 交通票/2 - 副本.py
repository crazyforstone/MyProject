#_*_coding:GBK_*_


tup_confirm = ('y','Y','')
"""
data_input(flag):
��Ҫ��������¼��
���������ж��Ƿ�ʼִ�и÷���
"""
def data_input(flag):
    f = open('123.txt','a')
    while(flag in tup_confirm):
        name = raw_input("����:\n")
        money = raw_input("Ʊ��:\n")
        print("���������:\n����:" + name + " $Ʊ��:" + money)
        flag_confirm = raw_input("ȷ������?\n")
        if flag_confirm in tup_confirm:
            f.write(name + '$' + money + '\n')
        else:
            flag_confirm = raw_input("�Ƿ���������?\n")
            if flag_confirm in tup_confirm:
                print("�Ѽ�¼��\n")
                continue
            else:
                break
        flag = raw_input("�Ƿ��������?\n")
    print("�Ѵ浵��\n")
    f.close()


"""
main
����������
"""

flag = raw_input("��ʼ����?\n")
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


