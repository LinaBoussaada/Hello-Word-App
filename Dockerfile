# Use official Python 3.10 slim base image
FROM python:3.10-slim

# Set working directory inside the container
WORKDIR /app

# Copy requirements first (for Docker caching)
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && pip install flake8 pytest

# Copy the rest of your project files
COPY . .

# Run lint & tests when building (optional)
# Comment out if you don’t want tests inside the image build
RUN flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics \
    && pytest || true

# Default command when the container runs
CMD ["python", "app.py"]
