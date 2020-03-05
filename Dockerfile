FROM tomcat:newTomcatCustom

LABEL maintainer="RAMR"

ADD Avinash.war /usr/local/tomcat/webapps/

EXPOSE 8080

