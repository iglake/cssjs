#

tic=$(date +%s)
spot=$(perl -S spot.pl | ipfs add -Q --hash sha1)
echo spot: $spot
git commit -a
rm -f *.org {css,js}/*.org
qm=$(ipfs add -Q --hash sha3-224 -r --cid-base=base58btc .)
echo qm: $qm
echo $tic: $qm >> qm.log
echo " - $qm" >> mutable.yml
mv index.htm index.htm~
perl -pe "s,/ipfs/(:?z6cYN|Qm)[^/\" ]+,/ipfs/$qm," index.htm~ > index.htm
rm -f index.htm~


