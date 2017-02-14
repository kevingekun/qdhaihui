#!/bin/bash
cd /dbdata/virtualHosts/haixin_partner/BackgroundService 
/usr/bin/php ./run.php Crontab/OrderQueue/couponRemind >> ./access_day_message.log
echo -e '\r' >>./access_day_message.log
