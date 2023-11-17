echo "downloading redis 2.8.1"
wget https://download.redis.io/releases/redis-2.8.1.tar.gz
tar -xvzf redis-2.8.1.tar.gz
cd redis-2.8.1

echo "installing required packages"
yum install make gcc wget tcl -y

echo "installing redis 2.8.1"
make
make test
make install

echo "creating redis user and greoup"
groupadd redis
adduser --system -g redis --no-create-home redis

mkdir -p /var/lib/redis
# chown -R redis:redis /var/lib/redis/
chown redis: /var/lib/redis
chmod 770 /var/lib/redis
# drwxrwx--- 2 redis redis 6 Oct 15 05:30 /var/lib/redis

echo "adding redis config file redis.config"
mkdir /etc/redis
cp /root/redis-2.8.1/redis.conf /etc/redis/redis.conf

echo "adding redis redis.service"
cp redis.service /etc/systemd/system/redis.service
systemctl daemon-reload

echo "enable and restarting redis service"
systemctl enable redis
systemctl restart redis
systemctl status redis