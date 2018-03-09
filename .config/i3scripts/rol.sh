#!/usr/bin/env bash

err() { printf '%s\n' "$*" >&2; }





usage() {
	while read; do printf '%s\n' "$REPLY"; done <<- EOF
		Usage: rol [flags]
		    Flags:
		        --help|-h                       Show this message.
		        -i [OPTIONAL INT]  				Raises volume by default 5
		        -d [OPTIONAL INT]				Lovers volume by default 5
	EOF
}

main() {

	Muted="$(pamixer --get-mute)"
	if ${Muted} ; then
	    pamixer -u
	fi
	defaultval=5
	if [ "$2" != "" ] ; then
		defaultval=$2
	fi

	while (( $# )); do
		case "$1" in
			--help|-h) usage; return 0;;
			-i) pamixer --allow-boost -i $defaultval && 
notify-send -u low -i notification-audio-volume-off "Vol inc by $defaultval";shift;;
			-d) pamixer --allow-boost -d $defaultval && 
notify-send -u low -i notification-audio-volume-off "Vol dec by $defaultval";shift;;
			
			--) shift; break;;
			-*)
				err "Unknown key: $1"
				usage
				return 1
			;;

			*) break;;
		esac
		shift
	done

	exec pkill -SIGRTMIN+3 i3blocks
	unset Muted
}


main "$@"
