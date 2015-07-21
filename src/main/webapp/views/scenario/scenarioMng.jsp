<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form id="scenarioManageForm" method="post">
	<input type="hidden" name="scenario.id" value="${scenario.id}"/>
	<table class="grid">
		<tr>
			<td>场景名称</td>
			<td><input name="scenario.name" value="${scenario.name}" class="easyui-textbox" data-options="required:true,prompt:'请输入场景名称'" style="width: 200px;"></td>
		</tr>
		<tr>
			<td>场景描述</td>
			<td><input name="scenario.remark" value="${scenario.remark}" class="easyui-textbox" data-options="multiline:true,prompt:'请输入场景内容'" style="width:250px;height:100px"></td>
		</tr>
	</table>
</form>