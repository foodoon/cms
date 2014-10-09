/**
 * zoneland.net Inc.
 * Copyright (c) 2002-2012 All Rights Reserved.
 */
package guda.cms.test;

import guda.mvc.runtime.core.config.ConfigrationFactory;
import org.mortbay.jetty.Server;
import org.mortbay.jetty.webapp.WebAppContext;

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
        server.setHandler(createWebapp());
        server.start();
        server.join();
    }

    protected WebAppContext createWebapp() {
        WebAppContext webapp = new WebAppContext();
        webapp.setDescriptor(getWebDescriptor());
        webapp.setResourceBase(getAppRoot() + "/htdocs");
        webapp.setContextPath("");

        //  webapp.setParentLoaderPriority(true);
        return webapp;
    }

    /**
     * Setter method for property <tt>jettyPort</tt>.
     * 
     * @param jettyPort value to be assigned to property jettyPort
     */
    public void setJettyPort(int jettyPort) {
        this.jettyPort = jettyPort;
    }

    private String getWebDescriptor() {
        return getAppRoot() + File.separatorChar + "assembly" + File.separatorChar + "config"
               + File.separatorChar + "web.xml";
    }

    private String getRealm() {
        return getAppRoot() + File.separatorChar + "assembly" + File.separatorChar + "config"
               + File.separatorChar + "realm.properties";
    }

    protected String getAppName() {
        return ConfigrationFactory.getConfigration().getAppName();
    }

    protected String getAppRoot() {
        return System.getProperty("user.dir");
    }

    protected String getHtdocsRoot() {
        return ConfigrationFactory.getConfigration().getHtdocsRoot();
    }

}
