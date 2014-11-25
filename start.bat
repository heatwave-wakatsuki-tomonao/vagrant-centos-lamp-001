@echo off

echo -------------------------------------------------
echo ���̃o�b�`�t�@�C���́AVagrant Cloud �� Box�ufillup/centos-6.5-i386-minimal�v���g���� LAMP �����\�z���܂��B
echo.
echo �\�z�ς݂̏ꍇ�́A���z�}�V���̋N���݂̂��s�Ȃ��܂��B
echo ���z�}�V�����I������ɂ́Avagrant halt �R�}���h�����s���Ă��������B
echo.
echo �r���Ŏ��s�����ꍇ�́AVagrantfile ���폜������A�ēx start.bat �����s���Ă��������B
echo -------------------------------------------------

if exist Vagrantfile goto VAGRANT_UP

rem -----------------------------------
rem IP�A�h���X�����[�U�̓��͂���擾����B
rem -----------------------------------
rem �ϐ��FIP�A�h���X
set IP_ADDRESS=""

rem ���[�U�̓��͂��󂯕t����B
set /p IP_ADDRESS="���z�}�V���ɐݒ肷��IP�A�h���X����͂��Ă��������F"

rem ���͒l��\������B
echo %IP_ADDRESS% �����z�}�V���ɐݒ肵�܂��B

rem �l�b�g���[�N�t�@�C���ݒ�t�@�C���𐶐�����B
echo BOOTPROTO=static > conf\ifcfg-eth1
echo ONBOOT=yes>> conf\ifcfg-eth1
echo DEVICE=eth1>> conf\ifcfg-eth1
echo NETMASK=255.255.255.0>> conf\ifcfg-eth1
echo DNS1=192.168.1.1>> conf\ifcfg-eth1
echo IPADDR=%IP_ADDRESS%>> conf\ifcfg-eth1

rem -----------------------------------
rem Vagrantfile �𐶐�����B
rem -----------------------------------
echo.
echo Vagrantfile �𐶐����܂��B

echo VAGRANTFILE_API_VERSION = "2"> Vagrantfile
echo Vagrant.configure(VAGRANTFILE_API_VERSION) do ^|config^|>> Vagrantfile
echo   config.vm.box = "CentOS 6.5 i386 Minimal">> Vagrantfile
echo   config.vm.box_url = "https://dl.dropbox.com/s/3fgr7lbvcpn51py/centos_6-5_i386.box">> Vagrantfile
echo   config.vm.network "public_network">> Vagrantfile
echo   config.vm.synced_folder "html", "/var/www/html", create: true>> Vagrantfile
echo   config.vm.provision :shell, :path =^> "bin/init.sh">> Vagrantfile
echo end>> Vagrantfile

echo Vagrantfile �𐶐����܂����B

:VAGRANT_UP

rem -----------------------------------
rem vagrant up �R�}���h�����s����B
rem -----------------------------------
echo.
echo vagrant up �R�}���h�����s���܂��B
cmd /k vagrant up
