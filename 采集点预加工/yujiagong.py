#!/usr/bin/env python
#_*_ coding:utf-8 _*_

import re;

#雷达URLtxt的全部字段
ziduan = ['"123";',#-0-起始点名称
'"";',#-1-网站名称
'"";',#-2-频道名称
'"";',#-3-所属分类
'1182;',#-4-起始频道编号
'1;',#-5-是否为社区论坛站点
'0;',#-6-是否选择RSS站点
'0;',#-7-是否使用源码脚本
'2;',#-8-扩展策略，默认按域扩展
'"";',#-9-源网页脚本
'"";',#-10-链接模板名称
'"";',#-11-链接脚本名称
'"";',#-12-包含什么样字符的url被采集，分号分隔
'"";',#-13-包含什么样字符的url不被采集，分号分隔
'"";',#-14-包含什么样字符的参数应被滤出，分号分隔
'"";',#-15-包含什么样字符的标题被采集，分号分隔
'"";',#-16-包含什么样字符的标题不被采集，分号分隔
'0;',#-17-页面采集深度策略
'1;',#-18-采集深度
'"";',#-19-包含什么样字符的url被更新
'"";',#-20-包含什么样字符的url不被更新
'0;',#-21-更新深度策略
'0;',#-22-更新层数
'"";',#-23-FORM置标
'"";',#-24-POST地址
'"";',#-25-POST参数
'1;',#-26-是否智能过滤内容
'1;',#-27-是否存储图片
'1;',#-28-是否存储文档
'1;',#-29-正文首行是否缩进
'1;',#-30-忽略隐藏置标
'"";',#-31-忽略标签，$分隔
'"";',#-32-META描述，$分隔
'"";',#-33-置标描述，$分隔
'"";',#-34-内容置标
'"";',#-35-内容模版名称，$分隔
'"";',#-36-内容脚本名称
'"";',#-37-HUB模板
'"";',#-38-论坛模板中帖子模板名称
'"";',#-39-论坛模板中主题模板名称
'"";',#-40-论坛模板中标题模板名称
'"content+authors";',#-41-论坛排重字段，加号分隔
'"sitename+channel+urltitle";',#-42-论坛主题判断字段，加号分隔
'1;',#-43-首页不入库设置
'0;',#-44-入库长度限制
'85;',#-45-图片长度限制
'85;',#-46-图片宽度限制
'3;',#-47-图片长宽比限制
'-1;',#-48-图片大小限制
'"";',#-49-链接包含什么样字符的可入库，分号分隔
'"";',#-50-链接包含什么样字符的不可入库，分号分隔
'"";',#-51-标题包含什么样字符的可入库，分号分隔
'"";',#-52-标题包含什么样字符的不可入库，分号分隔
'"";',#-53-内容包含什么样字符的可入库，分号分隔
'"";',#-54-内容包含什么样字符的不可入库，分号分隔
'0;',#-55-WCM频道号
'0;',#-56-认证方式
'"";',#-57-登录账号
'"";',#-58-登录密码
'"";',#-59-登录网址
'"";',#-60-登录参数
'"";',#-61-登录COOKIE
'"";',#-62-自定义请求头，$分隔
'0;',#-63-是否保持连接
'1;',#-64-选择协议版本号
'1;',#-65-是否选择gzip传输
'1;',#-66-代理策略
'"";',#-67-代理主机
'80;',#-68-代理端口
'"";',#-69-代理账号
'"";',#-70-代理密码
'"";',#-71-网页字符集设置
'"GB18030";',#-72-缺省字符集设置
'0;',#-73-URL编码
'1;',#-74-URL转义
'"test";',#-75-分组名称
'0;',#-76-是否已删除
'0;',#-77-支持内容更新
'"";',#-78-多页合并置标
'"";',#-79-多页合并，正文分隔符
'"";',#-80-资源库配置号
'1;',#-81-站点优先级
'""'];#-82-点的域值

pattern = re.compile(r'(.*?)\thttp://(.*?)\t',re.I)#正则表达式
fileout = open("out.txt","a")#打开输出文件
filein = open("test.txt","r")#打开输入文件

print 'loading...'
for line in filein:
    matche = pattern.match(line)#对每行文字进行匹配
    if matche:
        #print matche.group(1)+"#"+matche.group(2);
        #temp = matche.group(1)+"#-"+str(i)+"-"+matche.group(2)+"\n";
        #fileout.write(temp);
        rec = '"'+matche.group(2)+'";"'+matche.group(1)+'";'#拼接起始点与网站名称
        for i in range(83):
            if i in (0,1):#跳过前两个字段
                continue
            rec = rec + ziduan[i]#拼接剩余字段
        rec = rec + '\n'#换行结尾
        fileout.write(rec)#写入输出文件
print 'Mission accomplished !'
if filein.close:#关闭输入文件
    print("close filein")
if fileout.close:#关闭输出文件
    print("close fileout")
