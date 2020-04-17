# Lab Setup
## Before You Begin

This lab walks you through the steps to setup Docker engine and start working on it.

### Background
Oracle Cloud Compute makes it easy to create a Linux environment in the cloud, and creates a platform for installing and setting up a Docker container.

### What Do You Need?

* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [here](http://oracle.com/cloud/free).
* An Oracle Cloud Compute instance Public IP address
* SSH keys
* YUM

## **STEP 1**: Login to the SSH Terminal

1.  Open a terminal window and connect to your compute instance using SSH Keys and the public IP address of your compute instance.

    ````
    $ <copy>ssh -i optionskey opc@</copy>123.123.123.123
    Last login: Thu Apr 16 20:21:28 2020 from c-69-141-91-169.hsd1.nj.comcast.net
    [opc@oraclelinux77 ~]$
    ````

## **STEP 2**: Shut Down Listener

OPTIONAL: If you are running this on a compute instance that has Oracle already installed, you may need to check the status and shut down the listener as oracle user. If you do not have a listener running, proceed to the step 3.

1.  Switch to `oracle` user:

    ````
    <copy>sudo su - oracle</copy>
    ````

2.  Now let's check the listener status. If the listener is not running proceed to step 3.
   
    ````
    <copy>ps -ef | grep tns</copy>
    ````

    ````
    <copy>lsnrctl status LISTENER</copy>
    ````

3.  If the listener is running, stop the listener and exit.
   
    ````
    <copy>lsnrctl stop LISTENER</copy> 
    ````

    ````
    <copy>ps -ef | grep tns</copy> 
    ````

    ````
    <copy>exit</copy> 
    ````

## **STEP 3**: Install Docker Engine

Docker is shipped as addon with Oracle Linux 7 UEK4. On Oracle Cloud Compute instances, the `addons yum` repository is now enabled by default, so you only need to install the docker-engine package as root.

1.  Switch to the `root` user:

    ````
    [opc@oraclelinux77 ~]$ <copy>sudo -s</copy>
    [root@oraclelinux77 opc]#
    ````

2.  Install docker using yum. When prompted, press *y* to download. 
   
    ````
    [root@oraclelinux77 opc]# <copy>yum install docker-engine</copy> 
    Loaded plugins: langpacks, ulninfo
    ol7_UEKR5                                                             | 2.8 kB  00:00:00     
    ol7_addons                                                            | 2.8 kB  00:00:00     
    ol7_developer                                                         | 2.8 kB  00:00:00     
    ol7_developer_EPEL                                                    | 3.4 kB  00:00:00     
    ol7_ksplice                                                           | 2.8 kB  00:00:00     
    ol7_latest                                                            | 3.4 kB  00:00:00     
    ol7_oci_included                                                      | 2.9 kB  00:00:00     
    ol7_optional_latest                                                   | 2.8 kB  00:00:00     
    ol7_software_collections                                              | 2.8 kB  00:00:00     
    ...
    Total download size: 88 M
    Installed size: 372 M
    Is this ok [y/d/N]: y
    ...
    Installed:
    docker-engine.x86_64 0:19.03.1.ol-1.0.0.el7                                                                      

    Dependency Installed:
    container-selinux.noarch 2:2.107-3.el7    containerd.x86_64 0:1.2.0-1.0.5.el7  criu.x86_64 0:3.12-2.el7        
    docker-cli.x86_64 0:19.03.1.ol-1.0.0.el7  libnet.x86_64 0:1.1.6-7.el7          protobuf-c.x86_64 0:1.0.2-3.el7 
    runc.x86_64 0:1.0.0-65.rc8.el7           

    Complete!
    [root@oraclelinux77 opc]# 
    ````

    Docker is now installed!

## **STEP 4**: Grant Docker Privileges to Non-root User

Enable a non-root user to communicate with the Docker engine. When Docker was installed a new Unix group docker was created along with it. To allow a non-root user (for example, `opc`) to communicate with the Docker daemon directly, you add the non-root user to the docker group.

1.  Determine which groups `opc` belongs to:

    ```
    [root@oraclelinux77 opc]# <copy>id opc</copy>
    uid=1000(opc) gid=1000(opc) groups=1000(opc),4(adm),10(wheel),190(systemd-journal)
    [root@oraclelinux77 opc]#
    ```

2.  Grant docker privilege to the `opc` user:
   
    ````
    [root@oraclelinux77 opc]# <copy>usermod -aG docker opc</copy>
    [root@oraclelinux77 opc]# 
    ````

3.  Check `opc` is now part of `docker` group:
   
    ````
    [root@oraclelinux77 opc]# <copy>id opc</copy>
    uid=1000(opc) gid=1000(opc) groups=1000(opc),4(adm),10(wheel),190(systemd-journal),992(docker)
    [root@oraclelinux77 opc]#
    ````

## **STEP 5**: Start Docker

1.  Enable the docker service.
   
    ````
    [root@oraclelinux77 opc]# <copy>systemctl enable docker</copy>
    Created symlink from /etc/systemd/system/multi-user.target.wants/docker.service to /usr/lib/systemd/system/docker.service.
    [root@oraclelinux77 opc]# 
    ````

2.  Start the docker.

    ````
    [root@oraclelinux77 opc]# <copy>systemctl start docker</copy>
    [root@oraclelinux77 opc]# 
    ````

3. Check the status.

    ````
    [root@oraclelinux77 opc]# <copy>systemctl status docker</copy>
    ● docker.service - Docker Application Container Engine
      Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
      Active: active (running) since Thu 2020-04-16 21:05:39 GMT; 15min ago
        Docs: https://docs.docker.com
    Main PID: 29730 (dockerd)
       Tasks: 10
      Memory: 38.5M
      CGroup: /system.slice/docker.service
               └─29730 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
    ...
    Apr 16 21:05:39 oraclelinux77 systemd[1]: Started Docker Application Container Engine.
    Hint: Some lines were ellipsized, use -l to show in full.
    [root@oraclelinux77 opc]#
    ````

## **STEP 6**: Install GIT on Docker

Now, we are going to install git using yum as the root user.

1.  Verify you are `root` user: 

    ````
    [root@oraclelinux77 opc]# <copy>whoami</copy>
    root
    [root@oraclelinux77 opc]#
    ````

2.  Install git using yum. When prompted, press *y* to download.

    ````
    [root@oraclelinux77 opc]# <copy>yum install git</copy>
    Loaded plugins: langpacks, ulninfo
    Resolving Dependencies
    --> Running transaction check
    ---> Package git.x86_64 0:1.8.3.1-21.el7_7 will be installed
    --> Processing Dependency: perl-Git = 1.8.3.1-21.el7_7 for package: git-1.8.3.1-21.el7_7.x86_64
    --> Processing Dependency: perl(Term::ReadKey) for package: git-1.8.3.1-21.el7_7.x86_64
    --> Processing Dependency: perl(Git) for package: git-1.8.3.1-21.el7_7.x86_64
    --> Processing Dependency: perl(Error) for package: git-1.8.3.1-21.el7_7.x86_64
    --> Running transaction check
    ---> Package perl-Error.noarch 1:0.17020-2.el7 will be installed
    ---> Package perl-Git.noarch 0:1.8.3.1-21.el7_7 will be installed
    ---> Package perl-TermReadKey.x86_64 0:2.30-20.el7 will be installed
    --> Finished Dependency Resolution
    ...
    Total download size: 4.5 M
    Installed size: 22 M
    Is this ok [y/d/N]: y
    ...
    Installed:
    git.x86_64 0:1.8.3.1-21.el7_7                                                                                    

    Dependency Installed:
    perl-Error.noarch 1:0.17020-2.el7   perl-Git.noarch 0:1.8.3.1-21.el7_7   perl-TermReadKey.x86_64 0:2.30-20.el7  

    Complete!
    [root@oraclelinux77 opc]#
    ````

    Git is now installed!

## **STEP 7**: Verify Docker and GIT Version

Verify the version of Docker and GIT by switching to the `opc` user.

1.  Switch to `opc` user:

    ````
    root@oraclelinux77 opc]# <copy>su - opc</copy>
    Last login: Thu Apr 16 20:28:23 GMT 2020 from c-69-141-91-169.hsd1.nj.comcast.net on pts/1
    [opc@oraclelinux77 ~]$
    ````

2.  Check Docker version:

    ````
    [opc@oraclelinux77 ~]$ <copy>docker version</copy>
    Client: Docker Engine - Community
    Version:           19.03.1-ol
    API version:       1.40
    Go version:        go1.12.5
    Git commit:        ead9442
    Built:             Wed Sep 11 06:40:28 2019
    OS/Arch:           linux/amd64
    Experimental:      false

    Server: Docker Engine - Community
     Engine:
      Version:          19.03.1-ol
      API version:      1.40 (minimum version 1.12)
      Go version:       go1.12.5
      Git commit:       ead9442
      Built:            Wed Sep 11 06:38:43 2019
      OS/Arch:          linux/amd64
      Experimental:     false
      Default Registry: docker.io
     containerd:
      Version:          v1.2.0-rc.0-108-gc444666
      GitCommit:        c4446665cb9c30056f4998ed953e6d4ff22c7c39
     runc:
      Version:          spec: 1.0.1-dev
      GitCommit:        
     docker-init:
      Version:          0.18.0
      GitCommit:        fec3683
    [opc@oraclelinux77 ~]$
    ````

3.  Check Docker images:

    ````
    [opc@oraclelinux77 ~]$ <copy>docker images</copy>
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    [opc@oraclelinux77 ~]$
    ````

4.  Check git version:
   
    ````
    [opc@oraclelinux77 ~]$ <copy>git --version</copy> 
    git version 1.8.3.1
    [opc@oraclelinux77 ~]$
    ````

## **STEP 7**: Update the Server Mode

1.  Exit from `opc` user:

    ````
    [opc@oraclelinux77 ~]$ <copy>exit</copy> 
    logout
    [root@oraclelinux77 opc]# 
    ````

2.  Place your server in `permissive` mode.
   
    ````
    [root@oraclelinux77 opc]# <copy>setenforce 0</copy> 
    [root@oraclelinux77 opc]#
    ````

3.  Check Status:
   
    ````
    root@oraclelinux77 opc]# <copy>sestatus</copy>
    SELinux status:                 enabled
    SELinuxfs mount:                /sys/fs/selinux
    SELinux root directory:         /etc/selinux
    Loaded policy name:             targeted
    Current mode:                   permissive
    Mode from config file:          permissive
    Policy MLS status:              enabled
    Policy deny_unknown status:     allowed
    Max kernel policy version:      31
    root@oraclelinux77 opc]# 
    ```` 

4.  Switch back to the `opc` user:

    ````
    root@oraclelinux77 opc]# <copy>su - opc</copy>
    Last login: Thu Apr 16 22:10:07 GMT 2020 on pts/0
    [opc@oraclelinux77 ~]$  
    ````

5.  Verify you are the `opc` user
   
    ````
    [opc@oraclelinux77 ~]$ <copy>whoami</copy>
    opc
    [opc@oraclelinux77 ~]$ 
    ````

You may now proceed to the next lab.

## Acknowledgements
* **Author** - Oracle NATD Solution Engineering
* **Adapted for Cloud by** -  
* **Last Updated By/Date** - Anoosha, April 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
