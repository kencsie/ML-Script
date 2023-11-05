#tutorial
#https://devopscube.com/build-docker-image/

#base image selection
#https://pythonspeed.com/articles/base-image-python-docker-images/
FROM ubuntu:22.04

#install miniconda
#https://docs.conda.io/projects/miniconda/en/latest/
#https://stackoverflow.com/questions/58269375/how-to-install-packages-with-miniconda-in-dockerfile
ENV PATH="/root/miniconda3/bin:${PATH}"
RUN mkdir -p ~/miniconda3
RUN apt-get -y update && apt-get -y install wget
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
RUN bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
RUN rm -rf ~/miniconda3/miniconda.sh
RUN ~/miniconda3/bin/conda init bash

#check conda version
RUN conda --version

CMD ["tail", "-f", "/dev/null"]