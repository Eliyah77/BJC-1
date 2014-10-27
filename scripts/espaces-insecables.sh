#!/bin/bash

TEX='../tex/bjc_2014/*.tex'

# guillemets
sed -i 's/« /«~/g' $TEX
sed -i 's/ »/~»/g' $TEX
sed -i 's/ :/~:/g' $TEX
sed -i 's/ ;/~;/g' $TEX
sed -i 's/ !/~!/g' $TEX
sed -i 's/ ?/~?/g' $TEX

