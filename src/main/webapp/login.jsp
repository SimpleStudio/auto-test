<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="views/common/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${ctx}/jquery-easyui-1.4.2/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/jquery-easyui-1.4.2/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${ctx}/jquery-easyui-1.4.2/themes/color.css">
<script type="text/javascript" src="${ctx}/jquery-easyui-1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/jquery-easyui-1.4.2/locale/easyui-lang-zh_CN.js"></script>
<title>登陆</title>
</head>
<body>
<div id="loginWin" class="easyui-window" title="自动化测试管理系统-登录" style="width:350px;height:188px;padding:5px;"
   minimizable="false" maximizable="false" resizable="false" collapsible="false" draggable="false" data-options="modal:true,closable:false">
    <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding:10px 0 10px 35px;background:#fff;border:1px solid #ccc;">
        <form id="loginForm" method="post">
        	<table>
        		<tr>
        			<td>帐号：</td>
        			<td><input class="easyui-validatebox easyui-textbox" data-options="required:true,prompt:'请输入帐号',iconCls:'icon-man',iconWidth:38" style="height:30px" name="account" id="account"></td>
        		</tr>
        		<tr>
        			<td>密码：</td>
        			<td><input class="easyui-validatebox easyui-textbox" data-options="required:true,prompt:'请输入密码',iconCls:'icon-lock',iconWidth:38" style="height:30px" name="password"></td>
        		</tr>
        	</table>
             <div style="padding:5px 0;text-align: center;color: red;" id="showMsg"></div>
        </form>
            </div>
            <div region="south" border="false" style="text-align:center;padding:5px 0;">
                <a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="login()">登录</a>
                <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="cleardata()">重置</a>
            </div>
    </div>
</div>
<script type="text/javascript">
	function reset(){
	    $('#loginForm').form('clear');
	}
	$(document).ready(function(){
		document.onkeydown = function(e){
		    var event = e || window.event;  
		    var code = event.keyCode || event.which || event.charCode;
		    if (code == 13) {
		        login();
		    }
		}
	    $("#account").focus();
	});

function login(){
     if($("input[name='login']").val()=="" || $("input[name='password']").val()==""){
         $("#showMsg").html("用户名或密码为空，请输入");
         $("input[name='login']").focus();
    }else{
            //ajax异步提交  
           $.ajax({            
                  type:"POST",   //post提交方式默认是get
                  url:"login.action", 
                  data:$("#loginForm").serialize(),   //序列化               
                  error:function(request) {      // 设置表单提交出错                 
                      $("#showMsg").html(request);  //登录错误提示信息
                  },
                  success:function(data) {
                      document.location = "index.action";
                  }            
            });       
        } 
}
</script>
</body>
</html>