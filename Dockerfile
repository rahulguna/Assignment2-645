FROM tomcat:9

LABEL maintainer="RAMR"

COPY target/*.war /usr/local/tomcat/webapps/


