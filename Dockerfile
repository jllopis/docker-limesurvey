FROM dockerfile/ubuntu

# install required packages
RUN apt-get update && \
  
  # zabbix dependencies
  apt-get install -y \
    
  # php-fpm & nginx
  php5-mysql php5-fpm php5-gd nginx \
  
  # nullmailer for relaying emails
  nullmailer

# download limesurvey
RUN wget -O limesurvey.tar.bz2 http://www.limesurvey.org/en/stable-release/finish/25-latest-stable-release/1207-limesurvey205plus-build141210-tar-bz2 

RUN tar xvjf limesurvey.tar.bz2 && \
  chown -R www-data:www-data limesurvey
  # keep a copy, so the init script
  cp limesurvey /srv/ && \
  ls -la /srv/
  
# Expose nginx
EXPOSE 80

# VOLUME ["/usr/lib/zabbix/alertscripts", "/usr/lib/zabbix/externalscripts"]

ADD scripts/init_nullmailer /init_nullmailer
ADD scripts/run_limesurvey /run_limesurvey

CMD ["/run_limesurvey"]