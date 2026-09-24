pipeline {
    agent any

    stages {
        stage('Install Dependencies') {
            agent {
                docker {
                    image 'node:16'
                    reuseNode true
                }
            }
            steps {
                sh 'npm ci'
            }
        }

        stage('Security Audit') {
            agent {
                docker {
                    image 'node:16'
                    reuseNode true
                }
            }
            steps {
                sh 'npm audit --audit-level=high'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t assessment2-node-app:${BUILD_NUMBER} .'
            }
        }
    }
}
