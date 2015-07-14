package org.simplestudio.controller;

import org.apache.commons.lang3.StringUtils;
import org.simplestudio.dao.Scenario;
import org.simplestudio.util.ConstantUtil;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;

/** 
 * @author zhengzhq E-mail:zzq0324@qq.com 
 * @version 创建时间：2015年7月11日 下午6:24:15 
 */
public class ScenarioController extends Controller{

	public void list() {
		renderJsp("list.jsp");
	}
	
	public void dataGrid(){
		int pageNumber = getParaToInt("page");
		int pageSize = getParaToInt("rows");
		String sql = "select * from t_scenario where 1=1 ";
		String key = getPara("key");
		if (StringUtils.isNotBlank(key)) {
			sql += " and name like '%" + key.trim() + "%'";
		}
		Page<Scenario> page = Scenario.dao.paginate(pageNumber, pageSize, sql, " order by create_time desc");
		renderJson(page);
	}
	
	public void savePage(){
		
	}
	
	public void save(){
		Scenario scenario = getModel(Scenario.class);
		if (scenario.getLong("id") != null) {// 编辑
			scenario.update();
		} else {
			scenario.save();
		}
		renderText(ConstantUtil.RESULT_SUCCESS);
	}
	
	public void saveStepList(){
		
	}
	
	public void delete(){
		
	}
}
