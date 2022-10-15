CPU_FAM=$(/modules/spack-latest/bin/spack python -c 'import archspec.cpu as cpu; print(cpu.host().family)')
HIERARCHY_BASE_PATH="/modules/spack-latest/share/spack/lmod/linux-ubuntu20.04-$CPU_FAM/"
HIERARCHY_DIRS=(
    "Core/"
    "intel-oneapi-mpi/2021.6.0-h3cppyo/Core/"
    "openmpi/4.1.3-s3qn45p/Core/"
    "intel/2021.4.0/Core/"
)

# start with /modules/modulefiles and add all the hierarchy dirs
DIRS=("/modules/modulefiles")
for line in ${HIERARCHY_DIRS[@]}; do
    DIRS+=("$HIERARCHY_BASE_PATH$line")
done

# put the dirs list into modulepath
export MODULEPATH=''
for dir in ${DIRS[@]}; do
    export MODULEPATH="$dir:$MODULEPATH"
done
echo $MODULEPATH

export LMOD_HIERARCHY_LIMITED_VIEW=false
