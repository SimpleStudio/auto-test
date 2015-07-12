package org.simplestudio.controller;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.simplestudio.dao.Step;
import org.simplestudio.dao.StepConst;
import org.simplestudio.dao.StepTpl;
import org.simplestudio.util.ConstantUtil;
import org.simplestudio.util.StudioUtil;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
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
		StepTpl stepTpl = StepTpl.dao.findFirst("select b.* from t_step a left join t_steptpl b on a.tpl_id=b.id where a.id=? ",stepId);
		//获取参数个数
		int argNum = StudioUtil.getArgsNumber(stepTpl.getStr("expression"));
		List<Step> stepList = Step.dao.find("select a.step_id,a.constant_id,b.value,b.name from t_step_const a left join t_constant b on a.constant_id=b.id where step_id=? order by `order`",stepId);
		int need = argNum - stepList.size();
		while(need-->0){
			stepList.add(new Step());
		}
		renderJson(stepList);
	}
	
	public void saveStepParamValue(){
		String ids = getPara("constIds");
		long stepId = getParaToLong("stepId");
		//删除与该步骤相关的参数
		Db.update("delete from t_step_const where step_id=?", stepId);
		String[] idArr = ids.split(",");
		for(int i=0;i<idArr.length;i++){
			StepConst stepConst = new StepConst();
			stepConst.set("step_id", stepId);
			stepConst.set("constant_id", Long.parseLong(idArr[i]));
			stepConst.set("order", i+1);
			stepConst.save();
		}
		renderText(ConstantUtil.RESULT_SUCCESS);
	}
	
	public void savePage() {
		String idStr = getPara("id");
		if (StringUtils.isNotBlank(idStr)) {// 编辑
			Step step = Step.dao.findById(Long.parseLong(idStr));
			setAttr("step", step);
		}
		renderJsp("stepMng.jsp");
	}
	
	public void save() {
		Step step = getModel(Step.class);
		if (step.getLong("id") != null) {// 编辑
			step.update();
		} else {
			step.save();
		}
		renderText(ConstantUtil.RESULT_SUCCESS);
	}
	
	public void detele(){
		String ids = getPara("ids");
		if(StringUtils.isNotBlank(ids)){
			String[] idArr = ids.split(",");
			for(String id : idArr){
				long stepId = Long.parseLong(id);
				//删除参数值
				Db.update("delete from t_step_const where step_id=?",stepId);
				//删除步骤
				Step.dao.deleteById(stepId);
			}
		}
		
		renderText(ConstantUtil.RESULT_SUCCESS);
	}
	
}
