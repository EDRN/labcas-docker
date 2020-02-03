FROM nginx

RUN apt-get update &&\
    apt-get install -y git
    
# deploy application
# FIXME: use master
RUN cd /tmp &&\
    git clone https://github.com/EDRN/labcas-ui.git &&\
    cd labcas-ui &&\
    git checkout Development
 
RUN cd /tmp &&\
    cp -r labcas-ui/application /usr/share/nginx/html/application &&\
	cp -r labcas-ui/assets /usr/share/nginx/html/assets &&\
	rm -rf /tmp/labcas-ui
