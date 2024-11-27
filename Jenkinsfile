pipeline {
    agent any

    environment {
        IMAGE_NAME = "movie_success_prediction"
        // Assuming these are stored as Jenkins credentials
        DJANGO_SECRET_KEY = credentials('django-secret-key')  // Example: store secret key in Jenkins credentials
        DATABASE_URL = credentials('database-url')  // Example: store database URL securely in Jenkins credentials
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the GitHub repository
                git 'https://github.com/DevendraSiShekhawat/Movie_Success_Prediction.git'
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
                    // Deploy the app using Docker with environment variables
                    sh """
                    docker run -d -p 8000:8000 --name django_app \
                    -e DJANGO_SECRET_KEY=${DJANGO_SECRET_KEY} \
                    -e DATABASE_URL=${DATABASE_URL} \
                    ${IMAGE_NAME}
                    """
                }
            }
        }
    }

    post {
        always {
            // Clean up any stopped containers
            sh "docker container prune -f"
            // Optional: Clean up unused Docker images to save space
            sh "docker image prune -f"
        }
    }
}
