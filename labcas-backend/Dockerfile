# Docker image containing core LabCAS back-end services.

FROM edrn/labcas-node

MAINTAINER Luca Cinquini <luca.cinquini@jpl.nasa.gov>

# checkout LabCAS source
ENV LABCAS_SRC /tmp
RUN cd $LABCAS_SRC && \
    git clone https://github.com/EDRN/labcas-backend.git && \
    cd labcas-backend && \
    git checkout -b devel origin/devel

# install all services into $LABCAS_HOME
RUN cd $LABCAS_SRC/labcas-backend && \
    mvn install

# install all workflows into $LABCAS_HOME/workflows
RUN cd $LABCAS_SRC/labcas-backend && \
    mvn install -Dworkflow=labcas-upload && \
    mvn install -Dworkflow=labcas-test && \
    mvn install -Dworkflow=nist

# crate non-privileged Solr user (Solr does not run as root)
RUN groupadd solr && \
    useradd -s /sbin/nologin -g solr -d /usr/local/solr solr
RUN mkdir $LABCAS_HOME/solr-index
RUN chown -R solr:solr $LABCAS_HOME/solr-home $LABCAS_HOME/solr/server $LABCAS_HOME/solr-index

# expose service ports
EXPOSE 9000 9001 9002 8983 8080

# copy configuration and startup scripts
#COPY scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY conf/supervisord.conf /etc/supervisord.conf
COPY conf/supervisord-*.conf /etc/supervisor/conf.d/

# default command starts supervisor in non-daemon mode
# to be overridden by child images
CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisord.conf"]

