#!/bin/bash

TEX='../tex/bjc/*.tex'

#((\d\s)?\w{1,3}\.?\s+\d{1,3}:\d{1,3}([-,](\d{0,3})(\s*,\s*(\d{1,3})*-*(\d{1,3})*)*)*)
#\\vref{([A-Za-zéïë\.,:\- \d]*)}

# espaces
sed -i 's/~/ /g' $TEX
sed -i 's/ / /g' $TEX
sed -i 's/	/ /g' $TEX
sed -i 's/  / /g' $TEX
sed -i 's/{ /{/g' $TEX
sed -i 's/ }/}/g' $TEX

# espaces & ponctuations
sed -i 's/!/ !/g' $TEX
sed -i 's/?/ ?/g' $TEX
sed -i 's/;/ ;/g' $TEX
sed -i 's/  / /g' $TEX
sed -i 's/ ,/,/g' $TEX
sed -i 's/ \./\./g' $TEX

# ponctuations & caractères
sed -i "s/’/'/g" $TEX
sed -i 's/\.\.\./…/g' $TEX
sed -i 's/oe/œ/g' $TEX
sed -i 's/OE/Œ/g' $TEX

# guillemets
sed -i 's/ "/ « /g' $TEX
sed -i 's/" / » /g' $TEX
sed -i 's/",/ »,/g' $TEX
sed -i 's/"\./ »\./g' $TEX
sed -i 's/"}/ »}/g' $TEX
sed -i 's/{"/{« /g' $TEX

# espaces & guillemets
sed -i 's/«/« /g' $TEX
sed -i 's/»/ »/g' $TEX
sed -i 's/  / /g' $TEX

