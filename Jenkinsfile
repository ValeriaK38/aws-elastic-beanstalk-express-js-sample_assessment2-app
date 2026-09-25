pipeline {
    agent any

    stages {
        stage('Security Scan') {
            steps {
                echo 'Running npm audit inside Docker build'
                sh 'docker build --target security-scan -t assessment2-node-audit:${BUILD_NUMBER} .'
            }
        }

        stage('Docker Image') {
            steps {
                echo 'Building application Docker image'
                sh 'docker build --target app -t assessment2-node-app:${BUILD_NUMBER} .'
            }
        }
    }
}
