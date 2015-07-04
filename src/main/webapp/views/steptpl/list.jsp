<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
  var dataGrid = $('#dataGrid').datagrid({
		url : '${ctx}' + '/steptpl/dataGrid',
		striped : true,
		rownumbers : true,
		pagination : true,
		fitColumns : true,
		fit : true,
		singleSelect : false,
		pageSize : 50,
		pageList : [ 30, 50, 100],
		columns : [ [ {
			field : 'ck',
			checkbox:true,
			width:30
		}, {
			field : 'id',
			hidden : true
		}, {
			width : '35%',
			title : '步骤名称',
			field : 'name',
			sortable : true
		} , {
			width : '60%',
			title : '步骤模板',
			field : 'tpl',
			sortable : true
		}] ],
		toolbar : '#toolbar'
	});
	
</script>
	<table id="dataGrid"></table>
    <div id="toolbar" style="padding:2px 5px;">
        <table style="width: 100%;">
        	<tr>
        		<td>
        			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
			        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
			        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        		</td>
        		<td align="right">
		        	<input class="easyui-textbox" data-options="buttonText:'搜索',buttonIcon:'icon-search',prompt:'请输入过滤的模板名称'" style="width:250px;height:24px;">
        		</td>
        	</tr>
        </table>
    </div>