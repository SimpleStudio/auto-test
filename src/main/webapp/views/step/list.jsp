<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
  var stepDataGrid = $('#stepDataGrid').datagrid({
		url : '${ctx}' + '/step/dataGrid',
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
			title : '步骤名称',
			field : 'name',
			sortable : true
		} , {
			width : '25%',
			title : '步骤模板',
			field : 'expression',
			sortable : true
		}, {
			width : '50%',
			title : '提示信息',
			field : 'argsNum',
			sortable : false,
			formatter:function(val,row){
				if(val-row.setStepId==0){
					return "<font color='green'>参数设置完成</font>";
				}else if(val >0){
					return "<font color='red'>还有"+(val-row.setStepId)+"个参数需要设置，请展开进行设置</font>";
				}
			}
		}] ],
		toolbar : '#stepToolbar'
	});
	
</script>
<table id="stepDataGrid" style="width：800px;"></table>
<div id="stepToolbar" style="padding:2px 5px;">
    <table style="width: 100%;">
    	<tr>
    		<td>
    			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="saveStep(0)">新增</a>
    			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="saveStep(1)">编辑</a>
       			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="batchDelStep()">删除</a>
    		</td>
    		<td align="right">
      			<input id="stepSearchKey" class="easyui-textbox" data-options="buttonText:'搜索',buttonIcon:'icon-search',prompt:'请输入过滤的步骤名称'" style="width:250px;height:24px;">
    		</td>
    	</tr>
    </table>
</div>
<div id="stepDialog"></div>
<script type="text/javascript">
     $(function(){
    	 var stepLoader = function(param,success,error){
    		 var key = param.q;
    		 $.ajax({
    			 url: '${ctx}/constant/getConstList',
                 dataType: 'json',
                 method:'post',
                 data: {
                     key:key
                 },
    			 success:function(data){
                     success(data);
    			 },
    			 error:function(){
    				 error.apply(this, arguments);
    			 }
    		 });
    	 };
    	 var editSuGridIndex = -1;
         $('#stepDataGrid').datagrid({
        	 view: detailview,
             detailFormatter:function(index,row){
                 return '<div stle="over-flow:hidden;"><table class="ddv"></table></div>';
             },
             onExpandRow: function(index,row){
            	 if(row.argsNum ==0){
            		 return ;
            	 }
                 var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
                 ddv.datagrid({
                     url:'${ctx}/step/subDataGrid?stepId='+row.id,
                     loadMsg:"数据加载中...", 
                     singleSelect:true,
                     fitColumns:true,
                     height:'auto',
                     rownumbers:true,
                     columns:[[
                         {
                        	 field:'constant_id',
                        	 title:'参数值',
                        	 width:'98%', 
                        	 formatter:function(value,row){
                        		 if(row.name){
                        			 return row.name+'('+row.value+')';
                        		 }
    	                     },
                        	 editor:{
	                             type:'combobox',
	                             options:{
	                                 valueField:'id',
	                                 textField:'name',
	                                 mode:'remote',
	                                 loader:stepLoader,
	                                 required:true
	                             }}
                         	}
                     ]],
                     onResize:function(){
                    	 $('#stepDataGrid').datagrid('fixDetailRowHeight',index);
                     },
                     onLoadSuccess:function(){
                         setTimeout(function(){
                        	 $('#stepDataGrid').datagrid('fixDetailRowHeight',index);
                         },0);
                     },
                     onClickRow:function(index){
                    	 editSuGridIndex = index;
                    	 ddv.datagrid('beginEdit',index);
                     },
                     toolbar : [{
                    	 text : '保存',
                    	 iconCls:'icon-save',
                    	 handler:function(){
                    		 if(editSuGridIndex != -1){
	                    		 ddv.datagrid('endEdit',index);
	                    		 editSuGridIndex = -1;                    			 
                    		 }
                    		 var idArr = [];
                    		 var datas = ddv.datagrid('getData').rows;
                    		 for(var i=0;i<datas.length;i++){
                    			 var constId = datas[i].constant_id;
                    			 if(!constId){
                    				 $.messager.show({
                  		                title:'系统提示',
                  		                msg:'请设置好参数之后再保存！',
                  		                showType:'show'
                  		            });
                    				 return ;
                    			 }
                    			 idArr.push(constId);
                    		 }
                    		 $.post('${ctx}/step/saveStepParamValue',{stepId:row.id,constIds:idArr.join(',')},function(data){
                    			 ddv.datagrid('reload');
                    		 });
                   		 }
                     }]
                 });
                 $('#stepDataGrid').datagrid('fixDetailRowHeight',index);
             }
         });
     });
	function saveStep(type){
		var href = '${ctx}/step/savePage';
		if(type == 1){
			var selects = $('#stepDataGrid').datagrid('getSelections');
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
		$('#stepDialog').dialog({
			title : type==0?'添加步骤':'编辑步骤',
			width : 450,
			height : 235,
			href : href,
			modal:true,
			buttons:[{
				text:'确定',
				iconCls:'icon-ok',
				handler:function(){
					$('#stepManageForm').form('submit',{
						url:'${ctx }/step/save',
						success:function(){
							$('#stepDialog').dialog('close');
							$('#stepDataGrid').datagrid('reload');
						}
					});
				}
			},{
				text:'取消',
				iconCls:'icon-cancel',
				handler:function(){
					$('#stepDialog').dialog('close');
				}
			}]
		});
	}
	function batchDelStep(){
		$.messager.confirm('确认', '您确认删除选中的记录吗？', function(r){
			if (r){
				var selects = $('#stepDataGrid').datagrid('getSelections');
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
					$('#stepDataGrid').datagrid('reload');
				});
			}
		});
	}
	$('#stepSearchKey').textbox({
		onClickButton : function(){
			var searchKey = $('#stepSearchKey').textbox('getValue');
			$('#stepDataGrid').datagrid('load',{'key':searchKey});
		}
	});
</script>