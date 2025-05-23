# Base image with CUDA 12.6 runtime
FROM nvidia/cuda:12.6.0-devel-ubuntu22.04

# System configuration
WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive \
    GRADIO_SERVER_NAME=0.0.0.0 \
    GRADIO_SERVER_PORT=18111 \
    PYTHONUNBUFFERED=1

# Install system dependencies

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.10 \
    python3.10-dev \
    python3.10-venv \
    python3-pip \
    build-essential \
    git \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Install build tools
RUN pip install --no-cache-dir packaging ninja wheel

# Install PyTorch 2.6.0 with CUDA 12.6
RUN pip install --upgrade pip setuptools wheel packaging

RUN pip install --no-cache-dir \
    torch==2.3.0 \
    torchvision==0.18.0 \
    torchaudio==2.3.0 \
    --index-url https://download.pytorch.org/whl/cu121

RUN pip install --no-build-isolation flash-attn==2.5.8

# Application setup
COPY requirements-org.txt .
RUN pip install --no-cache-dir -r requirements-org.txt
COPY . .

# Expose and healthcheck
EXPOSE 7860
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s \
    CMD curl -f http://localhost:18111 || exit 1

CMD ["/usr/bin/python3.10", "demo_gradio.py", "--share", "--port", "18111"]
