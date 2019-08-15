#

set -e

rm -f *.org 2> /dev/null
qm=$(ipfs add -Q -r . --cid-version=1 --cid-base=base58btc)
ww32=$(ipfs cid base32 $qm)
echo "qm: $qm" >> qm.yml
for f in *.jpg *.mp3 *.ogg *.txt ; do
mh=$(ipfs add -w $f --hash sha1 -Q --cid-base=base32)
echo "//$mh.cf-ipfs.com/$f"
done
(curl -s -S -I https://gateway.ipfs.io/ipfs/$qm || \
curl -s -S -I https://siderus.io/ipfs/$qm || \
curl -s -S -I https://hardbin.com/ipfs/$qm || \
curl -s -S -I https://$ww32.ipfs.dweb.link/ || \
curl -s -S -I https://$ww32.cf-ipfs.com/ ) | grep -v Access &

echo url: https://$ww32.ipfs.dweb.link/
ipfs files rm -r /root/www/assets
ipfs files cp /ipfs/$qm /root/www/assets
www=$(ipfs files stat /root/www --hash)
echo url: https://$www.cf-ipfs.com/assets


exit $?;
