package org.simplestudio.controller;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.simplestudio.dao.Scenario;
import org.simplestudio.dao.Step;
import org.simplestudio.util.ConstantUtil;
import org.simplestudio.util.StudioUtil;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
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
		renderJson(StudioUtil.convertPage2EasyUiPage(page));
	}
	
	public void savePage(){
		String idStr = getPara("id");
		if (StringUtils.isNotBlank(idStr)) {// 编辑
			Scenario scenario = Scenario.dao.findById(Long.parseLong(idStr));
			setAttr("scenario", scenario);
		}
		renderJsp("scenarioMng.jsp");
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
		String ids = getPara("ids");
		if(StringUtils.isNotBlank(ids)){
			String[] idArr = ids.split(",");
			for(String id : idArr){
				long scenarioId = Long.parseLong(id);
				//删除场景与步骤的关系
				Db.update("delete from t_scen_step where scen_id=?",scenarioId);
				//删除步骤
				Scenario.dao.deleteById(scenarioId);
			}
		}
		
		renderText(ConstantUtil.RESULT_SUCCESS);
	}
	
	public void getStepList(){
		String sql = "select * from t_step where 1=1 ";
		String key = getPara("key");
		if (StringUtils.isNotBlank(key)) {
			sql += " and name like '%" + key.trim() + "%'";
		}
		sql += "limit 200";
		List<Step> stepList = Step.dao.find(sql);
		renderJson(stepList);
	}
	
	public void subGrid(){
		long scenarioId = getParaToLong("scenId");
		String sql = "select a.* from t_scen_step a inner join t_step b on a.step_id=b.id and a.scen_id=? order by a.order";
		List<Step> stepList = Step.dao.find(sql, scenarioId);
		renderJson(stepList);
	}
}
