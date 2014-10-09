/**
 * zoneland.net Inc.
 * Copyright (c) 2002-2012 All Rights Reserved.
 */
package guda.cms.test;




/**
 * 
 * @author gag
 * @version $Id: JettyTestServer.java, v 0.1 2012-4-26 ����9:19:14 gag Exp $
 */
public class JettyServerStart extends JettyServer {

    public static void main(String[] args) throws Exception {
        JettyServer jetty = new JettyServer();
        jetty.start();
    }
}
