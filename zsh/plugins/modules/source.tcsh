#!/bin/tcsh -f
set script = `readlink -f $0`
set script_dir = `dirname $script`

# Check input file
set source_file = $1
if ( ! -f $source_file ) then
	echo "source file '$source_file' doesn't exist"
	exit 1
endif

# Setup default env
source /arm/tools/setup/init/tcsh
module load core eda swdev util arm/cluster

# Insert other setup here
# e.g. `setenv PROJ_HOME /path/to/proj/dir`

# Create temp files
set tempdir = `mktemp -d`
set pre_env = $tempdir/pre.env
set post_env = $tempdir/post.env
cp $source_file $tempdir/source_file

# Dump environment
env > $pre_env
source $source_file
set retval = $?
env > $post_env

# Print temp directory and exit
echo $tempdir
exit $retval

