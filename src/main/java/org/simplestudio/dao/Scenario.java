package org.simplestudio.dao;

import com.jfinal.plugin.activerecord.Model;

/** 
 * @author zhengzhq E-mail:zzq0324@qq.com 
 * @version 创建时间：2015年6月30日 下午9:53:24 
 */
public class Scenario  extends Model<Scenario>{

	private static final long serialVersionUID = 5270599945567247744L;
	public static final Scenario dao = new Scenario();
	public static final String ID = "id";
	public static final String NAME = "name";
	public static final String CREATE_TIME = "create_time";
	
}
