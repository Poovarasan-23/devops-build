pipeline {
    agent any

    environment {
        DEV_IMAGE = "poov23/dev"
        PROD_IMAGE = "poov23/prod"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: "${env.BRANCH_NAME}", 
                    url: 'https://github.com/Poovarasan-23/devops-build.git'
            }
        }

        stage('Build & Push Dev') {
            when {
                branch 'dev'
            }
            steps {
                sh 'docker build -t $DEV_IMAGE:latest .'
                sh 'docker push $DEV_IMAGE:latest'
            }
        }

        stage('Build & Push Prod') {
            when {
                branch 'master'
            }
            steps {
                sh 'sh docker build -t poov23/dev:latest ./dev'
                sh 'docker push $PROD_IMAGE:latest'
            }
        }
    }
}
