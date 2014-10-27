#!/bin/bash

TEX='../tex/bjc_2014/*.tex'

#((\d\s*)*\w{1,3}\s*\.\s*\d{1,3}(\s*:\s*(\d{1,3})*(-*(\d{0,3})(\s*,\s*(\d{1,3})*-*(\d{1,3})*)*)*)*)

sed -i 's/~/ /g' $TEX
sed -i 's/ / /g' $TEX
sed -i 's/  / /g' $TEX
sed -i 's/ ,/,/g' $TEX
sed -i "s/’/'/g" $TEX
sed -i 's/\.\.\./…/g' $TEX
sed -i 's/ \./\./g' $TEX
sed -i 's/ "/ « /g' $TEX
sed -i 's/" / » /g' $TEX
sed -i 's/",/ »,/g' $TEX
sed -i 's/"\./ »\./g' $TEX

