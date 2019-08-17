[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)
[<img src="https://img.shields.io/badge/slack-@0xsp/npp-yellow.svg?logo=slack">](https://0xsp.slack.com/messages/CK3J9QWF2/)
[<img src="https://img.shields.io/badge/build%20with-Lazarus-red.svg">](https://www.lazarus-ide.org/)
[<img src="https://img.shields.io/badge/sponsored%20by-Secploit-green.svg">](https://secploit.com/)
[<img align="right" src="https://i.ibb.co/ss9jyMP/logo-m.png" height="512" width="400">]()

# 0xsp Mongoose Linux / Windows Privilege Escalation intelligent Enumeration Toolkit


using 0xsp mongoose you will be able to scan targeted operating system for any possible way for privilege escalation attacks,starting from 
collecting information stage unitl reporting information through 0xsp Web Application API . 

user will be able to scan  linux / Windows os system at same time with high perfromance , with out spending time looking inside the terminal or text file for what is found , mongoose shorten this way by allowing you to send these information directly into web application friendly interface through easy API endpoint . 

project is divided into two sections `web application ` & `agent [64 / 32] ` . 

`Web Application ` has been coded with PHP(`codeigniter`) you need to install this application into your preffered environment , you can use it online or on your localhost . user is free to choice .

`Agent` has been coded as executable  with `Lazarus Free Pascal`  released with ( 32 , 64 bit) ,
while executing `Agent` on targeted system with all required parameters . user is free to decided whether  willing to communicate with `Web Application API` to store results and explore them easily . or he can also run this tool with out Web Api Connection . Make Sure to Use Correct Executable Arch `64 OR 32 ` depending on Targeted Operation System . 



### Agent Usage 

2. ./agent.exe -h (display help instructions) 

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

### Server Web App (must be like this  : http://host/0xsp/ )

[<img src="https://github.com/lawrenceamer/0xsp-Mongoose/blob/master/Windows%20Agent%20Source%20Code/Screenshot_2019-08-09%20Dashboard.png?raw=true">]()

[<img src="https://github.com/lawrenceamer/0xsp-Mongoose/blob/master/Windows%20Agent%20Source%20Code/Screenshot_2019-08-09%20Scan%20Results.png?raw=true">]()

[<img src="https://github.com/lawrenceamer/0xsp-Mongoose/blob/master/Windows%20Agent%20Source%20Code/Screenshot_2019-08-09%20Scan%20Results(1).png?raw=true">]()

1. make sure to have at least `php 5.6 or above` 
2. requires  `mysql 5.6` 
3. make sure to add Web application on root path `/` with folder name  `0xsp` as  [ http://localhost/0xsp/]  , `Agent` will not connect to it in case not configured correctly . the `agent` will connect only as following case : 
```
./agent {SCAN OPTION} -o localhost -x secretkey
```


### Examples With WebApi  

```
agent.exe -c -o localhost -x 0xsp { enumerate for Senstive Configs files & Private Stuff} 
agent.exe -e -o localhost -x 0xsp { intelligent Exploits Detector Must Match Windows Arch 64 or 32 }
agent.exe -c -o localhost -x 0sxp { will run two scans together and send found results directly }
agent.exe -t filename.zip localhost 0xsp { will upload filename.zip into download center}
agent.exe -m -o 10.10.13.1 -x 0xsp { RUN all Scans together and export it to Web API} 
```

### Examples Without WebApi

```
./agent -c -e -p { this will run 3 scans at the same time with out sending results into Web Api }
```

### Agent Features 

1. High performance , stability , Output results Generated while executing no delays 
2. Ability to execute most of functions with intelligent techniques . 
3. results are being sent to Quick Web API
4. Exception Handling . 
5. inbuilt Json Data set for publicly disclosed Exploits . 
6. Fast As Mongoose , you will be amazed with how fast it is While executing . 

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/lG3HS7a9sVc/0.jpg)](https://www.youtube.com/watch?v=lG3HS7a9sVc)

