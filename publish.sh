#

git pull
find . -name \*.org -delete
tic=$(date +%s)
spot=$(perl -S spot.pl | ipfs add -Q --hash sha1)
echo spot: $spot
ver=$($HOME/bin/version index.htm | xyml scheduled)
qm=$(ipfs add -Q --hash sha3-224 -r --cid-base=base58btc .)
echo qm: $qm
echo $tic: $qm >> qm.log
echo " - $qm" >> mutable.yml
mv index.htm index.htm~
perl -pe "s,/ipfs/(:?z6cYN|Qm)[^/\" ]+,/ipfs/$qm," index.htm~ > index.htm
rm -f index.htm~

if git commit -a -m "publishing on $tic for $ver"; then
date=$(date +%D)
rev=$(git rev-parse --short HEAD)
git tag -f -a $ver -m "tagging $rev on $date"
echo "$ver: $date ($rev)" > VERSION
find .git/objects -type f -exec ipfs dag put --format=git --input-enc=zlib {} \; > hashes
git push --delete origin $ver
git push --tags
fi
