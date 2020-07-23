[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)
[<img src="https://img.shields.io/badge/join-telegram-blue">](https://t.me/join0xsp)
[<img src="https://img.shields.io/badge/build%20with-Lazarus-red.svg">](https://www.lazarus-ide.org/)
[<img align="right" src="https://github.com/lawrenceamer/0xsp-Mongoose/blob/0xsp-red/lg.png?raw=true" height="512" width="400">]()
[<img src="https://www.finextra.com/finextra-images/top_pics/xl/twitter.jpg" height="64" width="128">](https://twitter.com/zux0x3a)
# 0xsp Mongoose Red for Winodws 

0xsp mongoose red version released and provided to assist your offensive simulation, beside doing auditing for possible privilege escalation or misconfiguration on windows environment.the newer version has been favored by adding more red teaming techniques, and enhacning the performance and flexiabliity 

with node js support for web application api, it becomes much easier for installtion and customization in timely manner, the windows sensor agent will communicate with application api to transfer results, and recieve commands as bidirectional technique. 

by using windows update api, agent will able to identify the following vulnerabilities :
 
* CVE-2019-0836
* CVE-2019-0841
* CVE-2019-1064
* CVE-2019-1130
* CVE-2019-1253
* CVE-2019-1385
* CVE-2019-1388
* CVE-2019-1405
* CVE-2019-1315
* CVE-2020-0787
* CVE-2020-0796
* CVE-2020-0797 

## Features 

* Lateral movements techniques 
* Bidirectional communication channel
* Plugins online packaging  
* Enhanced exploit detecter scripting engine 
* abusing user access control 


### Usage 
```
-s --Enumerate Active Windows Services , Drivers  ..etc .
-u --Getting information about Users , groups , Roles , Releated information .
-c --Search for Senstive Config files Accessible & Private stuff .
-n --Retrieve Network information,interfaces ...etc .
-w --Enumerate for Writeable Directories , Access Permission Check , Modified Permissions.
-i --Enumerate Windows System information , Sessions , Releated information.
-l --Search in Any File by Specific Keywork , ex : agent.exe -l c:\ password *.config.
-o --Connect to 0xsp Mongoose Web Application API.
-p --Enumerate installed Softwares , Running Processes, Tasks .
-e --Kernel inspection Tool, it will help to search through tool databases for windows kernel vulnerabilities
-x --Secret Key to authorize your connection with WebApp.
-d --Download Files directly into Target Machine .
-t --Upload Files From Target Machine into Mongoose Web Application API. [agent.exe -t filename api secretkey]
-m --Run All Known Scan Types together .
```

```
./agent {SCAN OPTION} -o localhost -x secretkey
```


### export results into node js api   

```
./agent -c -o localhost -x 0xsp { enumerate for CRON Tasks and Transfer results into Web Api} 
./agent -e -o localhost -x 0xsp { intelligent Exploits Detector }
./agent -c -e localhost -x 0sxp { will run two scans together and send found results directly }
./agent -m -o 10.10.13.1 -x 0xsp { RUN all Scans together and export it to Web API} 
```
