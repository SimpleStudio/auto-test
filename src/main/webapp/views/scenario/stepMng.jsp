<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form id="stepManageForm" method="post">
	<input type="hidden" name="step.id" value="${step.id}"/>
	<table class="grid">
		<tr>
			<td>步骤名称</td>
			<td><input name="step.name" value="${step.name}" class="easyui-textbox" data-options="required:true,prompt:'请输入步骤名称'" style="width: 200px;"></td>
		</tr>
		<tr>
			<td>步骤模板</td>
			<td><input class="easyui-combobox" 
            name="step.tpl_id"
            id="stepTplId"
            value="${step.tpl_id}"
            style="width:200px;"
            data-options="required:true,prompt:'请输入模板名称',valueField:'id', textField:'expression',panelHeight:'auto',url:'${ctx}/steptpl/getStepTplList',method:'post',mode:'remote'"></td>
		</tr>
	</table>
</form>