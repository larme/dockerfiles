if [ -e ~/.local/share/container-registry.txt ]
then
    echo "registry file exists"
else
    echo "registry file missing"
    exit 1
fi

REGISTRY=`cat ~/.local/share/container-registry.txt | xargs`

docker run --name cpu-devbox -h $(hostname) -it --rm \
       -v ~/codes:/workspace/codes \
       -v ~/bentoml:/workspace/bentoml \
       -v ~/notebooks:/workspace/notebooks \
       -v ~/soft:/workspace/soft \
       -v ~/j:/workspace/j \
       -v ~/x:/workspace/x \
       -v ~/tmp:/workspace/tmp \
       -v ~/.local/dockerspace/cpu-devbox:/workspace/.local \
       -v ~/.ssh:/home/larme/.ssh \
       -v /var/run/docker.sock:/var/run/docker.sock \
       -e HOST_USER_ID=$(id -u $USER) \
       -e HOST_GROUP_ID=$(id -g $USER) \
       --net=host \
       ${REGISTRY}/cpu-dev-aarch64:latest
