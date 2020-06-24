#!/bin/sh -l

rcfile=$(mktemp)
echo>$rcfile

echo "set ftp:ssl-allow false">>$rcfile
echo "set ftp:ssl-force $INPUT_FORCESSL">>$rcfile
echo "set ssl:verify-certificate no">>$rcfile
echo "set sftp:auto-confirm yes">>$rcfile
echo "set ftp:ssl-protect-data yes">>$rcfile
echo "set xfer:timeout 5s">>$rcfile
echo "set net:timeout 5s">>$rcfile

lftp --rcfile=$rcfile $INPUT_HOST -u "$INPUT_USER,$INPUT_PASSWORD" -e "mirror --loop -R -P 4 -x ^\.git/$ $INPUT_LOCALDIR $INPUT_REMOTEDIR; quit"
rm -f $rcfile
