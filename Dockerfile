# Dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Langflow with optimizations
RUN pip install --no-cache-dir --timeout=1000 \
    --retries=5 --trusted-host pypi.org \
    --trusted-host pypi.python.org \
    --trusted-host files.pythonhosted.org \
    langflow

# Create necessary directories
RUN mkdir -p /app/flows

# Expose port
EXPOSE 7860

# Set environment variables
ENV LANGFLOW_HOST=0.0.0.0
ENV LANGFLOW_PORT=7860
ENV LANGFLOW_AUTO_LOGIN=true

# Start Langflow
CMD ["python", "-m", "langflow", "run", "--host", "0.0.0.0", "--port", "7860", "--auto-login"]