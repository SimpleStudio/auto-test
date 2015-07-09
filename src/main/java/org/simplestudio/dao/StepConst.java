package org.simplestudio.dao;

import com.jfinal.plugin.activerecord.Model;

/** 
 * @author zhengzhq E-mail:zzq0324@qq.com 
 * @version 创建时间：2015年7月9日 下午10:21:04 
 */
public class StepConst extends Model<Step>{

	private static final long serialVersionUID = -5459126534247424213L;
	public static final String STEP_ID = "step_id";
	public static final String CONST_ID = "const_id";
	public static final String ORDER = "order";
	public static final StepConst dao = new StepConst();
}
