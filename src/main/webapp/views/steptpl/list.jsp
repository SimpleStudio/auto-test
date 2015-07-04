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
			title : '模板名称',
			field : 'name',
			sortable : true
		} , {
			width : '60%',
			title : '模板内容',
			field : 'expression',
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
    			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="save(0)">新增</a>
       			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="save(1)">编辑</a>
       			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="batchDel()">删除</a>
    		</td>
    		<td align="right">
      			<input class="easyui-textbox" data-options="buttonText:'搜索',buttonIcon:'icon-search',prompt:'请输入过滤的模板名称'" style="width:250px;height:24px;">
    		</td>
    	</tr>
    </table>
</div>
<div id="savePageDialog"></div>
<script type="text/javascript">
	function save(type){
		var href = '${ctx}/steptpl/savePage';
		if(type == 1){
			var selects = $('#dataGrid').datagrid('getSelections');
			if(!selects || selects.length == 0){
				$.messager.show({
	                title:'系统提示',
	                msg:'请选择一行进行编辑！',
	                showType:'show'
	            });
				return ;
			}
			if(selects && selects.length>1){
				$.messager.show({
	                title:'系统提示',
	                msg:'您只能选择一行进行编辑！',
	                showType:'show'
	            });
				return ;
			}
			href+="?id="+selects[0].id;
		}
		$('#savePageDialog').dialog({
			title : '添加步骤模板',
			width : 450,
			height : 235,
			href : href,
			modal:true,
			buttons:[{
				text:'确定',
				iconCls:'icon-ok',
				handler:function(){
					$('#tplManageForm').form('submit',{
						url:'${ctx }/steptpl/save',
						success:function(){
							$('#savePageDialog').dialog('close');
							$('#dataGrid').datagrid('reload');
						}
					});
				}
			},{
				text:'取消',
				iconCls:'icon-cancel',
				handler:function(){
					$('#savePageDialog').dialog('close');
				}
			}]
		});
	}
	function batchDel(){
		$.messager.confirm('确认', '您确认删除选中的记录吗？', function(r){
			if (r){
				var selects = $('#dataGrid').datagrid('getSelections');
				if(selects.length == 0){
					$.messager.show({
		                title:'系统提示',
		                msg:'请选择要删除的记录！',
		                showType:'show'
		            });
					return ;
				}
				var ids = "";
				for(var i=0;i<selects.length;i++){
					if(i>0){
						ids+=",";
					}
					ids+=selects[i].id;
				}
				$.post('${ctx}/steptpl/delete',{ids:ids},function(data){
					$('#dataGrid').datagrid('reload');
				});
			}
		});
		
	}
</script>