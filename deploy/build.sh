cd .. && git pull
tomcat_home=/usr/tomcat-news
mvn package -Dmaven.test.skip=true
mv assembly/target/cms-1.0-SNAPSHOT.war ROOT.war
mv ${tomcat_home}/webapps/ROOT.war ${tomcat_home}/webapps/ROOT.war.bak
rm -rf ${tomcat_home}/webapps/ROOT

cp ROOT.war ${tomcat_home}/webapps/

