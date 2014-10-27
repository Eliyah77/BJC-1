#!/bin/bash

DIR='../tex/bjc_2014/*.tex'

# guillemets
sed -i 's/« /«~/g' $DIR
sed -i 's/ »/~»/g' $DIR

