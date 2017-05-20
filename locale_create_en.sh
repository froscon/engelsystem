#!/bin/bash

echo "Creating locale/en_US.UTF-8/LC_MESSAGES/default.po"

function pyexec() {
    echo -n "$(/usr/bin/python -c 'import sys; exec sys.stdin.read()')"
}

mkdir -p locale/en_US.UTF-8/LC_MESSAGES/

find includes/ -iname "*.php" | xargs xgettext --from-code=UTF-8 -o locale/en_US.UTF-8/LC_MESSAGES/default.po --width=1000000

pyexec <<END
import re
input = open("locale/en_US.UTF-8/LC_MESSAGES/default.po").read()

pat = 'msgid "(?P<msg>[^"]*)"\s+msgstr ""'
rep = 'msgid "\g<msg>"\nmsgstr "\g<msg>"'
input = re.sub(pat, rep, input, flags = re.MULTILINE)

pat = 'msgid "(?P<msg1>[^"]*)"\s+msgid_plural "(?P<msg2>[^"]*)"\s+msgstr\[0\] ""\s+msgstr\[1\] ""'
rep = 'msgid "\g<msg1>"\nmsgid_plural "\g<msg2>"\nmsgstr[0] "\g<msg1>"\nmsgstr[1] "\g<msg2>"'
input = re.sub(pat, rep, input, flags = re.MULTILINE)

open("locale/en_US.UTF-8/LC_MESSAGES/default.po", 'w').write(input)
END

DELIM="\([^[:alpha:]]\)"
FILE=locale/en_US.UTF-8/LC_MESSAGES/default.po

sed -i "/^msgstr/s/${DELIM}angel${DELIM}/\1volunteer\2/g" $FILE
sed -i "/^msgstr/s/${DELIM}Angel${DELIM}/\1Volunteer\2/g" $FILE
sed -i "/^msgstr/s/${DELIM}angels${DELIM}/\1volunteers\2/g" $FILE
sed -i "/^msgstr/s/${DELIM}Angels${DELIM}/\1Volunteers\2/g" $FILE

sed -i "/^msgstr/s/${DELIM}angeltype/\1volunteer type/g" $FILE
sed -i "/^msgstr/s/${DELIM}Angeltype/\1Volunteer type/g" $FILE
sed -i "/^msgstr/s/${DELIM}AngelType/\1Volunteer Type/g" $FILE

sed -i "/^msgstr/s/${DELIM}angelsystem/\1volunteer system/g" $FILE

sed -i "/^msgstr/s/${DELIM}heaven/\1Helper-GURU/g" $FILE
sed -i "/^msgstr/s/${DELIM}Heaven/\1Helper-GURU/g" $FILE

sed -i "s/Language: /Language: en_US/" $FILE
sed -i "s/charset=CHARSET/charset=UTF-8/" $FILE

echo "Compiling locale/en_US.UTF-8/LC_MESSAGES/default.po"

msgfmt -o locale/en_US.UTF-8/LC_MESSAGES/default.mo $FILE
