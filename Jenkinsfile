pipeline {
    agent any

    environment {
        DOCKER_CREDS = 'docker-creds'
        DEV_IMAGE  = 'poov23/dev'
        PROD_IMAGE = 'poov23/prod'
        TAG = 'latest'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Push Dev') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDS) {
                        sh "bash build.sh ${DEV_IMAGE} ${TAG}"
                    }
                }
            }
        }

        stage('Build & Push Prod') {
            when {
                branch 'main'
            }
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDS) {
                        sh "bash build.sh ${PROD_IMAGE} ${TAG}"
                    }
                }
            }
        }

        stage('Deploy to Dev') {
            when {
                branch 'dev'
            }
            steps {
                echo "Deploying to DEV server..."
                sh "bash deploy.sh ${DEV_IMAGE}:${TAG}"
            }
        }

        stage('Deploy to Prod') {
            when {
                branch 'main'
            }
            steps {
                echo "Deploying to PROD server..."
                sh "bash deploy.sh ${PROD_IMAGE}:${TAG}"
            }
        }
    }
}
