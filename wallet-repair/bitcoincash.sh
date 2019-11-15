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

echo "Downloading..."
curl -#o /tmp/bitcoincash.tar.gz https://download.bitcoinabc.org/0.20.5/linux/bitcoin-abc-0.20.5-x86_64-linux-gnu.tar.gz >> ${LOG_FILE} 2>&1
tar -xzf /tmp/bitcoincash.tar.gz -C /tmp/ >> ${LOG_FILE} 2>&1

echo "Updating..."
mv /usr/local/bin/bitcoincashd /usr/local/bin/bitcoincashd-old >> ${LOG_FILE} 2>&1
mv /usr/local/bin/bitcoincash-cli /usr/local/bin/bitcoin-cli-old >> ${LOG_FILE} 2>&1
cp /tmp/bitcoin-abc-0.20.5/bin/bitcoind /usr/local/bin/bitcoincashd >> ${LOG_FILE} 2>&1
cp /tmp/bitcoin-abc-0.20.5/bin/bitcoin-cli /usr/local/bin/bitcoincash-cli >> ${LOG_FILE} 2>&1
rm -r /tmp/bitcoin-abc-0.20.5 >> ${LOG_FILE} 2>&1
rm /tmp/bitcoincash.tar.gz >> ${LOG_FILE} 2>&1

sed -i 's/\<connections\>/maxconnections/g' /mnt/blockchains/bitcoincash/bitcoincash.conf >> ${LOG_FILE} 2>&1

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
