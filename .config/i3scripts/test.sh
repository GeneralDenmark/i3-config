#!/usr/bin/env bash




#ARRAY=(Fuck_You_Shannon.wav I_need_healing.ogg);

#toplay="$diry";
#toplay=$toplay${ARRAY[1]};
#echo "$toplay";
#play "$toplay";


list="$(ls ~/Music/Keyboard\ Soundclips/)";
files={};
index=0;

for bob in $list
do
	files[index]=$bob;
	let "index++";
done


rand=$(( ( RANDOM % index ) ));

echo "$rand";

theFile=${files[rand]};
echo ${files[*]}
echo "$theFile";
tooplay="~/Music/Keyboard\ Soundclips/";
tooplay=$tooplay$theFile;

echo "$tooplay"
play "$tooplay";