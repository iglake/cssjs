#

tic=$(date +%s)
spot=$(perl -S spot.pl | ipfs add -Q --hash sha1)
qm=$(ipfs add -Q --hash sha3-224 -r --cid-base=base58btc .)
echo spot: $spot
echo qm: $qm
echo $tic: $qm >> qm.log
mv index.htm index.htm~
perl -pe "s,/ipfs/(:?z6cYN|Qm)[^\"]+,/ipfs/$qm," index.htm~ > index.htm
rm -f index.htm~


