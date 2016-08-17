FROM jupyter/scipy-notebook

# Install psychopg2
USER root
RUN apt-get update
RUN apt-get -y install libpq-dev
USER $NB_USER
RUN pip install psycopg2

# Install nbgrader
RUN pip install nbgrader

# Add nbgrader config
ADD nbgrader_config.py /etc/jupyter/nbgrader_config.py

# Add the entrypoint.sh script
ADD entrypoint.sh /srv/entrypoint.sh
USER root
RUN chmod +x /srv/entrypoint.sh
USER $NB_USER

# Add the formgrade.sh script
ADD formgrade.sh /srv/formgrade.sh
USER root
RUN chmod +x /srv/formgrade.sh
USER $NB_USER

# Run the formgrader
ENTRYPOINT ["/srv/entrypoint.sh"]
