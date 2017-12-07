#!/bin/bash
#
# josemedeirosdealmeida@gmail.com jose.almeida@gfi.pt
# Jose Almeida
touch /var/log/backupmariadb.log
chmod 777 /var/log/backupmariadb.log
mysqldump -u root --all-databases > /tmp/mysql-backup_prdlsup028_$(date +\%Y\%m\%d_\%H\%M\%S).sql
ssh prdlsup038 "gzip /tmp/mysql-backup_prdlsup028_*.sql"
ssh prdlsup038 "rm -f /tmp/mysql-backup_prdlsup028_*.sql"
scp /tmp/mysql-backup_prdlsup028_*.sql root@prdlsup038:/tmp/
ssh prdlsup038 "mysql -u root < /tmp/mysql-backup_prdlsup028_*.sql"
ssh prdlsup038 "gzip /tmp/mysql-backup_prdlsup028_*.sql"
ssh prdlsup038 "rm -f /tmp/mysql-backup_prdlsup028_*.sql"
ssh prdlsup038 "find /tmp/*prdlsup028* -mtime +20 -exec rm -f {} \;"
rm -f /tmp/mysql-backup_prdlsup028_*.sql
