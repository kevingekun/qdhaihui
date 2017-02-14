#!/bin/bash
cd /dbdata/virtualHosts/haixin_partner/BackgroundService/
/usr/bin/php ./run.php Crontab/Mall/closeOrder >> ./access_closeOrder.log
echo -e '\r' >>./access_closeOrder.log
