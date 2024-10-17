pipeline {
  agent any
  environment {
    SRV_HOST_SSH = 'unodostres@192.168.0.14'
    APP_REPO = 'https://github.com/bonanzza-web/jensonar.git'
    SRV_WORKDIR = '/home/unodostres/git-app'
    DOCKER_IMAGE_NAME = 'ebuchiytest'
    DOCKER_IMAGE_TAG = 'latest'
  }
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
    stage("Git clone app") {
      steps {
        script {
          sh """
              ssh ${SRV_HOST_SSH} git pull ${SRV_WORKDIR} && docker build ${SRV_WORKDIR} -t ebuchiytest
            """
        }
        
      }
    }
  }
}
