#!/bin/bash
# echo "Getting the bookstore data ..."
# mkdir -p /tmp/bookstore/csv
# curl https://dl.dropboxusercontent.com/s/0z1iwdkw42cvr3d/fmc2.tar.gz?dl=1 --output /tmp/bookstore/csv/bookstore.tar.gz
# echo "Extracting bookstore files ..."
# tar -vxzf /tmp/bookstore/csv/bookstore.tar.gz --directory /tmp/bookstore/csv/

echo "Waiting for columnstore to respond (2m)."
i=0
until (/usr/local/mariadb/columnstore/bin/mcsadmin getSystemStatus|grep -c "System        ACTIVE" > /dev/null 2>&1)
    do
        if [ "$i" =  "24" ]; then
          break
        fi
        i=$(( $i+1 ))
        sleep 5s
        echo "Retry" $i
    done
echo "Loading Bookstore Sandbox Data ...."
/usr/local/mariadb/columnstore/mysql/bin/mysql < /tmp/bookstore/csv/load_ax_template.sql