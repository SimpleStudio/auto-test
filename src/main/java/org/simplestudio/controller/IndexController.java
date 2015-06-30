package org.simplestudio.controller;

import com.jfinal.core.Controller;

/** 
 * @author zhengzhq E-mail:zzq0324@qq.com 
 * @version 创建时间：2015年6月29日 下午11:19:18 
 */
public class IndexController extends Controller{

	public void index(){
		renderJsp("index.jsp");
	}
	
}
