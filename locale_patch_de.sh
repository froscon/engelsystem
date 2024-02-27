#!/usr/bin/env bash

FILE=resources/lang/de_DE/default.po

echo "Patching $FILE"

DELIM="\([^[:alpha:]]\)"

sed -i "s/${DELIM}Engel${DELIM}/\1Helferinnen\2/g" $FILE

sed -i "s/${DELIM}Engeln${DELIM}/\1Helfen\2/g" $FILE
sed -i "s/${DELIM}des Engels${DELIM}/\1der Helferin\2/g" $FILE

sed -i "s/${DELIM}Engelliste/\1Helferinnenliste/g" $FILE
sed -i "s/${DELIM}Engelsystem/\1Helferinnensystem/g" $FILE
sed -i "s/${DELIM}Engeltyp/\1Helferinnentyp/g" $FILE
sed -i "s/${DELIM}Engelzustand/\1Helferinnenzustand/g" $FILE

sed -i "s/${DELIM}engelsystem/\1helferinnensystem/g" $FILE

sed -i "s/${DELIM}Himmel${DELIM}/\1Helferinnen-GURU\2/g" $FILE
sed -i "s/${DELIM}Himmelsverwaltung/\1Office/g" $FILE
sed -i "s/${DELIM}Himmelsschreibtisch/\1GURU-Schreibtisch/g" $FILE

grep -Inri "engel" $FILE
grep -Inri "himmel" $FILE

echo "Compiling $FILE"
cd resources/lang/de_DE
msgfmt -o default.mo default.po
