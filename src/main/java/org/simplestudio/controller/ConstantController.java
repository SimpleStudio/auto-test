package org.simplestudio.controller;

import org.apache.commons.lang3.StringUtils;
import org.simplestudio.dao.Constant;
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
		String ids = getPara("ids");
		if(StringUtils.isNotBlank(ids)){
			String[] idArr = ids.split(",");
			for(int i=0;i<idArr.length;i++){
				Constant.dao.deleteById(Long.parseLong(idArr[i]));
			}
		}
		renderText(ConstantUtil.RESULT_SUCCESS);
	}
}
