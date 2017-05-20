#!/bin/sh

FILE=locale/de_DE.UTF-8/LC_MESSAGES/default.po

echo "Patching $FILE"

DELIM="\([^[:alpha:]]\)"

sed -i "s/${DELIM}Engel${DELIM}/\1Helfer\2/g" $FILE

sed -i "s/${DELIM}Engeln${DELIM}/\1Helfern\2/g" $FILE

sed -i "s/${DELIM}Engelliste/\1Helferliste/g" $FILE
sed -i "s/${DELIM}Engelsystem/\1Helfersystem/g" $FILE
sed -i "s/${DELIM}Engeltyp/\1Helfertyp/g" $FILE
sed -i "s/${DELIM}Engelzustand/\1Helferzustand/g" $FILE

sed -i "s/${DELIM}engelsystem/\1helfersystem/g" $FILE

sed -i "s/${DELIM}Himmel${DELIM}/\1Helfer-GURU\2/g" $FILE
sed -i "s/${DELIM}Himmelsverwaltung/\1Office/g" $FILE
sed -i "s/${DELIM}Himmelsschreibtisch/\1GURU-Schreibtisch/g" $FILE

grep -Inri "engel" $FILE
grep -Inri "himmel" $FILE

echo "Compiling $FILE"
cd locale/de_DE.UTF-8/LC_MESSAGES
msgfmt -o default.mo default.po
