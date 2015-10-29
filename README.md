---
title: Web UI | ARGO
---

## Description
# Web UI module for the ARGO Framework

* based on Lavoisier Framework - http://software.in2p3.fr/lavoisier
* prerequisites : a server certificate and java (version prior to 1.8 or 8 ) 
* no services running on port 80 and 443


# prerequisites (CENTOS installation)

* yum install java-1.7.0-openjdk.x86_64
* yum install wget
* yum install unzip 

# Open ports
* firewall-cmd --zone=public --add-port=80/tcp --permanent
* firewall-cmd --zone=public --add-port=43/tcp --permanent
* firewall-cmd --reload



# Installation of CAs

Add the following repo-file to the /etc/yum.repos.d/ directory:  
    
[EGI-trustanchors]
name=EGI-trustanchors
baseurl=http://repository.egi.eu/sw/production/cas/1/current/
gpgkey=http://repository.egi.eu/sw/production/cas/1/GPG-KEY-EUGridPMA-RPM-3
gpgcheck=1
enabled=1

* yum install ca-policy-egi-core

## Installation 
### the $HOME_LAVOISIER is the directory where do you install the service
* cd $HOME_LAVOISIER
* wget https://github.com/ARGOeu/argo-egi-web/archive/master.zip
* unzip master.zip
* mkdir certificate
* put your certificate in p12 format in this directory


## Configuration 
### edit lavoisier-hidden.properties
* cd $HOME_LAVOISIER/argo-egi-web-master/etc
* vi lavoisier-hidden.properties
* complete certificate.path and certificate.password
* specify the cache.baseDirectory property - location of the caches for the data
* specify the server.baseUrl 
* lavoisier.ssl.trustStore=path_to_your_ca  (/etc/grid-security/certificates)
* lavoisier.ssl.keyStore= path to the lavoisier certificate
* lavoisier.ssl.keyStorePassword= password of this certificate

### edit password.properties
* cd $HOME_LAVOISIER/argo-egi-web-master/etc/security
* vi password.properties
* change or add login and passwords (admin and changeit by defaut)


## Examples

### Start the service 

* ./bin/lavoisier.sh console
* check the logs and access to the interface : http://yourmachine/lavoisier
* if everything goes well 
*  ./bin/lavoisier.sh restart


### Useful commands and hints

* To change the PI base url : vi $HOME_LAVOISIER/etc/ARGO_UI/lavoisier-config.properties
* to stop lavoisier : 
cd $HOME_LAVOISIER
./bin/lavoisier.sh stop


## Links and further reading

* http://software.in2p3.fr/lavoisier/
