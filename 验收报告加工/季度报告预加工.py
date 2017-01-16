#_*_coding:UTF-8_*_

import re
reg = re.compile(r"(.*?)\tC2(.*?)\t(.*?)\n",re.I)
fin = open('test2.txt','r')
#str = fin.read()
for i in fin:
    print("=====")
    matche = reg.match(i)
    if matche:
        file_name = "TRS-R-750203验收报告("+matche.group(2)+")项目实施-"+matche.group(3)+".doc"
        print(file_name)
        fout = open(file_name,"w")
        fout.close
    print("=====")
fin.close()

fmod = open('mod.doc','r')
str = fmod.read()
print(str)
fmod.close()
