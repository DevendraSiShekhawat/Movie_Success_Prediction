pipeline {
    agent any

    environment {
        IMAGE_NAME = 'movie_success_prediction:latest'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/DevendraSiShekhawat/Movie_Success_Prediction.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    sh "docker run --rm ${IMAGE_NAME} python manage.py test"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh "docker run -d -p 8000:8000 ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            node {
                sh 'docker container prune --force'
            }
        }
        success {
            echo 'Pipeline executed successfully.'
        }
        failure {
            echo 'Pipeline execution failed.'
        }
    }
}
