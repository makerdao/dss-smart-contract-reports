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
	echo "$c"
	NAME=$(basename "${c%.sol}")
	echo $NAME
	mkdir "${OUT_DIR}/${NAME}"
	surya inheritance $c | dot -Tpng > "${OUT_DIR}/${NAME}/inheritance_${NAME}.png"
	surya graph $c | dot -Tpng > "${OUT_DIR}/${NAME}/graph_${NAME}.png"
	surya parse $c > "${OUT_DIR}/${NAME}/parse_${NAME}.txt"
	surya mdreport "${OUT_DIR}/${NAME}/report_${NAME}.md" $c
done

