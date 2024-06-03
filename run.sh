#!/bin/bash

# Function to check command existence
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Conda is available
if ! command_exists conda; then
    echo "Conda is not installed. Please run setup.sh first."
    exit 1
fi

# Activate the Conda environment
source activate colorization_env

# Check if the environment exists
if [ $? -ne 0 ]; then
    echo "The Conda environment does not exist. Please run setup.sh first."
    exit 1
fi

# Launch the Gradio application
echo "Launching the Gradio application..."
python app.py --port 7860 --server_name localhost

if [ $? -ne 0 ]; then
    echo "Failed to launch the Gradio application."
    exit 1
fi

echo "Gradio application is running on http://localhost:7860"
