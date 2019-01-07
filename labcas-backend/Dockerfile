# Docker image containing core LabCAS back-end services.

#############
## Stage 1 ##
#############
FROM maven:3.5.3-jdk-9 as labcas-build

MAINTAINER Luca Cinquini <luca.cinquini@jpl.nasa.gov>

RUN apt-get update

# checkout LabCAS source
ENV LABCAS_SRC /tmp
RUN cd $LABCAS_SRC && \
    git clone https://github.com/EDRN/labcas-backend.git && \
    cd labcas-backend &&\
    git checkout -b devel origin/devel

# install all services into $LABCAS_HOME
# Note: pom.xml will configure core.properties to use $LABCAS_HOME/solr-index/<core>/ as location of Solr index
ENV LABCAS_HOME /usr/local/labcas
RUN cd $LABCAS_SRC/labcas-backend && \
    mvn install
    
# install all workflows into $LABCAS_HOME/workflows
RUN cd $LABCAS_SRC/labcas-backend && \
    mvn install -Dworkflow=labcas-upload && \
    mvn install -Dworkflow=labcas-test && \
    mvn install -Dworkflow=nist
    

#############
## Stage 2 ##
#############

FROM openjdk:9-jre

# install supervisor in sysyem python
RUN apt-get update && \
    apt-get install -y supervisor

# copy all built-up services to $LABCAS_HOME
ENV LABCAS_HOME /usr/local/labcas
COPY --from=labcas-build /usr/local/labcas $LABCAS_HOME

# setup environment
ENV LABCAS_CONFIG $LABCAS_HOME/workflows
ENV LABCAS_STAGING /usr/local/labcas_staging
ENV LABCAS_ARCHIVE /usr/local/labcas_archive

ENV OODT_HOME $LABCAS_HOME
ENV FILEMGR_URL http://localhost:9000/
ENV WORKFLOW_URL http://localhost:9001/
RUN mkdir -p $OODT_HOME/run
ENV PGE_ROOT $OODT_HOME/jobs
RUN mkdir -p $PGE_ROOT

# expose service ports
EXPOSE 9000 9001 8983 8080

# copy configuration and startup scripts
#COPY scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY conf/supervisord.conf /etc/supervisord.conf
COPY conf/supervisord-*.conf /etc/supervisor/conf.d/

# start supervisor in non-daemon mode
CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisord.conf"]
#CMD ["/usr/local/bin/docker-entrypoint.sh"]
