#

# vim: nospell
git pull
find . -name \*~1 -delete
tic=$(date +%s)
spot=$(perl -S spot.pl | ipfs add -Q --hash sha1)
echo spot: $spot
# ------------------------------------------------------------
# put on the IPFS network
qm=$(ipfs add -Q --hash sha3-224 -r --cid-base=base58btc .)
echo qm: $qm
echo $tic: $qm >> qm.log
echo " - $qm" >> mutable.yml
# ------------------------------------------------------------
# update IPFS link in the index.htm
mv index.htm index.htm~
perl -pe "s,/ipfs/(:?z6cYN|Qm)[^/\" ]+,/ipfs/$qm," index.htm~ > index.htm
rm -f index.htm~
eval $($HOME/bin/version index.htm | eyml)
ver=$scheduled
v=${ver#v}
# ------------------------------------------------------------
if git commit -a -m "publishing on $tic for $ver"; then
date=$(date +%D)
rev=$(git rev-parse --short HEAD)
git tag -f -a $ver -m "tagging $rev on $date"
# push repository to IPFS too
find .git/objects -type f -exec ipfs dag put --format=git --input-enc=zlib {} \; > hashes
echo "$ver: $date ($rev) $version" > VERSION
git push --delete origin $ver
git push --tags
echo https://www.jsdelivr.com/package/gh/iglake/cssjs?version=$v
echo https://cdn.jsdelivr.net/gh/iglake/cssjs@$v/
fi
# ------------------------------------------------------------
