# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export GOPATH=$HOME/Coding/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export GO111MODULE=on

export PATH=$PATH:$HOME/Coding/kubeadm-dind-cluster/istio/bin
export PATH=$PATH:$HOME/Coding/kubeadm-dind-cluster/helm

export CLASSPATH=".:$HOME/.local/lib/antlr-4.7.2-complete.jar:$CLASSPATH"

alias antlr4="java -jar $HOME/.local/lib/antlr-4.7.2-complete.jar"
alias grun="java org.antlr.v4.gui.TestRig"

export PATH=$PATH:/opt/GoLand/bin
export PATH=$PATH:/opt/minishift
source $HOME/.minishift-completion
source $HOME/.oc-completion

export PATH=$PATH:/opt/crc
eval $(crc oc-env)
