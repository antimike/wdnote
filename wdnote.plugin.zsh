WDNOTE_IGNORE_FILE="/tmp/wdnote_ignore.$(id --user)"
touch $WDNOTE_IGNORE_FILE
WDNOTE_IGNORE=($(cat $WDNOTE_IGNORE_FILE))

wdnote () {
	# Print wdnote if it exists
	if [[ $# -eq 0 ]] ; then
		[[ -f $PWD/.wdnote ]] &&
			cat $PWD/.wdnote

	# Ignore current directory
	elif [[ $1 == stop ]] ; then
		if [[ $WDNOTE_IGNORE[(I)$PWD] -eq 0 ]] ; then
			WDNOTE_IGNORE+=($PWD)
			echo $WDNOTE_IGNORE >>! $WDNOTE_IGNORE_FILE
		fi

	# Stop ignoring current directory
	elif [[ $1 == show ]] ; then
		WDNOTE_IGNORE=(${WDNOTE_IGNORE:#$PWD})
		echo $WDNOTE_IGNORE >! $WDNOTE_IGNORE_FILE

	# List ignored directories
	elif [[ $1 == list ]] ; then
		echo ${(F)WDNOTE_IGNORE}
	
	# Remove nonexistent directories from ignore list
	elif [[ $1 == clean ]] ; then
		for dir in $WDNOTE_IGNORE ; do
			if [[ ! -d $dir ]] ; then
				WDNOTE_IGNORE=(${WDNOTE_IGNORE:#$dir})
				echo $dir
			fi
		done
		echo $WDNOTE_IGNORE >! $WDNOTE_IGNORE_FILE

	# Print help
	elif [[ $1 == help ]] ; then
		<<- EOF
		wdnote usage:
		    wdnote
		    wdnote stop
		    wdnote show
		    wdnote list
		    wdnote clean
		EOF

	# Argument error
	else
		echo "wdnote: invalid arguments: see 'wdnote help'"
		return 1
	fi
}

# Listen for directory changes
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _chpwd_wdnote
function _chpwd_wdnote { [[ $WDNOTE_IGNORE[(I)$PWD] -eq 0 ]] && wdnote }
_chpwd_wdnote
