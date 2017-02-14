#!/bin/bash
cd /dbdata/virtualHosts/haixin_partner/BackgroundService 
/usr/bin/php ./run.php Crontab/MsgQueue/startQueue >> ./access_redisQueue.log
echo -e '\r' >>./access_redisQueue.log
