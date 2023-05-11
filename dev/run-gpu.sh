docker run --name gpu-devbox -h gpu-devbox --gpus all -it --rm \
       -v ~/codes:/workspace/codes \
       -v ~/bentoml:/workspace/bentoml \
       -v ~/notebooks:/workspace/notebooks \
       -v ~/soft:/workspace/soft \
       -v ~/j:/workspace/j \
       -v ~/x:/workspace/x \
       -v ~/tmp:/workspace/tmp \
       -v ~/.local/dockerspace/gpu-devbox:/workspace/.local \
       -v ~/.ssh:/home/larme/.ssh \
       -v /var/run/docker.sock:/var/run/docker.sock \
       -e HOST_USER_ID=$(id -u $USER) \
       -e HOST_GROUP_ID=$(id -g $USER) \
       -p 3000:3000 \
       -p 4000:4000 \
       -p 127.0.0.1:11234:11233 \
       larme/gpu-dev:latest
