package org.simplestudio.controller;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.simplestudio.dao.Step;
import org.simplestudio.util.StudioUtil;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;

/** 
 * @author zhengzhq E-mail:zzq0324@qq.com 
 * @version 创建时间：2015年7月4日 下午10:26:26 
 */
public class StepController extends Controller{

	public void list() {
		renderJsp("list.jsp");
	}
	
	public void dataGrid(){
		int pageNumber = getParaToInt("page");
		int pageSize = getParaToInt("rows");
		String expectSqlSelect = "from t_step a inner join t_steptpl b on a.tpl_id=b.id where 1=1";
		String key = getPara("key");
		if (StringUtils.isNotBlank(key)) {
			expectSqlSelect += " and a.name like '%" + key.trim() + "%'";
		}
		expectSqlSelect += " order by a.create_time desc ";
		Page<Step> page = Step.dao.paginate(pageNumber, pageSize,"select a.*,b.name as tplName,b.expression,(select count(1) from t_step_const c where c.step_id=a.id) as setStepId", expectSqlSelect);
		//对参数进行格式化
		renderJson(StudioUtil.formatStepPage(page));
	}
	
	public void subDataGrid(){
		long stepId = getParaToLong("stepId");
		List<Step> stepList = Step.dao.find("select * from t_step_const where step_id=?",stepId);
		renderJson(stepList);
	}
	
	public void saveStep(){
		
	}
	
	public void saveStepParamValue(){
		
	}
	
	public void deleteStep(){
		
	}
	
	public void deleteStepParamValue(){
		
	}
}
