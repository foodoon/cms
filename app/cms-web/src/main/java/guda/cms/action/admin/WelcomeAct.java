package guda.cms.action.admin;

import guda.cms.entity.assist.CmsUserMenu;
import guda.cms.entity.main.Channel;
import guda.cms.entity.main.Content;
import guda.cms.entity.main.Content.ContentStatus;
import guda.cms.manager.assist.CmsUserMenuMng;
import guda.cms.manager.main.ChannelMng;
import guda.cms.manager.main.ContentMng;
import guda.cms.web.AdminContextInterceptor;
import guda.core.entity.CmsSite;
import guda.core.entity.CmsUser;
import guda.core.manager.CmsSiteMng;
import guda.core.web.util.CmsUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WelcomeAct {
	@RequiresPermissions("index")
	@RequestMapping("/index.do")
	public String index(HttpServletRequest request, ModelMap model) {
        List<CmsSite> siteList = cmsSiteMng.getList();
        CmsSite site = CmsUtils.getSite(request);
        CmsUser user = CmsUtils.getUser(request);
        model.addAttribute("siteList", siteList);
        model.addAttribute("site", site);
        model.addAttribute("siteParam", AdminContextInterceptor.SITE_PARAM);
        model.addAttribute("user", user);


        List<Channel> list = channelMng.getTopList(site.getId(), false);
        List<Channel> channelList = new ArrayList<Channel>();
        for(Channel channel:list) {
            List<Channel> tempList = channelMng.getChildList(channel.getId(), false);
            if(tempList == null || tempList.size() ==0 ){
                //没有子节点的，自己就是栏目
                channelList.add(channel);
            }else {
                channelList.addAll(tempList);
            }
        }

        model.addAttribute("channelList", channelList);
		return "index";
	}

	@RequiresPermissions("map")
	@RequestMapping("/map.do")
	public String map() {
		return "map";
	}

	@RequiresPermissions("top")
	@RequestMapping("/top.do")
	public String top(HttpServletRequest request, ModelMap model) {
		// 需要获得站点列表
		List<CmsSite> siteList = cmsSiteMng.getList();
		CmsSite site = CmsUtils.getSite(request);
		CmsUser user = CmsUtils.getUser(request);
		model.addAttribute("siteList", siteList);
		model.addAttribute("site", site);
		model.addAttribute("siteParam", AdminContextInterceptor.SITE_PARAM);
		model.addAttribute("user", user);
		return "top";
	}

	@RequiresPermissions("main")
	@RequestMapping("/main.do")
	public String main() {
		return "main";

	}

	@RequiresPermissions("left")
	@RequestMapping("/left.do")
	public String left(HttpServletRequest request, ModelMap model) {
		CmsUser user = CmsUtils.getUser(request);
		List<CmsUserMenu>menus=userMenuMng.getList(user.getId(),10);
		model.addAttribute("menus", menus);
		return "left";
	}
	
	@RequiresPermissions("right")
	@RequestMapping("/right.do")
	public String right(HttpServletRequest request, ModelMap model) {
		CmsSite site = CmsUtils.getSite(request);
		CmsUser user = CmsUtils.getUser(request);
		String version = site.getConfig().getVersion();
		Properties props = System.getProperties();
		Runtime runtime = Runtime.getRuntime();
		long freeMemoery = runtime.freeMemory();
		long totalMemory = runtime.totalMemory();
		long usedMemory = totalMemory - freeMemoery;
		long maxMemory = runtime.maxMemory();
		long useableMemory = maxMemory - totalMemory + freeMemoery;
		//最新10条待审内容
		List<Content>contents=(List<Content>) contentMng.getPageByRight(null, null, user.getId(), null, false, false, ContentStatus.prepared, user.getCheckStep(site.getId()), site.getId(), null, user.getId(), 0, 1, 10).getList();
		List<Content>newcontents=(List<Content>)contentMng.getPageByRight(null, null,  user.getId(), null, false, false, ContentStatus.checked,  user.getCheckStep(site.getId()), site.getId(), null,user.getId(), 0, 1, 10).getList();
		model.addAttribute("props", props);
		model.addAttribute("freeMemoery", freeMemoery);
		model.addAttribute("totalMemory", totalMemory);
		model.addAttribute("usedMemory", usedMemory);
		model.addAttribute("maxMemory", maxMemory);
		model.addAttribute("useableMemory", useableMemory);
		model.addAttribute("version", version);
		model.addAttribute("user", user);
		model.addAttribute("site", site);
		model.addAttribute("contents", contents);
		model.addAttribute("newcontents", newcontents);
		return "right";
	}
	

	@Autowired
	private CmsSiteMng cmsSiteMng;
	@Autowired
	private ContentMng contentMng;
	@Autowired
	private CmsUserMenuMng userMenuMng;

    @Autowired
    private ChannelMng channelMng;
}
