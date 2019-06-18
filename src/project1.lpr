{

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
program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, process, fpjson, jsonparser, Fileutil, StrUtils,
  unix,core, datain;
  { you can add units after this }

type

  { LinuxEnum }

  LinuxEnum = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
    procedure checkkernel; virtual;
    procedure userinfo;virtual;
    procedure banner ;virtual;
    procedure exploiter; virtual;
    procedure dirfile; virtual;
    procedure network;virtual;
    procedure jobinfo;virtual;
    procedure history;virtual;
    procedure configs;virtual;
    procedure processes;virtual;
    procedure readme;virtual;
    procedure ps;virtual;
    //this section is now for docs
    procedure docsexploiter;virtual;
    procedure docshistory;virtual;
    procedure docsdirfile;virtual;
    procedure docsdirtycow;virtual;
    procedure docsconfigs;virtual;
    procedure docsprocesses;virtual;
    procedure docsuserinfo;virtual;
    procedure docsnetwork;virtual;


    //end of it
  end;

{ LinuxEnum }

procedure LinuxEnum.DoRun;
var
  ErrorMsg: String;
  Op:string;
  i:integer;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h k c n w u s i p e f o x a m', 'help kernel cronjobs network Writablefiles userinfo Server history process inspect configs output password readme all');
   Op := checkoptions('k','kernel');
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
  if HasOption('k','kernel') then begin
    checkkernel;
  end;
  if hasoption('i','history') then begin
    history;
  end;
  if hasoption('f','configs') then begin
  configs;
  end;
  if hasoption('a','readme') then begin
  readme;
  terminate;
  exit;
  end;
  if hasoption('e','inspect') then begin
    exploiter;
   //  terminate;
    //exit;
  end;
  if hasoption('p','process') then begin
    processes;
    ps;
    // terminate;
   // exit;

  end;
  if HasOption('c','cronjobs') then begin
    jobinfo;
    // terminate;
    //exit;
  end;
  if HasOption('u','userinfo') then begin
    userinfo;
    // terminate;
    //exit;
  end;
  if HasOption('n','Network') then begin
   network;
    docsnetwork;

  end;
  if HasOption('w','Writablefiles') then begin
      dirfile;
  end;
  if HasOption('m','all') then begin
      userinfo;
      network;
      jobinfo;
      processes;
      ps;
      checkkernel;
      history;
      configs;
      exploiter;
  end;

  { add your program here }
  banner;
  // stop program loop
  Terminate;
end;

constructor LinuxEnum.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor LinuxEnum.Destroy;
begin
  inherited Destroy;
end;

//end;
 // end;
//docs starts here
procedure LinuxEnum.docsuserinfo;
begin

end;
procedure LinuxEnum.docshistory;
begin

end;
procedure LinuxEnum.docsprocesses;
begin

end;

procedure LinuxEnum.docsdirfile;
begin

end;

procedure LinuxEnum.docsconfigs;
begin
  writeln('[+] ref #004 - Sensitive Files attacks - https://0xsp.com');
end;
procedure LinuxEnum.docsdirtycow;
begin
  writeln('[+] ref #005 - Dirty Cow Privilege Escalation Exploit - https://0xsp.com');
end;

procedure LinuxEnum.docsexploiter;
begin
  writeln('[+] ref #003 - Kernel Vulnerability inspectation attacks - https://0xsp.com/ref-003-kernel-vulnerability-inspectation-attacks');
end;

procedure LinuxEnum.docsnetwork;
begin
    writeln('[+] ref #002- Network Enumeration - https://0xsp.com/ref-002-network-enumeration');
end;

//


Procedure LinuxEnum.Banner;
begin
  writeln('================================================='+
  #013#010'[+] 0xsp Mongoose Linux  Escalation Toolkit [V1.6] '#013#010'[+] Coded By : Lawrence Amer(@zux0x3a) '#013#010'[+] Site:https://0xsp.com'#013#010'[+] Arch:x64'+
    #013#010'================================================='
  );

end;


procedure LinuxEnum.ps;
var
  re,cmd,ip,os:string;
  list:Tstringlist;
  process : Tprocess;
begin

ip := getsysip;
os := sysname;
cmd := 'ps aux';
list := Tstringlist.Create;
try
  process := Tprocess.Create(nil);
  process.Options:= [poUsePipes,postderrtooutput];
  process.CommandLine:=cmd;
  process.Execute;
   list.LoadFromStream(process.Output);
   re := list.Text;
   writeln(re);
   postrequest('[*]running process'+re,ip,os,'4');
finally
  process.free;
  list.free;
end;


end;

procedure LinuxEnum.readme;
var
  thanks,footer:string;
begin
    thanks := ' 0xsp Mongoose Linux Privilege Escalation intelligent Tool is Licenced under GNU General Public License v3.0 '+#010+' Oxsp Community Would like to thanks all security contribution provided by the following list :' +#010+
               ''+#010+
               ' Antanas Kedys (Testing Contribution ) '+#010+
               ' Mouhsen Ibrahim (Testing Contribution)'+#010+
               ' Chenny (Testing Contribution) '+#010+
               ' abboud dokarli (Web Application API Developer)';
    footer:='The Project is Powered by Secploit , https://secploit.com/0xsp , https://0xsp.com ';
    writeln(thanks);
    writeln('');
    writeln(footer);
end;

procedure LinuxEnum.processes;
begin
vulnerablepackage;
end;
procedure LinuxEnum.history;
var
  APath,bash,python,mysql,flags,vim,sh,os,ip: String;
  AList,Pathlist,outres: TStringList;
  i,p: Integer;
begin
  AList := TStringList.Create;
  PathList := TstringList.create;
  outres := Tstringlist.create;
   //
     ip :=getsysip;
     os := sysname;
   //
  try
    writeln('[+] Searching for History Files (Bash , Python , SQL , VIM ..etc)');
    pathlist.Add('/root');
    pathlist.add('/etc');
    pathlist.add('/home');
    bash := '.bash_history';
    sh :='.sh_history';
    python := '.python_history';
    mysql :='.mysql_history';
    vim :='.viminfo';
    flags:='root.txt';

    Alist.Add(bash);
    Alist.Add(python);
    Alist.Add(sh);
    Alist.Add(mysql);
    Alist.Add(vim);
    Alist.Add(flags);
    for p:=0 to pathlist.Count -1 do begin
     pathlist[p];
     pathlist.Sorted:=true;
     pathlist.Duplicates:=dupIgnore;

    for i:=0 to Alist.Count -1 do
    begin
  //   Alist[i];
     Alist.Sorted:=true;
     Alist.Duplicates:=dupIgnore;
    FindAllFiles(outres, pathlist[p], Alist[i], True, faDirectory);

     end;
    //this will sort data as expected



    for i := 0 to outres.Count - 1 do  begin


       outres.Sorted:=true;
     outres.Duplicates:=dupIgnore;
      writeln(outres.Strings[i]);

      postRequest(outres.Strings[i],ip,os,'6');        //cat number 6 is for inforamtion collected
    end;

    end;
  finally
    pathlist.free;
    AList.Free;
    outres.free;
  end;
  end;
procedure LinuxEnum.configs;
var
  cfg,conf,cnf,config,ssh,ssh_host_rsa_key,id_dsa,id_rsa,authorized_keys,wp,ip,os: String;
  AList,Pathlist,outres: TStringList;
  i,p: Integer;
begin
  AList := TStringList.Create;
  PathList := TstringList.create;
  outres := Tstringlist.create;

  ip :=getsysip;     //retrieve host ip address for all unix system
  os := sysname;     //retrieve operating system distro os

  try
    writeln('[+] Searching for Potential Config Files & Private Keys ');
    pathlist.Add('/var/');
    pathlist.add('/etc');
    pathlist.Add('~/.ssh/');
    pathlist.Add('/home/');

    cfg := '*.cfg';
    conf:='*.conf';
    cnf :='*.cnf';
    config :='*.config';
    ssh :='*.pub';
    ssh_host_rsa_key:='ssh_host_rsa_key';
    id_dsa:='id_dsa';
    id_rsa :='id_rsa';
    authorized_keys:='authorized_keys';
    wp:='wp-config';
     //end;
    Alist.Add(cfg);
   // Alist.Add(conf);
    Alist.Add(cnf);
    Alist.Add(config);
    Alist.Add(conf);
    Alist.Add(ssh);
    Alist.Add(ssh_host_rsa_key);
    Alist.Add(id_dsa);
    Alist.Add(id_rsa);
    Alist.Add(authorized_keys);
    Alist.Add(wp);

    for p:=0 to pathlist.Count -1 do begin
    pathlist[p];
    pathlist.Sorted:=true;
    pathlist.Duplicates:=dupIgnore;
   // Alist.Add(python);
    for i:=0 to Alist.Count -1 do
    begin
  //   Alist[i];
     Alist.Sorted:=true;
     Alist.Duplicates:=dupIgnore;
    FindAllFiles(outres, pathlist[p], Alist[i], True, faDirectory);
     end;
    //this will sort data as expected

    for i := 0 to outres.Count - 1 do begin
      outres.Sorted:=true;
      outres.Duplicates:=dupIgnore;
      writeln(outres.Strings[i]);
      postRequest(outres.Strings[i],ip,os,'6');         //cat number 6 information collected
    end;

    end;
  finally
    pathlist.free;
    AList.Free;
    outres.free;
  end;
  end;
procedure LinuxEnum.exploiter;
begin
 exploitinspection;          //this will load procedure from datain unit;
end;

procedure LinuxEnum.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');

  Writeln('[!] ------------------------------------------------------------------');
  writeln('-k',' --check kernel for common used priviliges escalations exploits ');
  writeln('-u',' --Getting information about Users , groups , releated information ');
  writeln('-c',' --check cronjobs ');
  writeln('-n',' --Retrieve Network information,interfaces ...etc');
  writeln('-w',' --Enumerate for Writeable Files , Dirs , SUID , ');
  writeln('-i',' --Search for Bash,python,Mysql,Vim..etc History files');
  writeln('-f',' --search for Senstive config files accessible & private stuff ');
  writeln('-o',' --connect to 0xsp Web Application ');
  writeln('-p',' --Show All process By running under Root , Check For vulnerable Packages  ');
  Writeln('-e',' --Kernel inspection Tool, it will help to search through tool databases for kernel vulnerabilities ');
  writeln('-x',' --secret Key to authorize your connection with WebApp ');
  Writeln('-a',' --Display README ');



end;
procedure LinuxEnum.checkkernel;
var
  list:TstringList;
  loc,se :integer;
  vulnerable:widestring;
  vuln:string;
  command,selinux,out1,out2,ip,os:string;
begin
   ip := getsysip;
   os := sysname;


   RunCommand('/bin/bash',['-c','uname -r'],command);
   RunCommand('/bin/bash',['-c','sestatus 2>/dev/null'],selinux);
   out1 := '[+]Kernel Release is  : '+command+'[~] Not vulnerable';
   out2 := '[+]Kernel Release which is  : '+command+'[!]vulnerable To DirtyCow !';
   se :=pos(selinux,'');   //this will check if SE Linux is enabled or not
   if se=0 then begin
     writeln('{*} SELinux is not enabled ');
     end else
     writeln('[!] SELinux is Enabled !');

   vulnerable := '3.1.1-1400-linaro-lt-mx5 3.11.0-13-generic 3.11.0-14-generic 3.11.0-15-generic 3.11.0-17-generic 3.11.0-18-generic 3.11.0-20-generic 3.11.0-22-generic 3.11.0-23-generic 3.11.0-24-generic 3.11.0-26-generic 3.13.0-100-generic 3.13.0-24-generic 3.13.0-27-generic 3.13.0-29-generic 3.13.0-30-generic 3.13.0-32-generic 3.13.0-33-generic 3.13.0-34-generic 3.13.0-35-generic 3.13.0-36-generic 3.13.0-37-generic 3.13.0-39-generic 3.13.0-40-generic 3.13.0-41-generic 3.13.0-43-generic 3.13.0-44-generic 3.13.0-46-generic 3.13.0-48-generic 3.13.0-49-generic 3.13.0-51-generic 3.13.0-52-generic 3.13.0-53-generic 3.13.0-54-generic 3.13.0-55-generic 3.13.0-57-generic 3.13.0-58-generic 3.13.0-59-generic 3.13.0-61-generic 3.13.0-62-generic 3.13.0-63-generic 3.13.0-65-generic 3.13.0-66-generic 3.13.0-67-generic 3.13.0-68-generic 3.13.0-71-generic 3.13.0-73-generic 3.13.0-74-generic 3.13.0-76-generic 3.13.0-77-generic 3.13.0-79-generic 3.13.0-83-generic 3.13.0-85-generic 3.13.0-86-generic 3.13.0-88-generic 3.13.0-91-generic 3.13.0-92-generic 3.13.0-93-generic 3.13.0-95-generic 3.13.0-96-generic 3.13.0-98-generic 3.2.0-101-generic 3.2.0-101-generic-pae 3.2.0-101-virtual 3.2.0-102-generic 3.2.0-102-generic-pae 3.2.0-102-virtual 3.2.0-104-generic 3.2.0-104-generic-pae 3.2.0-104-virtual 3.2.0-105-generic 3.2.0-105-generic-pae 3.2.0-105-virtual 3.2.0-106-generic 3.2.0-106-generic-pae 3.2.0-106-virtual 3.2.0-107-generic 3.2.0-107-generic-pae 3.2.0-107-virtual 3.2.0-109-generic 3.2.0-109-generic-pae 3.2.0-109-virtual 3.2.0-110-generic 3.2.0-110-generic-pae 3.2.0-110-virtual 3.2.0-111-generic 3.2.0-111-generic-pae 3.2.0-111-virtual 3.2.0-1412-omap4 3.2.0-1602-armadaxp 3.2.0-23-generic 3.2.0-23-generic-pae 3.2.0-23-lowlatency 3.2.0-23-lowlatency-pae 3.2.0-23-omap 3.2.0-23-powerpc-smp 3.2.0-23-powerpc64-smp 3.2.0-23-virtual 3.2.0-24-generic 3.2.0-24-generic-pae 3.2.0-24-virtual 3.2.0-25-generic 3.2.0-25-generic-pae 3.2.0-25-virtual 3.2.0-26-generic 3.2.0-26-generic-pae 3.2.0-26-virtual 3.2.0-27-generic 3.2.0-27-generic-pae 3.2.0-27-virtual 3.2.0-29-generic 3.2.0-29-generic-pae 3.2.0-29-virtual 3.2.0-31-generic 3.2.0-31-generic-pae 3.2.0-31-virtual 3.2.0-32-generic 3.2.0-32-generic-pae 3.2.0-32-virtual 3.2.0-33-generic 3.2.0-33-generic-pae 3.2.0-33-lowlatency 3.2.0-33-lowlatency-pae 3.2.0-33-virtual 3.2.0-34-generic 3.2.0-34-generic-pae 3.2.0-34-virtual 3.2.0-35-generic 3.2.0-35-generic-pae 3.2.0-35-lowlatency 3.2.0-35-lowlatency-pae 3.2.0-35-virtual 3.2.0-36-generic 3.2.0-36-generic-pae 3.2.0-36-lowlatency 3.2.0-36-lowlatency-pae 3.2.0-36-virtual 3.2.0-37-generic 3.2.0-37-generic-pae 3.2.0-37-lowlatency 3.2.0-37-lowlatency-pae 3.2.0-37-virtual 3.2.0-38-generic 3.2.0-38-generic-pae 3.2.0-38-lowlatency 3.2.0-38-lowlatency-pae 3.2.0-38-virtual 3.2.0-39-generic 3.2.0-39-generic-pae 3.2.0-39-lowlatency 3.2.0-39-lowlatency-pae 3.2.0-39-virtual 3.2.0-40-generic 3.2.0-40-generic-pae 3.2.0-40-lowlatency 3.2.0-40-lowlatency-pae 3.2.0-40-virtual 3.2.0-41-generic 3.2.0-41-generic-pae 3.2.0-41-lowlatency 3.2.0-41-lowlatency-pae 3.2.0-41-virtual 3.2.0-43-generic 3.2.0-43-generic-pae 3.2.0-43-virtual 3.2.0-44-generic 3.2.0-44-generic-pae 3.2.0-44-lowlatency 3.2.0-44-lowlatency-pae 3.2.0-44-virtual 3.2.0-45-generic 3.2.0-45-generic-pae 3.2.0-45-virtual 3.2.0-48-generic 3.2.0-48-generic-pae 3.2.0-48-lowlatency 3.2.0-48-lowlatency-pae 3.2.0-48-virtual 3.2.0-51-generic 3.2.0-51-generic-pae 3.2.0-51-lowlatency 3.2.0-51-lowlatency-pae 3.2.0-51-virtual 3.2.0-52-generic 3.2.0-52-generic-pae 3.2.0-52-lowlatency 3.2.0-52-lowlatency-pae 3.2.0-52-virtual 3.2.0-53-generic 3.2.0-53-generic-pae 3.2.0-53-lowlatency 3.2.0-53-lowlatency-pae 3.2.0-53-virtual 3.2.0-54-generic 3.2.0-54-generic-pae 3.2.0-54-lowlatency 3.2.0-54-lowlatency-pae 3.2.0-54-virtual 3.2.0-55-generic 3.2.0-55-generic-pae 3.2.0-55-lowlatency 3.2.0-55-lowlatency-pae 3.2.0-55-virtual 3.2.0-56-generic 3.2.0-56-generic-pae 3.2.0-56-lowlatency 3.2.0-56-lowlatency-pae 3.2.0-56-virtual 3.2.0-57-generic 3.2.0-57-generic-pae 3.2.0-57-lowlatency 3.2.0-57-lowlatency-pae 3.2.0-57-virtual 3.2.0-58-generic 3.2.0-58-generic-pae 3.2.0-58-lowlatency 3.2.0-58-lowlatency-pae 3.2.0-58-virtual 3.2.0-59-generic 3.2.0-59-generic-pae 3.2.0-59-lowlatency 3.2.0-59-lowlatency-pae 3.2.0-59-virtual 3.2.0-60-generic 3.2.0-60-generic-pae 3.2.0-60-lowlatency 3.2.0-60-lowlatency-pae 3.2.0-60-virtual 3.2.0-61-generic 3.2.0-61-generic-pae 3.2.0-61-virtual 3.2.0-63-generic 3.2.0-63-generic-pae 3.2.0-63-lowlatency 3.2.0-63-lowlatency-pae 3.2.0-63-virtual 3.2.0-64-generic 3.2.0-64-generic-pae 3.2.0-64-lowlatency 3.2.0-64-lowlatency-pae 3.2.0-64-virtual 3.2.0-65-generic 3.2.0-65-generic-pae 3.2.0-65-lowlatency 3.2.0-65-lowlatency-pae 3.2.0-65-virtual 3.2.0-67-generic 3.2.0-67-generic-pae 3.2.0-67-lowlatency 3.2.0-67-lowlatency-pae 3.2.0-67-virtual 3.2.0-68-generic 3.2.0-68-generic-pae 3.2.0-68-lowlatency 3.2.0-68-lowlatency-pae 3.2.0-68-virtual 3.2.0-69-generic 3.2.0-69-generic-pae 3.2.0-69-lowlatency 3.2.0-69-lowlatency-pae 3.2.0-69-virtual 3.2.0-70-generic 3.2.0-70-generic-pae 3.2.0-70-lowlatency 3.2.0-70-lowlatency-pae 3.2.0-70-virtual 3.2.0-72-generic 3.2.0-72-generic-pae 3.2.0-72-lowlatency 3.2.0-72-lowlatency-pae 3.2.0-72-virtual 3.2.0-73-generic 3.2.0-73-generic-pae 3.2.0-73-lowlatency 3.2.0-73-lowlatency-pae 3.2.0-73-virtual 3.2.0-74-generic 3.2.0-74-generic-pae 3.2.0-74-lowlatency 3.2.0-74-lowlatency-pae 3.2.0-74-virtual 3.2.0-75-generic 3.2.0-75-generic-pae 3.2.0-75-lowlatency 3.2.0-75-lowlatency-pae 3.2.0-75-virtual 3.2.0-76-generic 3.2.0-76-generic-pae 3.2.0-76-lowlatency 3.2.0-76-lowlatency-pae 3.2.0-76-virtual 3.2.0-77-generic 3.2.0-77-generic-pae 3.2.0-77-lowlatency 3.2.0-77-lowlatency-pae 3.2.0-77-virtual 3.2.0-79-generic 3.2.0-79-generic-pae 3.2.0-79-lowlatency 3.2.0-79-lowlatency-pae 3.2.0-79-virtual 3.2.0-80-generic 3.2.0-80-generic-pae 3.2.0-80-lowlatency 3.2.0-80-lowlatency-pae 3.2.0-80-virtual 3.2.0-82-generic 3.2.0-82-generic-pae 3.2.0-82-lowlatency 3.2.0-82-lowlatency-pae 3.2.0-82-virtual 3.2.0-83-generic 3.2.0-83-generic-pae 3.2.0-83-virtual 3.2.0-84-generic 3.2.0-84-generic-pae 3.2.0-84-virtual 3.2.0-85-generic 3.2.0-85-generic-pae 3.2.0-85-virtual 3.2.0-86-generic 3.2.0-86-generic-pae 3.2.0-86-virtual 3.2.0-87-generic 3.2.0-87-generic-pae 3.2.0-87-virtual 3.2.0-88-generic 3.2.0-88-generic-pae 3.2.0-88-virtual 3.2.0-89-generic 3.2.0-89-generic-pae 3.2.0-89-virtual 3.2.0-90-generic 3.2.0-90-generic-pae 3.2.0-90-virtual 3.2.0-91-generic 3.2.0-91-generic-pae 3.2.0-91-virtual 3.2.0-92-generic 3.2.0-92-generic-pae 3.2.0-92-virtual 3.2.0-93-generic 3.2.0-93-generic-pae 3.2.0-93-virtual 3.2.0-94-generic 3.2.0-94-generic-pae 3.2.0-94-virtual 3.2.0-95-generic 3.2.0-95-generic-pae 3.2.0-95-virtual 3.2.0-96-generic 3.2.0-96-generic-pae 3.2.0-96-virtual 3.2.0-97-generic 3.2.0-97-generic-pae 3.2.0-97-virtual 3.2.0-98-generic 3.2.0-98-generic-pae 3.2.0-98-virtual 3.2.0-99-generic 3.2.0-99-generic-pae 3.2.0-99-virtual 3.5.0-40-generic 3.5.0-41-generic 3.5.0-42-generic 3.5.0-43-generic 3.5.0-44-generic 3.5.0-45-generic 3.5.0-46-generic 3.5.0-49-generic 3.5.0-51-generic 3.5.0-52-generic 3.5.0-54-generic 3.8.0-19-generic 3.8.0-21-generic 3.8.0-22-generic 3.8.0-23-generic 3.8.0-27-generic 3.8.0-29-generic 3.8.0-30-generic 3.8.0-31-generic 3.8.0-32-generic 3.8.0-33-generic 3.8.0-34-generic 3.8.0-35-generic 3.8.0-36-generic 3.8.0-37-generic 3.8.0-38-generic 3.8.0-39-generic 3.8.0-41-generic 3.8.0-42-generic 3.13.0-24-generic 3.13.0-24-generic-lpae 3.13.0-24-lowlatency 3.13.0-24-powerpc-e500 3.13.0-24-powerpc-e500mc 3.13.0-24-powerpc-smp 3.13.0-24-powerpc64-emb 3.13.0-24-powerpc64-smp 3.13.0-27-generic 3.13.0-27-lowlatency 3.13.0-29-generic 3.13.0-29-lowlatency 3.13.0-3-exynos5 3.13.0-30-generic 3.13.0-30-lowlatency 3.13.0-32-generic 3.13.0-32-lowlatency 3.13.0-33-generic 3.13.0-33-lowlatency 3.13.0-34-generic 3.13.0-34-lowlatency 3.13.0-35-generic 3.13.0-35-lowlatency 3.13.0-36-generic 3.13.0-36-lowlatency 3.13.0-37-generic 3.13.0-37-lowlatency 3.13.0-39-generic 3.13.0-39-lowlatency 3.13.0-40-generic 3.13.0-40-lowlatency 3.13.0-41-generic 3.13.0-41-lowlatency 3.13.0-43-generic 3.13.0-43-lowlatency 3.13.0-44-generic 3.13.0-44-lowlatency 3.13.0-46-generic 3.13.0-46-lowlatency 3.13.0-48-generic 3.13.0-48-lowlatency 3.13.0-49-generic 3.13.0-49-lowlatency 3.13.0-51-generic 3.13.0-51-lowlatency 3.13.0-52-generic 3.13.0-52-lowlatency 3.13.0-53-generic 3.13.0-53-lowlatency 3.13.0-54-generic 3.13.0-54-lowlatency 3.13.0-55-generic 3.13.0-55-lowlatency 3.13.0-57-generic 3.13.0-57-lowlatency 3.13.0-58-generic 3.13.0-58-lowlatency 3.13.0-59-generic 3.13.0-59-lowlatency 3.13.0-61-generic 3.13.0-61-lowlatency 3.13.0-62-generic 3.13.0-62-lowlatency 3.13.0-63-generic 3.13.0-63-lowlatency 3.13.0-65-generic 3.13.0-65-lowlatency 3.13.0-66-generic 3.13.0-66-lowlatency 3.13.0-67-generic 3.13.0-67-lowlatency 3.13.0-68-generic 3.13.0-68-lowlatency 3.13.0-70-generic 3.13.0-70-lowlatency 3.13.0-71-generic 3.13.0-71-lowlatency 3.13.0-73-generic 3.13.0-73-lowlatency 3.13.0-74-generic 3.13.0-74-lowlatency 3.13.0-76-generic 3.13.0-76-lowlatency 3.13.0-77-generic 3.13.0-77-lowlatency 3.13.0-79-generic 3.13.0-79-lowlatency 3.13.0-83-generic 3.13.0-83-lowlatency 3.13.0-85-generic 3.13.0-85-lowlatency 3.13.0-86-generic 3.13.0-86-lowlatency 3.13.0-87-generic 3.13.0-87-lowlatency 3.13.0-88-generic 3.13.0-88-lowlatency 3.13.0-91-generic 3.13.0-91-lowlatency 3.13.0-92-generic 3.13.0-92-lowlatency 3.13.0-93-generic 3.13.0-93-lowlatency 3.13.0-95-generic 3.13.0-95-lowlatency 3.13.0-96-generic 3.13.0-96-lowlatency 3.13.0-98-generic 3.13.0-98-lowlatency 3.16.0-25-generic 3.16.0-25-lowlatency 3.16.0-26-generic 3.16.0-26-lowlatency 3.16.0-28-generic 3.16.0-28-lowlatency 3.16.0-29-generic 3.16.0-29-lowlatency 3.16.0-31-generic 3.16.0-31-lowlatency 3.16.0-33-generic 3.16.0-33-lowlatency 3.16.0-34-generic 3.16.0-34-lowlatency 3.16.0-36-generic 3.16.0-36-lowlatency 3.16.0-37-generic 3.16.0-37-lowlatency 3.16.0-38-generic 3.16.0-38-lowlatency 3.16.0-39-generic 3.16.0-39-lowlatency 3.16.0-41-generic 3.16.0-41-lowlatency 3.16.0-43-generic 3.16.0-43-lowlatency 3.16.0-44-generic 3.16.0-44-lowlatency 3.16.0-45-generic 3.16.0-45-lowlatency 3.16.0-46-generic 3.16.0-46-lowlatency 3.16.0-48-generic 3.16.0-48-lowlatency 3.16.0-49-generic 3.16.0-49-lowlatency 3.16.0-50-generic 3.16.0-50-lowlatency 3.16.0-51-generic 3.16.0-51-lowlatency 3.16.0-52-generic 3.16.0-52-lowlatency 3.16.0-53-generic 3.16.0-53-lowlatency 3.16.0-55-generic 3.16.0-55-lowlatency 3.16.0-56-generic 3.16.0-56-lowlatency 3.16.0-57-generic 3.16.0-57-lowlatency 3.16.0-59-generic 3.16.0-59-lowlatency 3.16.0-60-generic 3.16.0-60-lowlatency 3.16.0-62-generic 3.16.0-62-lowlatency 3.16.0-67-generic 3.16.0-67-lowlatency 3.16.0-69-generic 3.16.0-69-lowlatency 3.16.0-70-generic 3.16.0-70-lowlatency 3.16.0-71-generic 3.16.0-71-lowlatency 3.16.0-73-generic 3.16.0-73-lowlatency 3.16.0-76-generic 3.16.0-76-lowlatency 3.16.0-77-generic 3.16.0-77-lowlatency 3.19.0-20-generic 3.19.0-20-lowlatency 3.19.0-21-generic 3.19.0-21-lowlatency 3.19.0-22-generic 3.19.0-22-lowlatency 3.19.0-23-generic 3.19.0-23-lowlatency 3.19.0-25-generic 3.19.0-25-lowlatency 3.19.0-26-generic 3.19.0-26-lowlatency 3.19.0-28-generic 3.19.0-28-lowlatency 3.19.0-30-generic 3.19.0-30-lowlatency 3.19.0-31-generic 3.19.0-31-lowlatency 3.19.0-32-generic 3.19.0-32-lowlatency 3.19.0-33-generic 3.19.0-33-lowlatency 3.19.0-37-generic 3.19.0-37-lowlatency 3.19.0-39-generic 3.19.0-39-lowlatency 3.19.0-41-generic 3.19.0-41-lowlatency 3.19.0-42-generic 3.19.0-42-lowlatency 3.19.0-43-generic 3.19.0-43-lowlatency 3.19.0-47-generic 3.19.0-47-lowlatency 3.19.0-49-generic 3.19.0-49-lowlatency 3.19.0-51-generic 3.19.0-51-lowlatency 3.19.0-56-generic 3.19.0-56-lowlatency 3.19.0-58-generic 3.19.0-58-lowlatency 3.19.0-59-generic 3.19.0-59-lowlatency 3.19.0-61-generic 3.19.0-61-lowlatency 3.19.0-64-generic 3.19.0-64-lowlatency 3.19.0-65-generic 3.19.0-65-lowlatency 3.19.0-66-generic 3.19.0-66-lowlatency 3.19.0-68-generic 3.19.0-68-lowlatency 3.19.0-69-generic 3.19.0-69-lowlatency 3.19.0-71-generic 3.19.0-71-lowlatency 3.4.0-5-chromebook 4.2.0-18-generic 4.2.0-18-lowlatency 4.2.0-19-generic 4.2.0-19-lowlatency 4.2.0-21-generic 4.2.0-21-lowlatency 4.2.0-22-generic 4.2.0-22-lowlatency 4.2.0-23-generic 4.2.0-23-lowlatency 4.2.0-25-generic 4.2.0-25-lowlatency 4.2.0-27-generic 4.2.0-27-lowlatency 4.2.0-30-generic 4.2.0-30-lowlatency 4.2.0-34-generic 4.2.0-34-lowlatency 4.2.0-35-generic 4.2.0-35-lowlatency 4.2.0-36-generic 4.2.0-36-lowlatency 4.2.0-38-generic 4.2.0-38-lowlatency 4.2.0-41-generic 4.2.0-41-lowlatency 4.4.0-21-generic 4.4.0-21-lowlatency 4.4.0-22-generic 4.4.0-22-lowlatency 4.4.0-24-generic 4.4.0-24-lowlatency 4.4.0-28-generic 4.4.0-28-lowlatency 4.4.0-31-generic 4.4.0-31-lowlatency 4.4.0-34-generic 4.4.0-34-lowlatency 4.4.0-36-generic 4.4.0-36-lowlatency 4.4.0-38-generic 4.4.0-38-lowlatency 4.4.0-42-generic 4.4.0-42-lowlatency 4.4.0-1009-raspi2 4.4.0-1012-snapdragon 4.4.0-21-generic 4.4.0-21-generic-lpae 4.4.0-21-lowlatency 4.4.0-21-powerpc-e500mc 4.4.0-21-powerpc-smp 4.4.0-21-powerpc64-emb 4.4.0-21-powerpc64-smp 4.4.0-22-generic 4.4.0-22-lowlatency 4.4.0-24-generic 4.4.0-24-lowlatency 4.4.0-28-generic 4.4.0-28-lowlatency 4.4.0-31-generic 4.4.0-31-lowlatency 4.4.0-34-generic 4.4.0-34-lowlatency 4.4.0-36-generic 4.4.0-36-lowlatency 4.4.0-38-generic 4.4.0-38-lowlatency 4.4.0-42-generic 4.4.0-42-lowlatency 2.6.18-8.1.1.el5 2.6.18-8.1.3.el5 2.6.18-8.1.4.el5 2.6.18-8.1.6.el5 2.6.18-8.1.8.el5 2.6.18-8.1.10.el5 2.6.18-8.1.14.el5 2.6.18-8.1.15.el5 2.6.18-53.el5 2.6.18-53.1.4.el5 2.6.18-53.1.6.el5 2.6.18-53.1.13.el5 2.6.18-53.1.14.el5 2.6.18-53.1.19.el5 2.6.18-53.1.21.el5 2.6.18-92.el5 2.6.18-92.1.1.el5 2.6.18-92.1.6.el5 2.6.18-92.1.10.el5 2.6.18-92.1.13.el5 2.6.18-92.1.18.el5 2.6.18-92.1.22.el5 2.6.18-92.1.24.el5 2.6.18-92.1.26.el5 2.6.18-92.1.27.el5 2.6.18-92.1.28.el5 2.6.18-92.1.29.el5 2.6.18-92.1.32.el5 2.6.18-92.1.35.el5 2.6.18-92.1.38.el5 2.6.18-128.el5 2.6.18-128.1.1.el5 2.6.18-128.1.6.el5 2.6.18-128.1.10.el5 2.6.18-128.1.14.el5 2.6.18-128.1.16.el5 2.6.18-128.2.1.el5 2.6.18-128.4.1.el5 2.6.18-128.4.1.el5 2.6.18-128.7.1.el5 2.6.18-128.8.1.el5 2.6.18-128.11.1.el5 2.6.18-128.12.1.el5 2.6.18-128.14.1.el5 2.6.18-128.16.1.el5 2.6.18-128.17.1.el5 2.6.18-128.18.1.el5 2.6.18-128.23.1.el5 2.6.18-128.23.2.el5 2.6.18-128.25.1.el5 2.6.18-128.26.1.el5 2.6.18-128.27.1.el5 2.6.18-128.29.1.el5 2.6.18-128.30.1.el5 2.6.18-128.31.1.el5 2.6.18-128.32.1.el5 2.6.18-128.35.1.el5 2.6.18-128.36.1.el5 2.6.18-128.37.1.el5 2.6.18-128.38.1.el5 2.6.18-128.39.1.el5 2.6.18-128.40.1.el5 2.6.18-128.41.1.el5 2.6.18-164.el5 2.6.18-164.2.1.el5 2.6.18-164.6.1.el5 2.6.18-164.9.1.el5 2.6.18-164.10.1.el5 2.6.18-164.11.1.el5 2.6.18-164.15.1.el5 2.6.18-164.17.1.el5 2.6.18-164.19.1.el5 2.6.18-164.21.1.el5 2.6.18-164.25.1.el5 2.6.18-164.25.2.el5 2.6.18-164.28.1.el5 2.6.18-164.30.1.el5 2.6.18-164.32.1.el5 2.6.18-164.34.1.el5 2.6.18-164.36.1.el5 2.6.18-164.37.1.el5 2.6.18-164.38.1.el5 2.6.18-194.el5 2.6.18-194.3.1.el5 2.6.18-194.8.1.el5 2.6.18-194.11.1.el5 2.6.18-194.11.3.el5 2.6.18-194.11.4.el5 2.6.18-194.17.1.el5 2.6.18-194.17.4.el5 2.6.18-194.26.1.el5 2.6.18-194.32.1.el5 2.6.18-238.el5 2.6.18-238.1.1.el5 2.6.18-238.5.1.el5 2.6.18-238.9.1.el5 2.6.18-238.12.1.el5 2.6.18-238.19.1.el5 2.6.18-238.21.1.el5 2.6.18-238.27.1.el5 2.6.18-238.28.1.el5 2.6.18-238.31.1.el5 2.6.18-238.33.1.el5 2.6.18-238.35.1.el5 2.6.18-238.37.1.el5 2.6.18-238.39.1.el5 2.6.18-238.40.1.el5 2.6.18-238.44.1.el5 2.6.18-238.45.1.el5 2.6.18-238.47.1.el5 2.6.18-238.48.1.el5 2.6.18-238.49.1.el5 2.6.18-238.50.1.el5 2.6.18-238.51.1.el5 2.6.18-238.52.1.el5 2.6.18-238.53.1.el5 2.6.18-238.54.1.el5 2.6.18-238.55.1.el5 2.6.18-238.56.1.el5 2.6.18-274.el5 2.6.18-274.3.1.el5 2.6.18-274.7.1.el5 2.6.18-274.12.1.el5 2.6.18-274.17.1.el5 2.6.18-274.18.1.el5 2.6.18-308.el5 2.6.18-308.1.1.el5 2.6.18-308.4.1.el5 2.6.18-308.8.1.el5 2.6.18-308.8.2.el5 2.6.18-308.11.1.el5 2.6.18-308.13.1.el5 2.6.18-308.16.1.el5 2.6.18-308.20.1.el5 2.6.18-308.24.1.el5 2.6.18-348.el5 2.6.18-348.1.1.el5 2.6.18-348.2.1.el5 2.6.18-348.3.1.el5 2.6.18-348.4.1.el5 2.6.18-348.6.1.el5 2.6.18-348.12.1.el5 2.6.18-348.16.1.el5 2.6.18-348.18.1.el5 2.6.18-348.19.1.el5 2.6.18-348.21.1.el5 2.6.18-348.22.1.el5 2.6.18-348.23.1.el5 2.6.18-348.25.1.el5 2.6.18-348.27.1.el5 2.6.18-348.28.1.el5 2.6.18-348.29.1.el5 2.6.18-348.30.1.el5 2.6.18-348.31.2.el5 2.6.18-371.el5 2.6.18-371.1.2.el5 2.6.18-371.3.1.el5 2.6.18-371.4.1.el5 2.6.18-371.6.1.el5 2.6.18-371.8.1.el5 2.6.18-371.9.1.el5 2.6.18-371.11.1.el5 2.6.18-371.12.1.el5 2.6.18-398.el5 2.6.18-400.el5 2.6.18-400.1.1.el5 2.6.18-402.el5 2.6.18-404.el5 2.6.18-406.el5 2.6.18-407.el5 2.6.18-408.el5 2.6.18-409.el5 2.6.18-410.el5 2.6.18-411.el5 2.6.18-412.el5 2.6.32-71.7.1.el6 2.6.32-71.14.1.el6 2.6.32-71.18.1.el6 2.6.32-71.18.2.el6 2.6.32-71.24.1.el6 2.6.32-71.29.1.el6 2.6.32-71.31.1.el6 2.6.32-71.34.1.el6 2.6.32-71.35.1.el6 2.6.32-71.36.1.el6 2.6.32-71.37.1.el6 2.6.32-71.38.1.el6 2.6.32-71.39.1.el6 2.6.32-71.40.1.el6 2.6.32-131.0.15.el6 2.6.32-131.2.1.el6 2.6.32-131.4.1.el6 2.6.32-131.6.1.el6 2.6.32-131.12.1.el6 2.6.32-131.17.1.el6 2.6.32-131.21.1.el6 2.6.32-131.22.1.el6 2.6.32-131.25.1.el6 2.6.32-131.26.1.el6 2.6.32-131.28.1.el6 2.6.32-131.29.1.el6 2.6.32-131.30.1.el6 2.6.32-131.30.2.el6 2.6.32-131.33.1.el6 2.6.32-131.35.1.el6 2.6.32-131.36.1.el6 2.6.32-131.37.1.el6 2.6.32-131.38.1.el6 2.6.32-131.39.1.el6 2.6.32-220.el6 2.6.32-220.2.1.el6 2.6.32-220.4.1.el6 2.6.32-220.4.2.el6 2.6.32-220.4.7.bgq.el6 2.6.32-220.7.1.el6 2.6.32-220.7.3.p7ih.el6 2.6.32-220.7.4.p7ih.el6 2.6.32-220.7.6.p7ih.el6 2.6.32-220.7.7.p7ih.el6 2.6.32-220.13.1.el6 2.6.32-220.17.1.el6 2.6.32-220.23.1.el6 2.6.32-220.24.1.el6 2.6.32-220.25.1.el6 2.6.32-220.26.1.el6 2.6.32-220.28.1.el6 2.6.32-220.30.1.el6 2.6.32-220.31.1.el6 2.6.32-220.32.1.el6 2.6.32-220.34.1.el6 2.6.32-220.34.2.el6 2.6.32-220.38.1.el6 2.6.32-220.39.1.el6 2.6.32-220.41.1.el6 2.6.32-220.42.1.el6 2.6.32-220.45.1.el6 2.6.32-220.46.1.el6 2.6.32-220.48.1.el6 2.6.32-220.51.1.el6 2.6.32-220.52.1.el6 2.6.32-220.53.1.el6 2.6.32-220.54.1.el6 2.6.32-220.55.1.el6 2.6.32-220.56.1.el6 2.6.32-220.57.1.el6 2.6.32-220.58.1.el6 2.6.32-220.60.2.el6 2.6.32-220.62.1.el6 2.6.32-220.63.2.el6 2.6.32-220.64.1.el6 2.6.32-220.65.1.el6 2.6.32-220.66.1.el6 2.6.32-220.67.1.el6 2.6.32-279.el6 2.6.32-279.1.1.el6 2.6.32-279.2.1.el6 2.6.32-279.5.1.el6 2.6.32-279.5.2.el6 2.6.32-279.9.1.el6 2.6.32-279.11.1.el6 2.6.32-279.14.1.bgq.el6 2.6.32-279.14.1.el6 2.6.32-279.19.1.el6 2.6.32-279.22.1.el6 2.6.32-279.23.1.el6 2.6.32-279.25.1.el6 2.6.32-279.25.2.el6 2.6.32-279.31.1.el6 2.6.32-279.33.1.el6 2.6.32-279.34.1.el6 2.6.32-279.37.2.el6 2.6.32-279.39.1.el6 2.6.32-279.41.1.el6 2.6.32-279.42.1.el6 2.6.32-279.43.1.el6 2.6.32-279.43.2.el6 2.6.32-279.46.1.el6 2.6.32-358.el6 2.6.32-358.0.1.el6 2.6.32-358.2.1.el6 2.6.32-358.6.1.el6 2.6.32-358.6.2.el6 2.6.32-358.6.3.p7ih.el6 2.6.32-358.11.1.bgq.el6 2.6.32-358.11.1.el6 2.6.32-358.14.1.el6 2.6.32-358.18.1.el6 2.6.32-358.23.2.el6 2.6.32-358.28.1.el6 2.6.32-358.32.3.el6 2.6.32-358.37.1.el6 2.6.32-358.41.1.el6 2.6.32-358.44.1.el6 2.6.32-358.46.1.el6 2.6.32-358.46.2.el6 2.6.32-358.48.1.el6 2.6.32-358.49.1.el6 2.6.32-358.51.1.el6 2.6.32-358.51.2.el6 2.6.32-358.55.1.el6 2.6.32-358.56.1.el6 2.6.32-358.59.1.el6 2.6.32-358.61.1.el6 2.6.32-358.62.1.el6 2.6.32-358.65.1.el6 2.6.32-358.67.1.el6 2.6.32-358.68.1.el6 2.6.32-358.69.1.el6 2.6.32-358.70.1.el6 2.6.32-358.71.1.el6 2.6.32-358.72.1.el6 2.6.32-358.73.1.el6 2.6.32-358.111.1.openstack.el6 2.6.32-358.114.1.openstack.el6 2.6.32-358.118.1.openstack.el6 2.6.32-358.123.4.openstack.el6 2.6.32-431.el6 2.6.32-431.1.1.bgq.el6 2.6.32-431.1.2.el6 2.6.32-431.3.1.el6 2.6.32-431.5.1.el6 2.6.32-431.11.2.el6 2.6.32-431.17.1.el6 2.6.32-431.20.3.el6 2.6.32-431.20.5.el6 2.6.32-431.23.3.el6 2.6.32-431.29.2.el6 2.6.32-431.37.1.el6 2.6.32-431.40.1.el6 2.6.32-431.40.2.el6 2.6.32-431.46.2.el6 2.6.32-431.50.1.el6 2.6.32-431.53.2.el6 2.6.32-431.56.1.el6 2.6.32-431.59.1.el6 2.6.32-431.61.2.el6 2.6.32-431.64.1.el6 2.6.32-431.66.1.el6 2.6.32-431.68.1.el6 2.6.32-431.69.1.el6 2.6.32-431.70.1.el6 2.6.32-431.71.1.el6 2.6.32-431.72.1.el6 2.6.32-431.73.2.el6 2.6.32-431.74.1.el6 2.6.32-504.el6 2.6.32-504.1.3.el6 2.6.32-504.3.3.el6 2.6.32-504.8.1.el6 2.6.32-504.8.2.bgq.el6 2.6.32-504.12.2.el6 2.6.32-504.16.2.el6 2.6.32-504.23.4.el6 2.6.32-504.30.3.el6 2.6.32-504.30.5.p7ih.el6 2.6.32-504.33.2.el6 2.6.32-504.36.1.el6 2.6.32-504.38.1.el6 2.6.32-504.40.1.el6 2.6.32-504.43.1.el6 2.6.32-504.46.1.el6 2.6.32-504.49.1.el6 2.6.32-504.50.1.el6 2.6.32-504.51.1.el6 2.6.32-504.52.1.el6 2.6.32-573.el6 2.6.32-573.1.1.el6 2.6.32-573.3.1.el6 2.6.32-573.4.2.bgq.el6 2.6.32-573.7.1.el6 2.6.32-573.8.1.el6 2.6.32-573.12.1.el6 2.6.32-573.18.1.el6 2.6.32-573.22.1.el6 2.6.32-573.26.1.el6 2.6.32-573.30.1.el6 2.6.32-573.32.1.el6 2.6.32-573.34.1.el6 2.6.32-642.el6 2.6.32-642.1.1.el6 2.6.32-642.3.1.el6 2.6.32-642.4.2.el6 2.6.32-642.6.1.el6 3.10.0-123.el7 3.10.0-123.1.2.el7 3.10.0-123.4.2.el7 3.10.0-123.4.4.el7 3.10.0-123.6.3.el7 3.10.0-123.8.1.el7 3.10.0-123.9.2.el7 3.10.0-123.9.3.el7 3.10.0-123.13.1.el7 3.10.0-123.13.2.el7 3.10.0-123.20.1.el7 3.10.0-229.el7 3.10.0-229.1.2.el7 3.10.0-229.4.2.el7 3.10.0-229.7.2.el7 3.10.0-229.11.1.el7 3.10.0-229.14.1.el7 3.10.0-229.20.1.el7 3.10.0-229.24.2.el7 3.10.0-229.26.2.el7 3.10.0-229.28.1.el7 3.10.0-229.30.1.el7 3.10.0-229.34.1.el7 3.10.0-229.38.1.el7 3.10.0-229.40.1.el7 3.10.0-229.42.1.el7 3.10.0-327.el7 3.10.0-327.3.1.el7 3.10.0-327.4.4.el7 3.10.0-327.4.5.el7 3.10.0-327.10.1.el7 3.10.0-327.13.1.el7 3.10.0-327.18.2.el7 3.10.0-327.22.2.el7 3.10.0-327.28.2.el7 3.10.0-327.28.3.el7 3.10.0-327.36.1.el7 3.10.0-327.36.2.el7 3.10.0-229.1.2.ael7b 3.10.0-229.4.2.ael7b 3.10.0-229.7.2.ael7b 3.10.0-229.11.1.ael7b 3.10.0-229.14.1.ael7b 3.10.0-229.20.1.ael7b 3.10.0-229.24.2.ael7b 3.10.0-229.26.2.ael7b 3.10.0-229.28.1.ael7b 3.10.0-229.30.1.ael7b 3.10.0-229.34.1.ael7b 3.10.0-229.38.1.ael7b 3.10.0-229.40.1.ael7b 3.10.0-229.42.1.ael7b 4.2.0-0.21.el7 2.6.24.7-74.el5rt 2.6.24.7-81.el5rt 2.6.24.7-93.el5rt 2.6.24.7-101.el5rt 2.6.24.7-108.el5rt 2.6.24.7-111.el5rt 2.6.24.7-117.el5rt 2.6.24.7-126.el5rt 2.6.24.7-132.el5rt 2.6.24.7-137.el5rt 2.6.24.7-139.el5rt 2.6.24.7-146.el5rt 2.6.24.7-149.el5rt 2.6.24.7-161.el5rt 2.6.24.7-169.el5rt 2.6.33.7-rt29.45.el5rt 2.6.33.7-rt29.47.el5rt 2.6.33.7-rt29.55.el5rt 2.6.33.9-rt31.64.el5rt 2.6.33.9-rt31.67.el5rt 2.6.33.9-rt31.86.el5rt 2.6.33.9-rt31.66.el6rt 2.6.33.9-rt31.74.el6rt 2.6.33.9-rt31.75.el6rt 2.6.33.9-rt31.79.el6rt 3.0.9-rt26.45.el6rt 3.0.9-rt26.46.el6rt 3.0.18-rt34.53.el6rt 3.0.25-rt44.57.el6rt 3.0.30-rt50.62.el6rt 3.0.36-rt57.66.el6rt 3.2.23-rt37.56.el6rt 3.2.33-rt50.66.el6rt 3.6.11-rt28.20.el6rt 3.6.11-rt30.25.el6rt 3.6.11.2-rt33.39.el6rt 3.6.11.5-rt37.55.el6rt 3.8.13-rt14.20.el6rt 3.8.13-rt14.25.el6rt 3.8.13-rt27.33.el6rt 3.8.13-rt27.34.el6rt 3.8.13-rt27.40.el6rt 3.10.0-229.rt56.144.el6rt 3.10.0-229.rt56.147.el6rt 3.10.0-229.rt56.149.el6rt 3.10.0-229.rt56.151.el6rt 3.10.0-229.rt56.153.el6rt 3.10.0-229.rt56.158.el6rt 3.10.0-229.rt56.161.el6rt 3.10.0-229.rt56.162.el6rt 3.10.0-327.rt56.170.el6rt 3.10.0-327.rt56.171.el6rt 3.10.0-327.rt56.176.el6rt 3.10.0-327.rt56.183.el6rt 3.10.0-327.rt56.190.el6rt 3.10.0-327.rt56.194.el6rt 3.10.0-327.rt56.195.el6rt 3.10.0-327.rt56.197.el6rt 3.10.33-rt32.33.el6rt 3.10.33-rt32.34.el6rt 3.10.33-rt32.43.el6rt 3.10.33-rt32.45.el6rt 3.10.33-rt32.51.el6rt 3.10.33-rt32.52.el6rt 3.10.58-rt62.58.el6rt 3.10.58-rt62.60.el6rt 3.10.0-229.rt56.141.el7 3.10.0-229.1.2.rt56.141.2.el7_1 3.10.0-229.4.2.rt56.141.6.el7_1 3.10.0-229.7.2.rt56.141.6.el7_1 3.10.0-229.11.1.rt56.141.11.el7_1 3.10.0-229.14.1.rt56.141.13.el7_1 3.10.0-229.20.1.rt56.141.14.el7_1 3.10.0-229.rt56.141.el7 3.10.0-327.rt56.204.el7 3.10.0-327.4.5.rt56.206.el7_2 3.10.0-327.10.1.rt56.211.el7_2 3.10.0-327.13.1.rt56.216.el7_2 3.10.0-327.18.2.rt56.223.el7_2 3.10.0-327.22.2.rt56.230.el7_2 3.10.0-327.28.2.rt56.234.el7_2 3.10.0-327.28.3.rt56.235.el7 3.10.0-327.36.1.rt56.237.el7';
   list := Tstringlist.Create;
   list.Text:=vulnerable;
   loc :=pos(command,list.Text);
   //to chech if kernal is vulnerable
   if loc=0 then begin
     writeln(out1);
    PostRequest(out1,ip,os,'1')
     end else begin
     writeln(out2);
    postRequest(out2,ip,os,'1');
   end;
     list.Free;
end;

procedure LinuxEnum.Dirfile;
var
        list:Tstringlist;
        list2:Tstringlist;
        i :integer;
        process:Tprocess;
        WWDIRSROOT:string;
        WWDIRS:string;
        WWFILES:string;
        SUID:string;
        outp:string;
        ROOT:string;
        os,ip:string;
begin
   ip:=getsysip;
   os:=sysname;

  ROOT := 'ls -ahlR /root';
  SUID := 'find / \( -perm -2000 -o -perm -4000 \) -exec ls -ld {} \;';
  WWDIRSROOT:='find / \( -wholename'+
  ''+' ''/home/homedir*'' '+
  ''+' -prune \) -o \( -type d -perm -0002 \) -exec ls -ld'+
  ' '+'{}'+
  ''+' '';'' '+'| grep root';
   WWDIRS :='find / \( -wholename'+
  ''+' ''/home/homedir*'' '+
  ''+' -prune \) -o \( -type d -perm -0002 \) -exec ls -ld'+
  ' '+'{}'+
  ''+' '';'' '+'| grep -v root';
   WWFILES :='find / \( -wholename'+
  ''+' ''/home/homedir*'' '+
  ''+' -prune -o -wholename ''/proc/*'' -prune \) -o \( -type d -perm -0002 \) -exec ls -ld'+
  ' '+'{}'+
  ''+' '';'' ';
     Writeln(' (*) Please Wait .....  ');
     RunCommand('/bin/bash',['-c',WWDIRSROOT],outp);
     writeln('[*] ======== World Writeable Directories for User/Group =====');
     writeln(outp);
     postrequest('[*] Writeable Directories for User/Group '+outp,ip,os,'8');
     writeln('[~] ===============World Writeable Directories for Users other than Root==================');
     RunCommand('/bin/bash',['-c',WWDIRS],outp);
     writeln(outp);
     postrequest('Writeable Directories for Users other than Root '+outp,ip,os,'8');
     writeln('[+] =============World Writable Files=============');
     RunCommand('/bin/bash',['-c',WWFILES],outp);
     writeln(outp);
     postrequest('[*] Writeable Files '+outp,ip,os,'8');
     writeln('[+] ============ SUID =========');
     RunCommand('/bin/bash',['-c',SUID],outp);
     writeln(outp);
     postrequest('[*] SUID '+outp,ip,os,'8');
     writeln('[+] ============ Check if ROOT Folder is Accessible  =========');
       RunCommand('/bin/bash',['-c',ROOT],outp);
     writeln(outp);
     postrequest('[*] Check if Root Folder is Accessible ! '+outp,ip,os,'8');
end;

procedure LinuxEnum.jobinfo;          //cat 2
var
 process: Tprocess;
 list: Tstringlist;
 listout: Tstringlist;
 i : integer;
 cronjob,owncron,cron,crontab,anacron,acron,ip,os:string;
 loc:integer;
begin
   ip := getsysip;
   os := sysname;
  cronjob := '/bin/bash -c "ls -la /etc/cron*"';     //this will show all cron jobs .
  owncron := '/bin/bash -c "crontab -l -u `whoami`"'; //this will use corntab to show info about root jobs
  cron    := 'cat /etc/crontab';
  crontab :='/bin/bash -c "ls -la /var/spool/cron/crontabs"';
  anacron := '/bin/bash -c "ls -la /etc/anacrontab"';
  acron :='/bin/bash -c "ls -la /var/spool/anacron"';

  Process := Tprocess.Create(nil);
   process.Options:= [poUsePipes,postderrtooutput];
  list := Tstringlist.Create;
   listout := Tstringlist.create;
   list.add(cronjob);
   list.Add(owncron);
   list.Add(cron);
   list.Add(crontab);
   list.Add(anacron);
   list.Add(acron);
   for i:= 0 to list.Count-1 do begin
       list[i];
       try
       process.CommandLine:=list[i];
       process.Execute;
        except
      on E: exception do
         //writeln(E.Message)
         postrequest(E.message,ip,os,'2');
       end;
       listout.LoadFromStream(process.Output);
       loc := pos(listout.text,'No such file');
       if (loc < 0)  then
        begin
       writeln('[+] Cron Results :',listout.Text);
       postrequest('[*] cron results : '+listout.Text,ip,os,'2');
       writeln('[+] ref : https://0xsp.com/ref-001-cron-jobs-privilege-escalation')
        end else
       writeln('{~} Tool Detected that some of crons functions are not being found or accessibly ,what we found is ',listout.Text);
         postrequest('[*] some of crons are not accessible any way we found  : '+listout.Text,ip,os,'2');
       end;
   listout.Free;
   list.Free;
   process.free;

end;
  procedure LinuxEnum.network;               //cat 7
var
  process : Tprocess;
  list : Tstringlist;
  listout: Tstringlist;
  i :integer;
  arp:string;
  gateway,ip,os:string;
  begin
    os := sysname;
    ip := getsysip;
    gateway := '/bin/bash -c "grep "nameserver" /etc/resolv.conf | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b""';
    arp := '/bin/bash -c "arp -a |grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b""';
    process := Tprocess.Create(nil);
    process.Options:= [poUsePipes,postderrtooutput];
    list := Tstringlist.Create;
    listout := Tstringlist.Create;

    list.Add('/bin/bash -c "ifconfig -a"');
    list.Add('route');
    list.add('netstat -antup | grep -v '+'''TIME_WAIT' +'');
    list.add(arp);
    list.Add(gateway);
    for i := 0 to list.Count-1 do begin
       list[i];
       try
       process.CommandLine:=list[i];
       process.execute;
        except
      on E: exception do
        // writeln(E.Message);
         Postrequest(E.message,ip,os,'7');
       end;
       listout.LoadFromStream(process.Output);
       if list[i]= arp then begin
       writeln('[+] Arp IPS '#013#010,listout.Text);// So here for example we will add http post request to send results to API .
       postrequest('[*] ARP IPS '+listout.Text,ip,os,'7')
       end else if list[i] = gateway then begin
       writeln('[+] Gateway / NameServer : ',listout.text);
       postrequest('[*] Gateway / Name Server information  '+listout.Text,ip,os,'7')
       end else
       writeln('[+] ',listout.text);
       postrequest('[*] other network information  '+listout.Text,ip,os,'7');
       end;

    process.Free;
    list.Free;
    listout.Free;
    end;
procedure LinuxEnum.userinfo;                   //cat 5
     var
        list:Tstringlist;
        list2:Tstringlist;
        i :integer;
        process:Tprocess;
        s:string;
        trick,ip,os:string;
     begin

      ip := getsysip;
      os := sysname;

      trick := 'for i in $(cut -d":" -f1 /etc/passwd 2>/dev/null);do id $i;done 2>/dev/null';
      Process := TProcess.Create(nil);
      process.Options:= [poUsePipes,postderrtooutput];
      list := Tstringlist.Create;
      list2 := Tstringlist.Create;
      list.Add('hostname');
      list.Add('id');
      list.add('/bin/bash -c "lastlog |grep -v Never"');
      list.add('w');
      list.add('/bin/bash -c "cat /etc/sudoers |grep -v "#" "');
      list.Add('find /home -name .sudo_as_admin_successful');
      try
     for i := 0 to  list.Count-1 do begin
       list[i];
        process.CommandLine:=list[i];
      // process.Parameters.Add('|grep');
        process.Execute;
        list2.LoadFromStream(process.output);
        if list[i] = 'hostname' then begin
        Writeln('[+] =============  Hostname  =====================');
        writeln('[~]: ',list[i],' => ',list2.Text);
        postrequest('[*]hostname  '+list2.Text,ip,os,'5')  // this will send data into web application as expected .
        end else
        if list[i] = 'id' then begin
          Writeln('[+] =============  ID  =====================');
        writeln('[~]: ',list[i],' => ',list2.Text);
        postrequest('[*]Current Linux ID : '+list2.Text,ip,os,'5')
        end else
        if list[i] = 'find /home -name .sudo_as_admin_successful' then begin
        writeln('[+] Who has sudoed in the past ');
        writeln('[~]: ',list[i],' => ',list2.Text);
        postrequest('[*] Who has sudoed in the past '+list2.Text,ip,os,'5')
        end else
        if list[i] = '/bin/bash -c "lastlog |grep -v Never"' then begin
        Writeln('[+] =============  Last Log   =====================');
        writeln('[~]: ',list[i],' => ',list2.Text);
        postrequest('[*] information from Lastlog : '+list2.Text,ip,os,'5')

        end else
        if list[i] = 'w' then begin
        Writeln('[+] ============= Active Session =====================');
        writeln('[~]: ',list[i],' => ',list2.Text);
        postrequest('[*] Active Session '+list2.Text,ip,os,'5')
        end else

        if list[i] ='/bin/bash -c "cat /etc/sudoers |grep -v "#" "' then begin
        writeln('[+] ====================== Sudoers Users ======================');
        writeln(list2.Text);
        postrequest('[*] Sudoers Users  '+list2.Text,ip,os,'5')
        end;

       end;
        Writeln('[+] ============= Listing All IDS & Groups ==================');
        RunCommand('/bin/bash',['-c','for i in $(cut -d":" -f1 /etc/passwd 2>/dev/null);do id $i;done 2>/dev/null'],s);
         Writeln(s);
         postrequest('[+] IDS & Groups '+s,ip,os,'5');
         Writeln('{} Extending - Search for Admin Users & Super Users ...');
         RunCommand('/bin/bash',['-c',trick+'|grep "(adm)"'],s);
         writeln(s);
         postrequest('[*] Admin Users & Supper Users  '+s,ip,os,'5');
      finally
        list.free;
        list2.Free;
        process.free;
      end;
   end;

var

  Application: LinuxEnum;
begin
  Application:=LinuxEnum.Create(nil);
  Application.Title:='0xsp Mongoose Linux Privilege Enumeration ';
  Application.Run;
  Application.Free;
end.

