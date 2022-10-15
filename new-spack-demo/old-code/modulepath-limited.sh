CPU_FAM=$(/modules/spack-latest/bin/spack python -c 'import archspec.cpu as cpu; print(cpu.host().family)')
DIRS=(
	"/modules/modulefiles" 
	"/modules/spack-latest/share/spack/lmod/linux-ubuntu20.04-$CPU_FAM/Core" 
)
export MODULEPATH=''
for dir in ${DIRS[@]}; do
	export MODULEPATH="$dir:$MODULEPATH"
done
#export MODULEPATH="/modules/spack-latest/share/spack/lmod/linux-ubuntu20.04-x86_64/Core"
export LMOD_HIERARCHY_LIMITED_VIEW=true
export LMOD_HIERARCHY_LIMITED_README=/modules/admin-resources/new-spack-demo/lmod-printme.txt
echo $MODULEPATH

