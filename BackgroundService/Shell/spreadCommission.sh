#!/bin/bash
cd /dbdata/virtualHosts/haixin_partner/BackgroundService 
/usr/bin/php ./run.php Crontab/Commission/spreadCommission >> ./access_spreadCommission.log
echo -e '\r' >>./access_spreadCommission.log
