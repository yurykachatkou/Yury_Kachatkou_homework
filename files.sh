#1
cat << EOF > /etc/httpd/conf.modules.d/mod_jk.conf
wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.46-src.tar.gz
tar -xvzf tomcat-connectors-1.2.46-src.tar.gz 
cd tomcat-connectors-1.2.46-src/
cd native/
./configure --with-apxs=/usr/bin/apxs
make
libtool --finish /usr/lib64/httpd/modules
make install
#2
hostnamectl set-hostname kachatkou-tomcat1
hostnamectl set-hostname kachatkou-tomcat2
hostnamectl set-hostname kachatkou-tomcat3
wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.5.46/bin/apache-tomcat-8.5.46.zip
unzip apache-tomcat-8.5.46.zip 
firewall-cmd --permanent --add-port=8080/tcp
#3
cp /home/clusterjsp.war /usr/local/tomcat/apache-tomcat-8.5.46/webapps/

#Task2
#1

#2
cat << EOF > /etc/httpd/conf/workers.properties
worker.list=kachatkou-tomcat1.lab,kachatkou-tomcat2.lab, kachatkou-tomcat3.lab, kachatkou-cluster.lab
worker.kachatkou-tomcat1.lab.port=8109
worker.kachatkou-tomcat1.lab.host=10.6.144.101
worker.kachatkou-tomcat1.lab.type=ajp13
worker.kachatkou-tomcat1.lab.lbfactor=1
worker.kachatkou-tomcat2.lab.port=8109
worker.kachatkou-tomcat2.lab.host=10.6.144.102
worker.kachatkou-tomcat2.lab.type=ajp13
worker.kachatkou-tomcat2.lab.lbfactor=1
worker.kachatkou-tomcat3.lab.port=8109
worker.kachatkou-tomcat3.lab.host=localhost
worker.kachatkou-tomcat3.lab.type=ajp13
worker.kachatkou-tomcat3.lab.lbfactor=1
worker.kachatkou-cluster.lab.type=lb
worker.kachatkou-cluster.lab.balanced_workers=kachatkou-tomcat1.lab,kachatkou-tomcat2.lab,kachatkou-tomcat3.lab
worker.kachatkou-cluster.lab.sticky_session=1
EOF

cat << EOF > /etc/httpd/conf/workers.conf

LoadModule jk_module /etc/httpd/modules/mod_jk.so

JkWorkersFile /etc/httpd/conf/workers.properties
JkLogFile /var/log/apache2/mod_jk.log
JkLogLevel info
JkLogStampFormat "[%a %b %d %H:%M:%S %Y] "
JkOptions +ForwardKeySize +ForwardURICompat -ForwardDirectories
JkRequestLogFormat "%w %V %T"
EOF

