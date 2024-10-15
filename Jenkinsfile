pipeline {
  agent any

  stages {
    stage('Test stage') {
      steps {
        sh 'ls -la'
        sh 'cat app.py'
      }
    }
    stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh '${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=jensonar -Dsonar.host.url=http://192.168.0.7:9000'
                }
            }
        }
  }
}
