#!/usr/bin/env bash
#har sat op for alle op untagen Tracer, Torbjörn, Symmetra, Sombra, Widowmaker, Zarya, Zenyatta

err() { printf '%s\n' "$*" >&2; }

usage() {
	while read; do printf '%s\n' "$REPLY"; done <<- EOF
		Usage: rol [flags]
		    Flags:
		        --help|-h                       Show this message.
		     	-------------------------------------------------------------
		     	should be used instead or before the following catagory
		        -r 								From random catagory.
		        -s 								Takes from the other section of catagories.
		        -------------------------------------------------------------
		        -one				  			Uses random for catagory one.
		        -two 							Uses random for catagory two.
		        -three							Uses random for catagory three.
		        -four							Uses random for catagory four.
		        -five							Uses random for catagory five.		
		        -six							Uses random for catagory six.
		        -seven							Uses random for catagory seven.
		        -eight							Uses random for catagory eight.
		        -nine							Uses random for catagory nine.
		        -zero							Uses random for catagory zero.
	EOF
}
function player {
	list="$(ls $0)"
	files={};
	index=0;
	echo "$0";
	for bob in $list
	do
		files[index]=$bob;
		let "index++";
		echo "this many times";
	done

	rand=$(( ( RANDOM % index ) ));

	theFile=${files[rand]};

	tooplay="$1";
	tooplay=$tooplay$theFile;

	play "$tooplay";

}

main() {

	Muted="$(pamixer --get-mute)"
	if ${Muted} ; then
	    echo "is muted. Please unute";
	fi
	second=false;
	path="$1";
	echo "0-> $0";
	echo "1 -> $1";
	echo "2 -> $2";

	case "$2" in
		--help|-h) usage; return 0;;

		-r) break;;
		#-s) second=true ;shift;;
		-one) path=$path"One" shift; break;;
		-two) path=$path"two" shift; break;;
		-three) path=$path"Three" shift; break;;
		-four) path=$path"Four" shift; break;;
		-five) path=$path"Five" shift; break;;
		-six) path=$path"Six" shift; break;;
		-seven) path=$path"Seven" shift; break;;
		-eight) path=$path"Eight" shift; break;;
		-nine) path=$path"Nine" shift; break;;
		-zero) path=$path"Zero" shift; break;;

		--) shift; break;;
		-*)
			err "Unknown key: $1"
			usage
			return 1
		;;

		*) break;;
	esac
	shift
	
	path=$path"/";
	player $path;


	unset second;
	unset path;
	unset Muted;
}


main "$@"