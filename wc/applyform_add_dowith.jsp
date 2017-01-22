<%--
/** Title:			applyform_addedit_dowith.jsp
 *  Description:
 *		处理ApplyForm的添加修改页面
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
 *		see applyform_addedit_dowith.xml
 *
 */
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" errorPage="../../../include/error.jsp"%>
<!------- WCM IMPORTS BEGIN ------------>
<%@ page import="com.trs.components.gkml.sqgk.persistent.ApplyForm" %>
<%@ page import="com.trs.infra.util.email.TRSMailer" %>
<%@ page import="com.trs.infra.util.email.CMyEmail" %>
<%@ page import="com.trs.infra.util.email.CMySMTPServer" %>
<%@ page import="com.trs.components.metadata.service.MailConfigsHelper" %>
<%@ page import="com.trs.cms.content.WCMObjHelper" %>
<%@ page import="com.trs.infra.util.database.TableInfo" %>
<%@ page import="com.trs.infra.persistent.db.DBManager" %>
<%@ page import="com.trs.infra.util.CMyString" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.trs.infra.util.CMyBitsValue" %>
<%@ page import="com.trs.infra.common.WCMException" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Hashtable,java.util.HashMap" %>
<%@ page import="com.trs.cms.auth.persistent.User" %>
<%@ page import="com.trs.ajaxservice.WCMApplyFormProcessServiceHelper" %>
<%@ page import="com.trs.components.gkml.sqgk.process.element.FlowContentApplyFormImpl" %>
<%@ page import="com.trs.infra.support.config.ConfigServer" %>
<%@ page import="com.trs.components.wcm.resource.Status" %>

<%@ page import="com.trs.web2frame.httpclient.HttpClientBuddy" %>
<%@ page import="com.trs.web2frame.httpclient.ResponseBuddy,java.io.ByteArrayOutputStream" %>
<!------- WCM IMPORTS END ------------>

<!--- 页面状态设定、登录校验、参数获取，都放在public_server.jsp中 --->
<%
//	User loginUser = User.getSystem();	
	String errorMsg = null;
	String sQueryCode = null;
	ApplyForm currApplyForm = null;

	try{
		ConfigServer oConfigServer = FlowContentApplyFormImpl.getConfigServer();
		String sUserAgent = oConfigServer.getSysConfigValue(
						"APPLYFORM_AGENT", "SYSTEM");
		User loginUser = User.findByName(sUserAgent);		
		if(loginUser==null){
			throw new Exception("没有正确配置依申请公开的代理用户，请在系统配置中配置APPLYFORM_AGENT！");
		}
		com.trs.cms.ContextHelper.setLoginUser(loginUser);
		currApplyForm = ApplyForm.createNewInstance();
		
		//6.业务代码
		try{
			TableInfo applyFormTableInfo = DBManager.getDBManager().getTableInfo(ApplyForm.DB_TABLE_NAME);
			Enumeration fields = applyFormTableInfo.getFieldNames();
			System.out.println("ceshi ");
			while(fields.hasMoreElements()){
				String fieldName = (String)fields.nextElement();
				
				String fieldValue = request.getParameter(fieldName);
				//System.out.println(fieldName+"=-------------!"+fieldValue);
				if(fieldValue == null){
					continue;
				}
				if(fieldName.trim().equals("DOC")==false){
					currApplyForm.setPropertyWithString(fieldName, fieldValue);
				}else{
					//System.out.println("2222"+fieldName+"！-------------="+fieldValue);
					//System.out.println(fieldName);
					//System.out.println(fieldValue);
				}
				byte[] bPostBody = getPostBody(request);
//				System.out.println(fieldValue+"---"+CMyString.getStr(fieldValue, true));
//				fieldValue = CMyString.getStr(fieldValue, true);
				//currApplyForm.setPropertyWithString(fieldName, fieldValue);
			}
			//set provider info type.
			setInfoType(
				request,
				currApplyForm,
				"INFOPROVIDERTYPE",
				new String[]{"pageProviderType","emailProviderType","cdProviderType","diskProviderType"}
			);

			//set get info type.
			setInfoType(
				request,
				currApplyForm,
				"INFOGETTYPE",
				new String[]{"postMailGetType","quickPostGetType","emailGetType","fixMailGetType","bySelfGetType"}
			);	
		} catch(Exception eInner){
			throw new Exception("保存数据时因属性值不正确而失败中止！");
		}
		String prefix = String.valueOf(Math.abs(currApplyForm.getPropertyAsString("email").hashCode()));
		sQueryCode = prefix + System.currentTimeMillis();
		currApplyForm.setQueryCode(sQueryCode);
		currApplyForm.setFlowStatus(Status.STATUS_ID_NEW);
		currApplyForm.save(loginUser);
		try{
			Map mailConfigs = MailConfigsHelper.getConfigs();
			sendMail(currApplyForm, mailConfigs);
		}catch(Exception mailException){
			mailException.printStackTrace();
		}
		WCMApplyFormProcessServiceHelper.startApplyFormInFlow(loginUser,
                    currApplyForm, new HashMap(0));
	//7.结束
		out.clear();
	}catch(Exception eOuter){
		eOuter.printStackTrace();
		errorMsg = eOuter.getMessage();
	}finally{
		//提交出现错误,删除已经保存的内容
		if(errorMsg != null && currApplyForm != null){
			currApplyForm.delete();
		}
	}
%>
<%!
	private void setInfoType(ServletRequest request, ApplyForm currApplyForm, 
			String fieldName, String[] aInfoType) throws WCMException{
		if(currApplyForm.getProperty(fieldName) != null){
			return;
		}
		long lInfoType = 0;
		for(int i = 0; i < aInfoType.length; i++){
			String sIndex = request.getParameter(aInfoType[i].toUpperCase());
			if(sIndex == null)
				continue;
			lInfoType = CMyBitsValue.setBit(lInfoType, Integer.parseInt(sIndex), true);
		}
		currApplyForm.setProperty(fieldName, lInfoType);
	}

    private void sendMail(ApplyForm currApplyForm, Map mailConfigs)throws Exception{
        try {
            // 构造邮件正文内容参数
            CMyEmail myEmail = new CMyEmail();
            myEmail.setFrom((String)mailConfigs.get("USERNAME"));
            myEmail.setTo(currApplyForm.getPropertyAsString("email"));
            myEmail.setSubject("依申请信息提交成功!");

			Map properties = new Hashtable();
			properties.putAll(currApplyForm.getProperties());
			properties.put("TO_USER", currApplyForm.getPropertyAsString("applyerName"));
			properties.put("FROM_USER", mailConfigs.get("USERNAME"));
			String sMailBodyTemplate = (String)mailConfigs.get("SUBMITMAILBODY");
			String sMailBody = CMyString.parsePageVariables(sMailBodyTemplate, properties);

            try {
                myEmail.setBody(sMailBody);
            } catch (Exception e) {
                throw new Exception("构造邮件内容失败!", e);
            }
            myEmail.setMailFormat(CMyEmail.FORMAT_HTML);

            TRSMailer currMailer = new TRSMailer();

            if (!currMailer.send(myEmail, getCMySMTPServer(mailConfigs))) {
                throw new WCMException("邮件发送失败!"
                        + currMailer.getMailLogString());
            }

        } catch (Exception ex) {
            throw new Exception("发送邮件出现异常！" + ex.toString());
        }
    } // END of testSendMail

    private CMySMTPServer getCMySMTPServer(Map mailConfigs) {
        CMySMTPServer smtpServer = new CMySMTPServer();
        smtpServer.setAuth(true);

        smtpServer.setUserName((String)mailConfigs.get("USERNAME"));
        smtpServer.setPassword((String)mailConfigs.get("PASSWORD"));
        smtpServer.setServerName((String)mailConfigs.get("SERVERNAME"));
		String sPort = (String)mailConfigs.get("SERVERPORT");
        smtpServer.setServerPort(Integer.parseInt(sPort));

        return smtpServer;
    }
%>

<%!
	private byte[] getPostBody(ServletRequest request) throws Exception{
		ServletInputStream inputStream = request.getInputStream();
		byte[] buffer = new byte[1024];
		int nLen = 0;
		ByteArrayOutputStream bos = new ByteArrayOutputStream(2048);

		while ((nLen = inputStream.read(buffer)) > 0) {
			bos.write(buffer, 0, nLen);
			System.out.println(bos.toString());
		}
		return bos.toByteArray();
	}
%>

<!DOCTYPE html PUBLIC
"-//W3C//DTD XHTML 1.0 Frameset//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>政府公开目录---依申请公开</title>
<link id="indexStyle" href="css/add_dowith.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../js/com.trs.util/Common.js" type="text/javascript"></script>
<style type="text/css">
    .infoRow{
        height:30px;
        line-height:30px;
    }
	.errorMsg{
		color:red;
	}
	.successContainer, .errorContainer{
		text-align:left;
		width:50%;
		margin-top:100px;
	}
	.errorContainer div{
		height:25px;
		line-height:25px;
	}
</style>
</HEAD>

<BODY>
<center>
<div class="container">
    <div class="header"></div>
	<div class="rowOfCurrentPosition" style="padding:0px;">当前位置：公开目录 &gt; 依申请公开 &gt; 提交结果</div>
	<center style="width:980px;">
    <div class="main" style="height: 480px;height:443\0;height: 464px\9;">
			<%
				if(errorMsg == null){
					String WCM_SERVICE_CHARSET = "UTF-8";
					String fieldValue = request.getParameter("DOC");
					String PostBody="DOC="+fieldValue;
					byte[] bPostBody = PostBody.getBytes();
					String sUrl="http://127.0.0.1:8086/wcm/WCMV6/gkml/sqgk/upload2.jsp";
					try {
						HttpClientBuddy oHttpClientBuddy = new HttpClientBuddy(
								WCM_SERVICE_CHARSET);
						ResponseBuddy oResponseBuddy = null;
						
						oResponseBuddy = oHttpClientBuddy.doPost(sUrl, bPostBody, false);
						
						out.print(oResponseBuddy.getBodyAsString());
					} catch (Exception ex) {
						out.println(ex.getMessage());
						ex.printStackTrace();
						// TODO 处理异常的情况
					}
			%>
				<div class="successContainer">
					<div class="infoRow" style="font-weight:bold;">申请信息提交成功</div>
					<div class="infoRow">您的申请已经提交成功，相关部门将会尽快办理</div>
					<div class="infoRow">您可以通过申请单的查询号查询到该申请的办理情况</div>
					<div class="infoRow">请您记住申请单的查询号[<b style="color:red;"><%=sQueryCode%></b>]，以供查询时使用</div>
					<div class="infoRow">同时系统已将查询号信息发送到您的邮箱</div>
				</div>
			<%
				}else{
			%>
			<center>
		        <div class="errorContainer">
                    <div style="font-weight:bold;">申请信息提交失败</div>
					<div>失败信息如下：</div>
					<div class="errorMsg"><%=errorMsg%></div>
					<div style="text-align:center;">
						<button onclick="window.history.back();">返回申请页面</button>
					</div>
				</div>
			</center>
			<%
				}
			%>
        </div>
    </div>
	</center>
    <div class="footer">
        <div class="footerLine"></div>
        <div>关于本站&nbsp;-&nbsp;使用帮助&nbsp;-&nbsp;联系我们</div>
        <div>技术支持：北京拓尔思信息技术股份有限公司</div>
        <div>Copyright&copy;2005-2012 All Rights Reserved 版权所有，未经授权，禁止转载</div>
        <div>ICP备案编号：京ICP备010164号</div>
        <div>建议使用IE5.5以上浏览器，分辨率1024*768</div>
    </div>
</div>
</center>
</BODY>
</HTML>