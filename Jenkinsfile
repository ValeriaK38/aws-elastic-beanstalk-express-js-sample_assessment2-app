pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Installing Node.js dependencies'
                sh 'docker run --rm -v "$PWD":/app -w /app node:16 npm ci'
            }
        }

        stage('Security Scan') {
            steps {
                echo 'Running npm audit security scan'
                sh 'docker run --rm -v "$PWD":/app -w /app node:16 npm audit --audit-level=high'
            }
        }

        stage('Docker Image') {
            steps {
                echo 'Building Docker image'
                sh 'docker build -t assessment2-node-app:${BUILD_NUMBER} .'
            }
        }
    }
}
