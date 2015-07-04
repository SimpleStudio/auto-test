package org.simplestudio.dao;

import com.jfinal.plugin.activerecord.Model;

/**
 * 步骤模板
 * 
 * @author zhengzhq E-mail:zzq0324@qq.com
 * @version 创建时间：2015年6月30日 下午9:46:29
 */
public class StepTpl extends Model<StepTpl> {

	private static final long serialVersionUID = -3455463486901397150L;
	public static final StepTpl dao = new StepTpl();
	public static final String ID = "id";
	public static final String NAME = "name";
	public static final String EXPRESSION = "expression";
	public static final String CREATE_DATE = "create_time";
}
