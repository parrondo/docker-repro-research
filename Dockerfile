FROM ubuntu:12.04

# Define environment variables
ENV LD_LIBRARY_PATH /usr/local/lib
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Install base utilities
RUN apt-get update
RUN apt-get install -y wget make g++ gfortran sudo git screen
RUN apt-get install -y libjpeg-dev imagemagick libblas-dev liblapack-dev libpng12-dev
RUN apt-get install -y python2.7 python-dev python-zmq python-matplotlib python-pip

# Install Python scientific packages
# Pin these versions for reproducibility
RUN pip install numpy==1.6.2 pycrypto==2.6.1 scipy==0.11 PIL==1.1.7 nibabel==1.2.2 pandas==0.14.0

# Install other Python utilities
RUN pip install jinja2 tornado ipython pymongo
ENV IPYTHONDIR /home/ipython

# Install Julia
RUN apt-get install -y python-software-properties software-properties-common
RUN add-apt-repository ppa:staticfloat/juliareleases
RUN add-apt-repository ppa:staticfloat/julia-deps
RUN apt-get update
RUN apt-get install -y julia
RUN julia -e 'Pkg.add("IJulia")'

# Install R
RUN sed -i '$ a\deb http://cran.cnr.berkeley.edu/bin/linux/ubuntu precise/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y --force-yes r-base

# Setup link to local source code
ADD source_install.sh /usr/local/bin/

# Expose port for IPython
EXPOSE 28888
# Expose port for IJulia
EXPOSE 38888

