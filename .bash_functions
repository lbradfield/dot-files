#!/bin/bash
# User created functions

################################################################################
#
# Attaches the current BASH session to a GNOME keyring daemon
#
# Returns 0 on success 1 on failure.
#
function gnome-keyring-attach() {
    local -a vars=( \
        DBUS_SESSION_BUS_ADDRESS \
        SSH_AUTH_SOCK \
        SSH_AGENT_PID \
        XAUTHORITY \
    )
    local pid=$(ps -C gdm3 -o pid --no-heading)
    eval "unset ${vars[@]}; $(printf "export %s;" $(sed 's/\x00/\n/g' /proc/${pid//[^0-9]/}/environ | grep $(printf -- "-e ^%s= " "${vars[@]}")) )"
}

calc () {
    # function to perform a command line arithmetic function
    bc -l <<< "$@"
}

# Add timestamps to terminals
#export PROMPT_COMMAND="echo -n \[\$(date -u +%Y/%m/%d\|%H:%M:%S)\]"

acp () {
    # Creates a dated backup of a file given as the first argument,
    # then replaces that file with a file given as the second
    # argument.
    local datestamp=$(date -u +%Y%m%d)
    if (( (2 < $#) || (1 > $#) ))
    then
        echo 'usage: acp [SOURCE] DEST'
    elif (( $# == 1 ))
    then
        cp "$1" "bak$datestamp.$1"
    elif (( $# == 2 ))
    then
        cp "$2" "bak$datestamp.$2"
        cp "$1" "$2"
    fi
}

zoomy () {
    # Launches the Zoom meeting client and connects to meeting with 
    # ID given as the first argument.
    xdg-open zoommtg://zoom.us/join?action=join&confno="$1"
}


table () {
    # Runs LibreOffice Calc on given command-line file(s) argument
    soffice --calc $@ &
}

swrel () {
    # Runs the software release program from Operations Landmapper 
    # ground automation.
    ~/Desktop/svn.Operations_Landmapper/Ground_Automation/released/datamanagement/sw_release $*
}

findfn () {
    # Finds all files, starting in current directory, with all or 
    # some of the input text in the filename (case insensitive).
    if [ $# -eq 1 ]; then
        find ./ -iname "*$1*" | sort
    elif [ $# -eq 2 ]; then
        find $1 -iname "*$2*" | sort
    else
        echo "usage: ${FUNCNAME[0]} [search starting dir (defaults to pwd)] <search term>"
    fi
}

rgrep () {
    # Searches for text in files recursively starting at given path
    # and searching for given regex string
    if [ $# -eq 1 ]; then
        local search_term=$1
        local starting_path="*"
    elif [ $# -gt 1 ]; then
        local search_term=$1
        local starting_path=""
    else
        echo "usage: ${FUNCNAME[0]} <search term> [search starting dir (defaults to pwd)]"
        return 1
    fi
    while (( "$#" )); do
        local starting_path="$starting_path $2"
        shift
    done
    local matching_files=$(grep -rTilI "$search_term" $starting_path | sort)
    # echo $matching_files
    for i in $matching_files; do 
        echo -e "\e[96m$i"
        grep -rTnh -C 1 "$search_term" $i
    done
}

copycat () {
    if [ $# -ne 1 ]; then
        echo "Usage: ${FUNCNAME[0]} <file>"
    elif [ -e $1 ]; then
        local filename=$(basename $1)
        local file_text=$(< $1)
        printf "$filename\n$file_text" | xclip -selection c
        cat $1
    else
        echo "copycat: $1: No such file or directory"
    fi
}

cdops () {
    local dev=0
    local level="released"
    while [ "$#" -gt 0 ]; do
        unset OPTIND
        unset OPTARG
        while getopts "d" opt; do
            case $opt in
            d) 
                local level="development"
                ;;
            *)
                echo "Usage: ${FUNCNAME[0]} [-d] [ops directory]"
                echo "Changes to given ops directory under ~/Desktop/svn.Operations_Landmapper/Ground_Automation/..."
                ;;
            esac
        done
        shift $((OPTIND-1))
        local dir="$1"
        shift
    done
    #echo "$dir"
    #echo "$level"
    #echo $(find "$HOME"/Desktop/svn.Operations_Landmapper/ -maxdepth 3 -type d -iname "$dir" -path "*$level*")
    cd $(find "$HOME"/Desktop/svn.Operations_Landmapper/ -maxdepth 3 -type d -iname "$dir" -path "*$level*")
}


build_prompt() {
  EXIT=$?               # save exit code of last command
  # 256 colors
  red='\[\e[38;5;160m\]'
  green='\[\e[38;5;46m\]'
  forest='\[\e[38;5;35m\]'
  aqua='\[\e[38;5;73m\]'
  tan='\[\e[38;5;144m\]'
  reset='\[\e[0m\]'
  # unicode
  cross=$'\u292b'
  circle=$'\u25CF'
  arrow=$'\u279c'
  PS1='${debian_chroot:+($debian_chroot)}'  # begin prompt

  PS1+=" $forest\u$reset@$tan\h: $aqua\w\n " # user, path, newline

  if [ $EXIT != 0 ]; then  # add arrow color dependent on exit code
    PS1+="$red$cross"
  else
    PS1+="$green$circle"
  fi

  PS1+="  $reset$arrow  " # construct rest of prompt
}

