#!/usr/bin/env bash

OUT_DIR="./reports"

[[ -d "${OUT_DIR}" ]] || mkdir -p "${OUT_DIR}"

rm -rf "${OUT_DIR}"/*

if [ -z "${DSS_DIR}" ]; then
	DSS_DIR="../dss"
fi

surya describe $DSS_DIR/**/*.sol | sed -E 's/[[:cntrl:]]\[[0-9;]*m//g' > ${OUT_DIR}/dss-describe.txt
surya graph $DSS_DIR/**/*.sol | dot -Tpng > ${OUT_DIR}/dss-graph.png

CONTRACTS=$DSS_DIR/src/*.sol

for c in $CONTRACTS
do
	NAME=$(basename "${c%.sol}")
	echo "Starting Contract: ${NAME}"
	mkdir "${OUT_DIR}/${NAME}"
	surya describe "$DSS_DIR/src/${NAME}.sol" | sed -E 's/[[:cntrl:]]\[[0-9;]*m//g' > ${OUT_DIR}/${NAME}/describe_${NAME}.txt
	describe="${OUT_DIR}/${NAME}/describe_${NAME}.txt"
	CONTRACT=""
	while IFS= read -r line
	do
		line=$(sed 's/#//g' <<< "$line")
		# line=$(sed -E 's/[[:cntrl:]]\[[0-9;]*m//g' <<< "$line")
		ar=($line)
		# echo ${ar[*]}
		if [ "${ar[0]}" == "+" ]; then
			CONTRACT="${ar[1]}"
			echo "dependencies of ${CONTRACT}"
			surya dependencies "${CONTRACT}" "${DSS_DIR}/src/${NAME}.sol" | sed -E 's/[[:cntrl:]]\[[0-9;]*m//g' > ${OUT_DIR}/${NAME}/dependencies_${CONTRACT}_${NAME}.txt
		elif [ "${ar[0]}" == "-" ]; then
			echo "ftrace of ${ar[2]} for ${CONTRACT}"
			surya ftrace "${CONTRACT}::${ar[2]}" all "${DSS_DIR}/src/${NAME}.sol" | sed -E 's/[[:cntrl:]]\[[0-9;]*m//g' > "${OUT_DIR}/${NAME}/ftrace_${CONTRACT}_${ar[2]}_${NAME}.txt"
		fi

	done < "$describe"
	surya inheritance $c | dot -Tpng > "${OUT_DIR}/${NAME}/inheritance_${NAME}.png"
	surya graph $c | dot -Tpng > "${OUT_DIR}/${NAME}/graph_${NAME}.png"
	surya parse $c > "${OUT_DIR}/${NAME}/parse_${NAME}.txt"
	surya mdreport "${OUT_DIR}/${NAME}/report_${NAME}.md" $c
done

