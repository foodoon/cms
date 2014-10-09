/**
 * zoneland.net Inc.
 * Copyright (c) 2002-2012 All Rights Reserved.
 */
package guda.cms.web;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * 
 * @author gag
 * @version $Id: BlankController.java, v 0.1 2012-4-26 9:16:33 gag Exp $
 */
@Controller
@RequestMapping("/*.htm")
public class BlankController {

    private final static Logger logger = Logger.getLogger(BlankController.class);

    @RequestMapping(method = RequestMethod.GET)
    public String doGet(HttpServletRequest request, ModelMap modelMap) {
        if (logger.isInfoEnabled()) {
            logger.info("test url" + request.getRequestURL());
        }
        return "index.vm";

    }


}
