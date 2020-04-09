#! /bin/sh

rc-service php-fpm7 start
tail -f /dev/null
