# Docker image to run the LabCAS publishing API
FROM python:3.7

RUN apt-get update &&\
    apt-get install -y git

# install dependencies
RUN pip install flask tika dlow

# install source code
RUN mkdir /app &&\
    cd /app &&\
    git clone https://github.com/EDRN/labcas_publish_api.git
    
# run the server
WORKDIR /app/labcas_publish_api
ENTRYPOINT ["python", "-u", "api.py"]
    