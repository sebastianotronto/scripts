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
	[ "$1" = "a" ] && echo FU
	[ "$1" = "b" ] && echo UF
	[ "$1" = "c" ] && echo UL
	[ "$1" = "d" ] && echo UB
	[ "$1" = "e" ] && echo FD
	[ "$1" = "f" ] && echo RD
	[ "$1" = "g" ] && echo LD
	[ "$1" = "i" ] && echo FR
	[ "$1" = "j" ] && echo LU
	[ "$1" = "k" ] && echo RB
	[ "$1" = "l" ] && echo DF
	[ "$1" = "m" ] && echo DB
	[ "$1" = "n" ] && echo DR
	[ "$1" = "o" ] && echo FL
	[ "$1" = "p" ] && echo DL
	[ "$1" = "r" ] && echo BU
	[ "$1" = "s" ] && echo BD
	[ "$1" = "t" ] && echo BL
	[ "$1" = "u" ] && echo BR
	[ "$1" = "v" ] && echo LF
	[ "$1" = "w" ] && echo LB
	[ "$1" = "z" ] && echo RF
}

corner() {
	[ "$1" = "a" ] && echo FUL
	[ "$1" = "b" ] && echo UBL
	[ "$1" = "c" ] && echo UFL
	[ "$1" = "d" ] && echo UBR
	[ "$1" = "e" ] && echo FDR
	[ "$1" = "f" ] && echo RDB
	[ "$1" = "g" ] && echo LDF
	[ "$1" = "j" ] && echo LUF
	[ "$1" = "k" ] && echo RUB
	[ "$1" = "l" ] && echo DFR
	[ "$1" = "m" ] && echo DBR
	[ "$1" = "n" ] && echo DFL
	[ "$1" = "o" ] && echo FDL
	[ "$1" = "p" ] && echo DBL
	[ "$1" = "r" ] && echo BUR
	[ "$1" = "s" ] && echo BUL
	[ "$1" = "t" ] && echo BDL
	[ "$1" = "u" ] && echo BDR
	[ "$1" = "v" ] && echo LUB
	[ "$1" = "w" ] && echo LDB
	[ "$1" = "z" ] && echo RDF
}

wing() {
	[ "$1" = "a" ] && echo FUl
	[ "$1" = "b" ] && echo URb
	[ "$1" = "c" ] && echo ULf
	[ "$1" = "d" ] && echo UBl
	[ "$1" = "e" ] && echo FDr
	[ "$1" = "f" ] && echo RDb
	[ "$1" = "g" ] && echo LDf
	[ "$1" = "i" ] && echo FRu
	[ "$1" = "j" ] && echo LUb
	[ "$1" = "k" ] && echo RBu
	[ "$1" = "l" ] && echo DFl
	[ "$1" = "m" ] && echo DBr
	[ "$1" = "n" ] && echo DRf
	[ "$1" = "o" ] && echo FLd
	[ "$1" = "p" ] && echo DLb
	[ "$1" = "r" ] && echo BUr
	[ "$1" = "s" ] && echo BDl
	[ "$1" = "t" ] && echo BLu
	[ "$1" = "u" ] && echo BRd
	[ "$1" = "v" ] && echo LFu
	[ "$1" = "w" ] && echo LBd
	[ "$1" = "x" ] && echo LUf
	[ "$1" = "z" ] && echo RFd
}

edit() {
	mkdir -p "$basedir/$1/$2/$3"
	$editor "$basedir/$1/$2/$3/$4"
}

showall_c() {
	all_letters="a b c d e f g j k l m n o p r s t u v w z"
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
	all_letters="a b c d e f g i j k l m n o p r s t u v w z"
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
	all_letters="a b c d e f g i j k l m n o p r s t u v w x z"
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
