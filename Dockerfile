# Use Python 3.9 slim image as the base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt first and install dependencies
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project to the container (this includes your Django app)
COPY . /app

# Expose port 5000
EXPOSE 5000

# Run the application using gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "Movie_Success_Prediction.wsgi:application"]
