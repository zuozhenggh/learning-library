FROM fedora:latest
ARG TF_VERSION=0.12.26
RUN dnf install -y wget unzip git \
        python3 python3-setuptools python3-virtualenv python3-pip
RUN pip install oci-cli oci
RUN wget --quiet https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
    unzip terraform_${TF_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TF_VERSION}_linux_amd64.zip
RUN mkdir learning-library && \
        cd learning-library && \
        git init && \
        git remote add origin -f https://github.com/oracle/learning-library.git && \
        git config core.sparsecheckout true && \
        echo "solutions-library/infrastructure-automation/*" >> .git/info/sparse-checkout && \
        git pull origin master && \
        rm -rf .git
# Install kubectl
RUN curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/latest.txt)/bin/linux/amd64/kubectl && \
        chmod +x /usr/bin/kubectl && \
        kubectl version --client

WORKDIR /learning-library/solutions-library/infrastructure-automation/thunder/
CMD ["/bin/bash"]
