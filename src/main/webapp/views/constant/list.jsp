<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
  var constantDataGrid = $('#constantDataGrid').datagrid({
		url : '${ctx}' + '/constant/dataGrid',
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
			width : '20%',
			title : '常量名称',
			field : 'name',
			sortable : true
		} , {
			width : '75%',
			title : '常量值',
			field : 'value',
			sortable : true
		}] ],
		toolbar : '#constantToolbar'
	});
	
</script>
<table id="constantDataGrid"></table>
<div id="constantToolbar" style="padding:2px 5px;">
    <table style="width: 100%;">
    	<tr>
    		<td>
    			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="save(0)">新增</a>
       			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="save(1)">编辑</a>
       			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="batchDel()">删除</a>
    		</td>
    		<td align="right">
      			<input id="constantSearchKey" class="easyui-textbox" data-options="buttonText:'搜索',buttonIcon:'icon-search',prompt:'请输入过滤的常量名称'" style="width:250px;height:24px;">
    		</td>
    	</tr>
    </table>
</div>
<div id="constantDialog"></div>
<script type="text/javascript">
	function save(type){
		var href = '${ctx}/constant/savePage';
		if(type == 1){
			var selects = $('#constantDataGrid').datagrid('getSelections');
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
		$('#constantDialog').dialog({
			title : type==0?'添加常量':'编辑常量',
			width : 450,
			height : 235,
			href : href,
			modal:true,
			buttons:[{
				text:'确定',
				iconCls:'icon-ok',
				handler:function(){
					$('#constantManageForm').form('submit',{
						url:'${ctx }/constant/save',
						success:function(){
							$('#constantDialog').dialog('close');
							$('#constantDataGrid').datagrid('reload');
						}
					});
				}
			},{
				text:'取消',
				iconCls:'icon-cancel',
				handler:function(){
					$('#constantDialog').dialog('close');
				}
			}]
		});
	}
	function batchDel(){
		$.messager.confirm('确认', '您确认删除选中的记录吗？', function(r){
			if (r){
				var selects = $('#constantDataGrid').datagrid('getSelections');
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
				$.post('${ctx}/constant/delete',{ids:ids},function(data){
					$('#constantDataGrid').datagrid('reload');
				});
			}
		});
	}
	$('#constantSearchKey').textbox({
		onClickButton : function(){
			var searchKey = $('#constantSearchKey').textbox('getValue');
			$('#constantDataGrid').datagrid('load',{'key':searchKey});
		}
	});
</script>