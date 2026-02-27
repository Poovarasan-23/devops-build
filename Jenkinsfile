pipeline {
    agent any

    environment {
        DEV_IMAGE = "poov23/dev"
        PROD_IMAGE = "poov23/prod"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'dev', url: 'https://github.com/Poovarasan-23/devops-build.git'
            }
        }

        stage('Build & Push Dev') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-creds') {
                        def image = docker.build("${DEV_IMAGE}:latest")
                        image.push()
                    }
                }
            }
        }

        stage('Build & Push Prod') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-creds') {
                        def image = docker.build("${PROD_IMAGE}:latest")
                        image.push()
                    }
                }
            }
        }
    }
}
