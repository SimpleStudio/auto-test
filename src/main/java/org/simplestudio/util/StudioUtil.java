package org.simplestudio.util;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.simplestudio.dao.Step;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Page;

/** 
 * @author zhengzhq E-mail:zzq0324@qq.com 
 * @version 创建时间：2015年7月4日 下午7:34:33 
 */
public class StudioUtil {
	private static final Pattern TPL_PATTERN = Pattern.compile("\\{\\d\\}");
	
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
	
	/**
	 * 格式化步骤，获取出参数个数等
	 * @param page
	 */
	public static JSONObject formatStepPage(Page<Step> page){
		JSONObject pageJson = convertPage2EasyUiPage(page);
		JSONArray data = new JSONArray();
		List<Step> stepList = page.getList();
		for(Step step:stepList){
			JSONObject json = new JSONObject();
			json.put("id", step.get("id"));
			json.put("name", step.get("name"));
			json.put("argsNum", getArgsNumber(step.getStr("expression")));
			json.put("expression", step.get("expression"));
			json.put("tplId", step.get("tpl_id"));
			json.put("setStepId", step.get("setStepId"));
			data.add(json);
		}
		pageJson.put("rows", data);
		
		return pageJson;
	}
	
	/**
	 * 获取参数个数
	 * @param tpl
	 * @return
	 */
	private static int getArgsNumber(String tpl){
		int number = 0;
		Matcher matcher = TPL_PATTERN.matcher(tpl);
		while(matcher.find()){
			number++;
		}
		return number;
	}
	
}
