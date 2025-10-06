unit uWinUsageHelpers;

interface

function GetCPUUsage: Double;
function GetMemoryUsage: Double;
function GetDiskReadBytes: UInt64;
function GetDiskWriteBytes: UInt64;
function GetNetworkInBytes(const AdapterName: string): UInt64;
function GetNetworkOutBytes(const AdapterName: string): UInt64;
function GetAllNetworkInBytes: UInt64;
function GetAllNetworkOutBytes: UInt64;

implementation

uses
  Windows, SysUtils, PsAPI, IpHlpApi, Winapi.IpRtrMib;

type
  TDiskPerformance = record
    BytesRead: Int64;
    BytesWritten: Int64;
    ReadTime: Int64;
    WriteTime: Int64;
    IdleTime: Int64;
    QueryTime: TLargeInteger;
    StorageDeviceNumber: DWORD;
    StorageManagerName: array[0..7] of WCHAR;
  end;

var
  PrevIdleTime, PrevKernelTime, PrevUserTime: UInt64;

function QueryDiskPerf(const Drive: string; out BytesRead, BytesWritten: UInt64): Boolean;
var
  hDevice: THandle;
  BytesReturned: DWORD;
  Perf: TDiskPerformance;
  DeviceName: string;
begin
  Result := False;
  BytesRead := 0;
  BytesWritten := 0;
  DeviceName := '\\.\' + Drive;
  hDevice := CreateFile(PChar(DeviceName), 0, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  if hDevice = INVALID_HANDLE_VALUE then Exit;
  try
    if DeviceIoControl(hDevice, $70020, nil, 0, @Perf, SizeOf(Perf), BytesReturned, nil) then
    begin
      BytesRead := Perf.BytesRead;
      BytesWritten := Perf.BytesWritten;
      Result := True;
    end;
  finally
    CloseHandle(hDevice);
  end;
end;

function FileTimeToUInt64(const ft: TFileTime): UInt64;
begin
  Result := (UInt64(ft.dwHighDateTime) shl 32) or ft.dwLowDateTime;
end;

function GetCPUUsage: Double;
var
  IdleTime, KernelTime, UserTime: TFileTime;
  Idle, Kernel, User: UInt64;
  SysTime, IdleDiff: UInt64;
begin
  Result := -1;
  if not GetSystemTimes(IdleTime, KernelTime, UserTime) then
    Exit;

  Idle := FileTimeToUInt64(IdleTime);
  Kernel := FileTimeToUInt64(KernelTime);
  User := FileTimeToUInt64(UserTime);

  if (PrevIdleTime = 0) and (PrevKernelTime = 0) and (PrevUserTime = 0) then
  begin
    // Primeira chamada, inicializa os valores
    PrevIdleTime := Idle;
    PrevKernelTime := Kernel;
    PrevUserTime := User;
    Exit;
  end;

  SysTime := (Kernel - PrevKernelTime) + (User - PrevUserTime);
  IdleDiff := Idle - PrevIdleTime;

  if SysTime > 0 then
    Result := 100.0 * (SysTime - IdleDiff) / SysTime
  else
    Result := 0.0;

  // Atualiza para próxima chamada
  PrevIdleTime := Idle;
  PrevKernelTime := Kernel;
  PrevUserTime := User;
end;

function GetMemoryUsage: Double;
var
  MemInfo: TMemoryStatusEx;
begin
  ZeroMemory(@MemInfo, SizeOf(MemInfo));
  MemInfo.dwLength := SizeOf(MemInfo);
  if GlobalMemoryStatusEx(MemInfo) then
    Result := 100.0 * (MemInfo.ullTotalPhys - MemInfo.ullAvailPhys) / MemInfo.ullTotalPhys
  else
    Result := -1;
end;


function GetDiskReadBytes: UInt64;
var
  i: Char;
  BytesRead, BytesWritten: UInt64;
begin
  Result := 0;
  for i := 'C' to 'Z' do
  begin
    if GetDriveType(PChar(i + ':\')) = DRIVE_FIXED then
      if QueryDiskPerf(i + ':', BytesRead, BytesWritten) then
        Inc(Result, BytesRead);
  end;
end;

function GetDiskWriteBytes: UInt64;
var
  i: Char;
  BytesRead, BytesWritten: UInt64;
begin
  Result := 0;
  for i := 'C' to 'Z' do
  begin
    if GetDriveType(PChar(i + ':\')) = DRIVE_FIXED then
      if QueryDiskPerf(i + ':', BytesRead, BytesWritten) then
        Inc(Result, BytesWritten);
  end;
end;

// Network usage with MIB_IFROW from IP Helper API
function GetNetworkInBytes(const AdapterName: string): UInt64;
var
  Table: PMIB_IFTABLE;
  Size, i: ULONG;
  Row: MIB_IFROW;
begin
  Result := 0;
  Size := 0;
  if GetIfTable(nil, Size, False) = ERROR_INSUFFICIENT_BUFFER then
  begin
    GetMem(Table, Size);
    try
      if GetIfTable(Table, Size, False) = NO_ERROR then
      begin
        for i := 0 to Table.dwNumEntries - 1 do
        begin
          Row := Table.table[i];
          if AdapterName = string(Row.wszName) then
          begin
            Result := Row.dwInOctets;
            Exit;
          end;
        end;
      end;
    finally
      FreeMem(Table);
    end;
  end;
end;

function GetNetworkOutBytes(const AdapterName: string): UInt64;
var
  Table: PMIB_IFTABLE;
  Size, i: ULONG;
  Row: MIB_IFROW;
begin
  Result := 0;
  Size := 0;
  if GetIfTable(nil, Size, False) = ERROR_INSUFFICIENT_BUFFER then
  begin
    GetMem(Table, Size);
    try
      if GetIfTable(Table, Size, False) = NO_ERROR then
      begin
        for i := 0 to Table.dwNumEntries - 1 do
        begin
          Row := Table.table[i];
          if AdapterName = string(Row.wszName) then
          begin
            Result := Row.dwOutOctets;
            Exit;
          end;
        end;
      end;
    finally
      FreeMem(Table);
    end;
  end;
end;

function GetAllNetworkInBytes: UInt64;
var
  NumInterfaces, i: ULONG;
  Row: TMibIfRow;
begin
  Result := 0;
  if GetNumberOfInterfaces(NumInterfaces) = NO_ERROR then
  begin
    for i := 1 to NumInterfaces do
    begin
      ZeroMemory(@Row, SizeOf(Row));
      Row.dwIndex := i;
      if GetIfEntry(@Row) = NO_ERROR then
        Inc(Result, Row.dwInOctets);
    end;
  end;
end;

function GetAllNetworkOutBytes: UInt64;
var
  NumInterfaces, i: ULONG;
  Row: TMibIfRow;
begin
  Result := 0;
  if GetNumberOfInterfaces(NumInterfaces) = NO_ERROR then
  begin
    for i := 1 to NumInterfaces do
    begin
      ZeroMemory(@Row, SizeOf(Row));
      Row.dwIndex := i;
      if GetIfEntry(@Row) = NO_ERROR then
        Inc(Result, Row.dwOutOctets);
    end;
  end;
end;

initialization
  PrevIdleTime := 0;
  PrevKernelTime := 0;
  PrevUserTime := 0;

end.
