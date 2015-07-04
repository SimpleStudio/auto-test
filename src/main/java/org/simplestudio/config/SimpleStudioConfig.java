package org.simplestudio.config;

import org.simplestudio.controller.IndexController;
import org.simplestudio.controller.StepTplController;

import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;

/**
 * @author zhengzhq E-mail:zzq0324@qq.com
 * @version 创建时间：2015年6月29日 下午10:08:27
 */
public class SimpleStudioConfig extends JFinalConfig {

	@Override
	public void configConstant(Constants me) {
		PropKit.use("config.properties");
		me.setDevMode(PropKit.getBoolean("devMode", true));
		me.setViewType(ViewType.JSP);
		me.setBaseViewPath("views/");
	}

	@Override
	public void configHandler(Handlers handlers) {

	}

	@Override
	public void configInterceptor(Interceptors interceptors) {

	}

	@Override
	public void configPlugin(Plugins plugins) {
		// 配置C3p0数据库连接池插件
		C3p0Plugin c3p0Plugin = new C3p0Plugin(PropKit.get("jdbc.url"), PropKit.get("jdbc.username"), PropKit.get("jdbc.password").trim());
		plugins.add(c3p0Plugin);

		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(c3p0Plugin);
		plugins.add(arp);
	}

	@Override
	public void configRoute(Routes routes) {
		routes.add("/",IndexController.class);
		routes.add("/steptpl",StepTplController.class);
	}

}
