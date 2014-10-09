package guda.cms.web.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import guda.cms.biz.DemoBiz;
import guda.cms.dao.domain.DemoDO;
import guda.cms.web.form.DemoEditForm;
import guda.cms.web.form.DemoForm;
import guda.tools.web.page.BaseQuery;
import guda.tools.web.page.BizResult;
import guda.tools.web.util.RequestUtil;


@Controller
public class DemoAction {


    @Autowired
    private DemoBiz demoBiz;

    @RequestMapping(value = "demo/list.htm", method = RequestMethod.GET)
    public String list(HttpServletRequest request, ModelMap modelMap) {
        int pageId = RequestUtil.getInt(request, "pageNo");
        int pageSize = RequestUtil.getInt(request, "pageSize");
        BaseQuery baseQuery = new BaseQuery();
        baseQuery.setPageNo(pageId);
        baseQuery.setPageSize(pageSize);
        modelMap.put("baseQuery",baseQuery);
        BizResult bizResult = demoBiz.list(baseQuery);
        if (bizResult.success) {
            modelMap.putAll(bizResult.data);
            return "demo/list.vm";
        } else {
            return "common/error.vm";
        }

    }

    @RequestMapping(value = "demo/edit.htm", method = RequestMethod.GET)
    public String edit(HttpServletRequest request, ModelMap modelMap, DemoEditForm demoEditForm,
        BindingResult result, Map<String,Object> model) {
        int id = RequestUtil.getInt(request, "id");
        BizResult bizResult = demoBiz.detail(id);
        if (bizResult.success) {
            modelMap.putAll(bizResult.data);
            demoEditForm.initForm(((DemoDO)bizResult.data.get("demoDO")));
            return "demo/edit.vm";
        } else {
            return "common/error.vm";
        }

    }

    @RequestMapping(value = "demo/detail.htm", method = RequestMethod.GET)
    public String detail(HttpServletRequest request, ModelMap modelMap) {
        int id = RequestUtil.getInt(request, "id");
        BizResult bizResult = demoBiz.detail(id);
        if (bizResult.success) {
            modelMap.putAll(bizResult.data);
            return "demo/detail.vm";
        } else {
            return "common/error.vm";
        }

    }

    @RequestMapping(value = "demo/create.htm", method = RequestMethod.GET)
    public String create(HttpServletRequest request, ModelMap modelMap, DemoForm demoForm,
        BindingResult result, Map<String,Object> model) {
        return "demo/create.vm";
    }

    @RequestMapping(value = "demo/doCreate.htm", method = RequestMethod.POST)
    public String doCreate(HttpServletRequest request, ModelMap modelMap,@Valid DemoForm demoForm,
        BindingResult result, Map<String,Object> model) {
        if (result.hasErrors()) {
            return "demo/create.vm";
        }
        DemoDO demoDO = demoForm.toDO();
        BizResult bizResult = demoBiz.create(demoDO);
        if (bizResult.success) {
            return "redirect:/demo/list.vm";
        } else {
            return "common/error.vm";
        }

    }

    @RequestMapping(value = "demo/doUpdate.htm", method = RequestMethod.POST)
    public String doUpdate(HttpServletRequest request, HttpServletResponse response,ModelMap modelMap,@Valid DemoEditForm demoEditForm,
        BindingResult result, Map<String,Object> model) {
        if (result.hasErrors()) {
            return "demo/edit.vm";
        }
        DemoDO demoDO = demoEditForm.toDO();
        BizResult bizResult = demoBiz.update(demoDO);
        if (bizResult.success) {
            return "redirect:/demo/list.vm";
        } else {
            return "common/error.vm";
        }

    }

    @RequestMapping(value = "demo/doDelete.htm", method = RequestMethod.POST)
    public String doDelete(HttpServletRequest request, ModelMap modelMap) {
        int id = RequestUtil.getInt(request, "id");
        BizResult bizResult = demoBiz.delete(id);
        if (bizResult.success) {
            return "demo/list.vm";
        } else {
            return "common/error.vm";
        }

    }



}
