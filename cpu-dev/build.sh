WORKING_DIR=`pwd`
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
docker build -t larme/cpu-dev .
