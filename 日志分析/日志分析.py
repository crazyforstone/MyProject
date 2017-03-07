#_*_coding:utf-8_*_

import re

reg = re.compile(r"^(.*?)AbstractBatcher\.log(.*?)- (.*?)$",re.I)
fin = open('trsids_log.txt','r')
fout = open('trsids_log_out.txt','a+')
for line in fin:
    matche = reg.match(line)
    if matche:
        rec = matche.group(3)
        #print(rec)
        fout.write(rec+'\n')
    else:
        pass
        #print("no")
if fout.flush():#刷新缓冲区
    print ('Mission accomplished !')
if fin.close:#关闭输入文件
    print("close filein")
if fout.close:#关闭输出文件
    print("close fileout")
