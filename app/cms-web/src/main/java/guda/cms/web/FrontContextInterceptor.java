package guda.cms.web;

import guda.common.web.CookieUtils;
import guda.core.entity.CmsConfig;
import guda.core.entity.CmsSite;
import guda.core.entity.CmsUser;
import guda.core.manager.CmsConfigMng;
import guda.core.manager.CmsSiteMng;
import guda.core.manager.CmsUserMng;
import guda.core.web.util.CmsUtils;
import guda.core.web.util.URLHelper;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * CMS上下文信息拦截器
 * 
 * 包括登录信息、权限信息、站点信息
 */
public class FrontContextInterceptor extends HandlerInterceptorAdapter {
	public static final String SITE_COOKIE = "_site_id_cookie";
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler)
			throws ServletException {
		CmsConfig config=configMng.get();
		CmsSite site = null;
		List<CmsSite> list = cmsSiteMng.getListFromCache();
		int size = list.size();
		if (size == 0) {
			throw new RuntimeException("no site record in database!");
		} else if (size == 1) {
			site = list.get(0);
		} else {
			String server = request.getServerName();
			String alias, redirect;
			//内网第一个/分隔符作为站点访问路径
			if(config.getInsideSite()){
				String[] paths = URLHelper.getPaths(request);
				int len = paths.length;
				if (len>0) {
					String siteAccessPath=paths[0];
					site=cmsSiteMng.findByAccessPath(siteAccessPath);
					if(site!=null){
						CookieUtils.addCookie(request, response, SITE_COOKIE, site.getId().toString(), null, null);
					}
				}
				if(site==null){
					site=getByCookie(request);
				}
			}else{
				for (CmsSite s : list) {
					// 检查域名
					if (s.getDomain().equals(server)) {
						site = s;
						break;
					}
					// 检查域名别名
					alias = s.getDomainAlias();
					if (!StringUtils.isBlank(alias)) {
						for (String a : StringUtils.split(alias, ',')) {
							if (a.equals(server)) {
								site = s;
								break;
							}
						}
					}
					// 检查重定向
					redirect = s.getDomainRedirect();
					if (!StringUtils.isBlank(redirect)) {
						for (String r : StringUtils.split(redirect, ',')) {
							if (r.equals(server)) {
								try {
									response.sendRedirect(s.getUrl());
								} catch (IOException e) {
									throw new RuntimeException(e);
								}
								return false;
							}
						}
					}
				}
			}
			if (site == null) {
				throw new SiteNotFoundException(server);
			}
		}
		
		CmsUtils.setSite(request, site);
		CmsThreadVariable.setSite(site);
		Subject subject = SecurityUtils.getSubject();
		if (subject.isAuthenticated()|| subject.isRemembered()) {
			String username =  (String) subject.getPrincipal();
			CmsUser user = cmsUserMng.findByUsername(username);
			CmsUtils.setUser(request, user);
			// Site加入线程变量
			CmsThreadVariable.setUser(user);
		}
		/*
		CmsUser user = null;
		Integer userId = authMng.retrieveUserIdFromSession(session, request);
		if (userId != null) {
			user = cmsUserMng.findById(userId);
		}
		if (user != null) {
			CmsUtils.setUser(request, user);
		}
		*/
		createJsessionId(request, response, site);
		return true;
	}
	
	private CmsSite getByCookie(HttpServletRequest request) {
		Cookie cookie = CookieUtils.getCookie(request, SITE_COOKIE);
		if (cookie != null) {
			String v = cookie.getValue();
			if (!StringUtils.isBlank(v)) {
				try {
					Integer siteId = Integer.parseInt(v);
					return cmsSiteMng.findById(siteId);
				} catch (NumberFormatException e) {
				}
			}
		}
		return null;
	}
	
	private void createJsessionId(HttpServletRequest request,HttpServletResponse response,CmsSite site){
		 String JSESSIONID = request.getSession().getId();//获取当前JSESSIONID （不管是从主域还是二级域访问产生）
		 Cookie cookie = new Cookie("JSESSIONID", JSESSIONID);
		 cookie.setDomain(site.getBaseDomain()); //关键在这里，将cookie设成主域名访问，确保不同域之间都能获取到该cookie的值，从而确保session统一
		 response.addCookie(cookie);  //将cookie返回到客户端
	}

	private CmsSiteMng cmsSiteMng;
	private CmsUserMng cmsUserMng;
	@Autowired
	private CmsConfigMng configMng;


	@Autowired
	public void setCmsSiteMng(CmsSiteMng cmsSiteMng) {
		this.cmsSiteMng = cmsSiteMng;
	}

	@Autowired
	public void setCmsUserMng(CmsUserMng cmsUserMng) {
		this.cmsUserMng = cmsUserMng;
	}
}