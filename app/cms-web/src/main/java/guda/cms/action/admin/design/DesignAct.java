package guda.cms.action.admin.design;

import guda.cms.entity.main.Channel;
import guda.cms.entity.main.CmsModel;
import guda.cms.entity.main.CmsModelItem;
import guda.cms.entity.main.CmsTopic;
import guda.cms.manager.assist.CmsFileMng;
import guda.cms.manager.main.*;
import guda.cms.service.ImageSvc;
import guda.cms.service.WeiXinSvc;
import guda.common.office.OpenOfficeConverter;
import guda.common.upload.FileRepository;
import guda.common.web.springmvc.RealPathResolver;
import guda.core.entity.CmsSite;
import guda.core.entity.CmsUser;
import guda.core.manager.*;
import guda.core.tpl.TplManager;
import guda.core.web.util.CmsUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * Created by well on 2014/11/7.
 */
@Controller
public class DesignAct {

    @Autowired
    private ChannelMng channelMng;
    @Autowired
    private CmsUserMng cmsUserMng;
    @Autowired
    private CmsModelMng cmsModelMng;
    @Autowired
    private CmsModelItemMng cmsModelItemMng;
    @Autowired
    private CmsTopicMng cmsTopicMng;
    @Autowired
    private CmsGroupMng cmsGroupMng;
    @Autowired
    private ContentTypeMng contentTypeMng;
    @Autowired
    private TplManager tplManager;
    @Autowired
    private FileRepository fileRepository;
    @Autowired
    private DbFileMng dbFileMng;
    @Autowired
    private CmsLogMng cmsLogMng;
    @Autowired
    private ContentMng manager;
    @Autowired
    private CmsFileMng fileMng;
    @Autowired
    private CmsSiteMng siteMng;


   // @RequiresPermissions("visual:index")
    @RequestMapping(value ="/design/index.do")
    public String index(String html,ModelMap model) {
        model.addAttribute("html", html);
        return "design/index";
    }

    @RequestMapping(value ="/design/setBiz.do")
    public String setBiz(String html,HttpServletRequest request, HttpServletResponse response,
            ModelMap model) {

        CmsSite site = CmsUtils.getSite(request);
        Integer siteId = site.getId();
        CmsUser user = CmsUtils.getUser(request);
        Integer userId = user.getId();
        // 栏目
        Channel c = null;
        // 模型
        CmsModel m = cmsModelMng.getDefModel();
        // 模型项列表
        List<CmsModelItem> itemList = cmsModelItemMng.getList(m.getId(), false,
                false);
        // 栏目列表
        List<Channel> channelList;
        Set<Channel> rights;
        if (user.getUserSite(siteId).getAllChannel()) {
            // 拥有所有栏目权限
            rights = null;
        } else {
            //			rights = user.getChannels(siteId);
            //更改成部门获取栏目权限
            rights = user.getChannelsByDepartment(siteId);
        }
        if (c != null) {
            channelList = c.getListForSelect(rights, true);
        } else {
            //			List<Channel> topList = channelMng.getTopListByRigth(userId,siteId, true);
            //更改成部门获取栏目权限
            Integer departId=null;
            if(user.getDepartment()!=null){
                departId=user.getDepartment().getId();
            }
            List<Channel> topList = channelMng.getTopListForDepartId(departId,userId,siteId,true);
            channelList = Channel.getListForSelect(topList, rights, true);
        }

        // 专题列表
        List<CmsTopic> topicList;
        if (c != null) {
            topicList = cmsTopicMng.getListByChannel(c.getId());
        } else {
            topicList = new ArrayList<CmsTopic>();
        }
        model.addAttribute("topicList", topicList);
        return "design/setBiz";
    }
}
