pipeline {
    agent any

    environment {
        IMAGE_NAME = 'lera38lera/assessment2-node-app'
    }

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
                sh 'docker build --target app -t ${IMAGE_NAME}:${BUILD_NUMBER} -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Push Image') {
            steps {
                echo 'Pushing Docker image to Docker Hub'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                    sh 'docker push ${IMAGE_NAME}:${BUILD_NUMBER}'
                    sh 'docker push ${IMAGE_NAME}:latest'
                }
            }
        }
    }
}
