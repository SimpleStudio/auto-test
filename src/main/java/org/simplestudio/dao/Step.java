package org.simplestudio.dao;

import com.jfinal.plugin.activerecord.Model;

/** 
 * @author zhengzhq E-mail:zzq0324@qq.com 
 * @version 创建时间：2015年6月30日 下午9:46:29 
 */
public class Step extends Model<Step>{

	private static final long serialVersionUID = -3455463486901397150L;
	public static final Step dao = new Step();
	public static final String ID = "id";
	public static final String TYPE = "type";
	public static final String SENTENCE = "sentence";
	
}
