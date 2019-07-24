#!/usr/bin/env bash

OUT_DIR="./reports"

rm -rf $OUT_DIR/*

if [ -z "$DSS_DIR" ]; then
	DSS_DIR="../dss"
fi

surya describe $DSS_DIR/**/*.sol > ${OUT_DIR}/dss-describe.txt
surya graph $DSS_DIR/**/*.sol | dot -Tpng > ${OUT_DIR}/dss-graph.png

CONTRACTS=$DSS_DIR/src/*.sol

for c in $CONTRACTS
do
	NAME=$(basename "${c%.sol}")
	echo $NAME
	mkdir "${OUT_DIR}/${NAME}"
	surya describe "$DSS_DIR/src/${NAME}.sol" > ${OUT_DIR}/${NAME}/describe_${NAME}.txt
	describe="${OUT_DIR}/${NAME}/describe_${NAME}.txt"
	CONTRACT=""
	while IFS= read -r line
	do
			set -ex
		line=$(sed 's/#//g' <<< "$line")
		echo -e $line
		# line=$(sed "s,\[[0-9;]*m,,g" <<< "$line")
		line=$(sed 's/\x1B\[[0-9;]*m//g' <<< "$line")
		echo -e $line
		# line=${line//"#[39m"/}
		# line=${line//"[31m"/}
		# line=${line//"[32m"/}
		# line=${line//"[39m"/}
		# ar=($line)
		# echo ${ar[*]}
		# if [ "${ar[0]}" == "+" ]; then
		# 	CONTRACT=${ar[1]}
		# 	surya dependencies ${CONTRACT} "$DSS_DIR/src/${NAME}.sol" > ${OUT_DIR}/${NAME}/dependencies_${CONTRACT}_${NAME}.txt
		# elif [ "${ar[0]}" == "-" ]; then
		# 	set -x
		# 	echo "function ${ar[2]}"
		# 	surya ftrace ${CONTRACT}::${ar[2]} all "$DSS_DIR/src/$NAME.sol" > $OUT_DIR/$NAME/ftrace_${CONTRACT}_${ar[2]}_${NAME}.txt
		# 	set +x
		# else
		# 	echo "neither ${ar[0]}"
		# fi

	done < "$describe"
	surya inheritance $c | dot -Tpng > "${OUT_DIR}/${NAME}/inheritance_${NAME}.png"
	surya graph $c | dot -Tpng > "${OUT_DIR}/${NAME}/graph_${NAME}.png"
	surya parse $c > "${OUT_DIR}/${NAME}/parse_${NAME}.txt"
	surya mdreport "${OUT_DIR}/${NAME}/report_${NAME}.md" $c
done

