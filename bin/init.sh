#!/bin/bash

#--------------------------------------
# ファイアウォールの設定
#--------------------------------------
# ファイアウォールを停止する。
/etc/init.d/iptables stop
/etc/init.d/ip6tables stop

# システム起動時にファイアウォールが起動しないようにする。
chkconfig iptables off
chkconfig ip6tables off

#--------------------------------------
# ネットワークの設定
#--------------------------------------
# ネットワークの設定ファイルをコピーする。
sed -i -e "s/\r//g" /vagrant/conf/ifcfg-eth1
cp -rf /vagrant/conf/ifcfg-eth1 /etc/sysconfig/network-scripts/

# ネットワークを再起動する。
service network restart

#--------------------------------------
# Apache HTTP Server の設定
#--------------------------------------
# apache をインストールする。
yum -y install httpd

# apache の設定ファイルをコピーする。
cp -f /vagrant/conf/httpd.conf /etc/httpd/conf/

# システム起動時に httpd を起動する。
chkconfig httpd on

# コンテンツ用のディレクトリを作成する。
#mkdir -p /vagrant/html
#rm -rf /var/www/html
#ln -s /vagrant/html /var/www

#--------------------------------------
# PHP の設定
#--------------------------------------
# php 関連のパッケージをインストールする。
yum -y install php php-mbstring php-pear

# php の設定ファイルをコピーする
cp -f /vagrant/conf/php.ini /etc/

#--------------------------------------
# expect のインストール
#--------------------------------------
yum -y install expect

#--------------------------------------
# MySQL の設定
#--------------------------------------
# MySQLサーバをインストールする。
yum -y install mysql-server

# MySQLサーバの設定ファイルをコピーする
cp -f /vagrant/conf/my.cnf /etc/

# MySQLサーバを起動する。
service mysqld start

# システム起動時に MySQLサーバを起動する。
chkconfig mysqld on

# mysql_secure_installation の実行と入力を expect を使って行なう。
/vagrant/bin/mysql_secure_installation_auto.sh

# httpd を起動する。
service httpd start
