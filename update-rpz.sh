#!/bin/bash

wget -O/etc/bind/hosts.txt http://www.malwaredomainlist.com/hostslist/hosts.txt
 
cat /etc/bind/hosts.txt | cut -d" " -f3 | tail -n +7  >> /etc/bind/justdomains

for file in $(cat /etc/bind/justdomains)
do
     echo "$file"  "   "   A  "   "  127.0.0.1  >> /etc/bind/newfile
done

rm -f /etc/bind/db.rpz

cp /etc/bind/db.rpz.bk /etc/bind/db.rpz
 
tr -d $'\r' < /etc/bind/newfile >> /etc/bind/rpz

sed -e '/^\;BADZONES/a\
' /etc/bind/rpz >> /etc/bind/db.rpz

rm /etc/bind/rpz 
rm /etc/bind/justdomains
rm /etc/bind/newfile
rm /etc/bind/hosts.txt 

/etc/init.d/bind9 restart

mail -s "RPZ update script on NS1" you@gmail.com <<< 'RPZ update-script Successfully ran '$day' on NS1'
