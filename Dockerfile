FROM sagemathinc/cocalc

#Install useful utilities missing in original CoCalc image
RUN apt-get update 
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

#Install the fish shell for default usage.
RUN apt-get install fish
RUN chsh -s /usr/bin/fish

#Install Anaconda
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

#Install Python packages (incl. Theano, Keras and PyTorch)
RUN /opt/conda/bin/conda install -c mutirri simpy
RUN /opt/conda/bin/conda install -y ipykernel pandas matplotlib pydot-ng theano pygpu bcolz paramiko keras seaborn graphviz scikit-learn tensorflow numpy scipy


ENV PATH /opt/conda/bin:${PATH}
RUN echo 'export PATH=/opt/conda/bin${PATH:+:${PATH}}' >> ~/.bashrc

#Add Conda kernel to Jupyter
RUN python -m ipykernel install --prefix=/usr/local/ --name "anaconda_kernel"

#Start CoCalc
CMD /root/run.py
EXPOSE 80 443
