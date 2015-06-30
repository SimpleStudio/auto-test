<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${ctx}/jquery-easyui-1.4.2/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/jquery-easyui-1.4.2/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${ctx}/jquery-easyui-1.4.2/themes/color.css">
<link rel="stylesheet" type="text/css" href="${ctx}/style/studio.css">
<script type="text/javascript" src="${ctx}/jquery-easyui-1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
<title>自动化测试管理系统</title>
</head>

<body class="easyui-layout">
    <div data-options="region:'north'" style="height:65px;background:#eee;">
    	<span style="float: right; padding-right: 20px;padding-top: 20px;">欢迎 <b>系统管理员</b>&nbsp;&nbsp; <a href="javascript:void(0)" onclick="editUserPwd()" style="color: #0099FF">修改密码</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="logout()" style="color: #0099FF">安全退出</a>
        	&nbsp;&nbsp;&nbsp;&nbsp;
    		</span>
    		<span class="header"></span>
    </div>
    <div data-options="region:'south',collapsible:false" style="height:30px;text-align: center;"><a style="text-decoration: none;" href="https://github.com/simpleStudio">版权所有@SimpleStudio</a></div>
    <div data-options="region:'west',title:'菜单列表'" style="width:250px;background:#eee;">
    	<div id="aa" class="easyui-accordion" style="height: 100%;">
		    <div title="系统管理" data-options="iconCls:'icon_sysmng'" style="overflow:auto;padding:10px;">
		        <h3 style="color:#0099FF;">Accordion for jQuery</h3>
		        <p>Accordion is a part of easyui framework for jQuery. 
		        It lets you define your accordion component on web page more easily.</p>
		    </div>
		    <div title="自动化管理" data-options="iconCls:'icon_resource'">
		        content3
		    </div>
		</div>
    </div>
    <div data-options="region:'center'" style="background:#eee;">
    	<div id="tt" class="easyui-tabs">
		    <div title="首页" style="background:#eee;">
		        <h3>自动化测试管理系统</h3>
		    </div>
		</div>
    </div>
</body>
</html>