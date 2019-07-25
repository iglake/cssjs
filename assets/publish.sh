#

rm -f *.org 2> /dev/null
qm=$(ipfs add -Q -r . --cid-version=1)
ww32=$(ipfs cid base32 $qm)
echo "qm: $qm" >> qm.yml
for f in *.jpg *.mp3 *.ogg *.txt ; do
ipfs add -w $f
done
curl -s -S -I https://gateway.ipfs.io/ipfs/$qm | grep -v access &
curl -s -S -I https://siderus.io/ipfs/$qm | grep -v access &
curl -s -S -I https://hardbin.com/ipfs/$qm | grep -v access &
curl -s -S -I https://$ww32.ipfs.dweb.link/ | grep -v access &
curl -s -S -I https://$ww32.cf-ipfs.com/ | grep -v access &

echo f https://$ww32.ipfs.dweb.link/
