{

this unit is part of mongoose privielge escalation enumeration toolkit , all these exploits are being
disclosed and publicly available on exploit-db or different known security sources .

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

@author : Lawrence Amer
@email : security@secploit.com
@zux0x3a

###  Environment
Lazarus 1.8 or above
FPC 3.0.4

}


unit datain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,fpjson, jsonparser,process,core;

procedure vulnerablepackage;
procedure exploitinspection;

implementation
procedure vulnerablepackage;
var
  dat :string;
 cmd,env,command,output,j:string;
 checksys,s,val2,val1,webres:string;
 pa,i,p:integer;
  jData : TJSONData;
  jObject : TJSONObject;
  jArray : TJSONArray;
  SubObj:TJSONObject;
  list : Tstringlist;
  rep : boolean;
  gentoo,deb,ubu,bsd,npm:integer;
  process : Tprocess;
  ptr:pointer;

begin
  list := Tstringlist.Create;
  process := Tprocess.Create(nil);
  process.Options:= [poUsePipes,postderrtooutput];
  process.CommandLine:='cat /proc/version';
  process.Execute;
 // list := Tstringlist.Create;
  try
    list.LoadFromStream(process.Output);
    checksys := list.Text;

  j:=
      '{'+
      '    "database" : ['+
      '        {'+
      '            "val1" : "MiniFtp parseconf_load_setting local-bufferoverflow",'+
      '            "val2" : "miniftp",'+
      '            "val3" : "https://www.exploit-db.com/exploits/46807",'+
      '            "val4" : "2.4.99"'+
      '        },'+
      '        {'+
      '            "val1" : "SystemTap 1.3 - MODPROBE_OPTIONS Privilege Escalation",'+
      '            "val2" : "systemtap",'+
      '            "val3" : "https://www.exploit-db.com/exploits/46730",'+
      '            "val4" : "2.4.20"'+
      '        },'+
      '        {'+
      '            "val1" : "Evince - CBT File Command Injection (Metasploit)",'+
      '            "val2" : "atril",'+
      '            "val3" : "https://www.exploit-db.com/exploits/46341",'+
      '            "val4" : "2.4.20"'+
      '        },'+
      '        {'+
      '            "val1" : "blueman - set_dhcp_handler D-Bus Privilege Escalation (Metasploit)",'+
      '            "val2" : "blueman",'+
      '            "val3" : "https://www.exploit-db.com/exploits/46186",'+
      '            "val4" : "2.4.20"'+
      '        },'+
      '        {'+
      '            "val1" : "xorg-x11-server < 1.20.1 - Local Privilege Escalation",'+
      '            "val2" : "xorg-x11-server",'+
      '            "val3" : "https://www.exploit-db.com/exploits/45832",'+
      '            "val4" : "2.4.20"'+
      '        },'+
      '        {'+
      '            "val1" : "ifwatchd - Privilege Escalation (Metasploit)",'+
      '            "val2" : "ifwatchd",'+
      '            "val3" : "https://www.exploit-db.com/exploits/45575",'+
      '            "val4" : "2.4.20"'+
      '        },'+
      '        {'+
      '            "val1" : "virtualenv 16.0.0 - Sandbox Escape",'+
      '            "val2" : "virtualenv",'+
      '            "val3" : "https://www.exploit-db.com/exploits/45528",'+
      '            "val4" : "2.4.20"'+
      '        },'+
      '        {'+
      '            "val1" : "lightDM (Ubuntu 16.04/16.10) - Guest Account Local Privilege Escalation",'+
      '            "val2" : "lightdm",'+
      '            "val3" : "https://www.exploit-db.com/exploits/41923",'+
      '            "val4" : "2.4.20"'+
      '        }'+
      '    ]'+
      '} ';


     writeln(checksys);
     gentoo :=pos('gentoo',checksys);
     deb := pos('debian',checksys);
     ubu := pos('ubuntu',checksys);
     bsd :=  pos('bsd',checksys);
     npm :=  pos('cent',checksys);
    if (gentoo > 0 ) then
     begin
     cmd := 'cd /var/db/pkg/ && ls -d */*'
      end else if (deb > 0 ) then
       begin
     cmd := 'dpkg -l'
       end else if (ubu > 0)  then begin
     cmd := 'dpkg -l '
       end else if (bsd > 0) then begin
       cmd := 'pkg_info'
       end else if (npm > 0)  then begin
      cmd := 'rpm -qa'
       end;
    RunCommand('/bin/bash',['-c',cmd],command);

     Jdata := GetJson(j);

     s := JData.AsJSON;

     s := JData.FormatJSON;

     JObject := TjsonObject(JData);

     JArray := JObject.Arrays['database'];

     for i := 0 to JArray.Count -1 do
      begin
     SubObj := JArray.Objects[i];
     val2 := JArray.Objects[i].FindPath('val2').AsString;
     val1 := JArray.Objects[i].FindPath('val1').AsString;

     pa := pos(val2,command);
     webres := '[!] this package '+' '+val2+' is vulnerable with '+'[!]' +val1+''; //
     if (pa > 0 ) then begin
           writeln(webres);
         env := sysname;
          dat :=getsysip;

          Postrequest(webres,dat,env,'4');     //this will send output data with host ip , category number : which is 4
         end else

       end;
     finally
       list.free;     // this will handle memory leaks
       process.Free;
        end;
     end;
procedure exploitinspection;
var
jData : TJSONData;
  jObject : TJSONObject;
  jArray : TJSONArray;
  min : String;
  ss :string;
  max:string;
  s:string;
  i:integer;
  res,ref:string;
  j,ip,os:string;
  SubObj:TJSONObject;
begin
   j :=
     '{'+
      '    "datain" : ['+
      '        {'+
      '            "val1" : "2.2.x-2.4.x ptrace kmod local exploit",'+
      '            "val2" : "3",'+
      '            "val3" : "2.2",'+
      '            "val4" : "2.4.99"'+
      '        },'+
      '        {'+
      '            "val1" : "Module Loader Local Root Exploit",'+
      '            "val2" : "12",'+
      '            "val3" : "0",'+
      '            "val4" : "2.4.20"'+
      '        },'+
      '        {'+
      '            "val1" : "mremap() bound checking Root Exploit",'+
      '            "val2" : "145",'+
      '            "val3" : "2.4",'+
      '            "val4" : "2.4.99"'+
      '        },'+
      '        {'+
      '            "val1" : "2.4.29-rc2 uselib() Privilege Elevation",'+
      '            "val2" : "744",'+
      '            "val3" : "0",'+
      '            "val4" : "2.4.29"'+
      '        },'+
      '        {'+
      '            "val1" : "uselib() Privilege Elevation Exploit",'+
      '            "val2" : "778",'+
      '            "val3" : "2.4",'+
      '            "val4" : "2.4"'+
      '        },'+
      '        {'+
      '            "val1" : "2.4.x / 2.6.x uselib() Local Privilege Escalation Exploit",'+
      '            "val2" : "895",'+
      '            "val3" : "2.4",'+
      '            "val4" : "2.6.99"'+
      '        },'+
      '        {'+
      '            "val1" : "2.4/2.6 bluez Local Root Privilege Escalation Exploit",'+
      '            "val2" : "926",'+
      '            "val3" : "2.4",'+
      '            "val4" : "2.6.99"'+
      '        },'+
      '        {'+
      '            "val1" : "2.6.13 <= 2.6.17.4 sys_prctl() Local Root Exploit",'+
      '            "val2" : "2004",'+
      '            "val3" : "2.6.13",'+
      '            "val4" : "2.6.17.4"'+
      '        },'+
      '        {'+
      '            "val1" : "2.6.13 <= 2.6.17.4 sys_prctl() Local Root Exploit (2)",'+
      '            "val2" : "2005",'+
      '            "val3" : "2.6.13",'+
      '            "val4" : "2.6.17.4"'+
      '        },'+
      '        {'+
      '            "val1" : "2.6.13 <= 2.6.17.4 sys_prctl() Local Root Exploit (3)",'+
      '            "val2" : "2006",'+
      '            "val3" : "2.6.13",'+
      '            "val4" : "2.6.17.4"'+
      '        },'+
      '        {'+
      '            "val1" : "2.6.13 <= 2.6.17.4 sys_prctl() Local Root Exploit (4)",'+
      '            "val2" : "2011",'+
      '            "val3" : "2.6.13",'+
      '            "val4" : "2.6.13"'+
      '        },'+
      '        {'+
      '            "val1" : "2.6.17.4 (proc) Local Root Exploit",'+
      '            "val2" : "2013",'+
      '            "val3" : "0",'+
      '            "val4" : "2.6.17.4"'+
      '        },'+
      '        {'+
      '            "val1" : "prctl() Local Root Exploit (logrotate)",'+
      '            "val2" : "2031",'+
      '            "val3" : "2.6.13",'+
      '            "val4" : "2.6.17.4"'+
      '        },'+
      '        {'+
      '            "val1" : "Linux/Kernel 2.4/2.6 x86-64 System Call Emulation Exploit",'+
      '            "val2" : "4460",'+
      '            "val3" : "2.4",'+
      '            "val4" : "2.6"'+
      '        },'+
      '        {'+
      '            "val1" : " 2.6.11.5 BLUETOOTH Stack Local Root Exploit",'+
      '            "val2" : "4756",'+
      '            "val3" : "0",'+
      '            "val4" : "2.6.11.5"'+
      '        },'+
      '        {'+
      '            "val1" : "vmsplice Local Root Exploit",'+
      '            "val2" : "5092",'+
      '            "val3" : "2.6.17",'+
      '            "val4" : "2.6.24.1"'+
      '        },'+
      '        {'+
      '            "val1" : "vmsplice Local Root Exploit",'+
      '            "val2" : "5093",'+
      '            "val3" : "2.6.23",'+
      '            "val4" : "2.6.24"'+
      '        },'+
      '        {'+
      '            "val1" : "ftruncate()/open() Local Exploit",'+
      '            "val2" : "6851",'+
      '            "val3" : "0",'+
      '            "val4" : "2.6.22"'+
      '        },'+
      '        {'+
      '            "val1" : "exit_notify() Local Privilege Escalation Exploit",'+
      '            "val2" : "8369",'+
      '            "val3" : "0",'+
      '            "val4" : "2.6.29"'+
      '        },'+
      '        {'+
      '            "val1" : "UDEV Local Privilege Escalation Exploit",'+
      '            "val2" : "8478",'+
      '            "val3" : "2.6",'+
      '            "val4" : "2.6.99"'+
      '        },'+
      '        {'+
      '            "val1" : "UDEV < 141 Local Privilege Escalation Exploit",'+
      '            "val2" : "8572",'+
      '            "val3" : "2.6",'+
      '            "val4" : "2.6.99"'+
      '        },'+
      '        {'+
      '            "val1" : "ptrace_attach Local Privilege Escalation Exploit",'+
      '            "val2" : "8673",'+
      '            "val3" : "2.6",'+
      '            "val4" : "2.6.99"'+
      '        },'+
      '        {'+
      '            "val1" : "ptrace_attach() Local Root Race Condition Exploit",'+
      '            "val2" : "8678",'+
      '            "val3" : "2.6.29",'+
      '            "val4" : "2.6.29"'+
      '        },'+
      '        {'+
      '            "val1" : "set_selection() UTF-8 Off By One Local Exploit",'+
      '            "val2" : "9083",'+
      '            "val3" : "0",'+
      '            "val4" : "2.6.28.3"'+
      '        },'+
      '        {'+
      '            "val1" : "PulseAudio (setuid) Priv. Escalation Exploit",'+
      '            "val2" : "9208",'+
      '            "val3" : "2.6.9",'+
      '            "val4" : "2.6.30"'+
      '        },'+
      '        {'+
      '            "val1" : "sock_sendpage() Local Ring0 Root Exploit",'+
      '            "val2" : "9435",'+
      '            "val3" : "2",'+
      '            "val4" : "2.99"'+
      '        },'+
      '        {'+
      '            "val1" : "sock_sendpage() Local Ring0 Root Exploit(2)",'+
      '            "val2" : "9436",'+
      '            "val3" : "2",'+
      '            "val4" : "2.99"'+
      '        },'+
      '        {'+
      '            "val1" : "sock_sendpage() ring0 Root Exploit (simple ver)",'+
      '            "val2" : "9479",'+
      '            "val3" : "2.4",'+
      '            "val4" : "2.6.99"'+
      '        },'+
      '        {'+
      '            "val1" : "ip_append_data() ring0 Root Exploit",'+
      '            "val2" : "9542",'+
      '            "val3" : "2.6",'+
      '            "val4" : "2.6.19"'+
      '        },'+
      '        {'+
      '            "val1" : "sock_sendpage() Local Root Exploit (ppc)",'+
      '            "val2" : "9545",'+
      '            "val3" : "2.4",'+
      '            "val4" : "2.6.99"'+
      '        },'+       '        {'+
      '            "val1" : "udp_sendmsg Local Root Exploit (x86/x64)",'+
      '            "val2" : "9574",'+
      '            "val3" : "0",'+
      '            "val4" : "2.6.19"'+
      '        },'+
      '        {'+
      '            "val1" : "udp_sendmsg Local Root Exploit",'+
      '            "val2" : "9575",'+
      '            "val3" : "0",'+
      '            "val4" : "2.6.19"'+
      '        },'+
      '        {'+
      '            "val1" : "sock_sendpage() Local Root Exploit [2]",'+
      '            "val2" : "9598",'+
      '            "val3" : "2.4",'+
      '            "val4" : "2.6.99"'+
      '        },'+
      '        {'+
      '            "val1" : "sock_sendpage() Local Root Exploit [3]",'+
      '            "val2" : "9641",'+
      '            "val3" : "2.4",'+
      '            "val4" : "2.6.99"'+
      '        },'+
      '        {'+
      '            "val1" : "Pipe.c Privelege Escalation",'+
      '            "val2" : "9844",'+
      '            "val3" : "2.4.1",'+
      '            "val4" : "2.6.32"'+
      '        },'+
      '        {'+
      '            "val1" : "Pipe.c Privelege Escalation[2]",'+
      '            "val2" : "10018",'+
      '            "val3" : "2.4.1",'+
      '            "val4" : "2.6.32"'+
      '        },'+
      '        {'+
      '            "val1" : "2009 Local Root Exploit",'+
      '            "val2" : "10613",'+
      '            "val3" : "2.6.18",'+
      '            "val4" : "2.6.20"'+
      '        },'+       '        {'+
      '            "val1" : "ReiserFS xattr Privilege Escalation",'+
      '            "val2" : "12130",'+
      '            "val3" : "0",'+
      '            "val4" : "2.6.34"'+
      '        },'+
      '        {'+
      '            "val1" : "ia32syscall Emulation Privilege Escalation",'+
      '            "val2" : "15023",'+
      '            "val3" : "0",'+
      '            "val4" : "99"'+
      '        },'+
      '        {'+
      '            "val1" : "Linux RDS Protocol Local Privilege Escalation",'+
      '            "val2" : "15285",'+
      '            "val3" : "0",'+
      '            "val4" : "2.6.36"'+
      '        },'+
      '        {'+
      '            "val1" : "2.6.37 Local Privilege Escalation",'+
      '            "val2" : "15704",'+
      '            "val3" : "0",'+
      '            "val4" : "2.6.37"'+
      '        },'+
      '        {'+
      '            "val1" : "ACPI custom_method Privilege Escalation",'+
      '            "val2" : "15774",'+
      '            "val3" : "0",'+
      '            "val4" : "2.6.37"'+
      '        },'+
      '        {'+
      '            "val1" : "CAP_SYS_ADMIN to root Exploit",'+
      '            "val2" : "15916",'+
      '            "val3" : "0",'+
      '            "val4" : "99"'+
      '        },'+
      '        {'+
      '            "val1" : "CAP_SYS_ADMIN to Root Exploit 2 (32 and 64-bit)",'+
      '            "val2" : "15944",'+
      '            "val3" : "0",'+
      '            "val4" : "99"'+
      '        },'+
      '        {'+
      '            "val1" : "Econet Privilege Escalation Exploit",'+
      '            "val2" : "17787",'+
      '            "val3" : "0",'+
      '            "val4" : "2.6.36.2"'+
      '        },'+       '        {'+
      '            "val1" : "Sendpage Local Privilege Escalation",'+
      '            "val2" : "19933",'+
      '            "val3" : "0",'+
      '            "val4" : "99"'+
      '        },'+
      '        {'+
      '            "val1" : "privileged File Descriptor Resource Exhaustion Vulnerability",'+
      '            "val2" : "21598",'+
      '            "val3" : "2.4.18",'+
      '            "val4" : "2.4.19"'+
      '        },'+
      '        {'+
      '            "val1" : "Privileged Process Hijacking Vulnerability (1)",'+
      '            "val2" : "22362",'+
      '            "val3" : "2.2",'+
      '            "val4" : "2.4.99"'+
      '        },'+
      '        {'+
      '            "val1" : "Privileged Process Hijacking Vulnerability (2)",'+
      '            "val2" : "22363",'+
      '            "val3" : "2.2",'+
      '            "val4" : "2.4.99"'+
      '        },'+
      '        {'+
      '            "val1" : "open-time Capability file_ns_capable() - Privilege Escalation Vulnerability",'+
      '            "val2" : "25307",'+
      '            "val3" : "0",'+
      '            "val4" : "99"'+
      '        },'+
      '        {'+
      '            "val1" : "open-time Capability file_ns_capable() Privilege Escalation",'+
      '            "val2" : "25450",'+
      '            "val3" : "0",'+
      '            "val4" : "99"'+
      '        },'+
      '        {'+
      '            "val1" : "Test Kernel Local Root Exploit 0day",'+
      '            "val2" : "9191",'+
      '            "val3" : "2.6.18",'+
      '            "val4" : "2.6.30"'+
      '        },'+
      '        {'+
      '            "val1" : "CVE-2019-11815",'+
      '            "val2" : "PRIVATE",'+
      '            "val3" : "2",'+
      '            "val4" : "5.0.8"'+
      '        },'+
      '        {'+
      '            "val1" : "do_brk() Local Root Exploit ",'+
      '            "val2" : "131",'+
      '            "val3" : "2.4.22",'+
      '            "val4" : "2.4.22"'+
      '        }'+
      '    ]'+
      '}  ';
   RunCommand('/bin/bash',['-c','uname -r'],ss);
   jData := GetJSON(j);
     ip := getsysip;
   os := sysname;
  s := jData.AsJSON;
  s := jData.FormatJSON;
  jObject := TJSONObject(jData);
  jArray := jObject.Arrays['datain'];
  for i := 0 to jArray.Count - 1 do
  begin
    SubObj := jArray.Objects[i];
    min := jArray.Objects[i].FindPath('val3').AsString;
    max := jArray.Objects[i].FindPath('val4').AsString;
    res := jArray.Objects[i].FindPath('val1').AsString;
    ref := JArray.Objects[i].FindPath('val2').AsString;
      if (ss = min) OR (ss < max) then begin
  writeln('[*] May be vulnerable To ','[',res,']','(https://exploit-db.com/exploits/'+ref+')');
  postrequest('[*] May be Vulnerable to [ '+res+' ]'+'(https://exploit-db.com/exploits/'+ref+')',ip,os,'3')
  end else begin
     if ss > max then begin
     //nothing to show !
     end;
    end;
  end;

  end;
end.

