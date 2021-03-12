# Lab Introduction and Overview #

## Thunder

This crawl, walk, run framework leverages our experiences and best practices in assisting
ISV organizations around the world adopting OCI. This project is open source and maintained by Oracle Corp.

In the span of a few days or hours, the code examples provided here establish an easy to understand path to gaining operational proficiency in OCI, including the vast majority components required to build and operate your software. Use as little or as much as you find useful here to shorten your time to market, we welcome the collaboration.

Why bother with creating all the infrastructure manually, or creating all the terraform code from scratch when the only thing that you will have to modify in order to achieve the desired infrastructure is a **terraform.tfvars** file?

Solutions in this framework are split between multiple examples containing both terraform and python automations.
The examples are organized as follows:

<table>
  <tr>
    <th width="200">Type</th>
    <th width="400">Description</th>
    <th width="400">Components</th>
  </tr>
  <tr>
    <td><a href="?lab=lab-4-crawl-walk">Crawl</td>
    <td>Independent examples for OCI's basic resources</td>
    <td>adw_atp, dbaas, iam, instances, network</td>
  </tr>
  <tr>
    <td><a href="?lab=lab-4-crawl-walk">Walk</td>
    <td>Independent examples for OCI's advanced resources</td>
    <td>dns, fss, instance-principal, load-balancer, object-storage</td>
  </tr>
  <tr>
    <td><a href="?lab=lab-5-free-tier">Free Tier</td>
    <td>Contains the always free components</td>
    <td>1 Instance, 1 LB, 1 Network, 1 ATP, 1 Object Storage Bucket</td>
  </tr>
  <tr>
    <td><a href="?lab=lab-6-enterprise-tier">Enterprise Tier</td>
    <td>Starting point for all automations</td>
    <td>Contains all crawl and walk terraform components</td>
  </tr>
  <tr>
    <td><a href="?lab=lab-7-run-examples">Run</td>
    <td>Different examples that may help you get proficient experience on OCI.</td>
    <td>backup-restore, glusterfs, grafana, start-stop, asg, remote-peering, kms, waas, fss-redudancy</td>
  </tr>
  <tr>
    <td><a href="?lab=lab-8-network-architectures">Network Architectures</td>
    <td>Contains network architecture examples</td>
    <td>N Tier Web App, SaaS Isolated/Shared</td>
  </tr>
    <tr>
    <td><a href="?lab=lab-9-custom-images">Custom Images</td>
    <td>Contains custom images examples</td>
    <td>Packer OCI/Non-OCI builder images, move images from region 1 to region 2</td>
  </tr>
  </tr>
    <tr>
    <td><a href="?lab=lab-10-dev-tools">Developer Tools</td>
    <td>Contains developer tools examples</td>
    <td>OKE, API Gateway, Functions, Marketplace Instances</td>
  </tr>
  </tr>
    <tr>
    <td><a href="?lab=lab-11-ci-cd">CI CD</td>
    <td>CI/CD Examples for Github and Gitlab</td>
    <td>Packer, Ansible, Docker based solutions</td>
  </tr>
</table>


## Acknowledgements

**Authors/Contributors** - Flavius Dinu, Ionut Sturzu, Ionut Irimia, Cristian Cozma, Marius Ciotir, Sorin Ionescu, Laura Paraschiv, Bogdan Darie, Emanuel Grama, Travis Mitchell, Thomas Liakos
