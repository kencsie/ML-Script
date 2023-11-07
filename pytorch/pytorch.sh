#!/bin/bash

# Ask the user if they want to run Jupyter
read -p "Do you want to run PyTorch with Jupyter? (y/n): " use_jupyter

# Ask the user for the local directory they want to mount in the Docker container
read -p "Please enter the local directory you want to use (press enter for default ~/): " local_dir
local_dir=${local_dir:-~/}

# Ask the user for the Docker container name
read -p "Please enter a name for your Docker container (press enter for default PyTorch-1.13.1): " container_name
container_name=${container_name:-PyTorch-1.13.1}

volume_mapping="-v $(realpath $local_dir):/home"
base_image="pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime"

# Define the base image and container tag based on user input
if [ "$use_jupyter" = "y" ]; then
    # Ask the user for the host port they want to use for Jupyter
    read -p "Please enter the host port you want to map to Jupyter's port 8888 (press enter for default 8888): " host_port
    host_port=${host_port:-8888}
    port_mapping="-p ${host_port}:8888"
    container_tag="pytorch:1.13.1-jupyter"
    dockerfile_name="Dockerfile.jupyter"
else
    port_mapping=""
    container_tag="pytorch:1.13.1"
    dockerfile_name="Dockerfile.no_jupyter"
fi

# Build the Docker image
docker build --build-arg BASE_IMAGE=$base_image -t $container_tag -f $dockerfile_name .

# Run the Docker container
docker run -it $port_mapping --gpus all --name "$container_name" $volume_mapping $container_tag
