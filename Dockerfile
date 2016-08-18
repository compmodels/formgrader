FROM jupyter/scipy-notebook

# Install psychopg2
USER root
ENV SHELL /bin/bash
ENV HOME /root
WORKDIR /root
RUN userdel -r $NB_USER
RUN apt-get update
RUN apt-get -y install libpq-dev
RUN pip install psycopg2

# Install nbgrader
RUN pip install nbgrader

# Add nbgrader config
ADD nbgrader_config.py /etc/jupyter/nbgrader_config.py

# Add the entrypoint.sh script
ADD entrypoint.sh /srv/entrypoint.sh
RUN chmod +x /srv/entrypoint.sh

# Add the formgrade.sh script
ADD formgrade.sh /srv/formgrade.sh
RUN chmod +x /srv/formgrade.sh

# smoke test entrypoint
RUN mkdir /home/nbgraderusertest
RUN chown 65000:65000 /home/nbgraderusertest
RUN NBGRADER_USER_ID=65000 NBGRADER_USER=nbgraderusertest sh /srv/entrypoint.sh -h && userdel -r nbgraderusertest

# Run the formgrader
ENTRYPOINT ["/srv/entrypoint.sh"]
