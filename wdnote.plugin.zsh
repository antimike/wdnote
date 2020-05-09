cache="$ZSH_CACHE_DIR/wdnote-ignore"

# Ensure cache directory exists
[[ ! -d "$cache" ]] &&
	mkdir "$cache"
# Ensure purge file exists
[[ ! -f "$cache/next_purge" ]] &&
	print "$(date --utc --date="1 month" +%s)" >| "$cache/next_purge"

# Purge expired ignore files each month
() {
	local purge="$(cat $cache/next_purge)"
	local now="$(date --utc +%s)"

	[[ "$purge" -le "$now" ]] &&
		print "$(date --utc --date="1 month" +%s)" >| "$cache/next_purge"

	local files=($(ls --literal -1 --ignore='[^|]*' $cache))
	for file in $files ; do
		local dir="${file:gs/|/\/}"
		local expire="$(cat "$cache/$file")"

		# Delete ignore file if expired or directory does not exist
		[[ "$expire" -le "$now" || ! -d "$dir" ]] &&
			rm "$file"
	done
}

unset cache

# Listen for directory changes
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _chpwd_wdnote

_chpwd_wdnote() {
	ZSH_WDNOTE_IGNORE="$ZSH_CACHE_DIR/wdnote-ignore/${PWD:gs/\//|}"

	# Delete ignore file if expired
	if [[ -f "$ZSH_WDNOTE_IGNORE" ]] ; then
		local expire="$(cat "$ZSH_WDNOTE_IGNORE")"
		local now="$(date --utc +%s)"

		[[ "$expire" -le "$now" ]] &&
			rm "$ZSH_WDNOTE_IGNORE"
	fi

	# If not being ignored, print wdnote
	if [[ ! -f "$ZSH_WDNOTE_IGNORE" ]] ; then
		local wdnote="$PWD/.wdnote"

		[[ -f "$wdnote" ]] &&
			cat "$wdnote"
	fi
}
_chpwd_wdnote

# Permanently or temporarily ignore wdnote in current path
wdnote() {
	if [[ "$#" -eq "0" ]] ; then
		cat ".wdnote"
		return 0

	elif [[ "$1" == "help" ]] ; then
		print "wdnote: usage:"
		print "\twdnote stop [ \33[4mignore-time\33[m ]"
		print "\twdnote resume"
		return 0

	elif [[ "$1" == "resume" ]] ; then
		[[ -f "$ZSH_WDNOTE_IGNORE" ]] &&
			rm "$ZSH_WDNOTE_IGNORE"
		return 0

	elif [[ "$1" == "stop" ]] ; then
		shift
		# Indefinite ignore if no more parameters
		if [[ "$#" -eq "0" ]] ; then
			local expire="9999999999"

		else
			# NOTE: BUG: not accepting +%s as part of command
			local expire="$(date --utc --date="$@" +%s)"
			if [[ "$?" -ne "0" ]] ; then
				print "wdnote: invalid ignore time '$@': see \33[4mman date\33[m"
				return 1
			fi
		fi

	elif [[ "$1" == "list" ]] ; then
		local files="$(ls --literal -1 --ignore='[^|]*' "$ZSH_CACHE_DIR/wdnote-ignore")"
		files="${files:gs/|/\/}"
		print "$files"
		return 0

	else
		print "wdnote: invalid arguments: see \33[4mwdnote help\33[m"
		return 1
	fi

	local now="$(date --utc +%s)"

	# Prevent redundancies
	if [[ "$expire" -le "$now" ]] ; then
		print "wdnote: invalid ignore time '$@': must point to the future"
		return 1
	fi

	# Store timestamp in ignore file
	[[ "$expire" -gt "$now" ]] &&
		print "$expire" >| "$ZSH_WDNOTE_IGNORE"
}
