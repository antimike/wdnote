# Ensure cache directory exists
mkdir "$ZSH_CACHE_DIR/wdnote-ignore" &> /dev/null

# Listen for directory changes
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _chpwd_wdnote
_chpwd_wdnote () {
	ZSH_WDNOTE_IGNORE="$ZSH_CACHE_DIR/wdnote-ignore/${PWD:gs/\//|}"

	# If not being ignored, print wdnote
	[[ ! -f "$ZSH_WDNOTE_IGNORE" ]] &&
		cat "$PWD/.wdnote" 2> /dev/null
}
_chpwd_wdnote

wdnote () {
	local files dir

	if [[ "$#" -eq "0" ]] ; then
		cat "$PWD/.wdnote"

	elif [[ "$1" == "stop" ]] ; then
		touch "$ZSH_WDNOTE_IGNORE"

	elif [[ "$1" == "show" ]] ; then
		rm "$ZSH_WDNOTE_IGNORE" &> /dev/null

	elif [[ "$1" == "list" ]] ; then
		files="$(ls --literal -1 "$ZSH_CACHE_DIR/wdnote-ignore")"
		[[ -n "$files" ]] &&
			print "${files:gs/|/\/}"
	
	elif [[ "$1" == "clean" ]] ; then
		files=($(ls --literal -1 "$ZSH_CACHE_DIR/wdnote-ignore"))
		for file in $files ; do
			dir="${file:gs/|/\/}"
			if [[ ! -d "$dir" ]] ; then
				rm "$ZSH_CACHE_DIR/wdnote-ignore/$file"
				print "\33[31m$dir\33[m"
			fi
		done

	elif [[ "$1" == "help" ]] ; then
		print "wdnote: usage:"
		print "\twdnote stop"
		print "\twdnote show"
		print "\twdnote list"
		print "\twdnote clean"

	else
		print "wdnote: invalid arguments: see \33[4mwdnote help\33[m"
		return 1
	fi

	return 0
}
