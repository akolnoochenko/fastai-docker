# Paperspace + Fast.ai Docker files (a little bit edit and updated)


## Overview

This is a docker build file designed to work with [Paperspace]. My lattest build is here: https://hub.docker.com/r/koppektop/fastai/

This container pulls the latest fast.ai class on start (i.e.: https://course.fast.ai/update_aws.html ). Please dont change git repo files to use git pull. 
You can find this repo here: https://github.com/fastai/fastai and you can learn more about the Fast.ai course here: http://course.fast.ai/

## Requirements:

[Docker CE](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)

[NVIDIA-docker](https://github.com/NVIDIA/nvidia-docker)

Nvidia Drivers (>=10.2)

## Build

`docker build -t koppektop/fastai .`

## Pre-built runtimes

You can also just run the following without having to build the entire container yourself. This will pull the container from Docker Hub.

`nvidia-docker run -d --name fastai -e JUPYTER_PASSWORD=MyPassword -p 127.0.0.1:8888:8888 --restart always -v $HOME/fastai-data:/storage 
-v /etc/shadow:/etc/shadow:ro -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro --shm-size=2gb koppektop/fastai:1.0.1-CUDA10.2-base-1.3.1 /run.sh $USER`

You can use custom password in JUPYTER_PASSWORD environment variable

You can store persistend data in data folder inside notebooks (course-v3/nbs/dl1/data) folder. 

Also note that all data will be saved under current user permissions.
