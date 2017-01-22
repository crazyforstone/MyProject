<%@ page contentType="text/html;charset=UTF-8" pageEncoding="GBK"
	errorPage="../include/error.jsp"%>

<%@ page import="com.trs.web2frame.httpclient.HttpClientBuddy" %>
<%@ page import="com.trs.web2frame.httpclient.ResponseBuddy,java.io.ByteArrayOutputStream" %>

<%@ page import="com.trs.FileUploadBean" %>

<%@ page import = "java.io.File" %>
<%@ page import = "java.util.ResourceBundle" %>
<%@ page import = "java.util.List" %>
<%@ page import = "org.apache.commons.fileupload.DiskFileUpload" %>
<%@ page import = "org.apache.commons.fileupload.FileItem" %>


<%@ page import = "java.util.Iterator" %>


<%	
	String WCM_HOST = "http://127.0.0.1:"+request.getServerPort()+"/wcm";

	// 实施人员需要将注释去掉，按照以下规则，根据WCM的所在机器以及端口修改	
	WCM_HOST = "http://127.0.0.1:8086/wcm";	
%>

<%
	

	byte[] bPostBody = getPostBody(request);
	
	String bPostBodystring = new String(bPostBody);
	System.out.println(bPostBodystring);

	String WCM_SERVICE_CHARSET = "UTF-8";
	String sUrlPrefix = WCM_HOST + "/WCMV6/gkml/sqgk/";
	String sUrl = (String)request.getParameter("url");

	String rand = (String)session.getAttribute("rand");
	if(rand == null || !rand.equals(request.getParameter("RAND"))){
		throw new Exception("输入的验证码错误！");
	}
	session.removeAttribute("rand");

	if(sUrl == null){
		throw new Exception("没有传入要访问的url地址" );
	}
	sUrl = sUrlPrefix + sUrl;
	//System.out.println(sUrl);
	boolean _bPost = request.getMethod().equalsIgnoreCase("POST");

	try {
		HttpClientBuddy oHttpClientBuddy = new HttpClientBuddy(
				WCM_SERVICE_CHARSET);
		ResponseBuddy oResponseBuddy = null;
		if (_bPost) {
			oResponseBuddy = oHttpClientBuddy.doPost(sUrl, bPostBody, false);
		} else {
			oResponseBuddy = oHttpClientBuddy.doGet(sUrl, new String(bPostBody, "UTF-8"));
		}
		out.print(oResponseBuddy.getBodyAsString());
	} catch (Exception ex) {
		out.println(ex.getMessage());
		ex.printStackTrace();
		// TODO 处理异常的情况
	}
%>

<%!
	private byte[] getPostBody(ServletRequest request) throws Exception{
		ServletInputStream inputStream = request.getInputStream();
		byte[] buffer = new byte[1024];
		int nLen = 0;
		ByteArrayOutputStream bos = new ByteArrayOutputStream(2048);
		System.out.println("开始输出数据");
		while ((nLen = inputStream.read(buffer)) > 0) {
			bos.write(buffer, 0, nLen);
			//System.out.println(bos.toString()+"结束");
		}
		return bos.toByteArray();
	}
%>