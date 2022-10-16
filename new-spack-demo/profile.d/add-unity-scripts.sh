#!/bin/bash

prepend_path() {
    # if $1 doesn't exist
    if [ ! -d $1 ]; then
        return 1
    fi
    # if $1 is already present in modulepath
    if [[ $PATH =~ (^|:)$1($|:) ]] ; then
        return 1
    fi
    if [ -z $PATH ]; then
        export PATH="$1"
    else
        export PATH="$1:$PATH"
    fi
}

prepend_path "/modules/admin-resources/production/bin"
