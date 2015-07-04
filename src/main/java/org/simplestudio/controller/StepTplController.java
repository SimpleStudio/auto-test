package org.simplestudio.controller;

import org.apache.commons.lang3.StringUtils;
import org.simplestudio.dao.StepTpl;
import org.simplestudio.util.ConstantUtil;
import org.simplestudio.util.StudioUtil;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;

/**
 * @author zhengzhq E-mail:zzq0324@qq.com
 * @version 创建时间：2015年7月4日 上午11:12:52
 */
public class StepTplController extends Controller {

	public void list() {
		renderJsp("list.jsp");
	}

	public void savePage() {
		String idStr = getPara("id");
		if (StringUtils.isNotBlank(idStr)) {// 编辑
			StepTpl stepTpl = StepTpl.dao.findById(Long.parseLong(idStr));
			setAttr("stepTpl", stepTpl);
		}
		renderJsp("tplmng.jsp");
	}

	public void save() {
		StepTpl stepTpl = getModel(StepTpl.class);
		if (stepTpl.getLong("id") != null) {// 编辑
			stepTpl.update();
		} else {
			stepTpl.save();
		}
		renderText(ConstantUtil.RESULT_SUCCESS);
	}

	public void dataGrid() {
		int pageNumber = getParaToInt("page");
		int pageSize = getParaToInt("rows");
		String expectSqlSelect = "from t_steptpl where 1=1";
		String key = getPara("key");
		if (StringUtils.isNotBlank(key)) {
			expectSqlSelect += " and name like '%" + key + "%'";
		}
		expectSqlSelect += " order by create_time desc ";
		Page<StepTpl> page = StepTpl.dao.paginate(pageNumber, pageSize,
				"select *", expectSqlSelect);
		renderJson(StudioUtil.convertPage2EasyUiPage(page));
	}

	public void delete(){
		String ids = getPara("ids");
		if(StringUtils.isNotBlank(ids)){
			String[] idArr = ids.split(",");
			for(int i=0;i<idArr.length;i++){
				StepTpl.dao.deleteById(Long.parseLong(idArr[i]));
			}
		}
		renderText(ConstantUtil.RESULT_SUCCESS);
	}
}
