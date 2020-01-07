# Docker image to run the LabCAS publishing API
FROM python:3.7

RUN apt-get update &&\
    apt-get install -y git
    
# install openslide library
RUN apt-get install -y openslide-tools
 
# install source code
# FIXME: use master branch
RUN mkdir /app &&\
    cd /app &&\
    git clone https://github.com/EDRN/labcas_publish_api.git
#   cd labcas_publish_api &&\
#   git checkout develop
    
# install dependencies
RUN cd /app/labcas_publish_api &&\
    pip install -r requirements.txt
        
# start the server with default solr port
WORKDIR /app/labcas_publish_api
ENTRYPOINT ["python", "-u", "api.py", "solr_url=http://localhost:8983/solr/"]
    