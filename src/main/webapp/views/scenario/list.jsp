<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
  var scenarioDataGrid = $('#scenarioDataGrid').datagrid({
		url : '${ctx}' + '/scenario/dataGrid',
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
			title : '场景名称',
			field : 'name',
			sortable : true
		} , {
			width : '60%',
			title : '场景描述',
			field : 'remark'
		}] ],
		toolbar : '#scenarioToolbar'
	});
	
</script>
<table id="scenarioDataGrid" style="width：800px;"></table>
<div id="scenarioToolbar" style="padding:2px 5px;">
    <table style="width: 100%;">
    	<tr>
    		<td>
    			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="saveStep(0)">新增</a>
    			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="saveStep(1)">编辑</a>
       			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="batchDelStep()">删除</a>
    		</td>
    		<td align="right">
      			<input id="scenarioSearchKey" class="easyui-textbox" data-options="buttonText:'搜索',buttonIcon:'icon-search',prompt:'请输入过滤的步骤名称'" style="width:250px;height:24px;">
    		</td>
    	</tr>
    </table>
</div>
<div id="scenarioDialog"></div>
<script type="text/javascript">
     $(function(){
    	 function initOperate(datagrid){
    		 var removeHtml = "<a href='javascript:;' style='margin-right:10px;'><img src='${ctx}/img/remove.png' style='border:0'/></a>";
        	 var upHtml = "<a href='javascript:;' style='margin-right:10px;'><img src='${ctx}/img/up.png' style='border:0'/></a>";
        	 var downHtml = "<a href='javascript:;' style='margin-right:10px;'><img src='${ctx}/img/down.png' style='border:0'/></a>";
    	 }
    	 var stepLoader = function(param,success,error){
    		 var key = param.q;
    		 $.ajax({
    			 url: '${ctx}/scenario/getStepList',
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
         $('#scenarioDataGrid').datagrid({
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
                     url:'${ctx}/scenario/subGrid?scenId='+row.id,
                     loadMsg:"数据加载中...", 
                     singleSelect:true,
                     fitColumns:true,
                     height:'auto',
                     rownumbers:true,
                     columns:[[
                         {
                        	 field:'name',
                        	 title:'步骤名称',
                        	 width:'80%',
                        	 editor:{
	                             type:'combobox',
	                             options:{
	                                 valueField:'id',
	                                 textField:'name',
	                                 mode:'remote',
	                                 loader:stepLoader,
	                                 required:true
	                             }}
                         	},{
                         		field:'format',
                         		title:'操作',
                         		width:'15%',
                         		formatter:function(){
                         			return removeHtml+upHtml+downHtml;
                         		}
                         	}
                     ]],
                     onResize:function(){
                    	 $('#scenarioDataGrid').datagrid('fixDetailRowHeight',index);
                     },
                     onLoadSuccess:function(){
                         setTimeout(function(){
                        	 $('#scenarioDataGrid').datagrid('fixDetailRowHeight',index);
                         },0);
                     },
                     onClickRow:function(index){
                    	 ddv.datagrid('beginEdit',index);
                     },
                     toolbar : [{
                    	text:'增加步骤',
                    	iconCls:'icon-add',
                    	handler:function(){
                    		ddv.datagrid('appendRow',{name:'',id:0,format:''});
                    	}
                     }, {
                    	 text : '保存',
                    	 iconCls:'icon-save',
                    	 handler:function(){
                    		 var idArr = [];
                    		 var datas = ddv.datagrid('getData').rows;
                    		 for(var i=0;i<datas.length;i++){
                    			 ddv.datagrid('endEdit',i);
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
                    			 $('#scenarioDataGrid').datagrid('reload');
                    		 });
                   		 }
                     }]
                 });
                 $('#scenarioDataGrid').datagrid('fixDetailRowHeight',index);
             }
         });
     });
	function saveStep(type){
		var href = '${ctx}/scenario/savePage';
		if(type == 1){
			var selects = $('#scenarioDataGrid').datagrid('getSelections');
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
		$('#scenarioDialog').dialog({
			title : type==0?'添加场景':'编辑场景',
			width : 450,
			height : 235,
			href : href,
			modal:true,
			buttons:[{
				text:'确定',
				iconCls:'icon-ok',
				handler:function(){
					$('#scenarioManageForm').form('submit',{
						url:'${ctx }/scenario/save',
						success:function(){
							$('#scenarioDialog').dialog('close');
							$('#scenarioDataGrid').datagrid('reload');
						}
					});
				}
			},{
				text:'取消',
				iconCls:'icon-cancel',
				handler:function(){
					$('#scenarioDialog').dialog('close');
				}
			}]
		});
	}
	function batchDelStep(){
		$.messager.confirm('确认', '您确认删除选中的场景吗？删除时所设置的对应步骤也将清空，请确认！', function(r){
			if (r){
				var selects = $('#scenarioDataGrid').datagrid('getSelections');
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
				$.post('${ctx}/scenario/delete',{ids:ids},function(data){
					$('#scenarioDataGrid').datagrid('reload');
				});
			}
		});
	}
	$('#scenarioSearchKey').textbox({
		onClickButton : function(){
			var searchKey = $('#scenarioSearchKey').textbox('getValue');
			$('#scenarioDataGrid').datagrid('load',{'key':searchKey});
		}
	});
</script>