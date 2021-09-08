FROM jenkins/jenkins:lts
USER root
RUN \
    curl https://mirrors.estointernet.in/apache/maven/maven-3/3.8.2/binaries/apache-maven-3.8.2-bin.tar.gz -o apache-maven-3.8.2-bin.tar.gz && \
    tar xvf apache-maven-3.8.2-bin.tar.gz -C /opt && \
    curl https://releases.hashicorp.com/terraform/1.0.5/terraform_1.0.5_linux_amd64.zip -o terraform_1.0.5_linux_amd64.zip && \
    unzip terraform_1.0.5_linux_amd64.zip -d /usr/local/bin && \
    curl https://nodejs.org/dist/v12.22.6/node-v12.22.6-linux-x64.tar.gz -o node-v12.22.6-linux-x64.tar.gz && \
    tar xvf node-v12.22.6-linux-x64.tar.gz -C /opt && \
    curl http://ftp.br.debian.org/debian/pool/main/z/zip/zip_3.0-11+b1_amd64.deb -o zip_3.0-11+b1_amd64.deb
RUN apt install ./zip_3.0-11+b1_amd64.deb
ENV PATH="/opt/apache-maven-3.8.2/bin:${PATH}"
ENV PATH="/opt/node-v12.22.6-linux-x64/bin:${PATH}"
RUN chown -R jenkins /opt/node-v12.22.6-linux-x64 && \
    chown -R jenkins /opt/apache-maven-3.8.2 
USER jenkins