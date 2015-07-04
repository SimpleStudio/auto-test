package org.simplestudio.util;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Page;

/** 
 * @author zhengzhq E-mail:zzq0324@qq.com 
 * @version 创建时间：2015年7月4日 下午7:34:33 
 */
public class StudioUtil {

	/**
	 * 将jFinal查询出来的分页转换成easyUI可以解析的格式
	 */
	@SuppressWarnings("rawtypes")
	public static JSONObject convertPage2EasyUiPage(Page page){
		JSONObject json = new JSONObject();
		json.put("total", page.getTotalRow());
		json.put("pageSize", page.getPageSize());
		json.put("pageNumber", page.getPageNumber());
		json.put("rows", page.getList());
		
		return json;
	}
	
}
