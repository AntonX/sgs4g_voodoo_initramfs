#!/bin/sh

# this script would install busybox, but the file is not included, it's a little too big
# probably it's better install it with a ROM

name='Busybox'

install_dir=/system/xbin
binary_source=/voodoo/extensions/busybox/busybox
binary_dest=$install_dir/busybox
link_test_dest=$install_dir/ls	# can be any file linked to busybox

#

extension_link_busybox()
{
	# create links  
  	$binary_dest --install -s $install_dir
}

extension_install_busybox()
{
        if test ! -u $binary_dest ; then
		# copy the file
		cp $binary_source $binary_dest
		# make sure it's owned by root
		chown 0.0 $binary_dest
		# sets the suid permission
		chmod 06755 $binary_dest
	        # link
	        extension_link_busybox
	else
		if test ! -e $link_test_dest ; then
			# it may be preinstalled but not linked to file commands yet
			extension_link_busybox
		fi
	fi
}

install_condition()
{
	test -d "/system/xbin"
}

if install_condition; then
	
	if test ! -u $binary_dest ; then
		if test -e $binary_source ; then
			extension_install_busybox
			log "$name is istalled"
		fi
	else
		if test ! -e $link_test_dest ; then
			extension_link_busybox
			log "$name is symlinked"
		fi
	fi

else
	log "$name cannot be installed"
fi
