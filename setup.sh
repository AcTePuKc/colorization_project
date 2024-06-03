#!/bin/bash

# Function to check command existence
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Conda is installed
if ! command_exists conda; then
    echo "Conda is not installed. Downloading and installing Miniconda..."
    
    # Download Miniconda installer
    curl -o Miniconda3-latest-Linux-x86_64.sh -O  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    
    # Run the Miniconda installer silently
    bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
    
    # Initialize Conda
    source $HOME/miniconda/bin/activate
    conda init
    
    # Apply changes to current shell
    exec $SHELL
    
    echo "Miniconda installed successfully. Please restart your terminal and run setup.sh again."
    exit 1
fi

# Check if the user wants to skip setup
if [ "$1" == "--skip-setup" ]; then
    goto run_app
fi

# Check if the environment already exists
if conda env list | grep "colorization_env" > /dev/null 2>&1; then
    echo "Conda environment 'colorization_env' already exists. Skipping setup..."
else
    # Check if Python is installed
    if ! command_exists python; then
        echo "Python is not installed. Installing Python..."
        
        # Install Python using Conda
        conda install python=3.8 -y
        
        if [ $? -ne 0 ]; then
            echo "Failed to install Python. Please install Python manually."
            exit 1
        fi
    fi

    # Create the Conda environment
    echo "Creating the Conda environment..."
    conda env create -f environment.yml

    if [ $? -ne 0 ]; then
        echo "Failed to create the Conda environment. Please check the environment.yml file."
        exit 1
    fi

    echo "Environment created successfully."
fi

# Activate the environment
echo "Activating the environment..."
source activate colorization_env

if [ $? -ne 0 ]; then
    echo "Failed to activate the Conda environment."
    exit 1
fi

run_app:
# Launch the Gradio application
echo "Launching the Gradio application..."
python app.py --port 7860 --server_name localhost

if [ $? -ne 0 ]; then
    echo "Failed to launch the Gradio application."
    exit 1
fi

echo "Gradio application is running on http://localhost:7860"
