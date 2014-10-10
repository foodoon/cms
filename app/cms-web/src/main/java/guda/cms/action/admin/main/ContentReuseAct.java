package guda.cms.action.admin.main;

import static guda.common.page.SimplePage.cpn;
import guda.cms.entity.main.ContentType;
import guda.cms.entity.main.Content.ContentStatus;
import guda.cms.manager.main.ContentMng;
import guda.cms.manager.main.ContentTypeMng;
import guda.common.page.Pagination;
import guda.common.web.CookieUtils;
import guda.common.web.RequestUtils;
import guda.core.entity.CmsSite;
import guda.core.entity.CmsUser;
import guda.core.manager.CmsSiteMng;
import guda.core.manager.CmsUserMng;
import guda.core.web.util.CmsUtils;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Tom
 */
@Controller
public class ContentReuseAct {
	private static final Logger log = LoggerFactory
			.getLogger(ContentReuseAct.class);

	@RequiresPermissions("content_reuse:v_main")
	@RequestMapping("/content_reuse/v_main.do")
	public String main(ModelMap model) {
		return "content_reuse/main";
	}

	@RequiresPermissions("content_reuse:v_left")
	@RequestMapping("/content_reuse/v_left.do")
	public String left() {
		return "content_reuse/left";
	}

	@RequiresPermissions("content_reuse:v_tree")
	@RequestMapping(value = "/content_reuse/v_tree.do")
	public String v_tree(String root, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) {
		log.debug("tree path={}", root);
		boolean isRoot;
		// jquery treeview的根请求为root=source
		if (StringUtils.isBlank(root) || "source".equals(root)) {
			isRoot = true;
		} else {
			isRoot = false;
		}
		model.addAttribute("isRoot", isRoot);
		List<CmsSite> siteList;
		if (isRoot) {
			siteList = siteMng.getTopList();
		} else {
			siteList = siteMng.getListByParent(Integer.parseInt(root));
		}
		model.addAttribute("list", siteList);
		response.setHeader("Cache-Control", "no-cache");
		response.setContentType("text/json;charset=UTF-8");
		return "content_reuse/tree";
	}

	@RequiresPermissions("content_reuse:v_list")
	@RequestMapping("/content_reuse/v_list.do")
	public String list(String queryStatus, Integer queryTypeId,
			Boolean queryTopLevel, Boolean queryRecommend,
			Integer queryOrderBy, Integer querySiteId, Integer pageNo,
			HttpServletRequest request, ModelMap model) {
		String queryTitle = RequestUtils.getQueryParam(request, "queryTitle");
		queryTitle = StringUtils.trim(queryTitle);
		String queryInputUsername = RequestUtils.getQueryParam(request,
				"queryInputUsername");
		queryInputUsername = StringUtils.trim(queryInputUsername);
		if (queryTopLevel == null) {
			queryTopLevel = false;
		}
		if (queryRecommend == null) {
			queryRecommend = false;
		}
		if (queryOrderBy == null) {
			queryOrderBy = 0;
		}
		ContentStatus status;
		if (!StringUtils.isBlank(queryStatus)) {
			status = ContentStatus.valueOf(queryStatus);
		} else {
			status = ContentStatus.all;
		}
		Integer queryInputUserId = null;
		if (!StringUtils.isBlank(queryInputUsername)) {
			CmsUser u = cmsUserMng.findByUsername(queryInputUsername);
			if (u != null) {
				queryInputUserId = u.getId();
			} else {
				// 用户名不存在，清空。
				queryInputUsername = null;
			}
		}
		if (querySiteId == null) {
			querySiteId = CmsUtils.getSiteId(request);
		}
		List<ContentType> typeList = contentTypeMng.getList(true);
		Pagination p = contentMng.getPageBySite(queryTitle, queryTypeId,
				queryInputUserId, queryTopLevel, queryRecommend, status,
				querySiteId, queryOrderBy, cpn(pageNo), CookieUtils
						.getPageSize(request));
		model.addAttribute("pagination", p);
		model.addAttribute("typeList", typeList);
		model.addAttribute("site", CmsUtils.getSite(request));
		addAttibuteForQuery(model, queryTitle, queryInputUsername, queryStatus,
				queryTypeId, queryTopLevel, queryRecommend, queryOrderBy,
				pageNo);
		return "content_reuse/list";
	}

	private void addAttibuteForQuery(ModelMap model, String queryTitle,
			String queryInputUsername, String queryStatus, Integer queryTypeId,
			Boolean queryTopLevel, Boolean queryRecommend,
			Integer queryOrderBy, Integer pageNo) {
		if (!StringUtils.isBlank(queryTitle)) {
			model.addAttribute("queryTitle", queryTitle);
		}
		if (!StringUtils.isBlank(queryInputUsername)) {
			model.addAttribute("queryInputUsername", queryInputUsername);
		}
		if (queryTypeId != null) {
			model.addAttribute("queryTypeId", queryTypeId);
		}
		if (queryStatus != null) {
			model.addAttribute("queryStatus", queryStatus);
		}
		if (queryTopLevel != null) {
			model.addAttribute("queryTopLevel", queryTopLevel);
		}
		if (queryRecommend != null) {
			model.addAttribute("queryRecommend", queryRecommend);
		}
		if (queryOrderBy != null) {
			model.addAttribute("queryOrderBy", queryOrderBy);
		}
		if (pageNo != null) {
			model.addAttribute("pageNo", pageNo);
		}
	}

	@Autowired
	private CmsSiteMng siteMng;
	@Autowired
	private ContentMng contentMng;
	@Autowired
	private ContentTypeMng contentTypeMng;
	@Autowired
	private CmsUserMng cmsUserMng;

}
