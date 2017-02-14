#!/bin/bash
cd /dbdata/virtualHosts/haixin_partner/BackgroundService 
/usr/bin/php ./run.php Logistics/Route/updateRoutes >> ./access_logisticsRoute.log
echo -e '\r' >>./access_logisticsRoute.log
