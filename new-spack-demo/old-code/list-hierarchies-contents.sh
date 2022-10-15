#!/bin/bash
initial_modulepath=$MODULEPATH
IFS=':'
module_dirs=("$MODULEPATH")

for module_dir in ${module_dirs[@]}; do
    echo $module_dir
    export MODULEPATH="$module_dir"
    module av
done

export MODULEPATH=$initial_modulepath
