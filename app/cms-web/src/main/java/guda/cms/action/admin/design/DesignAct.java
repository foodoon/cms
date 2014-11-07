package guda.cms.action.admin.design;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by well on 2014/11/7.
 */
@Controller
public class DesignAct {

   // @RequiresPermissions("visual:index")
    @RequestMapping(value ="/design/index.do")
    public String index(String html,ModelMap model) {
        model.addAttribute("html", html);
        return "design/index";
    }
}
