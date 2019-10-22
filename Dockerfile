# Script author Danny Meijer - 2019

# This Dockerfile is based on the jupyter distributed and maintained pyspark-notebook
# Github link: https://github.com/jupyter/docker-stacks/blob/master/pyspark-notebook/Dockerfile
# Original copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

# This Docker image simply extends the pyspark-notebook with the following additions:
#  - enables Jupyter Lab by default
#  - exposes correct ports for JupyterLab and SparkUI
#  - with current port setup, SparkUI supports up to ten consecutive Spark applications

# Although generally considered bad practice, I have opted to hard expose the ports
# between host and container. This is done solely because of me expecting this
# container to be used by Docker novices that might not know exactly how port bindings
# work. The intend of this container is to be able to follow along the PySpark
# tutorials that I have provided, and not to teach how to use Docker.

FROM jupyter/pyspark-notebook:d4cbf2f80a2a
ARG AUTHOR="Danny Meijer <chilltake@gmail.com>"
ARG COURSE_NAME="Mastering Big Data Analytics with Pyspark"
ARG CONTAINER_NAME="mastering-pyspark-ml"
ARG VERSION="20191021"
ENV HOME="/home/jovyan"

# Maintain last refresh date as version - for simple version control
LABEL maintainer=${AUTHOR}
LABEL version=${VERSION}
ENV VERSION ${VERSION}

# RUN pip install pyspark==2.4.3

# Install blackcellmagic. Python plugin for formatting Python code
RUN pip install blackcellmagic
# To load:
# %load_ext blackcellmagic
# To run (once loaded):
# %%black
# TODO: make black enabled by default

RUN pip install pyspark-stubs

# TODO: %config IPCompleter.greedy=True
# https://stackoverflow.com/questions/34853848/jupyter-notebook-greedy-completer-configuration

# TODO: jupyter_contrib_nbextensions
# https://github.com/ipython-contrib/jupyter_contrib_nbextensions
# RUN pip install jupyter_contrib_nbextensions
# RUN jupyter contrib nbextension install --user
# jupyter nbextensions_configurator enable --user

# Enable Jupyter Lab
ENV SPARK_JUPYTER_ENABLE_LABHOME yes

# # Disable Notebook App Token
ENV JUPYTER_TOKEN "masteringpysparkml"

## Exposing neccesary ports
# Jupyter Lab
EXPOSE 8888/tcp
# SparkUI ports
EXPOSE 4040/tcp
EXPOSE 4041/tcp
EXPOSE 4042/tcp
EXPOSE 4043/tcp
EXPOSE 4044/tcp
EXPOSE 4045/tcp
