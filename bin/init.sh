#!/bin/bash

#--------------------------------------
# �t�@�C�A�E�H�[���̐ݒ�
#--------------------------------------
# �t�@�C�A�E�H�[�����~����B
/etc/init.d/iptables stop
/etc/init.d/ip6tables stop

# �V�X�e���N�����Ƀt�@�C�A�E�H�[�����N�����Ȃ��悤�ɂ���B
chkconfig iptables off
chkconfig ip6tables off

#--------------------------------------
# �l�b�g���[�N�̐ݒ�
#--------------------------------------
# �l�b�g���[�N�̐ݒ�t�@�C�����R�s�[����B
sed -i -e "s/\r//g" /vagrant/conf/ifcfg-eth1
cp -rf /vagrant/conf/ifcfg-eth1 /etc/sysconfig/network-scripts/

# �l�b�g���[�N���ċN������B
service network restart

#--------------------------------------
# Apache HTTP Server �̐ݒ�
#--------------------------------------
# apache ���C���X�g�[������B
yum -y install httpd

# apache �̐ݒ�t�@�C�����R�s�[����B
cp -f /vagrant/conf/httpd.conf /etc/httpd/conf/

# �V�X�e���N������ httpd ���N������B
chkconfig httpd on

# �R���e���c�p�̃f�B���N�g�����쐬����B
#mkdir -p /vagrant/html
#rm -rf /var/www/html
#ln -s /vagrant/html /var/www

#--------------------------------------
# PHP �̐ݒ�
#--------------------------------------
# php �֘A�̃p�b�P�[�W���C���X�g�[������B
yum -y install php php-mbstring php-pear

# php �̐ݒ�t�@�C�����R�s�[����
cp -f /vagrant/conf/php.ini /etc/

#--------------------------------------
# expect �̃C���X�g�[��
#--------------------------------------
yum -y install expect

#--------------------------------------
# MySQL �̐ݒ�
#--------------------------------------
# MySQL�T�[�o���C���X�g�[������B
yum -y install mysql-server

# MySQL�T�[�o�̐ݒ�t�@�C�����R�s�[����
cp -f /vagrant/conf/my.cnf /etc/

# MySQL�T�[�o���N������B
service mysqld start

# �V�X�e���N������ MySQL�T�[�o���N������B
chkconfig mysqld on

# mysql_secure_installation �̎��s�Ɠ��͂� expect ���g���čs�Ȃ��B
/vagrant/bin/mysql_secure_installation_auto.sh

# httpd ���N������B
service httpd start
