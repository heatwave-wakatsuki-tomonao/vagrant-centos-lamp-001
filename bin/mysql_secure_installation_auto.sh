#!/usr/bin/expect --
spawn mysql_secure_installation

expect "Enter current password for root \(enter for none\):"
send "\r"

expect "Set root password\? \[Y/n\] "
send "Y\r"

expect "New password:"
send "mysql\r"

expect "Re-enter new password:"
send "mysql\r"

expect "Remove anonymous users\? \[Y/n\] "
send "Y\r"

expect "Disallow root login remotely\? \[Y/n\] "
send "Y\r"

expect "Remove test database and access to it\? \[Y/n\] "
send "Y\r"

expect "Reload privilege tables now\? \[Y/n\] "
send "Y\r"

interact
