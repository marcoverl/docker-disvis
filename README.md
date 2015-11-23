# docker-disvis
Dockerfile based on ubuntu_nvidia_opencl + disvis

## Pre condictions

You need first build the docker image **ubuntu_nvidia_opencl** from:
* https://github.com/indigo-dc/docker-opencl

## Build docker image

docker build -t opencl_disvis .

## Run docker-disvis

The docker containes the opencl application hosted in:
* https://github.com/haddocking/disvis

Read section "Options" for examples to run the application. 
The example below uses the files
* O14250.pdb
* Q9UT97.pdb
* restraints.dat

```
mkdir test-disvis
cd test-disvis
export WDIR=`pwd`
```

Copy the abovementioned files to test-disvis, and run:


```
docker run \
    --device=/dev/nvidia0:/dev/nvidia0 \
    --device=/dev/nvidiactl:/dev/nvidiactl \
    --device=/dev/nvidia-uvm:/dev/nvidia-uvm \
    -v $WDIR:/home \
    opencl_disvis /bin/sh -c 'export LD_LIBRARY_PATH=/usr/local/lib64; disvis /home/O14250.pdb /home/Q9UT97.pdb /home/restraints.dat -g -a 9.72 -vs 2 -d /home/res-gpu'
```

**Note: At the moment we need to export LD_LIBRARY_PATH , this issue will be solved in the future**

