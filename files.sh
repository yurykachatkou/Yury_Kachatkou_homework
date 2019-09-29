#Task1
#worker

cat << EOF > /etc/httpd/conf.modules.d/10-worker.conf
<IfModule mpm_worker_module>
    ServerLimit              10
    StartServers             2
    MinSpareThreads          10
    MaxSpareThreads          20
    MaxrequestWorkers        50
    ThreadsPerChild          10
</IfModule>
EOF

systemctl restart httpd
ab -n 10000 -c 1000 -t 60 http://worker.yury.kachatkou:80/
pstree apache
#prefork
cat << EOF > /etc/httpd/conf.modules.d/10-prefork.conf
<IfModule mpm_prefork_module>
    StartServers             8
    MinSpareServers          5
    MaxSpareServers          50
    ServerLimit              100
    MaxrequestWorkers        25
    MaxRequestsPerChild      4000
</IfModule>
EOF
ab -n 10000 -c 1000 -t 60 http://prefork.yury.kachatkou:80/
ps aux | grep "apache" | wc -l

#Task2
#forward proxy

 cat << EOF > /etc/httpd/conf.d/proxy.conf
<VirtualHost *>
  ServerName forward.yury.kachatkou
  ProxyRequests On
  ProxyVia On
<Proxy *>
  AuthType Basic
  AuthName "Input Password"
  AuthUserFile /opt/htpasswd
  Require valid-user
  Order deny,allow
  Allow from all
</Proxy>

</VirtualHost>
EOF
htpasswd /opt/htpasswd Yury_Kachatkou

#reverse proxy

cat << EOF > /etc/httpd/conf.d/revproxy.conf
 VirtualHost *>
    ServerAdmin reverse.yury.kachatkou
    ProxyPreserveHost Off
    ProxyPass / http://www.byfly.by/
    ProxyPassReverse / http://www.byfly.by/
</VirtualHost>
EOF

#Tomcat
yum install tomcat -y
yum install tomcat-webapps tomcat-admin-webapps -y
yum install tomcat-docs-webapp tomcat-javadoc -y
systemctl enable tomcat
systemctl start tomcat
cat << EOF > /etc/httpd/conf.d/balancer.conf
 <Location /balancer-manager>
   SetHandler balancer-manager
   AuthType Basic
   AuthName "Balancer Manager"
   AuthUserFile /etc/htpasswd
  Require valid-user
 </Location>
 EOF
cat << EOF > /etc/httpd/conf.d/ajp.conf
<Proxy "balancer://cluster stickysession=JSESSIONID">
    BalancerMember "ajp://127.0.0.1:8009" loadfactor=1
    BalancerMember "ajp://127.0.0.1:8019" loadfactor=2
    ProxySet lbmethod=bytraffic
</Proxy>
ProxyPass / balancer://cluster/
EOF
htpasswd -c /etc/htpasswd Yury_Kachatkou
systemctl restart httpd
