# Set the base image to use
FROM python:3.8-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the project dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Download the 'brown' corpus
RUN python -c "import nltk; nltk.download('brown', download_dir='/app/nltk_data')"

# Add the custom NLTK data directory to the path
ENV NLTK_DATA=/app/nltk_data

# Copy the application code
COPY . .

# Set the environment variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_ENV=development

# Expose the port to the outside world
EXPOSE 5000

# Start the application
CMD ["python", "server.py"]
