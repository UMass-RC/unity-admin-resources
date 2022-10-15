#!/bin/bash

if [ $# -eq 0 ]; then
    echo "not enough arguments! Which module would you like to find?"
    echo "example: unity-find-module openmpi"
    exit
fi

if [ $# -gt 1 ]; then
    echo "too many arguments! I can only find one module at a time!"
    echo "example: unity-find-module openmpi"
    exit
fi


echo "modules found:"
old_pwd=$PWD
cd /modules/spack-latest/share/spack/lmod
# find lua modulefiles, then find things that contain $1 in the second to last directory in the path, then highlight $1 in red
find . | grep -e \.lua$ | grep -e .*$1/[^/]*$ | awk '{print substr($1,3,length($1)-2)}' | grep --color $1
cd $old_pwd

echo -e "$(</modules/admin-resources/new-spack-demo/find-module-printme.txt)"

echo
echo "your modulepath:"
IFS=':'
modulepath_dirs=($MODULEPATH)
for dir in ${modulepath_dirs[@]}; do
    echo $dir
done
unset IFS

