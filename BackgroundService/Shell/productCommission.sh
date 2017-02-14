#!/bin/bash
cd /dbdata/virtualHosts/haixin_partner/BackgroundService 
/usr/bin/php ./run.php Crontab/Commission/productCommission >> ./access_productCommission.log
echo -e '\r' >>./access_productCommission.log
