# Provisioning a complete ready Kubernetes Cluster and Jenkins Server using Vagrant

### Pre-requisits
To provision K8S Cluster and Jenkins Server your machine must have the following applications installed.
- Vagrant
- VirtualBox

### Provision, Stop, and Destroy All VMs
Go to the root directory where `Vagrantfile` resides and execute `vagrant up` command. Within a few hours (based on your internet speed) it will get everything ready.
```
vagrant up
vagrant halt
vagrant destory
```

### Execute the following command if anything is changed in `provision` section after the `vagrant up` command.
```
vagrant reload --provision
```


## Jenkins Dependencies
Some additional plugins need to be installed and configured accordingly to successfully run the Jenkins Pipeline ( `Manage Jenkins > Manage Plugins` ). They are as follows:
- Maven (If it is a Maven Project)
- Gradle
- Publish Over SSH
- SSH Pipeline Steps
- Docker Pipeline Plugin
- Docker Build Step Plugin
- Kubernetes Plugin
- Kubernetes Continuous Deployment Plugin

I have faced some issues with the latest `Kubernetes Continuous Deployment Plugin`. It has to be downgraded to make it working. You can download the downgraded version from https://updates.jenkins.io/download/plugins/kubernetes-cd/1.0.0/kubernetes-cd.hpi and install it from `Manage Jenkins > Manage Plugins> Advanced Options> Upload Plugin`



# Spring Boot MySQL Base Project

This application was developed to demonstrate Spring Boot with MySQL with simple API.

Technologies Used

- Spring Boot 2.4.1
- Spring Data JPA
- Lombok
- MySQL

How to Run this application

First change the **src/main/resources/application.properties** with your MySQL instance properties.

Then,

```shell
$ ./gradlew bootRun
```

or create a build using following command,

```shell
$ ./gradlew clean build
```

Then start the JAR file using java

```shell
$ java -jar build/libs/spring-boot-mysql-base-project-0.0.1-SNAPSHOT.jar
```

### Related Articles

- [Docker Compose For Spring Boot with MySQL](https://javatodev.com/docker-compose-for-spring-boot-with-mysql/)
- [Docker Compose For Spring Boot with MariaDB](https://javatodev.com/docker-compose-for-spring-boot-with-mariadb/)
