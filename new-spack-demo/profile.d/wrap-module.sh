#!/bin/sh

# if module() hasn't already been wrapped
if ! type module_wrapped &> /dev/null; then

    # https://stackoverflow.com/a/34177402/20140415
    # rename `module` to `module_wrapped`
    a="$(declare -f "module")" &&
        eval "function module_wrapped ${a#*"()"}" &&
        unset -f "module";

    # re-define module()
    module(){
        # call original module() and remove the last line (empty line)
        module_wrapped $@
        if [ -f ~/.unity-module ]; then
            . ~/.unity-module
        fi
        if [ -z $UNITY_MODULE_LMOD_DISABLE_HELP ] ||
                [[ ! $UNITY_MODULE_LMOD_DISABLE_HELP == "true" ]]; then
            help_file="/modules/admin-resources/production/res/unity-module-lmod-help.txt"
            if [ -f $help_file ]; then
                printf "$(cat $help_file)\n"
            fi
        fi
    }
fi

