[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)
[<img src="https://img.shields.io/badge/slack-@0xsp/npp-yellow.svg?logo=slack">](https://0xsp.slack.com/messages/CK3J9QWF2/)
[<img src="https://img.shields.io/badge/build%20with-Lazarus-red.svg">](https://www.lazarus-ide.org/)
[<img src="https://img.shields.io/badge/sponsored%20by-Secploit-green.svg">](https://secploit.com/)
[<img align="right" src="https://secploit.com/static/0xsp/trans.png" height="512" width="400">]()
[<img src="https://www.finextra.com/finextra-images/top_pics/xl/twitter.jpg" height="64" width="128">](https://twitter.com/zux0x3a)
# 0xsp Mongoose Red for Winodws 

0xsp mongoose red version released and provided to assist your offensive simulation, beside doing auditing for possible privilege escalation or misconfiguration on windows environment.the newer version has been favored by adding more red teaming techniques, and enhacning the performance and flexiabliity 

with node js support for web application api, it becomes much easier for installtion and customization in timely manner, the windows sensor agent will communicate with application api to transfer results, and recieve commands. 



### Windows auditing options [Wiki](https://github.com/lawrenceamer/0xsp-Mongoose/wiki/Mongoose-Windows-Agent-Guide)
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

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/lG3HS7a9sVc/0.jpg)](https://www.youtube.com/watch?v=lG3HS7a9sVc)
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/YRrnXPDVZlg/0.jpg)](https://www.youtube.com/watch?v=YRrnXPDVZlg)
