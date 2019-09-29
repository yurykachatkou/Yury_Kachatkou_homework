Review
Show worker and prefork MPM modules
Show proxy and loadbalancing modules

Task1
1. Configure hybrid multi-process multi-threaded httpd server (i.e., worker). Set server fqdn to worker.name.surname
![Image](/images/2_1.PNG)
 
2. Set MaxRequestWorkers to 50. If necessary, change other module settings accordingly and start httpd server.

3. Show that httpd is using worker module. 
![Image](/images/2_2.PNG)
 
4. Using ab benchmarking tool prove that server can process only 50 simultaneous requests.
![Image](/images/2_3.PNG)
 
5. Show process tree, which includes workers and threads.
![Image](/images/2_4.PNG)
 

6. Stop httpd server and configure non-threaded httpd server (i.e., prefork). Set server fqdn to prefork.name.surname

7. Set MaxRequestWorkers to 25. If necessary, change other module settings accordingly and start httpd server.
![Image](/images/2_5.PNG) 
8. Show that httpd is using prefork module.
![Image](/images/2_6.PNG) 

9. Using ab benchmarking tool prove that server can process only 25 simultaneous requests.
![Image](/images/2_7.PNG) 

10. Show process tree, which includes workers.
![Image](/images/2_8.PNG)
 

Task2
1. Review proxying
2. Review mod_proxy configuration
3. Configure httpd as a forward proxy with authentication. Set proxy fqdn to forward.name.surname
![Image](/images/2_9.PNG)
 
![Image](/images/2_10.PNG) 
4. Grant access to internet via proxy only for user Name_Surname.



![Image](/images/2_11.PNG) 
5. Configure httpd as a reverse proxy to any url of your choice. Set proxy fqdn to reverse.name.surname
![Image](/images/2_12.PNG) 
![Image](/images/2_13.PNG)
 
6. (extra) Configure connection to Tomcat with mod_proxy_ajp, send screenshot with balancer-manager with
authentication.
  
![Image](/images/2_14.PNG)



![Image](/images/2_15.PNG)
![Image](/images/2_16.PNG)
![Image](/images/2_17.PNG)
 

 
 
