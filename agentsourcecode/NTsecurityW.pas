(*======================================================================*
 | unitNTSecurity                                                       |
 |                                                                      |
 | Encapsulates NT security                                             |
 |                                                                      |
 | Version  Date        By    Description                               |
 | -------  ----------  ----  ------------------------------------------|
 | 1.0      04/01/2002  CPWW  Original                                  |
 *======================================================================*)


 //Original unit by Colin Wilson
 // adapted to unicode by Luis Cobian
 {$mode Delphi}
unit NTSecurityW;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses Windows, Classes, SysUtils, ConTnrs;

const
  SE_CREATE_TOKEN_NAME              = 'SeCreateTokenPrivilege';
  SE_ASSIGNPRIMARYTOKEN_NAME        = 'SeAssignPrimaryTokenPrivilege';
  SE_LOCK_MEMORY_NAME               = 'SeLockMemoryPrivilege';
  SE_INCREASE_QUOTA_NAME            = 'SeIncreaseQuotaPrivilege';
  SE_UNSOLICITED_INPUT_NAME         = 'SeUnsolicitedInputPrivilege';
  SE_MACHINE_ACCOUNT_NAME           = 'SeMachineAccountPrivilege';
  SE_TCB_NAME                       = 'SeTcbPrivilege';
  SE_SECURITY_NAME                  = 'SeSecurityPrivilege';
  SE_TAKE_OWNERSHIP_NAME            = 'SeTakeOwnershipPrivilege';
  SE_LOAD_DRIVER_NAME               = 'SeLoadDriverPrivilege';
  SE_SYSTEM_PROFILE_NAME            = 'SeSystemProfilePrivilege';
  SE_SYSTEMTIME_NAME                = 'SeSystemtimePrivilege';
  SE_PROF_SINGLE_PROCESS_NAME       = 'SeProfileSingleProcessPrivilege';
  SE_INC_BASE_PRIORITY_NAME         = 'SeIncreaseBasePriorityPrivilege';
  SE_CREATE_PAGEFILE_NAME           = 'SeCreatePagefilePrivilege';
  SE_CREATE_PERMANENT_NAME          = 'SeCreatePermanentPrivilege';
  SE_BACKUP_NAME                    = 'SeBackupPrivilege';
  SE_RESTORE_NAME                   = 'SeRestorePrivilege';
  SE_SHUTDOWN_NAME                  = 'SeShutdownPrivilege';
  SE_DEBUG_NAME                     = 'SeDebugPrivilege';
  SE_AUDIT_NAME                     = 'SeAuditPrivilege';
  SE_SYSTEM_ENVIRONMENT_NAME        = 'SeSystemEnvironmentPrivilege';
  SE_CHANGE_NOTIFY_NAME             = 'SeChangeNotifyPrivilege';
  SE_REMOTE_SHUTDOWN_NAME           = 'SeRemoteShutdownPrivilege';
  SE_UNDOCK_NAME                    = 'SeUndockPrivilege';
  SE_SYNC_AGENT_NAME                = 'SeSyncAgentPrivilege';
  SE_ENABLE_DELEGATION_NAME         = 'SeEnableDelegationPrivilege';

  // Values for TAccessControlElement.Flags
  OBJECT_INHERIT_ACE                = $1;  // Non-Container child objects inherited this ACE.
                                           // Container child objects inherit the ace with INHERIT_ONLY_ACE set:
                                           // - they don't get it, but their child objects do.

  CONTAINER_INHERIT_ACE             = $2;  // Container child objects inherit this ACE.
  NO_PROPAGATE_INHERIT_ACE          = $4;  // Child objects get the ACE - but their children don't
  INHERIT_ONLY_ACE                  = $8;  // Indicates that the ACE doesn't work on this object - only on it's children

  INHERITED_ACE                     = $10; // Indicates that an ACE was inherited for this object, rather than directly specified.

  FILE_READ_DATA                    = $1;  // file & pipe
  FILE_LIST_DIRECTORY               = $1;  // directory

  FILE_WRITE_DATA                   = $2;  // file & pipe
  FILE_ADD_FILE                     = $2;  // directory

  FILE_APPEND_DATA                  = $4;  // file
  FILE_ADD_SUBDIRECTORY             = $4;  // directory
  FILE_CREATE_PIPE_INSTANCE         = $4;  // named pipe


  FILE_READ_EA                      = $8;  // file & directory
  FILE_WRITE_EA                     = $10; // file & directory

  FILE_EXECUTE                      = $20; // file
  FILE_TRAVERSE                     = $20; // directory

  FILE_DELETE_CHILD                 = $40; // directory
  FILE_READ_ATTRIBUTES              = $80; // all
  FILE_WRITE_ATTRIBUTES             = $100;// all

  FILE_ALL_ACCESS      = STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or $3FF;
  FILE_GENERIC_READ    = STANDARD_RIGHTS_READ or FILE_READ_DATA or FILE_READ_ATTRIBUTES or FILE_READ_EA or SYNCHRONIZE;
  FILE_GENERIC_WRITE   = STANDARD_RIGHTS_WRITE or FILE_WRITE_DATA or FILE_WRITE_ATTRIBUTES or FILE_WRITE_EA or FILE_APPEND_DATA or SYNCHRONIZE;
  FILE_GENERIC_EXECUTE = STANDARD_RIGHTS_EXECUTE or FILE_READ_ATTRIBUTES or FILE_EXECUTE or SYNCHRONIZE;

type

TAccessElementType = (aeAccessAllowed, aeAccessDenied, aeSystemAudit);

TAccessControlElement = class;
TSecurityDescriptor = class;

//------------------------------------------------------------------
// TAccessControlList class

TAccessControlList = class
private
  fElementList : TObjectList;
  function GetElementCount: Integer;
  function GetElement(idx: Integer): TAccessControlElement;

  function CreatePACL : PACL;
public
  constructor Create;
  destructor Destroy; override;
  property ElementCount : Integer read GetElementCount;
  property Element [idx : Integer] : TAccessControlElement read GetElement;

  procedure AddElement (element : TAccessControlElement);
  procedure DeleteElement (idx : Integer);
  procedure Clear;
end;

//------------------------------------------------------------------
// TAccessControlElement class

TAccessControlElement = class
private
  fTP : TAccessElementType;
  fMask : ACCESS_MASK;
  fFlags : Byte;   // eg. CONTAINER_INHERIT_ACE
  fSID : PSID;

  fSIDDecoded : Boolean;
  fName : WideString;
  fDomain : WideString;
  fUse : SID_NAME_USE;
  fOwnsSID : Boolean;
  function GetName: WideString;
  procedure DecodeSID;
  function GetDomain: WideString;
  function GetUse: SID_NAME_USE;
  function GetTp: TAccessElementType;
protected
  constructor Create (AType : TAccessElementType; AFlags : Byte; AMask : ACCESS_MASK; ASID : PSID); overload;
public
  constructor Create (const AName : WideString; ATp : TAccessElementType; AFlags : Byte; AMask : ACCESS_MASK); overload;
  destructor Destroy; override;
  property Name : WideString read GetName;
  property Domain : WideString read GetDomain;
  property Use : SID_NAME_USE read GetUse;
  property Type_ : TAccessElementType read GetTp;
  property Mask : ACCESS_MASK read fMask;
  property Flags : Byte read fFlags;
end;

//------------------------------------------------------------------
// TSecurityDescriptor class

TSecurityDescriptor = class
private
  fpSD : PSecurityDescriptor;
  fSDLen : DWORD;
  fInfoFlags : SECURITY_INFORMATION;
  fControlInfo : SECURITY_DESCRIPTOR_CONTROL;
  procedure DecodeAcl (Source : PACL; dest : TAccessControlList);
public
  destructor Destroy; override;
  property PSD : PSecurityDescriptor read fPSD;
  property SDLen : DWORD read fSDLen;

  function GetOwner (var Name : WideString; var use : SID_NAME_USE) : Boolean;
  function GetPrimaryGroup (var Name : WideString; var use : SID_NAME_USE) : Boolean;
  function GetDiscretionaryAccessList (var acl : TAccessControlList) : Boolean;
  function GetSystemAccessList (var acl : TAccessControlList) : Boolean;
end;

//------------------------------------------------------------------
// TNTObject class

TNTObject = class
private
  fOwnerSD : TSecurityDescriptor;
  fGroupSD : TSecurityDescriptor;
  fDACLSD : TSecurityDescriptor;
  fSACLSD : TSecurityDescriptor;
protected
  procedure GetSecurity (securityInfo : SECURITY_INFORMATION; SD : TSecurityDescriptor); virtual; abstract;
  procedure SetSecurity (securityInfo : SECURITY_INFORMATION; SD : TSecurityDescriptor); virtual; abstract;
public
  destructor Destroy; override;
  function GetOwner (var Name : WideString; var use : SID_NAME_USE) : Boolean;
  function GetGroup (var Name : WideString; var use : SID_NAME_USE) : Boolean;
  function GetDiscretionaryAccessList(var acl: TAccessControlList): Boolean;
  function GetSystemAccessList (var acl : TAccessControlList) : Boolean;

  procedure SetOwner (const Name : WideString);
  procedure SetGroup (const Name : WideString);
  procedure SetDiscretionaryAccessList (acl : TAccessControlList);
end;

TGetObjectSecurityFn = function (hObj: THandle; var pSIRequested: DWORD;
  pSID: PSecurityDescriptor; nLength: DWORD; var lpnLengthNeeded: DWORD): BOOL; stdcall;

//------------------------------------------------------------------
// TNTHandleObject class

TNTHandleObject = class (TNTObject)
private
  fHandle: THandle;
  procedure SetHandle(const Value: THandle);
  procedure GetObjectSecurity (fn : TGetObjectSecurityFn; securityInfo : SECURITY_INFORMATION; SD : TSecurityDescriptor);
protected
public
  constructor Create (AHandle : THandle);
  property Handle : THandle read fHandle write SetHandle;
end;

//------------------------------------------------------------------
// TNTRegistryObject class

TNTRegistryObject = class (TNTObject)
private
  fKEY : HKEY;
  procedure SetKey(const Value: HKEY);
protected
  procedure GetSecurity (securityInfo : SECURITY_INFORMATION; SD : TSecurityDescriptor); override;
  procedure SetSecurity (securityInfo : SECURITY_INFORMATION; SD : TSecurityDescriptor); override;
public
  constructor Create (AKey : HKEY);
  property Key : HKEY read fKey write SetKey;
end;

//------------------------------------------------------------------
// TNTFileObject

TNTFileObject = class (TNTObject)
private
  fFileName : WideString;
  procedure SetFileName(const Value: WideString);
protected
  procedure GetSecurity (securityInfo : SECURITY_INFORMATION; SD : TSecurityDescriptor); override;
  procedure SetSecurity (securityInfo : SECURITY_INFORMATION; SD : TSecurityDescriptor); override;
public
  constructor Create (const AFileName : WideString);
  property FileName : WideString read fFileName write SetFileName;
end;

//------------------------------------------------------------------
// TNTUserObject

TNTUserObject = class (TNTHandleObject)
protected
  procedure GetSecurity (securityInfo : SECURITY_INFORMATION; SD : TSecurityDescriptor); override;
  procedure SetSecurity (securityInfo : SECURITY_INFORMATION; SD : TSecurityDescriptor); override;
end;

//------------------------------------------------------------------
// TNTKernelObject

TNTKernelObject = class (TNTHandleObject)
protected
  procedure GetSecurity (securityInfo : SECURITY_INFORMATION; SD : TSecurityDescriptor); override;
  procedure SetSecurity (securityInfo : SECURITY_INFORMATION; SD : TSecurityDescriptor); override;
end;

//------------------------------------------------------------------
// TNTServiceObject

TNTServiceObject = class (TNTHandleObject)
protected
  procedure GetSecurity (securityInfo : SECURITY_INFORMATION; SD : TSecurityDescriptor); override;
  procedure SetSecurity (securityInfo : SECURITY_INFORMATION; SD : TSecurityDescriptor); override;
end;

function EnableNTPrivilege (const privilege : WideString; state : Integer) : Integer;

implementation

uses lmglobalW;

const
  DEFAULT_SD_LEN = 4096;

  ACCESS_ALLOWED_ACE_TYPE = 0;
  ACCESS_DENIED_ACE_TYPE = 1;
  SYSTEM_AUDIT_ACE_TYPE = 2;

  ACL_REVISION = 2;

type
  TAceHeader = packed record
    AceFlags : byte;
    AceSize : word;
  end;

  TAccessAllowedAce = packed record
    Header : TAceHeader;
    Mask : ACCESS_MASK;
    SidStart : DWORD
  end;

  TAccessDeniedAce = packed record
    Header : TAceHeader;
    Mask : ACCESS_MASK;
    SidStart : DWORD
  end;

  TSystemAuditAce = packed record
    Header : TAceHeader;
    Mask : ACCESS_MASK;
    SidStart : DWORD
  end;

  TAce = packed record
    case AceType : byte of
      ACCESS_ALLOWED_ACE_TYPE : (accessAllowedAce : TAccessAllowedAce);
      ACCESS_DENIED_ACE_TYPE  : (accessDeniedAce  : TAccessDeniedAce);
      SYSTEM_AUDIT_ACE_TYPE   : (systemAuditAce   : TSystemAuditAce);
  end;
  PAce = ^TAce;

function SetServiceObjectSecurity (hService : THandle; dwSecurityInformation : SECURITY_INFORMATION; lpSecurityDescriptor : PSecurityDescriptor) : BOOL; stdcall; external 'advapi32.dll';
function QueryServiceObjectSecurity (hService : THandle; dwSecurityInformation : SECURITY_INFORMATION; lpSecurityDescriptor : PSecurityDescriptor; nLength: DWORD; var lpnLengthNeeded: DWORD) : BOOL; stdcall; external 'advapi32.dll';

(*----------------------------------------------------------------------*
 | EnableNTPrivilege                                                    |
 |                                                                      |
 | Enable an NT Privilege                                               |
 |                                                                      |
 | Parameters:                                                          |
 |   const privilege : Widestring;                                          |
 |   state : Integer                                                    |
 |                                                                      |
 | The function returns the privileges previous state.                  |
 *----------------------------------------------------------------------*)
function EnableNTPrivilege (const privilege : WideString; state : Integer) : Integer;
var
  hToken : THandle;
  aluid : TLargeInteger;
  cbPrevTP : DWORD;
  tp, fPrevTP : PTokenPrivileges;
begin
  result := 0;
  if OpenProcessToken (GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then
  try
    Win32Check (LookupPrivilegeValueW (nil, PWideChar (privilege), aluid));

    cbPrevTP := SizeOf (TTokenPrivileges) + sizeof (TLUIDAndAttributes);

    GetMem (tp, cbPrevTP);
    GetMem (fPrevTP, cbPrevTP);
    try

      tp^.PrivilegeCount := 1;
      tp^.Privileges [0].Luid := aLuid;
      tp^.Privileges [0].Attributes := state;

      if not AdjustTokenPrivileges (hToken, False, tp^, cbPrevTP, fPrevTP^, cbPrevTP) then
        RaiseLastOSError;

      result := fPrevTP^.Privileges [0].Attributes;

    finally
     FreeMem (fPrevTP);
     FreeMem (tp);
    end
  finally
    CloseHandle (hToken);
  end
end;

(*----------------------------------------------------------------------*
 | GetSIDInfo                                                           |
 |                                                                      |
 | Get Domain/Name for a SID                                            |
 |                                                                      |
 | Parameters:                                                          |
 |   sid: PSID                  The SID to get details for              |
 |   var Name : Widestring;         Returns Name\Domain                     |
 |   var use: SID_NAME_USE      Returns the SID_NAME_USE for the SID    |
 *----------------------------------------------------------------------*)
procedure GetSIDInfo(sid: PSID; var Name : WideString; var use: SID_NAME_USE);
var
  nameLen : DWORD;
  domainLen : DWORD;
  domain : WideString;
begin
  nameLen := UNLEN + 1;
  domainLen := DNLEN + 1;

  SetLength (Name, nameLen);
  SetLength (domain, domainLen);

  if not LookupAccountSIDW (nil, sid, PWideChar (Name), nameLen, PWideChar (domain), domainLen, use) then
    if GetLastError = ERROR_NONE_MAPPED then
      Name := '?'
    else
      RaiseLastOSError;

  Name := PWideChar (Name);
  Domain := PWideChar (Domain);

  if domain <> '' then Name := domain + '\' + Name;
end;

procedure CreateSIDFromName (const AName : WideString; var sid : PSID; var domain : WideString; var use : SID_NAME_USE);
var
  dnLen : DWORD;
  sidLen : DWORD;
begin
  sid := nil;
  sidLen := 1024;
  dnLen := 1024;
  try
    repeat
      SetLength (domain, dnLen);
      ReallocMem (sid, sidLen);

      if LookupAccountNameW (nil, PWideChar (AName), sid, sidLen, PWideChar (domain), dnLen, use) then
        SetLastError (0)
    until GetLastError <> ERROR_INSUFFICIENT_BUFFER;

    if GetLastError <> 0 then
      RaiseLastOSError;

    sidLen := GetLengthSid (sid);
    ReallocMem (sid, sidLen);
    SetLength (domain, dnLen)
  except
    ReallocMem (sid, 0);
    raise
  end
end;

function CreateSelfRelativeSD (sd : PSECURITY_DESCRIPTOR) : PSECURITY_DESCRIPTOR;
var
  sdLen : DWORD;
begin
  sdLen := 1024;
  Result := nil;
  try
    repeat
      ReallocMem (result, sdLen);
      if MakeSelfRelativeSD (sd, result, sdLen) then
        SetLastError (0)
    until GetLastError <> ERROR_INSUFFICIENT_BUFFER;

    if GetLastError <> 0 then
      RaiseLastOSError;

    sdLen := GetSecurityDescriptorLength (result);
    ReallocMem (result, sdLen);
  except
    FreeMem (result);
    raise
  end
end;

{ TNTObject }

{ TNTRegistryObject }

constructor TNTRegistryObject.Create(AKey: HKEY);
begin
  fKey := AKey
end;

procedure TNTRegistryObject.GetSecurity(securityInfo: SECURITY_INFORMATION;
  SD: TSecurityDescriptor);
var
  sdLen : DWORD;
  rv : Longint;
begin
  sdLen := DEFAULT_SD_LEN;
  ReallocMem (SD.fpSD, sdLen);
  try
    rv := RegGetKeySecurity (Key, securityInfo, SD.fpSD, sdLen);
    if rv = ERROR_INSUFFICIENT_BUFFER then
    begin
      ReallocMem (SD.fpSD, sdLen);
      rv := RegGetKeySecurity (Key, securityInfo, SD.fpSD, sdLen);
      if rv <> ERROR_SUCCESS then
        RaiseLastOSError
    end
    else
      if rv = ERROR_SUCCESS then
        ReallocMem (SD.fpSD, sdLen)
      else
        RaiselastOSError;
  except
    ReallocMem (SD.fpSD, 0);
    raise
  end;

  if Assigned (SD.fpSD) then
  begin
    SD.fSDLen := sdlen;
    SD.fInfoFlags := securityInfo
  end
  else
    SD.fInfoFlags := 0;
end;

procedure TNTRegistryObject.SetKey(const Value: HKEY);
begin
  fKey := Value;
end;

procedure TNTRegistryObject.SetSecurity(securityInfo: SECURITY_INFORMATION;
  SD: TSecurityDescriptor);
var
  rv : Longint;
begin
  rv := RegSetKeySecurity (Key, securityInfo, SD.PSD);
  if rv <> ERROR_SUCCESS then
    RaiseLastOSError;
end;

{ TNTFileObject }

constructor TNTFileObject.Create(const AFileName: WideString);
begin
  fFileName := AFileName;
end;

procedure TNTFileObject.GetSecurity(securityInfo: SECURITY_INFORMATION;
  SD: TSecurityDescriptor);
var
  sdLen, nsdLen : DWORD;
begin
  sdLen := DEFAULT_SD_LEN;
  ReallocMem (SD.fpSD, sdLen);
  try
    if not GetFileSecurityW(PWideChar (FileName), securityInfo, SD.fpSD, sdLen, nsdLen) then
      if GetLastError <> ERROR_INSUFFICIENT_BUFFER then
        RaiseLastOSError;

    if nsdLen > sdLen then
    begin
      Reallocmem (SD.fpsd, nsdLen);
      Win32Check (GetFileSecurityW (PWideChar (FileName), securityInfo, SD.fpSD, nsdLen, nsdLen))
    end
    else
      ReallocMem (SD.fpSD, nsdLen)
  except
    ReallocMem (SD.fpSD, 0);
    raise
  end;

  if Assigned (SD.fpSD) then
  begin
    SD.fSDLen := nsdlen;
    SD.fInfoFlags := securityInfo
  end
  else
    SD.fInfoFlags := 0;
end;

procedure TNTFileObject.SetFileName(const Value: WideString);
begin
  fFileName := Value;
end;

procedure TNTFileObject.SetSecurity(securityInfo: SECURITY_INFORMATION;
  SD: TSecurityDescriptor);
begin
  Win32Check (SetFileSecurityW (PWideChar (fFileName), securityInfo, SD.PSD));
end;

{ TNTUserObject }

procedure TNTUserObject.GetSecurity(securityInfo: SECURITY_INFORMATION;
  SD: TSecurityDescriptor);
begin
  GetObjectSecurity (GetUserObjectSecurity, securityInfo, SD);
end;

procedure TNTUserObject.SetSecurity(securityInfo: SECURITY_INFORMATION;
  SD: TSecurityDescriptor);
begin
  Win32Check (SetUserObjectSecurity (fHandle, securityInfo, SD.PSD));
end;

{ TNTKernelObject }

procedure TNTKernelObject.GetSecurity(securityInfo: SECURITY_INFORMATION;
  SD: TSecurityDescriptor);
begin
  GetObjectSecurity (TGetObjectSecurityFn (@GetKernelObjectSecurity), securityInfo, SD);
end;

procedure TNTKernelObject.SetSecurity(securityInfo: SECURITY_INFORMATION;
  SD: TSecurityDescriptor);
begin
  Win32Check (SetKernelObjectSecurity (fHandle, securityInfo, SD.PSD));
end;

{ TNTServiceObject }

procedure TNTServiceObject.GetSecurity(securityInfo: SECURITY_INFORMATION;
  SD: TSecurityDescriptor);
begin
  GetObjectSecurity (TGetObjectSecurityFn (@QueryServiceObjectSecurity), securityInfo, SD);
end;

procedure TNTServiceObject.SetSecurity(securityInfo: SECURITY_INFORMATION;
  SD: TSecurityDescriptor);
begin
  Win32Check (SetServiceObjectSecurity (fHandle, securityInfo, SD.PSD));
end;

{ TNTHandleObject }

constructor TNTHandleObject.Create(AHandle: THandle);
begin
  fHandle := AHandle
end;

procedure TNTHandleObject.GetObjectSecurity(fn: TGetObjectSecurityFn;
  securityInfo: SECURITY_INFORMATION; SD: TSecurityDescriptor);
var
  sdLen, nsdLen : DWORD;
begin
  sdLen := DEFAULT_SD_LEN;
  ReallocMem (SD.fpSD, sdLen);
  try
    if not fn (Handle, securityInfo, SD.fpSD, sdLen, nsdLen) then
      if GetLastError <> ERROR_INSUFFICIENT_BUFFER then
        RaiseLastOSError;

    if nsdLen > sdLen then
    begin
      Reallocmem (SD.fpsd, nsdLen);
      Win32Check (fn (Handle, securityInfo, SD.fpSD, nsdLen, nsdLen))
    end
    else
      ReallocMem (SD.fpSD, nsdLen);
  except
    ReallocMem (SD.fpSD, 0);
    raise
  end;
  if Assigned (SD.fpSD) then
  begin
    SD.fSDLen := nsdlen;
    SD.fInfoFlags := securityInfo
  end
  else
    SD.fInfoFlags := 0;
end;

procedure TNTHandleObject.SetHandle(const Value: THandle);
begin
  fHandle := Value;
end;

{ TSecurityDescriptor }

{ TSecurityDescriptor }

procedure TSecurityDescriptor.DecodeAcl(Source: PACL; dest: TAccessControlList);
var
  aces : PACE;
  i : Integer;
begin
  aces := PACE (PChar (Source) + SizeOf (Source^));

  dest.Clear;

  for i := 0 to Source^.AceCount - 1 do
    case aces^.AceType of
      ACCESS_ALLOWED_ACE_TYPE :
        begin
          dest.AddElement(TAccessControlElement.Create (aeAccessAllowed,
                                                 aces^.accessAllowedAce.Header.AceFlags,
                                                 aces^.accessAllowedAce.Mask,
                                                 PSID (@aces^.accessAllowedAce.SidStart)));

          aces := PACE (PChar (aces) + aces^.accessAllowedAce.Header.AceSize)
        end;

      ACCESS_DENIED_ACE_TYPE :
        begin
          dest.AddElement(TAccessControlElement.Create (aeAccessDenied,
                                                 aces^.accessDeniedAce.Header.AceFlags,
                                                 aces^.accessDeniedAce.Mask,
                                                 PSID (@aces^.accessDeniedAce.SidStart)));
          aces := PACE (PChar (aces) + aces^.accessDeniedAce.Header.AceSize)
        end;
      SYSTEM_AUDIT_ACE_TYPE :
        begin
          dest.AddElement(TAccessControlElement.Create (aeSystemAudit,
                                                 aces^.systemAuditAce.Header.AceFlags,
                                                 aces^.systemAuditAce.Mask,
                                                 PSID (@aces^.systemAuditAce.SidStart)));
          aces := PACE (PChar (aces) + aces^.systemAuditAce.Header.AceSize)
        end
  end
end;

destructor TSecurityDescriptor.Destroy;
begin
  FreeMem (fpSD);

  inherited;
end;

function TSecurityDescriptor.GetDiscretionaryAccessList(
  var acl: TAccessControlList): Boolean;
var
  dacl : PACL;
  present, defaulted : BOOL;
begin
  if (fInfoFlags and DACL_SECURITY_INFORMATION) <> 0 then
  begin
    Win32Check (GetSecurityDescriptorDACL(PSD, present, dacl, defaulted));
    if Present then
      DecodeAcl (dacl, acl)
    else
      acl.Clear;
    if defaulted then
      fControlInfo := fControlInfo or SE_DACL_DEFAULTED
    else
      fControlInfo := fControlInfo and not SE_DACL_DEFAULTED;

    if present then
      fControlInfo := fControlInfo or SE_DACL_PRESENT
    else
      fControlInfo := fControlInfo and not SE_DACL_PRESENT;
    Result := True;
  end
  else
    Result := False
end;

function TSecurityDescriptor.GetOwner(var Name : WideString;
  var use: SID_NAME_USE) : Boolean;
var
  sid : PSID;
  defaulted : BOOL;
begin
  if (fInfoFlags and OWNER_SECURITY_INFORMATION) <> 0 then
  begin
    Win32Check (GetSecurityDescriptorOwner (PSD, sid, defaulted));
    GetSidInfo (sid, Name, use);
    if defaulted then
      fControlInfo := fControlInfo or SE_OWNER_DEFAULTED
    else
      fControlInfo := fControlInfo and not SE_OWNER_DEFAULTED;
    Result := True
  end
  else
    Result := False
end;

function TSecurityDescriptor.GetPrimaryGroup(var Name: WideString;
  var use: SID_NAME_USE): Boolean;
var
  sid : PSID;
  defaulted : BOOL;
begin
  if (fInfoFlags and OWNER_SECURITY_INFORMATION) <> 0 then
  begin
    Win32Check (GetSecurityDescriptorGroup (PSD, sid, defaulted));
    GetSidInfo (sid, Name, use);
    if defaulted then
      fControlInfo := fControlInfo or SE_GROUP_DEFAULTED
    else
      fControlInfo := fControlInfo and not SE_GROUP_DEFAULTED;
    Result := True
  end
  else
    Result := False
end;

function TSecurityDescriptor.GetSystemAccessList(
  var acl: TAccessControlList): Boolean;
var
  sacl : PACL;
  present, defaulted : BOOL;
begin
  if (fInfoFlags and SACL_SECURITY_INFORMATION) <> 0 then
  begin
    Win32Check (GetSecurityDescriptorSACL (PSD, present, sacl, defaulted));
    if Present then
      DecodeAcl (sacl, acl)
    else
      acl.Clear;

    if defaulted then
      fControlInfo := fControlInfo or SE_SACL_DEFAULTED
    else
      fControlInfo := fControlInfo and not SE_SACL_DEFAULTED;

    if present then
      fControlInfo := fControlInfo or SE_SACL_PRESENT
    else
      fControlInfo := fControlInfo and not SE_SACL_PRESENT;
    Result := True;
  end
  else
    Result := False
end;

{ TNTObject }

destructor TNTObject.Destroy;
begin
  fOwnerSD.Free;
  fGroupSD.Free;
  fDACLSD.Free;
  fSACLSD.Free;

  inherited;
end;

function TNTObject.GetDiscretionaryAccessList(
  var acl: TAccessControlList): Boolean;
begin
  if not Assigned (fDACLSD) then
  begin
    fDACLSD := TSecurityDescriptor.Create;
    GetSecurity (DACL_SECURITY_INFORMATION, fDACLSD)
  end;

  Result := fDACLSD.GetDiscretionaryAccessList (acl)
end;

function TNTObject.GetGroup(var Name: WideString;
  var use: SID_NAME_USE): Boolean;
begin
  if not Assigned (fGroupSD) then
  begin
    fGroupSD := TSecurityDescriptor.Create;
    GetSecurity (GROUP_SECURITY_INFORMATION, fGroupSD)
  end;

  Result := fGroupSD.GetPrimaryGroup (Name, use)
end;

function TNTObject.GetOwner(var Name: WideString;
  var use: SID_NAME_USE): Boolean;
begin
  if not Assigned (fOwnerSD) then
  begin
    fOwnerSD := TSecurityDescriptor.Create;
    GetSecurity (OWNER_SECURITY_INFORMATION, fOwnerSD)
  end;

  Result := fOwnerSD.GetOwner(Name, use)
end;

function TNTObject.GetSystemAccessList(
  var acl: TAccessControlList): Boolean;
var
  oldState : Integer;
begin
  oldState := EnableNTPrivilege (SE_SECURITY_NAME, SE_PRIVILEGE_ENABLED);
  try
    if not Assigned (fSACLSD) then
    begin
      fSACLSD := TSecurityDescriptor.Create;
      GetSecurity (SACL_SECURITY_INFORMATION, fSACLSD)
    end;

    Result := fSACLSD.GetSystemAccessList (acl)
  finally
    EnableNTPrivilege (SE_SECURITY_NAME, oldState)
  end
end;

procedure TNTObject.SetDiscretionaryAccessList(acl: TAccessControlList);
var
  sd, ssd : PSECURITY_DESCRIPTOR;
  a : PACL;
begin
  a := nil;
  sd:= nil;
  try
    a := acl.CreatePACL;
    GetMem (sd, SECURITY_DESCRIPTOR_MIN_LENGTH);
    Win32Check (InitializeSecurityDescriptor (sd, SECURITY_DESCRIPTOR_REVISION));
    Win32Check (SetSecurityDescriptorDACL (sd, acl.ElementCount > 0, a, False));
    ssd := CreateSelfRelativeSD (sd);

    FreeAndNil (fDACLSD);
    fDACLSD := TSecurityDescriptor.Create;
    fDACLSD.fpSD := ssd;

  finally
    // by luis cobian
    Freemem(sd);
    FreeMem (a)
  end;

  SetSecurity (DACL_SECURITY_INFORMATION, fDACLSD);
end;

procedure TNTObject.SetGroup(const Name: WideString);
var
  sid : PSID;
  domain : WideString;
  use : SID_NAME_USE;
  sd : PSECURITY_DESCRIPTOR;
begin
  FreeAndNil (fGroupSD);
  fGroupSD := TSecurityDescriptor.Create;

  CreateSIDFromName (Name, sid, domain, use);
  try
    GetMem (sd, SECURITY_DESCRIPTOR_MIN_LENGTH);
    Win32Check (InitializeSecurityDescriptor (sd, SECURITY_DESCRIPTOR_REVISION));
    Win32Check (SetSecurityDescriptorGroup (sd, sid, False));
    fGroupSD.fpSD := CreateSelfRelativeSD (sd);
  finally
    FreeMem (sid)
  end;

  SetSecurity (GROUP_SECURITY_INFORMATION, fGroupSD);
end;

procedure TNTObject.SetOwner(const Name: WideString);
var
  sid : PSID;
  domain : WideString;
  use : SID_NAME_USE;
  sd : PSECURITY_DESCRIPTOR;
begin
  FreeAndNil (fOwnerSD);
  fOwnerSD := TSecurityDescriptor.Create;
  sd:= nil;

  CreateSIDFromName (Name, sid, domain, use);
  try
    GetMem (sd, SECURITY_DESCRIPTOR_MIN_LENGTH);
    Win32Check (InitializeSecurityDescriptor (sd, SECURITY_DESCRIPTOR_REVISION));
    Win32Check (SetSecurityDescriptorOwner (sd, sid, False));
    fOwnerSD.fpSD := CreateSelfRelativeSD (sd);
  finally
    // by Luis Cobian
    FreeMem( sd);
    FreeMem (sid)
  end;

  SetSecurity (OWNER_SECURITY_INFORMATION, fOwnerSD);
end;

{ TAccessControlElement }

constructor TAccessControlElement.Create (AType : TAccessElementType; AFlags : Byte; AMask : ACCESS_MASK; ASID : PSID);
begin
  fTP := AType;
  fMask := AMask;
  fFlags := AFlags;
  fSID := ASID;
end;

constructor TAccessControlElement.Create(const AName : WideString; ATp : TAccessElementType;
  AFlags: Byte; AMask: ACCESS_MASK);
begin
  CreateSIDFromName (AName, fSID, fDomain, fUse);
  fFlags := AFlags;
  fMask := AMask;
  fTP := aTP;
end;

procedure TAccessControlElement.DecodeSID;
begin
  if not fSIDDecoded then
  begin
    GetSIDInfo(fSID, fName, fUse);
    fSIDDecoded := True
  end
end;

destructor TAccessControlElement.Destroy;
begin
  if fOwnsSID then
    FreeMem (fSID);

  inherited;
end;

function TAccessControlElement.GetDomain: WideString;
begin
  DecodeSID;
  Result := fDomain
end;

function TAccessControlElement.GetName: WideString;
begin
  DecodeSID;
  Result := fName
end;

function TAccessControlElement.GetTp: TAccessElementType;
begin
  DecodeSID;
  Result := fTp;

end;

function TAccessControlElement.GetUse: SID_NAME_USE;
begin
  DecodeSID;
  Result := fUse
end;

{ TAccessControlList }

procedure TAccessControlList.AddElement(element: TAccessControlElement);
begin
  fElementList.Add(element)
end;

procedure TAccessControlList.Clear;
begin
  fElementList.Clear();
end;

constructor TAccessControlList.Create;
begin
  fElementList := TObjectList.Create;
end;

function TAccessControlList.CreatePACL: PACL;
var
  i, aclLen : Integer;
  elem : TAccessControlElement;
  ace : Pointer;
begin
  aclLen := SizeOf (ACL);

  for i := 0 to ElementCount - 1 do
    aclLen := aclLen + SizeOf (TAce) + Integer (GetLengthSID (Element [i].fSID)) - SizeOf (DWORD);

  GetMem (Result, aclLen);
  try
    Win32Check (InitializeACL (Result^, aclLen, ACL_REVISION));
    for i := 0 to ElementCount - 1 do
    begin
      elem := Element [i];

      case elem.Type_ of
        aeAccessAllowed : Win32Check (AddAccessAllowedAce (Result^, ACL_REVISION, elem.fMask, elem.fSID));
        aeAccessDenied : Win32Check (AddAccessDeniedAce (Result^, ACL_REVISION, elem.fMask, elem.fSID));
        aeSystemAudit : Win32Check (AddAuditAccessAce (Result^, ACL_REVISION, elem.Mask, elem.fSID, True, True));
      end;

      if GetACE (Result^, i, ace) then
        PACE (ace)^.accessAllowedAce.Header.AceFlags := elem.Flags
    end;

  except
    FreeMem (Result);
    raise
  end
end;

procedure TAccessControlList.DeleteElement(idx: Integer);
begin
  fElementList.Delete(idx);
end;

destructor TAccessControlList.Destroy;
begin
  fElementList.Free;

  inherited;
end;

function TAccessControlList.GetElement(idx: Integer): TAccessControlElement;
begin
  Result := TAccessControlElement (fElementList.Items [idx]);
end;

function TAccessControlList.GetElementCount: Integer;
begin
  Result := fElementList.Count
end;

end.
