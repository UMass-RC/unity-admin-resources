#!/bin/bash

# this tells modified `module` function the location of readme file to print
export LMOD_LIMITED_README=/modules/admin-resources/new-spack-demo/lmod-limited-view-printme.txt

# for some reason if we use the spack-latest symlink lmod has a stack overflow
SPACK_MOD_PREFIX="/modules/spack-latest/share/spack/lmod"
#SPACK_MOD_PREFIX="/modules/spack-0.18.1/share/spack/lmod"

DEFAULT_DIRS=(
    "/modules/modulefiles"
)

COMPILER_DIRS=(
    "gcc-9.4.0"
    "intel/2021.4.0"
)

PROVIDER_DIRS=(
    "intel-oneapi-mpi/2021.6.0-h3cppyo"
    "openmpi/4.1.3-s3qn45p"
)

yes_or_no() {
    case $1 in
        [Yy]es) return 0 ;;
        [Tt]rue) return 0;;
        [Nn]o) return  1;;
        [Ff]alse) return  1;;
    esac
}

prepend_modulepath() {
    # if $1 doesn't exist
    if [ ! -d $1 ]; then
        #echo "$1 doesn't exist"
        return 1
    fi
    # if $1 is already present in modulepath
    if [[ $MODULEPATH =~ (^|:)$1($|:) ]] ; then
        return 1
    fi
    if [ -z $MODULEPATH ]; then
        export MODULEPATH="$1"
    else
        export MODULEPATH="$1:$MODULEPATH"
    fi
}

if [ -z $LMOD_ENABLE_LIMITED_VIEW ] || yes_or_no $LMOD_ENABLE_LIMITED_VIEW; then
    LMOD_ENABLE_LIMITED_VIEW="true"
else
    LMOD_ENABLE_LIMITED_VIEW="false"
fi

unset MODULEPATH

# if this is not a JupyterHub session
# if there are no environment variables that contain substring JUPYTERHUB
if ! env | grep JUPYTERHUB > /dev/null; then
    echo "purging loaded modules..."
    module purge
fi

for dir in ${DEFAULT_DIRS[@]}; do
    prepend_modulepath $dir
done

IFS=$'\n'
if [[ $LMOD_ENABLE_LIMITED_VIEW ]]; then
    for arch in $(tac /etc/spack-cpu-arches); do
        prepend_modulepath "$SPACK_MOD_PREFIX/$arch/gcc-9.4.0"
    done
else
    for arch in $(tac /etc/spack-cpu-arches); do
        for comp_dir in ${COMPILER_DIRS[@]}; do
            prepend_modulepath $SPACK_MOD_PREFIX/$arch/$comp_dir
            for prov_dir in ${PROVIDER_DIRS[@]}; do
                prepend_modulepath $SPACK_MOD_PREFIX/$arch/$prov_dir/$comp_dir
            done
        done
    done
fi
unset IFS



