pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'docker-creds'
        DOCKER_IMAGE = 'poov23/devops-build'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                        docker build -t ${DOCKER_IMAGE}:${BRANCH_NAME} .
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry([credentialsId: DOCKERHUB_CREDENTIALS, url: '']) {
                        sh """
                            docker push ${DOCKER_IMAGE}:${BRANCH_NAME}
                        """
                    }
                }
            }
        }

        stage('Deploy to Dev') {
            when {
                branch 'dev'
            }
            steps {
                echo "Deploying to DEV environment..."
                sh "bash deploy.sh dev"
            }
        }

        stage('Deploy to Prod') {
            when {
                branch 'main'
            }
            steps {
                echo "Deploying to PRODUCTION environment..."
                sh "bash deploy.sh prod"
            }
        }
    }
}
