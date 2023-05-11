if [[ $# -eq 0 ]] ; then
    echo 'need provide image short name/variant'
    exit 1
fi

VARIANT=$1
TODAY=$(date '+%Y-%m-%d')
WORKING_DIR=$(pwd)

python3 gen-dockerfile.py

# clone private repositories
if [[ -d "emacs-init-files.cache" ]]
then
    cd emacs-init-files.cache && git pull
else
    git clone git@github.com:larme/emacs-init-files.git emacs-init-files.cache
fi

cd "$WORKING_DIR"
if [[ -d "dotfiles.cache" ]]
then
    cd dotfiles.cache && git pull
else
    git clone git@github.com:larme/dotfiles.git dotfiles.cache
fi

cd "$WORKING_DIR"
docker build -f "./generated/Dockerfile.$VARIANT" -t "larme/$VARIANT-dev:$TODAY" -t "larme/$VARIANT-dev:latest" .
