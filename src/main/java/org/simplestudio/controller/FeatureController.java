package org.simplestudio.controller;

import org.apache.commons.lang3.StringUtils;
import org.simplestudio.dao.Feature;
import org.simplestudio.util.StudioUtil;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;

/** 
 * @author zhengzhq E-mail:zzq0324@qq.com 
 * @version 创建时间：2015-9-22 下午09:45:46 
 */
public class FeatureController extends Controller  {

	public void list(){
		renderJsp("list.jsp");
	}
	
	public void dataGrid(){
		int pageNumber = getParaToInt("page");
		int pageSize = getParaToInt("rows");
		String sql = "select * from t_feature where 1=1 ";
		String key = getPara("key");
		if (StringUtils.isNotBlank(key)) {
			sql += " and name like '%" + key.trim() + "%'";
		}
		Page<Feature> page = Feature.dao.paginate(pageNumber, pageSize, sql, " order by update_time desc");
		renderJson(StudioUtil.convertPage2EasyUiPage(page));
	}
}
