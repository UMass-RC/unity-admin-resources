#! /bin/bash
alias less='less -R'

alias spack_setup="source /modules/spack/share/spack/setup-env.sh"
alias spack_list_json="spack list --format=version_json $1"
alias spack_regen_modfile="spack module tcl refresh $1"
alias spack_douche_modfiles="spack module tcl refresh --delete-tree"

alias spack_install_dir="cd /modules/spack-package-installers"
alias spack_log_dir="cd /modules/spack-package-installers/logs"
alias spack_builtins_dir="cd /modules/spack/var/spack/repos/builtin/packages"
alias spack_config_dir="cd /modules/spack/etc/spack"

alias lmod_regen_cache="/modules/lmod/lmod/lmod/libexec/update_lmod_system_cache_files -d /modules/lmod/cache $MODULEPATH"

alias find_replace_no_colons="grep -RiIl '$1' | xargs sed -i 's:$1:$2:g'"
