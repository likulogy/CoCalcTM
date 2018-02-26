FROM sagemathinc/cocalc

#Install useful utilities missing in original CoCalc image
RUN sed -i -e 's/archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list && apt-get update 
RUN apt-get install -y --no-install-recommends \
	curl \
	ca-certificates \
        nano \
        gnuplot \
	wget \
	bzip2 \
        g++-5 \
        gcc-5 \
        ca-certificates \
        libglib2.0-0 \
        libxext6 \
        libsm6 \
        libxrender1 \
        git mercurial subversion \
        hugo \
	libkrb5-dev

#Install Anaconda
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

#Install Python packages (incl. Theano, Keras and PyTorch)
RUN /opt/conda/bin/conda install -y ipykernel matplotlib pydot-ng theano pygpu bcolz paramiko keras seaborn graphviz scikit-learn

#RUN /opt/conda/bin/conda install -c calex sklearn-pandas

ENV PATH /opt/conda/bin:${PATH}
RUN echo 'export PATH=/opt/conda/bin${PATH:+:${PATH}}' >> ~/.bashrc

#Add Conda kernel to Jupyter
RUN python -m ipykernel install --prefix=/usr/local/ --name "anaconda_kernel"

#Start CoCalc

CMD /root/run.py

EXPOSE 80 443
