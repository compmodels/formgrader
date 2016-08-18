FROM jupyter/scipy-notebook

# Install psychopg2
USER root
ENV SHELL /bin/bash
ENV HOME /root
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

# Run the formgrader
ENTRYPOINT ["/srv/entrypoint.sh"]
