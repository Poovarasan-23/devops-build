pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "yourdockerhubusername/devops-build"
        DOCKER_CREDENTIALS = "docker-creds"   // Jenkins credential ID
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
                    docker.build("${DOCKER_IMAGE}:${env.BRANCH_NAME}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', DOCKER_CREDENTIALS) {
                        docker.image("${DOCKER_IMAGE}:${env.BRANCH_NAME}").push()
                    }
                }
            }
        }

        stage('Deploy to Dev') {
            when {
                branch 'dev'
            }
            steps {
                sh '''
                docker stop dev-container || true
                docker rm dev-container || true
                docker run -d -p 3001:3000 --name dev-container ${DOCKER_IMAGE}:dev
                '''
            }
        }

        stage('Deploy to Prod') {
            when {
                branch 'main'
            }
            steps {
                sh '''
                docker stop prod-container || true
                docker rm prod-container || true
                docker run -d -p 3000:3000 --name prod-container ${DOCKER_IMAGE}:main
                '''
            }
        }
    }
}
