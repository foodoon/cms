/**
 * zoneland.net Inc.
 * Copyright (c) 2002-2012 All Rights Reserved.
 */
package guda.cms.test;



import guda.mvc.core.config.ConfigrationFactory;
import org.eclipse.jetty.security.ConstraintSecurityHandler;
import org.eclipse.jetty.security.HashLoginService;
import org.eclipse.jetty.security.SecurityHandler;
import org.eclipse.jetty.server.NCSARequestLog;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.handler.HandlerCollection;
import org.eclipse.jetty.server.handler.RequestLogHandler;
import org.eclipse.jetty.webapp.WebAppContext;

import java.io.File;

/**
 * 
 * @author gag
 * @version $Id: JettyServer.java, v 0.1 2012-4-26 下午8:18:54 gag Exp $
 */
public class JettyServer {

    public static final int defaultJettyPort = 8080;

    private int             jettyPort        = defaultJettyPort;

    public void start() throws Exception {
        Server server = new Server(jettyPort);
        //Ajp13SocketConnector c = new Ajp13SocketConnector();
        //c.setPort(9091);
       // server.addConnector(c);

        HandlerCollection collection = new HandlerCollection();
//        RequestLogHandler logHandler = new RequestLogHandler();
//        NCSARequestLog log = new NCSARequestLog();
//        log.setFilename("request.log");
//        logHandler.setRequestLog(log);


      //  collection.addHandler(logHandler);
        collection.addHandler(createWebapp());
        server.setHandler(collection);

        server.start();
        server.join();
    }

    protected WebAppContext createWebapp() {
        WebAppContext webapp = new WebAppContext();
        webapp.setDescriptor(getWebDescriptor());
        webapp.setResourceBase(getAppRoot() + "/htdocs/home");
        webapp.setContextPath("/");
        webapp.setInitParameter("org.eclipse.jetty.servlet.Default.dirAllowed", "false");
        webapp.setInitParameter("org.eclipse.jetty.servlet.Default.useFileMappedBuffer", "false");
      //  webapp.setInitParameter("useFileMappedBuffer","false");
        SecurityHandler securityHandler = new ConstraintSecurityHandler();
        HashLoginService loginService  = new HashLoginService();
        loginService.setName("authorizingRealm");
        securityHandler.setLoginService(loginService);
        webapp.setSecurityHandler(securityHandler);
        return webapp;
    }

    public void setJettyPort(int jettyPort) {
        this.jettyPort = jettyPort;
    }

    private String getWebDescriptor() {
        return getAppRoot() + File.separatorChar + "htdocs" + File.separatorChar + "home"
               + File.separatorChar + "WEB-INF"+File.separatorChar+"web.xml";
    }

    private String getWebDefDescriptor() {
        return getAppRoot() + File.separatorChar + "assembly" + File.separatorChar + "config"
               + File.separatorChar + "webdefault.xml";
    }

    private String getRealm() {
        return getAppRoot() + File.separatorChar + "assembly" + File.separatorChar + "config"
               + File.separatorChar + "realm.properties";
    }

    protected String getAppName() {
        return ConfigrationFactory.getConfigration().getAppName();
    }

    protected String getAppRoot() {
        return ConfigrationFactory.getConfigration().getAppRoot();
    }

    protected String getHtdocsRoot() {
        return ConfigrationFactory.getConfigration().getHtdocsRoot();
    }

}
