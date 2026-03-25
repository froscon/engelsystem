FROM mariadb:10.7

RUN apt update && \
    apt install -y cron strace && \
    mkdir /backup

COPY docker/backup.hourly /etc/cron.hourly/backup
COPY docker/backup.daily /etc/cron.daily/backup
COPY docker/backup.weekly /etc/cron.weekly/backup

ENTRYPOINT env >> /etc/environment && cron -f -l 2 > /proc/1/fd/1 2> /proc/1/fd/2
