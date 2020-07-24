unit netenum;

{$mode delphi}

interface

uses
  Classes, SysUtils,WinSock,StrUtils,windows;

type
 PNetResourceArray = ^TNetResourceArray;
 TNetResourceArray = array[0..1023] of TNetResource;



 procedure ScanNetworkResources(ResourceType, DisplayType: DWord);

implementation

function SendArp(DestIP,SrcIP:ULONG;pMacAddr:pointer;PhyAddrLen:pointer) : DWord; StdCall; external 'iphlpapi.dll' name 'SendARP';



function GetIPAddress(const HostName: AnsiString): AnsiString;
var
  HostEnt: PHostEnt;
  Host: AnsiString;
  SockAddr: TSockAddrIn;
begin
  Result := '';
  Host := HostName;
  if Host = '' then
  begin
    SetLength(Host, MAX_PATH);
    GetHostName(PAnsiChar(Host), MAX_PATH);
  end;
  HostEnt := GetHostByName(PAnsiChar(Host));
  if HostEnt <> nil then
  begin
    SockAddr.sin_addr.S_addr := Longint(PLongint(HostEnt^.h_addr_list^)^);
    Result := inet_ntoa(SockAddr.sin_addr);
  end;
end;


function GetMacAddr(const IPAddress: AnsiString; var ErrCode : DWORD): AnsiString;
var
 MacAddr    : Array[0..5] of Byte;
 DestIP     : ULONG;
 PhyAddrLen : ULONG;
begin
  Result    :='';
  ZeroMemory(@MacAddr,SizeOf(MacAddr));
  DestIP    :=inet_addr(PAnsiChar(IPAddress));
  PhyAddrLen:=SizeOf(MacAddr);
  ErrCode   :=SendArp(DestIP,0,@MacAddr,@PhyAddrLen);
  if ErrCode = S_OK then
   Result:=AnsiString(Format('%2.2x-%2.2x-%2.2x-%2.2x-%2.2x-%2.2x',[MacAddr[0], MacAddr[1],MacAddr[2], MacAddr[3], MacAddr[4], MacAddr[5]]));
end;


function ParseRemoteName(Const lpRemoteName : string) : string;
begin
  Result:=lpRemoteName;
  if AnsiStartsStr('\\', lpRemoteName) and (Length(lpRemoteName)>2) and (LastDelimiter('\', lpRemoteName)>2) then
   Result:=Copy(lpRemoteName, 3, PosEx('\', lpRemoteName,3)-3)
  else
  if AnsiStartsStr('\\', lpRemoteName) and (Length(lpRemoteName)>2) and (LastDelimiter('\', lpRemoteName)=2) then
   Result:=Copy(lpRemoteName, 3, length(lpRemoteName));
end;


function CreateNetResourceList(ResourceType: DWord;
                              NetResource: PNetResource;
                              out Entries: DWord;
                              out List: PNetResourceArray): Boolean;
var
  EnumHandle: THandle;
  BufSize: DWord;
  Res: DWord;
begin
  Result := False;
  List := Nil;
  Entries := 0;
  if WNetOpenEnum(RESOURCE_GLOBALNET, ResourceType, 0, NetResource, EnumHandle) = NO_ERROR then
  begin
    try
      BufSize := $4000;  // 16 kByte
      GetMem(List, BufSize);
      try
        repeat
          Entries := DWord(-1);
          FillChar(List^, BufSize, 0);
          Res := WNetEnumResource(EnumHandle, Entries, List, BufSize);
          if Res = ERROR_MORE_DATA then
          begin
            ReAllocMem(List, BufSize);
          end;
        until Res <> ERROR_MORE_DATA;

        Result := Res = NO_ERROR;
        if not Result then
        begin
          FreeMem(List);
          List := Nil;
          Entries := 0;
        end;
      except
        FreeMem(List);
        raise;
      end;
    finally
      WNetCloseEnum(EnumHandle);
    end;
  end;
end;

procedure ScanNetworkResources(ResourceType, DisplayType: DWord);

procedure ScanLevel(NetResource: PNetResource);
var
  Entries: DWord;
  NetResourceList: PNetResourceArray;
  i: Integer;
  IPAddress, MacAddress : AnsiString;
  ErrCode : DWORD;

begin

  if CreateNetResourceList(ResourceType, NetResource, Entries, NetResourceList) then try
    for i := 0 to Integer(Entries) - 1 do
    begin

      IF  (NetResourceList[i].dwDisplayType = DisplayType) then

        begin
          IPAddress   :=GetIPAddress(ParseRemoteName(AnsiString(NetResourceList[i].lpRemoteName)));
          MacAddress  :=GetMacAddr(IPAddress, ErrCode);
          Writeln(Format('[+] DISCOVERED HOST:    %s Ip: %s MAC: %s',[NetResourceList[i].lpRemoteName, IPAddress, MacAddress]));

        end
         else if
        (NetResourceList[i].dwDisplayType = RESOURCEDISPLAYTYPE_SHARE) then    begin
         IPAddress   :=GetIPAddress(ParseRemoteName(AnsiString(NetResourceList[i].lpRemoteName)));
          MacAddress  :=GetMacAddr(IPAddress, ErrCode);
          Writeln(Format('[+] DISCOVERED SHARE:    %s Ip: %s MAC: %s',[NetResourceList[i].lpRemoteName, IPAddress, MacAddress]));

      end
        else if
        (NetResourceList[i].dwDisplayType = RESOURCEDISPLAYTYPE_DOMAIN) then    begin
         IPAddress   :=GetIPAddress(ParseRemoteName(AnsiString(NetResourceList[i].lpRemoteName)));
          MacAddress  :=GetMacAddr(IPAddress, ErrCode);
          Writeln(Format('[+] DOMAIN INFO :    %s Ip: %s MAC: %s',[NetResourceList[i].lpRemoteName, IPAddress, MacAddress]));
          end;
      if (NetResourceList[i].dwUsage and RESOURCEUSAGE_CONTAINER) <> 0 then
        ScanLevel(@NetResourceList[i]);
    end;
  finally
    FreeMem(NetResourceList);
  end;
end;

begin
  ScanLevel(Nil);
end;


 end.


