# LabCAS as Docker containers

## How to start the labcas-backend

* Download this repository, use the master branch (which is the latest stable release):
  git clone https://github.com/EDRN/labcas-docker.git
  
* Create the shared docker network:
  * docker-network create labcas-network

* Define the following enviromental variables, which must be pointing to already existing directories (already populated with data or not):
  * LABCAS_HOME
  * LABCAS_ARCHIVE
  * LABCAS_STAGING
  
  For example:
  * export LABCAS_HOME=/usr/local/labcas/home
  * export LABCAS_ARCHIVE=/usr/local/labcas/archive
  * export LABCAS_STAGING=/usr/local/labcas/staging

* Optional: pull the labcas-backend Docker container ahead of time:
  * docker pull edrn/labcas-backend

* Start the containers:
  * docker-compose up -d
  * docker-compose logs -f
