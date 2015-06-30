package org.simplestudio.dao;

import com.jfinal.plugin.activerecord.Model;

/** 
 * @author zhengzhq E-mail:zzq0324@qq.com 
 * @version 创建时间：2015年6月30日 下午9:56:04 
 */
public class Feature extends Model<Feature> {
	private static final long serialVersionUID = -3260040823557720925L;
	public static final Feature dao = new Feature();
	
	public static final String ID = "id";
	public static final String NAME = "name";
	public static final String FILE_NAME = "file_name";
	public static final String REMARK = "remark";
}
