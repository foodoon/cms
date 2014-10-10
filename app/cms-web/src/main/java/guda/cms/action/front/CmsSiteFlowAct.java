package guda.cms.action.front;


import guda.cms.service.CmsSiteFlowCache;
import guda.common.web.ResponseUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CmsSiteFlowAct {
	@RequestMapping("/flow_statistic.jspx")
	public void flowStatistic(HttpServletRequest request,
			HttpServletResponse response, String page, String referer) throws JSONException {
		Long[] counts = null;
		if (!StringUtils.isBlank(page)) {
			counts=cmsSiteFlowCache.flow(request, page, referer);
		} 
		String json;
		if (counts != null) {
			json = new JSONArray(counts).toString();
			ResponseUtils.renderJson(response, json);
		} else {
			ResponseUtils.renderJson(response, "[]");
		}
	}
	
	@Autowired
	private CmsSiteFlowCache cmsSiteFlowCache;
}
