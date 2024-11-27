pipeline {
    agent any

    environment {
        IMAGE_NAME = "movie_success_prediction"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/yourusername/yourrepo.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    // Run the container and execute tests
                    sh "docker run --rm ${IMAGE_NAME} python manage.py test"
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Start the container
                    sh "docker run -d -p 8000:8000 --name django_app ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            // Clean up any stopped containers
            sh "docker container prune -f"
        }
    }
}
