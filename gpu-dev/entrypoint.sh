#!/bin/sh
# Get standard cali USER_ID variable
USER_ID=${HOST_USER_ID:-9001}
GROUP_ID=${HOST_GROUP_ID:-9001}

# Change $USERNAME uid to host user's uid
if [ ! -z "$USER_ID" ] && [ "$(id -u $USERNAME)" != "$USER_ID" ]; then
    # Create the user group if it does not exist
    groupadd --non-unique -g "$GROUP_ID" group
    # Set the user's uid and gid
    usermod --non-unique --uid "$USER_ID" --gid "$GROUP_ID" "$USERNAME"
fi

# Setting permissions on /home/me
chown -R "$USERNAME": "/home/$USERNAME"
# Setting permissions on docker.sock
chown "$USERNAME": /var/run/docker.sock

# link workspace directories to home
for dir in /workspace/*/
do
    ln -s "$dir" "/home/$USERNAME/$(basename "$dir")"
    chown -h "$USERNAME": "/home/$USERNAME/$(basename "$dir")"
done

ln -s /workspace/.local "/home/$USERNAME/.local" && \
    chown -h "$USERNAME": "/home/$USERNAME/.local"

gosu "$USERNAME" bash -c  "mkdir -p /workspace/.local/w3m && ln -s /workspace/.local/w3m ~/.w3m"
gosu "$USERNAME" bash -c "mkdir -p /workspace/.local/emacs.d && ln -s /workspace/.local/emacs.d ~/.emacs.d"
gosu "$USERNAME" bash -c "~/.ro/emacs.d/init/init-dirs.sh && touch ~/.emacs.d/flags/docker"
gosu "$USERNAME" bash -c "touch /workspace/.local/bash_history && ln -s /workspace/.local/bash_history ~/.bash_history"

exec /usr/sbin/gosu $USERNAME bash -l
