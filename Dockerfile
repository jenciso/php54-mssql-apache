FROM centos:6
MAINTAINER Juan Enciso <juan.enciso@gmail.com>
# install repo
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

RUN yum --enablerepo remi,remi-php54 -y install httpd sed php php-mysql php-mcrypt php-pdo php-odbc php-mbstring php-pear php-devel php-dom php-intl php-mssql php-xml php-mcrypt php-pear php-soap php-mongo && yum clean all && rm -rf /var/cache/yum

RUN service httpd start

ENV LOG_STDOUT **Boolean**
ENV LOG_STDERR **Boolean**
ENV LOG_LEVEL warn
ENV ALLOW_OVERRIDE All
ENV DATE_TIMEZONE UTC

COPY index.php /var/www/html/
COPY run-lap.sh /usr/sbin/
RUN chmod +x /usr/sbin/run-lap.sh
RUN chown -R apache:apache /var/www/html

VOLUME /var/www/html
VOLUME /var/log/httpd

EXPOSE 80

CMD ["/usr/sbin/run-lap.sh"]
