package org.simplestudio.controller;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.simplestudio.dao.Constant;
import org.simplestudio.dao.StepConst;
import org.simplestudio.util.ConstantUtil;
import org.simplestudio.util.StudioUtil;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;

/** 
 * @author zhengzhq E-mail:zzq0324@qq.com 
 * @version 创建时间：2015年7月4日 下午9:43:06 
 */
public class ConstantController  extends Controller{

	public void list() {
		renderJsp("list.jsp");
	}
	
	public void dataGrid() {
		int pageNumber = getParaToInt("page");
		int pageSize = getParaToInt("rows");
		String expectSqlSelect = "from t_constant where 1=1";
		String key = getPara("key");
		if (StringUtils.isNotBlank(key)) {
			expectSqlSelect += " and name like '%" + key.trim() + "%'";
		}
		expectSqlSelect += " order by create_time desc ";
		Page<Constant> page = Constant.dao.paginate(pageNumber, pageSize,"select *", expectSqlSelect);
		renderJson(StudioUtil.convertPage2EasyUiPage(page));
	}
	
	public void getConstList(){
		String expectSqlSelect = "select id,concat(name,'(',value,')') as name from t_constant where 1=1";
		String key = getPara("key");
		if (StringUtils.isNotBlank(key)) {
			expectSqlSelect += " and name like '%" + key.trim() + "%'";
		}
		expectSqlSelect+=" limit 200";
		List<Constant> constList = Constant.dao.find(expectSqlSelect);
		renderJson(constList);
	}
	
	public void save() {
		Constant constant = getModel(Constant.class);
		if (constant.getLong("id") != null) {// 编辑
			constant.update();
		} else {
			constant.save();
		}
		renderText(ConstantUtil.RESULT_SUCCESS);
	}
	
	public void savePage() {
		String idStr = getPara("id");
		if (StringUtils.isNotBlank(idStr)) {// 编辑
			Constant constant = Constant.dao.findById(Long.parseLong(idStr));
			setAttr("constant", constant);
		}
		renderJsp("constantMng.jsp");
	}
	
	public void delete(){
		String renderText = "";
		String ids = getPara("ids");
		if(StringUtils.isNotBlank(ids)){
			String[] idArr = ids.split(",");
			StringBuffer errorMsg = new StringBuffer();
			for(int i=0;i<idArr.length;i++){
				StepConst stepConst = StepConst.dao.findFirst("select * from t_step_const where constant_id=?", Long.parseLong(idArr[i]));
				if(stepConst != null){
					if(errorMsg.length()>0){
						errorMsg.append(",");
					}
					Constant constant = Constant.dao.findFirst("select name from t_constant where id=?", stepConst.getLong("constant_id"));
					errorMsg.append("[").append(constant.getStr("name")).append("]");
				}
			}
			if(errorMsg.length() == 0){
				for(int i=0;i<idArr.length;i++){
					Constant.dao.deleteById(Long.parseLong(idArr[i]));
				}
				renderText = ConstantUtil.RESULT_SUCCESS;
			}else{
				renderText = "常量"+errorMsg.toString()+"已经被引用，请先解除引用关系！";
			}
		}
		renderText(renderText);
	}
}
