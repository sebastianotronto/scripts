#!/bin/sh

# Script to store and access blindsolving algs (speedcubing stuff)

# Example: alg e FG - opens up editor to edit $basedir/edges/$ebuffer/RD/LD
# Example: alg c UBL E - prints out all first algs for UBL-FDR-*

usage() {
	echo "Usage: alg [c|e|w] [buffer] [1 letter|2 letters]"
}

editor=vi
basedir="$HOME/box/speedcubing/bld/algs"
ebuffer=UR
cbuffer=UFR
wbuffer=UFr

edge() {
	[ "$1" = "A" ] && echo FU
	[ "$1" = "B" ] && echo UF
	[ "$1" = "C" ] && echo UL
	[ "$1" = "D" ] && echo UB
	[ "$1" = "E" ] && echo FD
	[ "$1" = "F" ] && echo RD
	[ "$1" = "G" ] && echo LD
	[ "$1" = "I" ] && echo FR
	[ "$1" = "J" ] && echo LU
	[ "$1" = "K" ] && echo RB
	[ "$1" = "L" ] && echo DF
	[ "$1" = "M" ] && echo DB
	[ "$1" = "N" ] && echo DR
	[ "$1" = "O" ] && echo FL
	[ "$1" = "P" ] && echo DL
	[ "$1" = "R" ] && echo BU
	[ "$1" = "S" ] && echo BD
	[ "$1" = "T" ] && echo BL
	[ "$1" = "U" ] && echo BR
	[ "$1" = "V" ] && echo LF
	[ "$1" = "W" ] && echo LB
	[ "$1" = "Z" ] && echo RF
}

corner() {
	[ "$1" = "A" ] && echo FUL
	[ "$1" = "B" ] && echo UBL
	[ "$1" = "C" ] && echo UFL
	[ "$1" = "D" ] && echo UBR
	[ "$1" = "E" ] && echo FDR
	[ "$1" = "F" ] && echo RDB
	[ "$1" = "G" ] && echo LDF
	[ "$1" = "J" ] && echo LUF
	[ "$1" = "K" ] && echo RUB
	[ "$1" = "L" ] && echo DFR
	[ "$1" = "M" ] && echo DBR
	[ "$1" = "N" ] && echo DFL
	[ "$1" = "O" ] && echo FDL
	[ "$1" = "P" ] && echo DBL
	[ "$1" = "R" ] && echo BUR
	[ "$1" = "S" ] && echo BUL
	[ "$1" = "T" ] && echo BDL
	[ "$1" = "U" ] && echo BDR
	[ "$1" = "V" ] && echo LUB
	[ "$1" = "W" ] && echo LDB
	[ "$1" = "Z" ] && echo RDF
}

wing() {
	[ "$1" = "A" ] && echo FUl
	[ "$1" = "B" ] && echo URb
	[ "$1" = "C" ] && echo ULf
	[ "$1" = "D" ] && echo UBl
	[ "$1" = "E" ] && echo FDr
	[ "$1" = "F" ] && echo RDb
	[ "$1" = "G" ] && echo LDf
	[ "$1" = "I" ] && echo FRu
	[ "$1" = "J" ] && echo LUb
	[ "$1" = "K" ] && echo RBu
	[ "$1" = "L" ] && echo DFl
	[ "$1" = "M" ] && echo DBr
	[ "$1" = "N" ] && echo DRf
	[ "$1" = "O" ] && echo FLd
	[ "$1" = "P" ] && echo DLb
	[ "$1" = "R" ] && echo BUr
	[ "$1" = "S" ] && echo BDl
	[ "$1" = "T" ] && echo BLu
	[ "$1" = "U" ] && echo BRd
	[ "$1" = "V" ] && echo LFu
	[ "$1" = "W" ] && echo LBd
	[ "$1" = "X" ] && echo LUf
	[ "$1" = "Z" ] && echo RFd
}

edit() {
	mkdir -p "$basedir/$1/$2/$3"
	$editor "$basedir/$1/$2/$3/$4"
}

showall_c() {
	all_letters="A B C D E F G J K L M N O P R S T U V W Z"
	buffer="$1"
	firstletter="$2"
	firsttarget="$(corner $firstletter)"
	for secondletter in $all_letters; do
		secondtarget="$(corner $secondletter)"
		f="$basedir/corners/$buffer/$firsttarget/$secondtarget"
		[ -f "$f" ] || continue
		line="$(head -n 1 "$f")"
		printf '%s   %s\n' "$firstletter$secondletter" "$line"
	done
}

showall_e() {
	all_letters="A B C D E F G I J K L M N O P R S T U V W Z"
	buffer="$1"
	firstletter="$2"
	firsttarget="$(edge $firstletter)"
	for secondletter in $all_letters; do
		secondtarget="$(edge $secondletter)"
		f="$basedir/edges/$buffer/$firsttarget/$secondtarget"
		[ -f "$f" ] || continue
		line="$(head -n 1 "$f")"
		printf '%s   %s\n' "$firstletter$secondletter" "$line"
	done
}

showall_w() {
	all_letters="A B C D E F G I J K L M N O P R S T U V W X Z"
	buffer="$1"
	firstletter="$2"
	firsttarget="$(wing $firstletter)"
	for secondletter in $all_letters; do
		secondtarget="$(wing $secondletter)"
		f="$basedir/wings/$buffer/$firsttarget/$secondtarget"
		[ -f "$f" ] || continue
		line="$(head -n 1 "$f")"
		printf '%s   %s\n' "$firstletter$secondletter" "$line"
	done
}

type="$1"
if [ -z "$3" ]; then
	letters="$2"
else
	letters="$3"
	cbuffer="$2"
	ebuffer="$2"
	wbuffer="$2"
fi

letter1="$(echo "$letters" | cut -c 1)"
letter2="$(echo "$letters" | cut -b 2)"

[ -z "$letter1" ] && usage && exit 1

case "$type" in
c)
	if [ -n "$letter2" ]; then
		edit corners $cbuffer $(corner $letter1) $(corner $letter2)
	else
		showall_c $cbuffer $letter1
	fi
	;;
e)
	if [ -n "$letter2" ]; then
		edit edges $ebuffer $(edge $letter1) $(edge $letter2)
	else
		showall_e $ebuffer $letter1
	fi
	;;
w)
	if [ -n "$letter2" ]; then
		edit wings $wbuffer $(wing $letter1) $(wing $letter2)
	else
		showall_w $wbuffer $letter1
	fi
	;;
*)
	usage && exit 1
	;;
esac
