set -e

d=$(date -u "+%Y%m%d%H%M%S")

echo
echo 'Stopping Bitcoin Cash...'
supervisorctl stop bitcoincash &>/dev/null

echo 'Clearing the database, chainstate, and blocks...'
cd /mnt/blockchains/bitcoincash
mkdir empty-$d
rsync -a --delete empty-$d/ database/
rsync -a --delete empty-$d/ chainstate/
rsync -a --delete empty-$d/ blocks/

echo 'Updating Bitcoin Cash...'
curl -#o /tmp/bitcoincash.tar.gz https://download.bitcoinabc.org/0.19.10/linux/bitcoin-abc-0.19.10-x86_64-linux-gnu.tar.gz &>/dev/null
tar -xzf /tmp/bitcoincash.tar.gz -C /tmp/
mv /usr/local/bin/bitcoincashd /usr/local/bin/bitcoincashd-old
mv /usr/local/bin/bitcoincash-cli /usr/local/bin/bitcoincash-cli-old
cp /tmp/bitcoin-abc-0.19.10/bin/bitcoind /usr/local/bin/bitcoincashd
cp /tmp/bitcoin-abc-0.19.10/bin/bitcoin-cli /usr/local/bin/bitcoincash-cli
rm -r /tmp/bitcoin-abc-0.19.10
rm /tmp/bitcoincash.tar.gz

echo 'Clearing Bitcoin logs...'
mv /var/log/supervisor/bitcoincash.err.log /var/log/supervisor/bitcoincash.err.log-$d
mv /var/log/supervisor/bitcoincash.out.log /var/log/supervisor/bitcoincash.out.log-$d

echo "Resetting Bitcoin Cash's supervisor configuration..."
curl -#o /etc/supervisor/conf.d/bitcoincash.conf https://raw.githubusercontent.com/naconner/lamascripts/master/switches/reindex/bitcoincash-orig.conf  &>/dev/null
supervisorctl reread &>/dev/null

echo 'Starting Bitcoin Cash...'
supervisorctl start bitcoincash &>/dev/null

echo 'Done!'
echo
