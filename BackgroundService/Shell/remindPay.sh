#!/bin/bash
cd /data/vIrtualHosts/hx.t2.01china.com/BackgroundService/
/usr/bin/php ./run.php Crontab/Mall/remindPay >> ./access_remindPay.log
echo -e '\r' >>./access_remindPay.log
