# Use the official Python image from Docker Hub (with Python 3.9)
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Upgrade pip to avoid potential issues with outdated versions
RUN pip install --upgrade pip

# Copy the requirements.txt into the container and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . /app

# Expose port 8000 for the Django application (if you're using Django default)
EXPOSE 8000

# Run the application with gunicorn in production mode
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "Movie_Success_Prediction.wsgi:application"]