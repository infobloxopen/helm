// This library defines the isPrBuild, prepareBuild and finalizeBuild methods
@Library('jenkins.shared.library') _

pipeline {
  agent {
    label 'ubuntu_docker_label'
  }
  options {
    checkoutToSubdirectory('src/github.com/infobloxopen/helm')
  }
  environment {
    DIRECTORY = "src/github.com/infobloxopen/helm"
  }

  stages {
    stage("Setup") {
      steps {
        // prepareBuild is one of the Secure CICD helper methods
        prepareBuild()
      }
    }
    stage("Build Image") {
      steps {
        dir("$DIRECTORY") {
           sh "make build"
        }
      }
    }
    stage("Push Image") {
      //when { expression { ! isPrBuild() }  }
      when { anyOf { branch "master", branch "helm3" } }
      steps {
        // reference Jenkins credential ids via an environment variable
        withDockerRegistry([credentialsId: "${env.JENKINS_DOCKER_CRED_ID}", url: ""]) {
          dir("$DIRECTORY") {
             sh "make docker-push"
          }
        }
      }
    }
  post {
    success {
      // finalizeBuild is one of the Secure CICD helper methods
      dir("$DIRECTORY") {
          finalizeBuild()
      }
    }
    cleanup {
      dir("$DIRECTORY") {
        sh "make clean || true"
      }
      cleanWs()
    }
  }
}

