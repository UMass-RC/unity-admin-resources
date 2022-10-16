#!/bin/bash
# if module() hasn't already been wrapped
if ! type module_wrapped &> /dev/null; then

    # get the definition of module() and put it in module_wrapped()
    eval "$(echo "module_wrapped()"; declare -f module | tail -n +2)"

    # re-define module()
    module(){
        module_wrapped $@
        if [ -f ~/.unity-module ]; then
            . ~/.unity-module
        fi
        if [ ! $UNITY_MODULE_LMOD_DISABLE_HELP == "true" ]; then
            help_file="/modules/admin-resources/production/res/unity-module-lmod-help.txt"
            if [ -f $help_file ]; then
                cat $help_file
            fi
        fi
    }
fi

