#!/bin/sh
# script to start the file manager through supervisor in non-daemon mode

export SOLR_INSTALL_DIR=${LABCAS_HOME}/solr
export SOLR_HOME=${LABCAS_HOME}/solr-home
export SOLR_DATA_DIR=${LABCAS_HOME}/solr-index
/usr/local/bin/supervisord -c /etc/supervisor/supervisord-filemgr.conf
