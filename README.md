[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)
[<img src="https://img.shields.io/badge/join-telegram-blue">](https://t.me/join0xsp)
[<img src="https://img.shields.io/badge/build%20with-Lazarus-red.svg">](https://www.lazarus-ide.org/)
[<img align="right" src="https://github.com/lawrenceamer/0xsp-Mongoose/blob/0xsp-red/lg.png?raw=true" height="512" width="400">]()
[<img src="https://www.finextra.com/finextra-images/top_pics/xl/twitter.jpg" height="64" width="128">](https://twitter.com/zux0x3a)
# 0xsp Mongoose Red for Winodws 

0xsp mongoose red version is provided to assist your needs during cyber security simulation, by using this version you will be able to audit a targeted windows operation system 
for system vulnerabilities, misconfigurations and privilege escalation attacks.

with node js support for web application api, it becomes much easier for installtion and customization in timely manner, the windows sensor agent will communicate with application api to transfer results, and recieve commands as bidirectional technique. 

the agent is able to identify and detect windows exploits by using `windows update api` and `exploit database denfinitions` modules, the new release will detect also the following 
vulnerabilities.
 
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

* web application built with NodeJS 
* supports sqlite DB 
* Lateral movements techniques. 
* Bidirectional communication channel.
* Plugins online packaging.  
* Enhanced exploit detecter scripting engine. 
* weaponization of run-as-user windows api function.
* local network scanning and shares enumeration.
* lsass memory dummping technique (plugin).

### installation 

```
git clone --single-branch --branch 0xsp-red https://github.com/lawrenceamer/0xsp-mongoose
cd 0xsp-mongoose/ 
npm install 
node index.js
```

### quick deploy of agent 


### Usage 
```
-s --retrieve windows services and installed drivers.
-u --retrieve information about Users, groups, roles.
-c --search for senstive config files by extension.
-n --retrieve network information,network interfaces, connection details.
-w --enumerate for writeable directories, access permission Check, modified permissions.
-i --enumerate windows system information, Sessions, log information.
-l --search in any file for specific string , ex : agent.exe -l c:\ password *.config.
-o --specify host address of nodejs application.
-p --enumerate installed Softwares, Running Processes, Tasks .
-e --kernel inspection Tool, it will help to search through tool databases for windows kernel vulnerabilities
-x --password to authorize your connection with node js application.
-d --download Files directly into Target Machine .
-t --upload Files From target machine into node js application.
-m --run all known scan Types together .

-r --spawn a reverse shell with specific account .
-lr --Lateral movement technique using WMI (e.g -lr -host 192.168.14.1 -username administrator -password blabla -srvhost nodejsip )
-nds --network discovery and share enumeration
-cmd --transfer commands via HTTP Shell
-interactive --starting interactive mode (eg : loading plugins ..etc)
-username --identity authentication for specific attack modules.
-password --identity authentication for specific attack modules.
-host --identify remote host to conduct an attack to.
-srvhost --set rhost of node js application.(bidirectional communications).
```

