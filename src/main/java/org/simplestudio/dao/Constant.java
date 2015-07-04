package org.simplestudio.dao;

import com.jfinal.plugin.activerecord.Model;

/** 
 * @author zhengzhq E-mail:zzq0324@qq.com 
 * @version 创建时间：2015年7月4日 下午9:47:29 
 */
public class Constant  extends Model<Constant> {

	private static final long serialVersionUID = 1371035302230641068L;
	public static final Constant dao = new Constant();
	public static final String ID = "id";
	public static final String NAME = "name";
	public static final String VALUE = "value";
}
