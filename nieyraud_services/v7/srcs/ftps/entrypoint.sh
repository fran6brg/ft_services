pure-pw useradd admin -u admin -d /home/ftp/admin
pure-pw mkdb
ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/75puredb
pure-pw mkdb
/usr/sbin/pure-ftpd -Y 2
