pipeline {
    agent any

    environment {
        IMAGE_NAME = 'movie_success_prediction:latest' // Image name for Docker
        GIT_URL = 'https://github.com/DevendraSiShekhawat/Movie_Success_Prediction.git' // GitHub repository URL
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Checkout from GitHub repository
                    git url: "${GIT_URL}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                        echo "Building Docker image..."
                        docker build -t ${IMAGE_NAME} . // Builds the Docker image using the Dockerfile in the repo
                    """
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    sh """
                        echo "Running tests inside the container..."
                        docker run --rm ${IMAGE_NAME} python manage.py test // Runs tests inside the Docker container
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh """
                        echo "Deploying the application..."
                        docker run -d -p 8000:8000 --name movie_app ${IMAGE_NAME} // Deploys the app in the background
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up resources...'
            sh """
                docker container prune -f || true // Cleanup of unused containers
                docker image prune -f || true // Cleanup of unused Docker images
            """
        }
        success {
            echo 'Pipeline executed successfully!' // Message on successful pipeline execution
        }
        failure {
            echo 'Pipeline execution failed. Check logs for details.' // Message if the pipeline fails
        }
    }
}
