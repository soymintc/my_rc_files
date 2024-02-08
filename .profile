# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Set screen dir
export SCREENDIR=$HOME/.screen

# are we an interactive shell?
if [ "$PS1" ]; then
  if [ -z "$PROMPT_COMMAND" ]; then
    case $TERM in
    xterm*)
        if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
            PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
        else
            PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
        fi  
        ;;  
    screen)
        if [ -e /etc/sysconfig/bash-prompt-screen ]; then
            PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
        else
            PROMPT_COMMAND='printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
        fi  
        ;;  
    *)  
        [ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default
        ;;  
      esac
  fi  
  # Turn on checkwinsize
  shopt -s checkwinsize
  [ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\h \W]\\$ "
  # You might want to have e.g. tty in prompt (e.g. more virtual machines)
  # and console windows
  # If you want to do so, just add e.g.
  # if [ "$PS1" ]; then
  #   PS1="[\u@\h:\l \W]\\$ "
  # fi
  # to your custom modification shell script in /etc/profile.d/ directory
fi

if ! shopt -q login_shell ; then # We're not a login shell
    # Need to redefine pathmunge, it get's undefined at the end of /etc/profile
    pathmunge () {
        case ":${PATH}:" in
            *:"$1":*)
                ;;
            *)
                if [ "$2" = "after" ] ; then
                    PATH=$PATH:$1
                else
                    PATH=$1:$PATH
                fi
        esac
    }

    # By default, we want umask to get set. This sets it for non-login shell.
    # Current threshold for system reserved uid/gids is 200
    # You could check uidgid reservation validity in
    # /usr/share/doc/setup-*/uidgid file
    if [ $UID -gt 199 ] && [ "`id -gn`" = "`id -un`" ]; then
       umask 002
    else
       umask 022
    fi
    # Only display echos from profile.d scripts if we are no login shell
    # and interactive - otherwise just process them to set envvars
    for i in /etc/profile.d/*.sh; do
        if [ -r "$i" ]; then
            if [ "$PS1" ]; then
                . "$i"
            else
                . "$i" >/dev/null 2>&1
            fi
        fi
    done
    unset i
    unset pathmunge
fi

# vim:ts=4:sw=4

# some more ls aliases
alias ls='ls --color'
alias ll='ls -al'
alias la='ls -A'

LS_COLORS='di=00;94:ow=1;34:tw=1;33:fi=0:ln=32:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS

alias grep='grep --color=auto'

# User specific aliases and functions
export PS1='\[\033[0;35m\]\u@\h\[\033[0;33m\]:\W\[\033[00m\]$ '
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

# Set PATH
PATH="$HOME/miniconda3/bin:$PATH"
#source $HOME/miniconda3/etc/profile.d/conda.sh

# Activate conda py39 [default]
#conda activate py39

# Activate singularity: 3.6.2
module load singularity/3.6.2
#export SINGULARITY_CACHEDIR=/juno/work/shah/users/chois7/singularity/cache
export SINGULARITY_CACHEDIR=/rtsess01/compute/juno/shah/users/chois7/.cache
#export NXF_SINGULARITY_CACHEDIR=/juno/work/shah/users/chois7/nextflow/cache
export NXF_SINGULARITY_CACHEDIR=/rtsess01/compute/juno/shah/users/chois7/.cache
#export SINGULARITY_DOCKER_USERNAME=soymintc
#export SINGULARITY_DOCKER_PASSWORD=$(cat ~/.dockerhub_password)

# Add /juno/shah/work/users/chois7 to PATH
PATH="$PATH:/juno/work/shah/users/chois7"

# Add neovim path
PATH="$PATH:/juno/home/chois7/.config/nvim/nvim-linux64/bin"

# Add aws cli path
PATH="$PATH:${HOME}/bin"

# Vim


# Aspera PATH add
export PATH=/home/chois7/.aspera/cli/bin:$PATH
export MANPATH=/home/chois7/.aspera/cli/share/man:$MANPATH

# Add gdc-client
export PATH=$PATH:/juno/work/shah/users/chois7/packages/gdc # gdc-client
export PATH=$PATH:/juno/work/shah/users/chois7/packages/AnnotSV/bin # AnnotSV
export PATH=$PATH:/juno/work/shah/users/chois7/packages/svtools # vcfToBedpe etc
export PATH=$PATH:/juno/work/shah/users/chois7/envs/R/lib/R/library/dryclean/extdata # dryclean (drcln)


# isabl
export ISABL_API_URL='https://isabl.shahlab.mskcc.org/api/v1/'
#export ISABL_CLIENT_ID=20 # ID with rohqc support
export ISABL_CLIENT_ID=3 # production

# set different cache and tmp dir
export TMPDIR=/rtsess01/compute/juno/shah/users/chois7/tmp
export PIP_CACHE_DIR=/rtsess01/compute/juno/shah/users/chois7/.cache
export XDG_CACHE_HOME=/rtsess01/compute/juno/shah/users/chois7/.cache

# language settings
export LANGUAGE="en"
export LANG="C"
export LC_MESSAGES="C"

# set LC_CTYPE - allow special chars
export LC_CTYPE=en_US.utf8

# source-highlight
export LESSOPEN="| $HOME/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# default editor
export EDITOR=vim

# for bcftools
# after configure --prefix=~ , make, make install of gsl-2.7
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/chois7/lib:/home/chois7/lib/lib

# nextflow
export CAPSULE_LOG=none

# alias customis
alias py37='conda activate /juno/work/shah/users/chois7/envs/p37'
alias py39='conda activate /rtsess01/compute/juno/shah/users/chois7/envs/p39'
alias juno='ssh -A chois7@juno.mskcc.org'
alias ceto='ssh -A chois7@ceto.mskcc.org'
alias lilac='ssh -A chois7@lilac.mskcc.org'
alias mipy37='mamba install -p /juno/work/shah/users/chois7/envs/p37 -c bioconda -c conda-forge'
alias mipy39='mamba install -p /rtsess01/compute/juno/shah/users/chois7/envs/p39 -c bioconda -c conda-forge'
alias bfg='java -jar ~/bin/bfg-1.14.0.jar'
alias make_sing='singularity run -B /juno ~/chois7/singularity/sif/cmake.sif make'
alias cmake_sing='singularity run -B /juno ~/chois7/singularity/sif/cmake.sif cmake'
function rp { realpath $1 | sed 's/^\/juno//' | sed 's/^\/ceto//'; }

# R libs user
export R_LIBS_USER=/juno/work/shah/users/chois7/R/x86_64-pc-linux-gnu-library/4.2_singularity

# git-filter-repo
export PATH=$PATH:/juno/work/shah/users/chois7/packages/git-filter-repo

# IgCaller
export PATH=$PATH:/juno/work/shah/users/chois7/packages/IgCaller

# Run R like a civilized person
function Rscript_ {
    module purge
    module load singularity/3.7.1
    singularity exec -B /work:/work -B /admin:/admin -B /common:/common -B /juno:/juno /work/shah/users/leej39/singularity/rstudio-V0.8.sif Rscript "$@"
}

# github token
export GITHUB_TOKEN=$(cat ~/.gittoken)

# making life easier
function analysis {
    cd /juno/work/shah/isabl_data_lake/analyses/${1: -4:-2}/${1: -2}/${1}
}

alias bjobso='bjobs -o "JOBID:10 SUBMIT_TIME:13 USER:7 STAT:6 QUEUE:10 EXEC_HOST:10 JOB_NAME"'

# alias ipynb to md
alias tomd='jupytext --to markdown'

# JAVA home
export JAVA_HOME='/home/chois7/.jdk/jdk-11.0.22+7'
export PATH=$PATH:$JAVA_HOME/bin

# bedtools2
export PATH=$PATH:/fscratch/chois7/packages/bedtools2/bin
