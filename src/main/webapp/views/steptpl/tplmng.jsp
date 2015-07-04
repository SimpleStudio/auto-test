<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form id="tplManageForm" method="post">
	<input type="hidden" name="stepTpl.id" value="${stepTpl.id}"/>
	<table class="grid">
		<tr>
			<td>模板名称</td>
			<td><input name="stepTpl.name" value="${stepTpl.name}" class="easyui-textbox" data-options="required:true,prompt:'请输入模板名称'" style="width: 200px;"></td>
		</tr>
		<tr>
			<td>模板内容</td>
			<td><input name="stepTpl.expression" value="${stepTpl.expression}" class="easyui-textbox" data-options="multiline:true,required:true,prompt:'请输入模板内容'" style="width:250px;height:100px"></td>
		</tr>
	</table>
</form>