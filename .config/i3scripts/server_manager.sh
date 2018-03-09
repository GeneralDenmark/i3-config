#!/usr/bin/env bash
# Skrevet af Asger W. aka. GeneralDenmark
# Et hurtigt lille script der kan sende kommandoer til linuxGSM hvis man har flere servere :)
#

# Her ligger vi bare lige en standard path hvis den eksistere.. Altså hvis du i dit filsystem har dine steamservers i mappe i HOME (~/mappenavn/)
baseLocation=~/Steam_servers/

# Array med hvor i din undermappe dine servers ligger:


usage() {
	while read; do printf '%s\n' "$REPLY"; done <<- EOF
		Usage: rol [flags]
		    Flags:
		        --help|-h                       Viser denne besked.

		        Alle følgende kommandoer skal du skrive servernavnet efter kommandoen hvor servvernavnet
		        er navnet på mappen som ligger i din mappe "$baseLocation"
		        eg.
		        -g csgo
		     	-------------------------------------------------------------
		     	--start|-g						Starter en server
		     	--stop|-s 						Stopper en server
		     	--details|-d 					Giver detaljer om serveren.
		     	--console|-c 					Giver adgang til konsollen for serveren.
		     	--config|-conf 					NANOer ind i spilkonsollens config file.
		     	--sdtdconfig|-sdtdc 			NANOer ind i sdtd configgen til pågældende server.


		     	Følgende bliver kørt på alle servere som scriptet kan finde.
		     	-------------------------------------------------------------
		     	--listall|-la 					Viser alle servere som ligger i mappen.

		     	--update|-u 					

	EOF
}

main() {

	case "$1" in 
		--help|-h) usage; return 0;;

		
		--stop|-s) path=$path"One" shift; break;;
		--start|-g) path=$path"two" shift; break;;
		--details|-d) path=$path"Three" shift; break;;
		--console|-c) path=$path"Four" shift; break;;
		--update|-u) path=$path"Five" shift; break;;
		

		--) shift; break;;
		-*)
			err "Unknown key: $1"
			usage
			return 1
		;;

		*) break;;
	esac



}

main "$@"

