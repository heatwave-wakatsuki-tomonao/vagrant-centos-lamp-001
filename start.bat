@echo off

echo -------------------------------------------------
echo このバッチファイルは、Vagrant Cloud の Box「fillup/centos-6.5-i386-minimal」を使って LAMP 環境を構築します。
echo.
echo 構築済みの場合は、仮想マシンの起動のみを行ないます。
echo 仮想マシンを終了するには、vagrant halt コマンドを実行してください。
echo.
echo 途中で失敗した場合は、Vagrantfile を削除した後、再度 start.bat を実行してください。
echo -------------------------------------------------

if exist Vagrantfile goto VAGRANT_UP

rem -----------------------------------
rem IPアドレスをユーザの入力から取得する。
rem -----------------------------------
rem 変数：IPアドレス
set IP_ADDRESS=""

rem ユーザの入力を受け付ける。
set /p IP_ADDRESS="仮想マシンに設定するIPアドレスを入力してください："

rem 入力値を表示する。
echo %IP_ADDRESS% を仮想マシンに設定します。

rem ネットワークファイル設定ファイルを生成する。
echo BOOTPROTO=static > conf\ifcfg-eth1
echo ONBOOT=yes>> conf\ifcfg-eth1
echo DEVICE=eth1>> conf\ifcfg-eth1
echo NETMASK=255.255.255.0>> conf\ifcfg-eth1
echo DNS1=192.168.1.1>> conf\ifcfg-eth1
echo IPADDR=%IP_ADDRESS%>> conf\ifcfg-eth1

rem -----------------------------------
rem Vagrantfile を生成する。
rem -----------------------------------
echo.
echo Vagrantfile を生成します。

echo VAGRANTFILE_API_VERSION = "2"> Vagrantfile
echo Vagrant.configure(VAGRANTFILE_API_VERSION) do ^|config^|>> Vagrantfile
echo   config.vm.box = "CentOS 6.5 i386 Minimal">> Vagrantfile
echo   config.vm.box_url = "https://dl.dropbox.com/s/3fgr7lbvcpn51py/centos_6-5_i386.box">> Vagrantfile
echo   config.vm.network "public_network">> Vagrantfile
echo   config.vm.synced_folder "html", "/var/www/html", create: true>> Vagrantfile
echo   config.vm.provision :shell, :path =^> "bin/init.sh">> Vagrantfile
echo end>> Vagrantfile

echo Vagrantfile を生成しました。

:VAGRANT_UP

rem -----------------------------------
rem vagrant up コマンドを実行する。
rem -----------------------------------
echo.
echo vagrant up コマンドを実行します。
cmd /k vagrant up
