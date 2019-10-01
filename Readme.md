Task 4. Apache Tomcat
Review
Show tomcat LoadBalancing with mod_jk
Show tomcat Clustering with mod_jk

Task

1. Setup apache2 web server VM with mod_jk module.

   	![Image](/images/3_1.png) 

	![Image](/images/3_2.png) 

2. Setup 3 VMs with tomcat server and configure them. Tomcat instances surname-tomcat1, surname-tomcat2, surname-tomcat3

 	![Image](/images/3_3.png) 

	![Image](/images/3_4.png) 

	![Image](/images/3_5.png) 
3. Add test.jsp from presentation to all tomcat servers.

 ![Image](/images/3_6.png)

 ![Image](/images/3_7.png)
 ![Image](/images/3_8.png)


4. Deploy clusterjsp.war on each tomcat:
 
Autodeploy on surname-tomcat1

 ![Image](/images/3_9.png)
Deploy via browse local host on surname-tomcat2
 ![Image](/images/3_10.png)
 ![Image](/images/3_11.png)

Deploy via ContextPath on surname-tomcat3

 ![Image](/images/3_12.png)
  ![Image](/images/3_13.png)
 ![Image](/images/3_14.png)
Task2
1. Using mod_jk configure Tomcat Cluster with session persistence (replication):
a. Configure 4 separate Virtual hosts for surname-tomcat1.lab, surname-tomcat2.lab, surname-tomcat3.lab and Tomcat Cluster – surname-cluster.lab.

	 ![Image](/images/3_15.png)	
b. Configure mod_jk – worker.properties

 ![Image](/images/3_16.png)

c. Setup cluster and check that you can reach clusterjsp app via surname-cluster.lab.
 ![Image](/images/3_17.png)

 ![Image](/images/3_18.png)

 ![Image](/images/3_19.png)

d. Check session persistence by stopping active tomcat server.
 ![Image](/images/3_20.png)


 ![Image](/images/3_21.png)

Task3
1. Configure Log4j2 logging for one of the tomcat servers.
