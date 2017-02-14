#!/bin/bash
backupdir=/dbdata/virtualHosts/haixin_partner/AssocData
time=` date +%Y%m%d%H%M `
cd /dbdata/virtualHosts/haixin_partner/BackgroundService/
/usr/bin/mysqldump -uroot -pab21e6c443et haixin_partner | gzip > $backupdir/haixin_partner$time.sql.gz
find $backupdir -name "haixin_partner*.sql.gz" -type f -mtime +10 -exec rm {} \; >> ./access_mysqlBak.log
echo -e '\r' >> ./access_mysqlBak.log                                                                                                                                                                                                                                                                                                      
