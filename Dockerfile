# Use CUDA 12.6 compatible base image
FROM nvidia/cuda:12.6.0-runtime-ubuntu22.04

# Set working directory and environment variables
WORKDIR /app
ENV GRADIO_SERVER_NAME=0.0.0.0 \
    GRADIO_SERVER_PORT=7860 \
    PYTHONUNBUFFERED=1

# Install system dependencies (optimized layers)
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.10 \
    python3.10-venv \
    python3-pip \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Install PyTorch with correct CUDA 12.6 compatibility
RUN pip install --no-cache-dir \
    torch==2.3.0 \
    torchvision==0.18.0 \
    torchaudio==2.3.0 \
    --index-url https://download.pytorch.org/whl/cu126

# Copy and install application requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose Gradio port
EXPOSE 7860

# Health check and entrypoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s \
    CMD curl -f http://localhost:7860 || exit 1

CMD ["python", "demo_gradio.py"]