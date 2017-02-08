#import re;
#pattern = re.compile(r'"([wptscda]+(.*?)[ml])";',re.I)



def chouqu(filename):
    fileout = open(filename+"out.txt","a")
    filein = open(filename,"r")
    for line in filein:
    #    matche = pattern.match(line)
    #    if matche:
    #        fileout.write(matche.group(1)+'\n')
        temp = line.split(';')
        if temp:
            fileout.write(temp[0]+'\t'+temp[1]+'\t'+temp[2]+'\n')
        else:
            fileout.write('\n')
    if fileout.flush():#刷新缓冲区
        print ('Mission accomplished !')
    if filein.close:#关闭输入文件
        print("close filein")
    if fileout.close:#关闭输出文件
        print("close fileout")

for i in range(8):
    chouqu(str(i+1)+".txt")
    print("chou qu wan cheng")
