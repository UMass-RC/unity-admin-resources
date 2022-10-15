#!/bin/bash

yes_or_no() {
    case $1 in
        [Yy]es) return 0 ;;
        [Tt]rue) return 0;;
        [Nn]o) return  1;;
        [Ff]alse) return  1;;
    esac
}

prompt_yes_or_no() {
    read response
    yes_or_no $response
}

echo "this is a serious action!"
echo "are you sure you want to set permissions recursively in this directory?"
if ! prompt_yes_or_no; then
    exit 1
fi

