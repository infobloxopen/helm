// This library defines the isPrBuild, prepareBuild and finalizeBuild methods
@Library('jenkins.shared.library') _

pipeline {
  agent {
    label 'ubuntu_docker_label'
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
           sh "make build"
      }
    }
    stage("Push Image") {
      when { expression { ! isPrBuild() }  }
      steps {
        // reference Jenkins credential ids via an environment variable
         withDockerRegistry([credentialsId: "${env.JENKINS_DOCKER_CRED_ID}", url: ""]) {
         sh "make docker-push"
        }
      }
    }
  }
  post {
    success {
      // finalizeBuild is one of the Secure CICD helper methods
      finalizeBuild()
    }
    cleanup {
      sh "make clean || true"
      cleanWs()
    }
  }
}

