
local here=${0:h}

# Sourcing this script will setup your environment in Arm
# tcsh equivalent: source /arm/tools/setup/init/tcsh
# bash equivalent: source /arm/tools/setup/init/bash
source $here/zsh-setup.zsh

# This function is useful for finding the Windows of a Linux path
# $> armdisk | grep porter
# \\nahpc2-pod04.nahpc2.arm.com\projects\ssg\pj01384_porter
function armdisk() {
	mount \
		| perl -pe 's/^(\S+arm.com):(\S+).*/\\\\\1\2/' \
		| sed -e 's/armhome/home/' \
		-e 's:/:\\:g' \
		-e 's:\\ifs::g'
}

