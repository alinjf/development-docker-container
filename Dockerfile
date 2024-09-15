# Start with a base image
FROM ubuntu:jammy

# Set environment variables to skip interactive prompts during installations
ENV DEBIAN_FRONTEND=noninteractive
ENV NVM_DIR="/root/.nvm"

# Install curl, nano, vim, tmux, git, bash-completion
RUN apt-get update && apt-get install -y \
    curl \
    nano \
    vim \
    tmux \
    git \
    bash-completion

# Install NVM (Node Version Manager)
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# Install Node.js and npm using NVM, then install pnpm
RUN bash -c "source $NVM_DIR/nvm.sh && \
    nvm install 20.10.0 && \
    nvm use 20.10.0 && \
    npm install -g pnpm"

# Clone the Tmux configuration repository
RUN git clone https://github.com/gpakosz/.tmux.git /root/.tmux && \
    ln -s -f /root/.tmux/.tmux.conf /root/.tmux.conf && \
    cp /root/.tmux/.tmux.conf.local /root/

# Add the provided .bashrc content to the root user's .bashrc
# Add the provided .bashrc content to the root user's .bashrc
RUN echo '# ~/.bashrc: executed by bash(1) for non-login shells.\n\
    # see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)\n\
    # for examples\n\n\
    # If not running interactively, don\'t do anything\n\
    [ -z "$PS1" ] && return\n\n\
    # check the window size after each command and, if necessary,\n\
    # update the values of LINES and COLUMNS.\n\
    shopt -s checkwinsize\n\n\
    # If set, the pattern "**" used in a pathname expansion context will\n\
    # match all files and zero or more directories and subdirectories.\n\
    #shopt -s globstar\n\n\
    # make less more friendly for non-text input files, see lesspipe(1)\n\
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"\n\n\
    # set variable identifying the chroot you work in (used in the prompt below)\n\
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then\n\
    debian_chroot=$(cat /etc/debian_chroot)\n\
    fi\n\n\
    # set a fancy prompt (non-color, unless we know we "want" color)\n\
    case "$TERM" in\n\
    xterm-color) color_prompt=yes;;\n\
    esac\n\n\
    # uncomment for a colored prompt, if the terminal has the capability; turned\n\
    # off by default to not distract the user: the focus in a terminal window\n\
    # should be on the output of commands, not on the prompt\n\
    export PS1="\\[\\e[33m\\]\\u\\[\\e[m\\]\\[\\e[34m\\]@\\[\\e[m\\]\\[\\e[36m\\]\\h\\[\\e[m\\]\\[\\e[34m\\]:\\[\\e[m\\]\\[\\e[35m\\]\\W\\[\\e[m\\]\\[\\e[34m\\]\\\\$\\[\\e[m\\]\\[\\e[34m\\]>\\[\\e[m\\] "\n\
    unset color_prompt force_color_prompt\n\n\
    # If this is an xterm set the title to user@host:dir\n\
    case "$TERM" in\n\
    xterm*|rxvt*)\n\
    PS1="\\[\\e]0;${debian_chroot:+($debian_chroot)}\\u@\\h: \\w\\a\\]$PS1"\n\
    ;;\n\
    *)\n\
    ;;\n\
    esac\n\n\
    # enable color support of ls and also add handy aliases\n\
    if [ -x /usr/bin/dircolors ]; then\n\
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"\n\
    alias ls="ls --color=auto"\n\
    alias grep="grep --color=auto"\n\
    alias fgrep="fgrep --color=auto"\n\
    alias egrep="egrep --color=auto"\n\
    fi\n\n\
    # some more ls aliases\n\
    alias ll="ls -alF --time-style=iso"\n\
    alias la="ls -A"\n\
    alias l="ls -CF"\n\n\
    # Alias definitions.\n\
    if [ -f ~/.bash_aliases ]; then\n\
    . ~/.bash_aliases\n\
    fi\n\n\
    # enable programmable completion features\n\
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then\n\
    . /etc/bash_completion\n\
    fi\n\n\
    export PATH=/opt/ambin:$PATH\n\n\
    # Custom Aliases and Functions\n\
    function mkcd() {\n\
    mkdir -p "$1"\n\
    cd "$1"\n\
    }\n\
    alias ..="cd .."\n\
    alias ...="cd ../.."\n\
    alias lsps="ps aux | grep"\n\
    alias reload="source ~/.bashrc"\n\n\
    # Git commands\n\
    test -f ~/.git-completion.bash && . $_\n\
    test -f ~/.git-prompt.sh && . $_\n\
    alias glg="git log --date-order --graph --format=\\"%C(green)%h%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s\\""\n\
    alias glgd="git log --date-order --graph --date=short --format=\\"%C(green)%h%Creset %C(blue bold)%cd%Creset %C(red bold)%d%Creset%s\\""\n\
    alias glga="git log --date-order --graph --format=\\"%C(green)%h%Creset %C(yellow)%an %ae %Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s\\""\n\
    alias glb="glg --branches"\n\
    alias gs="git status"\n\
    alias ga="git add"\n\
    alias gb="git branch"\n\
    alias gchk="git checkout"\n\
    alias gpush="git push"\n\n\
    # Proxy tunnel\n\
    alias myip="dig +short myip.opendns.com @resolver1.opendns.com"\n\n\
    # History control\n\
    HISTFILESIZE=1000000\n\
    HISTSIZE=2000\n\
    shopt -s histappend\n\
    HISTCONTROL=ignoreboth\n\n\
    # Enable vi editing mode\n\
    set editing-mode vi\n\
    set keymap vi-command\n\n\
    # Load NVM\n\
    export NVM_DIR="$HOME/.nvm"\n\
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"\n\
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"' >> /root/.bashrc

# Expose a default terminal when the container is run
CMD ["tail", "-f", "/dev/null"]
