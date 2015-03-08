#!/bin/bash

TEX='../tex/bjc/*.tex'

# guillemets
sed -i 's/« /«~/g' $TEX
sed -i 's/ »/~»/g' $TEX
sed -i 's/ :/~:/g' $TEX
sed -i 's/ ;/~;/g' $TEX
sed -i 's/ !/~!/g' $TEX
sed -i 's/ ?/~?/g' $TEX

