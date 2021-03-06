FROM centos:7

ENV MINICONDA_VERSION=4.7.12 TINI_VERSION=0.18.0

RUN yum -y install bzip2 ca-certificates git glib2 grep libSM \
        libXext libXrender mercurial sed subversion wget \
        && yum -y install "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.rpm" \
        && yum -y update \
        && yum -y clean all

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh \
        && wget --quiet "https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh" -O ~/miniconda.sh \
        && /bin/bash ~/miniconda.sh -b -p /opt/conda \
        && rm ~/miniconda.sh

ENV PATH /opt/conda/bin:$PATH

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
