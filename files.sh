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
worker.list=kachatkou-tomcat1,kachatkou-tomcat2,kachatkou-tomcat3,kachatkou-cluster
worker.default.port=8009
worker.default.type=ajp13
worker.default.lbfactor=1
worker.kachatkou-tomcat1.host=kachatkou-tomcat1.lab
worker.kachatkou-tomcat2.host=kachatkou-tomcat2.lab
worker.kachatkou-tomcat3.host=kachatkou-tomcat3.lab

worker.kachatkou-cluster.type=lb
worker.kachatkou-cluster.balanced_workers=kachatkou-tomcat1,kachatkou-tomcat2,kachatkou-tomcat3
worker.kachatkou-cluster.sticky_session=1
EOF

cat << EOF > /etc/httpd/conf/workers.conf
LoadModule jk_module modules/mod_jk.so
JkWorkersFile conf/workers.properties
JkLogFile /var/log/httpd/mod_jk.log
JkLogLevel debug
JkMountCopy All
JkMount / kachatkou-cluster
JkMount /* kachatkou-cluster
EOF

cat << EOF > /etc/httpd/conf/vhosts.conf
<VirtualHost *:80>
ServerName kachatkou-tomcat1.lab
JkMount /* kachatkou-tomcat1

</VirtualHost>


<VirtualHost *:80>

ServerName kachatkou-tomcat2.lab
JkMount /* kachatkou-tomcat2

</VirtualHost>

<VirtualHost *:80>

ServerName kachatkou-tomcat3.lab
JkMount /* kachatkou-tomcat3

</VirtualHost>

<VirtualHost *:80>
ServerName kachatkou-cluster.lab
JkMount /* kachatkou-cluster
</VirtualHost>
EOF
