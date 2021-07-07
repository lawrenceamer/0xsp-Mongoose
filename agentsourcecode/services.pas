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


 # Modified Unit for Windows Acitve Services enumeration with out required Permission , Check User in Group Function


}

unit services;
{$mode Delphi}
interface
uses
  Classes,windows,SysUtils;



function ServiceRunning(sMachine, sService: PChar): Boolean;
 function  UserInGroup(Group :DWORD) : Boolean;
 function ServiceGetList(sMachine: string;
                         dwServiceType, dwServiceState: DWord;
                         slServicesList: TStrings) : boolean;
implementation
  uses
 jwawinsvc;
  const
 // users privielges levels
 SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
 SECURITY_BUILTIN_DOMAIN_RID = $00000020;
 DOMAIN_ALIAS_RID_ADMINS     = $00000220;
 DOMAIN_ALIAS_RID_USERS      = $00000221;
 DOMAIN_ALIAS_RID_GUESTS     = $00000222;
 DOMAIN_ALIAS_RID_POWER_USERS= $00000223;


 //
  // Service Types
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

 function CheckTokenMembership(TokenHandle: THandle; SidToCheck: PSID; var IsMember: BOOL): BOOL; stdcall; external advapi32;

 function  UserInGroup(Group :DWORD) : Boolean;
 var
  pIdentifierAuthority :TSIDIdentifierAuthority;
  pSid : Windows.PSID;
  IsMember    : BOOL;
 begin
  pIdentifierAuthority := SECURITY_NT_AUTHORITY;
  Result := AllocateAndInitializeSid(pIdentifierAuthority,2, SECURITY_BUILTIN_DOMAIN_RID, Group, 0, 0, 0, 0, 0, 0, pSid);
  try
    if Result then
      if not CheckTokenMembership(0, pSid, IsMember) then //passing 0 means which the function will be use the token of the calling thread.
         Result:= False
      else
         Result:=IsMember;
  finally
     FreeSid(pSid);
  end;
 end;

function ServiceGetStatus(sMachine, sService: PChar): DWORD;

var
  SCManHandle, SvcHandle: SC_Handle;
  SS: TServiceStatus;
  dwStat: DWORD;
  username,password,domain:PChar;
   htoken:Thandle;
begin
//username := 'lawrence';
//password := '0xsp2021';
//domain := '0xsp';
//hToken := 0;
 //LogonUser(username, domain, password,
  //  LOGON32_LOGON_NEW_CREDENTIALS, LOGON32_PROVIDER_WINNT50, &hToken);
//ImpersonateLoggedOnUser(hToken);
  dwStat := 0;
  // Open service manager handle.
  SCManHandle := OpenSCManager(sMachine, nil, SC_MANAGER_CONNECT);
  if (SCManHandle > 0) then
  begin
    SvcHandle := OpenService(SCManHandle, sService, SERVICE_QUERY_STATUS);
    // if Service installed
    if (SvcHandle > 0) then
    begin
      // SS structure holds the service status (TServiceStatus);
      if (QueryServiceStatus(SvcHandle, SS)) then
        dwStat := ss.dwCurrentState;
      CloseServiceHandle(SvcHandle);
    end;
    CloseServiceHandle(SCManHandle);
  end;
  Result := dwStat;
end;

function ServiceRunning(sMachine, sService: PChar): Boolean;
begin
  Result := SERVICE_RUNNING = ServiceGetStatus(sMachine, sService);
end;

 function ServiceGetList(sMachine: string;
                         dwServiceType, dwServiceState: DWord;
                         slServicesList: TStrings) : boolean;
const
  // assume that the total number of services is less than 4096.
  //Increase if necessary
  cnMaxServices = 4096;
type
  TSvcA = array [0..cnMaxServices] of TEnumServiceStatus;
  PSvcA = ^TSvcA;
  var
  j: integer;
  // service control manager handle
  schm: SC_Handle;
  // bytes needed for the next buffer, if any
  nBytesNeeded,
  // number of services
  nServices,
  // pointer to the next unread service entry
  nResumeHandle: DWord;
  // service status array
  ssa: PSvcA;
begin { ServiceGetList }
  Result := false;

  // connect to the service control manager
  schm := OpenSCManager(PChar(sMachine), nil, SC_MANAGER_ENUMERATE_SERVICE);

  // if successful...
  if (schm>0) then
  begin
    nResumeHandle := 0;

    New(ssa);

    EnumServicesStatus(schm, dwServiceType, dwServiceState,ssa^,
                       sizeof(ssa^), nBytesNeeded, nServices,
                       nResumeHandle);

    // assume that our initial array was large enough to hold all
    // entries. add code to enumerate if necessary.
    for j := 0 to nServices-1 do
    begin
      slServicesList.Add(StrPas(ssa^[j].lpDisplayName));
    end; { for j }
    Result := true;

    Dispose(ssa);

    // close service control manager handle
    CloseServiceHandle(schm);
  end; { (schm>0) }
end; { ServiceGetList }



end.

