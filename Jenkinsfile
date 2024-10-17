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
                    sh '/var/jenkins_home/tools/hudson.plugins.sonar.SonarRunnerInstallation/sonarscanner/bin/bin/sonar-scanner -Dsonar.projectKey=jensonar -Dsonar.host.url=http://192.168.0.7:9000'
                }
            }
        }
    stage("Quality Gate") {
            steps {
                // Этот шаг ожидает завершения анализа и возвращает статус Quality Gate
                timeout(time: 2, unit: 'MINUTES') { 
                    script {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }
    stage("Build docker image") {
      steps {
        sh 'ssh unodostres@192.168.0.14 -c whoami'
      }
    }
  }
}
