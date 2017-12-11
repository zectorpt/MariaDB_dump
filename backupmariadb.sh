touch /var/log/backupmariadb.log
chmod 777 /var/log/backupmariadb.log
mysqldump -u root --all-databases > /tmp/mysql-backup_prdlsup028_$(date +\%Y\%m\%d_\%H\%M\%S).sql
ssh prdlsup038 "gzip /tmp/mysql-backup_prdlsup028_*.sql"
ssh prdlsup038 "rm -f /tmp/mysql-backup_prdlsup028_*.sql"
scp /tmp/mysql-backup_prdlsup028_*.sql root@prdlsup038:/tmp/
ssh prdlsup038 "mysql -u root < /tmp/mysql-backup_prdlsup028_*.sql"
ssh prdlsup038 "gzip /tmp/mysql-backup_prdlsup028_*.sql"
ssh prdlsup038 "rm -f /tmp/mysql-backup_prdlsup028_*.sql"
ssh prdlsup038 "find /tmp/*prdlsup028* -type f -mtime +6 -exec rm -f {} \;"
#Just in case
rm -f /tmp/mysql-backup_prdlsup028_*.sql
