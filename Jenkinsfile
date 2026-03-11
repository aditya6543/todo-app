pipeline {
    agent any

    environment {
        IMAGE_NAME = "adityadevsecops/my-app"
        TAG = "latest"
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main',
                url: 'https://github.com/aditya6543/todo-app.git'
            }
        }

        stage('Secret Scan - Gitleaks') {
            steps {
                sh '''
                echo "Running Gitleaks Scan..."
                gitleaks detect --source .
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                echo "Building Docker Image"
                docker build -t $IMAGE_NAME:$TAG .
                '''
            }
        }

        stage('Trivy Security Scan') {
            steps {
                sh '''
                echo "Scanning Image with Trivy"
                trivy image $IMAGE_NAME:$TAG
                '''
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                sh '''
                echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
                docker push $IMAGE_NAME:$TAG
                '''
            }
        }

        stage('Deploy Application') {
            steps {
                sh '''
                echo "Deploying Application"
                docker rm -f nginx_web || true
                docker-compose down
                docker-compose up -d --build
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                docker ps
                '''
            }
        }
    }

    post {
        success {
            echo "Deployment Successful"
        }
        failure {
            echo "Pipeline Failed"
        }
    }
}