package guda.cms.action.directive;

import static freemarker.template.ObjectWrapper.DEFAULT_WRAPPER;
import static guda.cms.Constants.TPL_STYLE_LIST;
import static guda.cms.Constants.TPL_SUFFIX;
import static guda.common.web.Constants.UTF8;
import static guda.common.web.freemarker.DirectiveUtils.OUT_LIST;
import static guda.common.web.freemarker.DirectiveUtils.OUT_PAGINATION;
import static guda.core.web.util.FrontUtils.PARAM_STYLE_LIST;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import guda.cms.action.directive.abs.AbstractCmsGuestbookDirective;
import guda.common.page.Pagination;
import guda.common.web.freemarker.DirectiveUtils;
import guda.common.web.freemarker.ParamsRequiredException;
import guda.common.web.freemarker.DirectiveUtils.InvokeType;
import guda.core.entity.CmsSite;
import guda.core.web.util.FrontUtils;

/**
 * 留言分页标签
 */
public class CmsGuestbookPageDirective extends AbstractCmsGuestbookDirective {
	/**
	 * 模板名称
	 */
	public static final String TPL_NAME = "guestbook_page";

	@SuppressWarnings("unchecked")
	public void execute(Environment env, Map params, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		CmsSite site = FrontUtils.getSite(env);
		int pageNo = FrontUtils.getPageNo(env);
		int count = FrontUtils.getCount(params);
		Pagination page = cmsGuestbookMng.getPage(getSiteId(params),
				getCtgId(params),null, getRecommend(params), getChecked(params),
				getDesc(params), true, pageNo, count);

		Map<String, TemplateModel> paramWrap = new HashMap<String, TemplateModel>(
				params);
		paramWrap.put(OUT_PAGINATION, DEFAULT_WRAPPER.wrap(page));
		paramWrap.put(OUT_LIST, DEFAULT_WRAPPER.wrap(page.getList()));
		Map<String, TemplateModel> origMap = DirectiveUtils
				.addParamsToVariable(env, paramWrap);
		InvokeType type = DirectiveUtils.getInvokeType(params);
		String listStyle = DirectiveUtils.getString(PARAM_STYLE_LIST, params);
		if (InvokeType.sysDefined == type) {
			if (StringUtils.isBlank(listStyle)) {
				throw new ParamsRequiredException(PARAM_STYLE_LIST);
			}
			env.include(TPL_STYLE_LIST + listStyle + TPL_SUFFIX, UTF8, true);
			FrontUtils.includePagination(site, params, env);
		} else if (InvokeType.userDefined == type) {
			if (StringUtils.isBlank(listStyle)) {
				throw new ParamsRequiredException(PARAM_STYLE_LIST);
			}
			FrontUtils.includeTpl(TPL_STYLE_LIST, site, env);
			FrontUtils.includePagination(site, params, env);
		} else if (InvokeType.custom == type) {
			FrontUtils.includeTpl(TPL_NAME, site, params, env);
			FrontUtils.includePagination(site, params, env);
		} else if (InvokeType.body == type) {
			body.render(env.getOut());
			FrontUtils.includePagination(site, params, env);
		} else {
			throw new RuntimeException("invoke type not handled: " + type);
		}
		DirectiveUtils.removeParamsFromVariable(env, paramWrap, origMap);
	}
}
