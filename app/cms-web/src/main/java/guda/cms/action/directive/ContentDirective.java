package guda.cms.action.directive;

import static freemarker.template.ObjectWrapper.DEFAULT_WRAPPER;
import static guda.common.web.freemarker.DirectiveUtils.OUT_BEAN;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import guda.cms.entity.main.Content;
import guda.cms.manager.main.ContentMng;
import guda.common.web.freemarker.DirectiveUtils;
import guda.common.web.freemarker.ParamsRequiredException;
import guda.core.entity.CmsSite;
import guda.core.web.util.FrontUtils;

/**
 * 内容对象标签
 */
public class ContentDirective implements TemplateDirectiveModel {
	/**
	 * 输入参数，栏目ID。
	 */
	public static final String PARAM_ID = "id";
	/**
	 * 输入参数，下一篇。
	 */
	public static final String PRAMA_NEXT = "next";
	/**
	 * 输入参数，栏目ID。
	 */
	public static final String PARAM_CHANNEL_ID = "channelId";

	@SuppressWarnings("unchecked")
	public void execute(Environment env, Map params, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		Integer id = getId(params);
		Boolean next = DirectiveUtils.getBool(PRAMA_NEXT, params);
		Content content;
		if (next == null) {
			content = contentMng.findById(id);
		} else {
			CmsSite site = FrontUtils.getSite(env);
			Integer channelId = DirectiveUtils.getInt(PARAM_CHANNEL_ID, params);
			content = contentMng.getSide(id, site.getId(), channelId, next);
		}

		Map<String, TemplateModel> paramWrap = new HashMap<String, TemplateModel>(
				params);
		paramWrap.put(OUT_BEAN, DEFAULT_WRAPPER.wrap(content));
		Map<String, TemplateModel> origMap = DirectiveUtils
				.addParamsToVariable(env, paramWrap);
		body.render(env.getOut());
		DirectiveUtils.removeParamsFromVariable(env, paramWrap, origMap);
	}

	private Integer getId(Map<String, TemplateModel> params)
			throws TemplateException {
		Integer id = DirectiveUtils.getInt(PARAM_ID, params);
		if (id != null) {
			return id;
		} else {
			throw new ParamsRequiredException(PARAM_ID);
		}
	}

	@Autowired
	private ContentMng contentMng;
}
