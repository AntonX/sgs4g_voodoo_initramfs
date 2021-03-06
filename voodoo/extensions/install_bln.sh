# Voodoo lagfix extension

name='BLN, BackLight Notifications installer'
binary_source='/voodoo/extensions/bln/lights.s5pc110.so'
binary_dest='/system/lib/hw/lights.s5pc110.so'

extension_install_bln()
{
	cp $binary_source $binary_dest
	chmod 0644 $binary_dest
	log "$name now installed"
}

install_condition()
{
	test -d "/system/lib/hw"
}


if install_condition; then
	# test if the bln binary already exists
	if test -f $binary_dest; then
		# okay, the bln binary exists
		if test $binary_source -nt $binary_dest; then

			# but it's older than ours, let''s update it
			extension_install_bln
		else
			# ours is the same or older, don't touch it
			log "$name already installed"
		fi
	else
		# not here or not setup properly, let's install bln
		extension_install_bln
	fi
else
	log "$name cannot be installed"
fi
