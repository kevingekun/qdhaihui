#!/bin/bash

backupdir=/dbdata/virtualHosts/bak
projectdir=/dbdata/virtualHosts/haixin_partner
time=` date +%Y%m%d%H%M`

cd /dbdata/virtualHosts 
tar -czf ./bak/haixin_partner$time.tar.gz --exclude=haixin_partner/AssocData haixin_partner
find $backupdir -name "haixin_partner*.tar.gz" -type f -mtime +5 -exec rm {} \; >> $backupdir/access_projectBak.log
echo -e '\r' >> $bakupdir/access_projectBak.log
