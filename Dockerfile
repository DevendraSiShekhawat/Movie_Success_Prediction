# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt and install dependencies
COPY requirements.txt .

# Install any dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . /app/

# Set the environment variable for Django settings module
ENV DJANGO_SETTINGS_MODULE=mvs.settings

# Expose port 5000 to be able to access the app outside the container
EXPOSE 5000

# Command to run the Gunicorn server
CMD ["gunicorn", "temp2.wsgi:application", "--bind", "0.0.0.0:5000"]
