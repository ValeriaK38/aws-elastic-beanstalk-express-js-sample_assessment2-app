pipeline {
    // Runs the pipeline on any available Jenkins agent.
    agent any

    environment {
        // Docker Hub image name used by the pipeline.
        IMAGE_NAME = 'lera38lera/assessment2-node-app'
    }

    stages {
        stage('Install Dependencies') {
            // Uses a Node.js 16 Docker container for this stage.
            agent {
                docker {
                    image 'node:16'
                    reuseNode true
                }
            }
            steps {
                // Installs the Node.js dependencies from package-lock.json.
                echo 'Installing Node.js dependencies using Node 16 Docker agent'
                sh 'npm ci'
            }
        }
        stage('Unit Test') {
            // Uses Node.js 16 Docker container for the unit test stage.
            agent {
                docker {
                    image 'node:16'
                    reuseNode true
                }
            }
            steps {
                // Runs the test script defined in package.json.
                echo 'Running unit tests using Node 16 Docker agent'
                sh 'npm test'
            }
        }
        stage('Security Scan') {
            // Uses the same Node.js 16 Docker image for the security scan.
            agent {
                docker {
                    image 'node:16'
                    reuseNode true
                }
            }
            steps {
                // Runs npm audit and fails the build if high or critical issues are found.
                echo 'Running npm audit using Node 16 Docker agent'
                sh 'npm audit --audit-level=high'
            }
        }

        stage('Docker Image') {
            steps {
                // Builds the application Docker image and tags it with the build number and latest.
                echo 'Building Docker image'
                sh 'docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Push Image') {
            steps {
                // Pushes the Docker image to Docker Hub using Jenkins credentials.
                echo 'Pushing Docker image to Docker Hub'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                    sh 'docker push ${IMAGE_NAME}:${BUILD_NUMBER}'
                    sh 'docker push ${IMAGE_NAME}:latest'
                }
            }
        }

        stage('Archive Build Info') {
            steps {
                // Creates a text file with important build information.
                echo 'Creating build information artifact'
                sh '''
                    echo "Build Number: ${BUILD_NUMBER}" > build-info.txt
                    echo "Image Name: ${IMAGE_NAME}" >> build-info.txt
                    echo "Git Commit: ${GIT_COMMIT}" >> build-info.txt
                    echo "Docker Hub Repository: lera38lera/assessment2-node-app" >> build-info.txt
                '''
                // Saves the build-info.txt file as a Jenkins build artifact.
                archiveArtifacts artifacts: 'build-info.txt', fingerprint: true
            }
        }
    }
}
