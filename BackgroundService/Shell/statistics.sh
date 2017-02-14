#!/bin/bash
cd /dbdata/virtualHosts/haixin_partner/BackgroundService/
/usr/bin/php ./run.php Statistics/DataFlow/start >> ./access_stastistics.log
echo -e '\r' >>./access_stastistics.log
