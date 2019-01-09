# Docker container holding LabCA client libraries
# Based on continuumio/miniconda Docker image which contains a Miniconda installation based on Python 2.7
FROM continuumio/miniconda

RUN apt-get update &&\
    apt-get install -y gcc

ENV LABCAS_STAGING /usr/local/labcas/staging
ENV LABCAS_ARCHIVE /usr/local/labcas/archive

# Install Python libraries needed by LabCAS client
RUN pip install --upgrade pip
RUN pip install solrpy numpy Pillow pydicom pypng pandas 
# Must install special compiler to install openslide-python
RUN conda install gxx_linux-64
RUN pip install openslide-python

# install LabCAS client
RUN cd /tmp && \
    git clone https://github.com/EDRN/labcas-backend.git &&\
    mkdir -p /usr/local/labcas/python &&\
    cp -R /tmp/labcas-backend/common/src/main/python /usr/local/labcas/python
ENV PYTHONPATH /usr/local/labcas/python