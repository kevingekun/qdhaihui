#!/bin/bash
cd /dbdata/virtualHosts/haixin_partner/BackgroundService 
/usr/bin/php ./run.php Crontab/OrderQueue/payRemind >> ./access_message_minute.log
/usr/bin/php ./run.php Crontab/MsgQueue/startQueue >> ./access_message_minute.log
echo -e '\r' >>./access_message_minute.log
