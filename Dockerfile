FROM jupyter/scipy-notebook:latest

# Installing java into the environment
USER root
RUN apt-get update && \
    apt-get install -y openjdk-8-jre \
    && apt-get clean
USER $NB_USER

# Install packages
COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/

RUN pip install --no-cache --requirement /tmp/requirements.txt && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Disable token to login
CMD ["start-notebook.sh", "--LabApp.token=''", "--NotebookApp.token=''"]

# Install OpenRefine
ARG OPENREFINEVERSION=3.4.1
ENV OPENREFINEPATH=/opt/openrefine/refine

USER root
RUN wget -q -O /tmp/openrefine.tar.gz \
    https://github.com/OpenRefine/OpenRefine/releases/download/$OPENREFINEVERSION/openrefine-linux-$OPENREFINEVERSION.tar.gz && \
    mkdir -p /opt/openrefine && \
    tar xzf /tmp/openrefine.tar.gz -C /opt/openrefine --strip-components 1 && \
    rm /tmp/openrefine.tar.gz
USER $NB_USER

RUN pip install --no-cache jupyter-server-proxy

COPY --chown=${NB_UID}:${NB_GID} jupyter_notebook_config.py /home/$NB_USER/.jupyter/
