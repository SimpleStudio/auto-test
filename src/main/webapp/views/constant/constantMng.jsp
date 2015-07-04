<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form id="constantManageForm" method="post">
	<input type="hidden" name="constant.id" value="${constant.id}"/>
	<table class="grid">
		<tr>
			<td>常量名称</td>
			<td><input name="constant.name" value="${constant.name}" class="easyui-textbox" data-options="required:true,prompt:'请输入常量名称'" style="width: 200px;"></td>
		</tr>
		<tr>
			<td>常量值</td>
			<td><input name="constant.value" value="${constant.value}" class="easyui-textbox" data-options="multiline:true,required:true,prompt:'请输入常量值'" style="width:250px;height:100px"></td>
		</tr>
	</table>
</form>