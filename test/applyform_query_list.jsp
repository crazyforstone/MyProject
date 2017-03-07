<%--
/** Title:			applyform_add.jsp
 *  Description:
 *		ApplyForm的添加修改页面
 *  Copyright: 		www.trs.com.cn
 *  Company: 		TRS Info. Ltd.
 *  Author:			TRS WCM 6.0
 *  Created:		2008-02-20 20:18:05
 *  Vesion:			1.0
 *  Last EditTime:	2008-02-20 / 2008-02-20
 *	Update Logs:
 *		TRS WCM 6.0@2008-02-20 产生此文件
 *
 *  Parameters:
 *		see applyform_add.xml
 *
 */
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8"
	errorPage="../../../include/error.jsp"%>
<!------- WCM IMPORTS BEGIN ------------>
<%@ page import="com.trs.components.wcm.content.persistent.Appendix"%>
<%@ page import="com.trs.components.wcm.content.persistent.Appendixes"%>
<%@ page import="com.trs.infra.persistent.WCMFilter"%>
<%@ page import="com.trs.infra.support.file.FilesMan"%>
<%@ page import="com.trs.infra.util.CMyFile"%>
<%@ page import="com.trs.infra.util.CMyString"%>
<!------- WCM IMPORTS END ------------>
<%@ page import="com.trs.components.gkml.sqgk.persistent.ApplyForm"%>
<%@ page import="com.trs.components.gkml.sqgk.persistent.ApplyForms"%>
<%@ page import="com.trs.components.gkml.sqgk.constant.ApplyFormConstants"%>
<%@ page import="com.trs.components.gkml.sqgk.SqgkFileUtil"%>

<HTML>

<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>政府公开目录---依申请公开</title>
	<link id="indexStyle" href="css/add.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="../js/com.trs.util/Common.js" type="text/javascript"></script>
	<script language="javascript" src="applyform_query_dowith.js" type="text/javascript"></script>
	<style type="text/css">
		.listHead {
			margin: 0px 0px;
			padding: 4px 8px;
			background: #F1F1F1;
			font-weight: bold;
			border-top: 1px solid silver;
			border-bottom-style: solid;
			border-width: 1px;
		}
		
		.listData {
			width: 100%;
			height: 100%;
			overflow-y: auto;
		}
		
		.activeRow {
			background-color: #FFFFCC;
		}
		
		.row li {
			list-style-type: none;
			margin: 0px;
			padding: 0px;
			height: 22px;
			line-height: 22px;
			text-align: center;
		}
		
		.listHead li {
			font-weight: bold;
		}
		
		.listData li {
			border-right-style: solid;
			border-bottom-style: solid;
			border-width: 1px;
		}
		
		.listData .autoColumn {
			text-align: left;
			text-align: center;
			overflow: hidden;
			text-overflow: ellipsis;
		}
	</style>

</HEAD>

<BODY>
	<div class="container" style="MARGIN:0 AUTO">
		<div class="header">
			<div class="headerLeft"></div>
			<div class="headerRight"></div>
		</div>
		<div class="rowOfCurrentPosition">当前位置：公开目录 &gt; 依申请公开 &gt; 查询结果</div>
		<div class="listHead">
			<div class="row">
				<li style="float:left;width:120px;overflow:hidden;">申请人</li>
				<li style="float:left;width:120px;">类型</li>
				<li style="float:left;width:150px;overflow:hidden;">索引号</li>
				<li style="float:right;width:150px;">处理时间</li>
				<li style="float:right;width:120px;">申请时间</li>
				<li style="float:right;width:120px;">处理状态</li>
				<li class="autoColumn">内容</li>
			</div>
		</div>
		<div class="listData" id="listData">
<%
	for(int i=0; i<=2; i++)
	{
%>
			<div class="row" id="row_<%=i%>" +>
				<li class="autoColumn" style="border-left-style:solid;float:left;width:120px;overflow:hidden;">1</li>
				<li style="float:left;width:120px;overflow:hidden;">公民</li>
				<li style="float:left;width:150px;overflow:hidden;">3</li>
				<li style="float:right;width:150px;overflow:hidden;">1</li>
				<li style="float:right;width:120px;overflow:hidden;">1</li>
				<li style="float:right;width:120px;overflow:hidden;">1</li>
				<li class="autoColumn">2</li>
			</div>
<%
	}
%>
			<div class="footer">
				<div class="footerLine"></div>
				<div>关于本站&nbsp;-&nbsp;使用帮助&nbsp;-&nbsp;联系我们</div>
				<div>技术支持：北京拓尔思信息技术股份有限公司</div>
				<div>Copyright&copy;2005-2012 All Rights Reserved 版权所有，未经授权，禁止转载</div>
				<div>ICP备案编号：京ICP备010164号</div>
				<div>建议使用IE5.5以上浏览器，分辨率1024*768</div>
			</div>
		</div>

</BODY>

</HTML>