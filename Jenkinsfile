@Library("Shared") _
pipeline {
    agent { label "vinod" }

    stages {
        stage("Hello") {
            steps {
                script {
                    hello()
                }
            }
        }
        stage("code") {
            steps {
                script {
                    clone("https://github.com/aditya6543/todo-app.git", "main")
                }
            }
        }
        stage("build") {
            steps {
                script {
                    docker_build("my-app", "latest", "adityadevsecops")
                }
            }
        }
        stage("Push to Docker-hub") {
            steps {
                script {
                    docker_push("my-app", "latest", "adityadevsecops")
                }
            }
        }
        stage("deploy") {
            steps {
                echo "this is deploying the code"
                sh "docker compose up -d --build"
            }
        }
    }
}
