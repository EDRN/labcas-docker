# Image for LabCAS UI
# ===================

# I'd use Alpine, but I don't yet know atk
FROM debian:latest

# Install dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        python-pip \
        python-dev \
        curl \
        libldap2-dev \
        libsasl2-dev \
        swig \
        libssl-dev \
        gcc \
        git \
        cron \
    && pip install --upgrade pip setuptools
    
# clone repo from GitHub
RUN git clone https://github.com/EDRN/edrn.labcas.ui.git /app

# Doing this first for caching reasons, apparently
# (??? see https://runnable.com/docker/python/dockerize-your-pyramid-application)
#COPY ./requirements.txt /app/

# Let's get going
WORKDIR /app/
RUN pip install -r requirements.txt
#COPY MANIFEST.in README.rst setup.py app.py /app/
#COPY src src
#COPY docs docs
RUN python setup.py install && ls -lF /usr/local/bin/

# install cron job to update the vocabularies
COPY update-vocabularies-cron /etc/cron.d/update-vocabularies-cron
RUN crontab /etc/cron.d/update-vocabularies-cron &&\
    crontab -l

# And let's get running
ENTRYPOINT ["python"]
CMD ["app.py"]
