#!/bin/bash

#clone thunder repo
yum install git -y
mkdir learning-library && \
cd learning-library && \
git init && \
git remote add origin -f https://github.com/oracle/learning-library.git && \
git config core.sparsecheckout true && \
echo "solutions-library/infrastructure-automation/*" >> .git/info/sparse-checkout && \
git pull origin master && \
rm -rf .git

# enable yum config
yum install yum-utils -y
echo "Success"

echo 'Installing EPEL, Oracle Public Yum Repo, Python OCI SDK, OCI CLI, Terraform, Terraform OCI Provider'

yum install curl wget which tar unzip -y && \
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && rpm -Uvh epel*.rpm && \
wget http://public-yum.oracle.com/public-yum-ol7.repo -O /etc/yum.repos.d/public-yum-ol7.repo && \
yum install git python-pip -y && wget https://github.com/oracle/oci-python-sdk/releases/download/v2.1.0/oci-python-sdk-2.1.0.zip && \
unzip oci*.zip && cd oci-python-sdk && pip install --upgrade --force-reinstall pip==9.0.3 && pip install requests[security]==2.18.4 && \
pip install oci-*-py2.py3-none-any.whl && yum install ansible -y && pip install oci-cli && \
yum-config-manager --enable ol7_developer && yum install terraform -y && yum install terraform-provider-oci -y && \
wget https://releases.hashicorp.com/packer/1.3.3/packer_1.3.3_linux_amd64.zip -O /usr/local/bin/packer_1.3.3_linux_amd64.zip && \
cd /usr/local/bin && unzip /usr/local/bin/packer_1.3.3_linux_amd64.zip && \

echo 'export PATH=$PATH::/usr/lib/oracle/18.3/client64/bin' >> /etc/profile

echo 'INSTALLER: Python OCI SDK, OCI CLI, Packer, Terraform, Terraform OCI Provider, installed'

cat > /etc/motd << EOF

Welcome to Oracle Linux Server release 7.6 Bastion Example
OCI Development Tools:
 - OCI Python SDK
 - OCI CLI
 - Hashicorp Packer
 - Hashicorp Terraform
 - Terraform OCI Provider

Gather your OCI Tenancy/Compartment details and configure the OCI cli and test the installed tools are working

    * oci setup config (follow the prompts)
       - https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#Other
    * terraform version
    * packer version

EOF
