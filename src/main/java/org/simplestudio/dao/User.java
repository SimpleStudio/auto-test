package org.simplestudio.dao;

import com.jfinal.plugin.activerecord.Model;

/**
 * @author zhengzhq E-mail:zzq0324@qq.com
 * @version 创建时间：2015年6月30日 下午9:25:02
 */
public class User extends Model<User> {
	private static final long serialVersionUID = -5414818929049503753L;
	public static final String ID = "id";
	public static final String NAME = "name";
	public static final String PASSWORD = "passowrd";
	public static final String EMAIL = "email";
	public static final String REMARK = "remark";
	public static final User dao = new User();
}
