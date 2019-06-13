[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)
[<img src="https://img.shields.io/badge/slack-@0xsp/npp-yellow.svg?logo=slack">](https://0xsp.slack.com/messages/CK3J9QWF2/)
[<img src="https://img.shields.io/badge/build%20with-Lazarus-red.svg">](https://www.lazarus-ide.org/)
[<img src="https://img.shields.io/badge/sponsored%20by-Secploit-green.svg">](https://secploit.com/)

# 0xsp Mongoose Linux Privilege Escalation intelligent Enumeration Toolkit

using 0xsp mongoose you will be able to scan targeted operating system for any possible way for privilege escalation attacks,starting from 
collecting information stage unitl reporting information through 0xsp Web Application API . 

user will be able to scan different linux os system at same time with high perfromance , with out spending time looking inside the terminal or text file for what is found , mongoos shorten this way by allowing you to send these information directly into web application friendly interface through easy api endpoint . 

project is divided into two sections `server` & `agent` . 

`server` has been coded with PHP(`codignitor`) you need to install this application into your prefered environment , you can use it online or on your localhost . user is free to choice .also contribution to enhace features are most welcomed .

`Agent` has been coded as ELF with `Lazarus Free Pascal` will be released with ( 32 , 64 bit) , the source code of it still not released , but will be in upcoming releasing .
while executing `Agent` on targeted system with all required parameters . user is free to decided wether willing to communicate with `Server App` to store results and explore them easily . or he can also run this tool with out Web Api Connection . 



### Agent Usage 

1. make sure to give it executable permission `chmod +x agent`
2. ./agent -h (display help instructions) 

```
-k --check kernel for common used privilige escalations exploits 
-u --Getting information about Users , groups , releated information 
-c --check cronjobs 
-n --Retrieve Network information,interfaces ...etc
-w --Enumerate for Writeable Files , Dirs , SUID , 
-i --Search for Bash,python,Mysql,Vim..etc History files
-f --search for Senstive config files accessible & private stuff 
-o --connect to 0xsp Web Application 
-p --Show All process By running under Root 
-e --Kernel inspection Tool, it will help to search through tool databases for kernel vulnerabilities 
-x --secret Key to authorize your connection with WebApp API (default is 0xsp) 
-a --Display README 




```

### Server Web App 

1. make sure to have at least `php 5.6 or above` 
2. requires  `mysql 5.6` 
3. make sure to add Web application on root path `/` with folder name  `0xsp` as  [ http://localhost/0xsp/]  , `Agent` will not connect to it in case not configured correctly . the `agent` will connect only as following case : 
```
./agent {SCAN OPTION} -o localhost -x secretkey
```


### Examples With WebApi  

```
./agent -c -o localhost -x 0xsp { enumerate for CRON Tasks and Transfer results into Web Api} 
./agent -e -o localhost -x 0xsp { intelligent Exploits Detector }
./agent -c -e localhost -x 0sxp { will run two scans together and send found results directly }
```

### Examples Without WebApi

```
./agent -c -k -p { this will run 3 scans at the same time with out sending results into Web Api }
```


