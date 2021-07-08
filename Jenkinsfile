pipeline {
  environment {
    image_name = "shakilsaddam/springboot-mysql"
    registryCredential = 'DOCKER-HUB-SHAKIL'
    dockerImage = ''
  }

  agent any

  stages {
    stage("Git Clone") {
        steps {
            git branch: "build-automation", url: "https://github.com/shakilsaddam/spring-boot-mysql-base-project.git"
        }
    }

    stage("Gradle Build") {
        steps {
            sh './gradlew clean build'
        }  
    }

    stage("Building/Dockerizing Image") {
      steps{
        script {
          dockerImage = docker.build("${env.image_name}", ".")
        }
      }
    }

    stage("Docker Push to Dockerhub") {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("$BUILD_NUMBER")
            dockerImage.push('latest')

          }
        }
      }
    }

    stage("Deploy App to K8S Cluster") {
      steps {
        script {
          kubernetesDeploy(
            configs: "k8s-all/*.yml",
            kubeconfigId: "KUBE_CONFIG",
            enableConfigSubstitution: true
          )
        }
      }
    }

  }
}