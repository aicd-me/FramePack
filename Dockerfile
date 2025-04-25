# Use a base image with Python 3.10 and CUDA support
FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

# Set the working directory
WORKDIR /app

# Install Python and dependencies
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment and activate it
RUN python3.10 -m venv /app/.venv
ENV PATH="/app/.venv/bin:$PATH"

# Install PyTorch with CUDA 12.6
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port for the Gradio GUI, defaulting to 7860
ARG PORT=7860
ENV PORT=${PORT}
EXPOSE ${PORT}

# Command to run the Gradio GUI
CMD ["python", "demo_gradio.py", "--port", "$(PORT)", "--listen"]