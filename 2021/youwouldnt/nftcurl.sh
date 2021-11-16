#!/bin/bash

contract=BC4CA0EdA7647A8aB7C2061c2E118A18a936f13D

gw=https://ipfs.io/ipfs/
scan="https://etherscan.io/readContract?m=normal&a=0x${contract}&v=0x${contract}"
rootdir=$(curl -s $scan | egrep -ao "ipfs:..[^/]*")

for i in {0..9999}; do
  nft=$(curl -s $gw${rootdir:7}/$i | egrep -ao "ipfs:..\w*")
  color=$(curl -s $gw${nft:7} |
    egrep "^\s*$(convert - -alpha off -depth 8 txt:- |
    fgrep -m1 '70,0:' |
    sed 's/^.*srgb.\([0-9,]*\).$/ \1,/;s/[0-9]\{2\},/\\w\\w,/g;s/ //g;s/,/\\s+/g')" rgb.txt |
    head | shuf -n1 |
    cut -f3,4 |
    head -n1 |
    sed 's/ /-/g;s/[0-9X]//g;s/\([A-Z]\)/\L\1/;s/\([A-Z]\)/-\L\1/g')
  out=$(shuf -n1 phrases.txt |
    sed "s/APE/$(shuf -n1 apes.txt)/;
         s/IS/$(shuf -n1 is.txt)/;
         s/BORED/$(shuf -n1 bored.txt)/;
         s/ON/$(shuf -n1 on.txt)/;
         s/WITH/$(shuf -n1 with.txt)/;
         s/GROUND/$(shuf -n1 ground.txt)/;
         s/BEING/$(shuf -n1 being.txt)/
         s/COLOR/$color/")
  echo "<span style=\"color:${color//-}\" title=\"$nft\">${out^}</span>"
done
