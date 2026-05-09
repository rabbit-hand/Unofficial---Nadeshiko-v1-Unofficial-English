unit memory_manager;

// Modern memory management for なでしこ
// Replaces deprecated FastMM4 with secure FPC memory management

interface

uses
  SysUtils, Classes;

type
  // Modern memory manager with security features
  TNakoMemoryManager = class
  private
    class var FInstance: TNakoMemoryManager;
    class function GetInstance: TNakoMemoryManager; static;
  public
    class property Instance: TNakoMemoryManager read GetInstance;
    
    // Secure memory allocation with bounds checking
    class function SecureAlloc(Size: NativeUInt): Pointer;
    class procedure SecureFree(P: Pointer);
    class function SecureRealloc(P: Pointer; NewSize: NativeUInt): Pointer;
    
    // Memory leak detection
    class procedure EnableLeakDetection;
    class procedure DumpMemoryStats;
    
    // Buffer overflow protection
    class function SecureStrCopy(Dest, Source: PChar; DestSize: SizeInt): PChar;
    class function SecureStrCat(Dest, Source: PChar; DestSize: SizeInt): PChar;
    
    constructor Create;
    destructor Destroy; override;
  end;

// Security constants
const
  MEMORY_CANARY = $DEADBEEF;
  MIN_BUFFER_SIZE = 256;
  MAX_BUFFER_SIZE = 1024 * 1024 * 100; // 100MB limit

implementation

var
  MemoryLeakDetection: Boolean = False;
  AllocationCount: Integer = 0;
  TotalAllocated: NativeUInt = 0;

{ TNakoMemoryManager }

class function TNakoMemoryManager.GetInstance: TNakoMemoryManager;
begin
  if not Assigned(FInstance) then
    FInstance := TNakoMemoryManager.Create;
  Result := FInstance;
end;

constructor TNakoMemoryManager.Create;
begin
  inherited Create;
  // Initialize modern memory manager features
  SetHeapTraceOptions([htoCheckHeap, htoTraceErrors]);
end;

destructor TNakoMemoryManager.Destroy;
begin
  if MemoryLeakDetection then
    DumpMemoryStats;
  inherited Destroy;
end;

class function TNakoMemoryManager.SecureAlloc(Size: NativeUInt): Pointer;
var
  ActualSize: NativeUInt;
  Header: PNativeUInt;
begin
  // Validate size
  if (Size = 0) or (Size > MAX_BUFFER_SIZE) then
    raise Exception.CreateFmt('Invalid allocation size: %d', [Size]);
  
  // Add space for canary and header
  ActualSize := Size + SizeOf(NativeUInt) * 2;
  
  // Allocate memory
  GetMem(Result, ActualSize);
  if not Assigned(Result) then
    raise OutOfMemoryError.Create('Memory allocation failed');
  
  // Set up security header
  Header := PNativeUInt(Result);
  Header^ := MEMORY_CANARY; // Start canary
  Inc(Header);
  Header^ := Size; // Store actual size
  Inc(Header);
  
  Result := Header; // Return pointer after header
  
  // Set end canary
  PNativeUInt(PByte(Result) + Size)^ := MEMORY_CANARY;
  
  // Update statistics
  Inc(AllocationCount);
  Inc(TotalAllocated, Size);
end;

class procedure TNakoMemoryManager.SecureFree(P: Pointer);
var
  Header: PNativeUInt;
  Size: NativeUInt;
  ActualPtr: Pointer;
  Canary: NativeUInt;
begin
  if not Assigned(P) then Exit;
  
  try
    // Get header information
    Header := PNativeUInt(P);
    Dec(Header);
    Size := Header^;
    Dec(Header);
    
    // Verify start canary
    if Header^ <> MEMORY_CANARY then
      raise Exception.Create('Memory corruption detected (underflow)');
    
    // Verify end canary
    Canary := PNativeUInt(PByte(P) + Size)^;
    if Canary <> MEMORY_CANARY then
      raise Exception.Create('Memory corruption detected (overflow)');
    
    // Clear sensitive data
    FillChar(P^, Size, 0);
    
    // Get actual pointer to free
    ActualPtr := Header;
    
    // Update statistics
    Dec(AllocationCount);
    Dec(TotalAllocated, Size);
    
    // Free memory
    FreeMem(ActualPtr);
  except
    on E: Exception do
      raise Exception.CreateFmt('Memory free error: %s', [E.Message]);
  end;
end;

class function TNakoMemoryManager.SecureRealloc(P: Pointer; NewSize: NativeUInt): Pointer;
var
  Header: PNativeUInt;
  OldSize: NativeUInt;
begin
  if not Assigned(P) then
    Exit(SecureAlloc(NewSize));
  
  if NewSize = 0 then
  begin
    SecureFree(P);
    Exit(nil);
  end;
  
  // Get old size
  Header := PNativeUInt(P);
  Dec(Header);
  OldSize := Header^;
  
  // Allocate new memory
  Result := SecureAlloc(NewSize);
  
  // Copy data
  if OldSize < NewSize then
    Move(P^, Result^, OldSize)
  else
    Move(P^, Result^, NewSize);
  
  // Free old memory
  SecureFree(P);
end;

class procedure TNakoMemoryManager.EnableLeakDetection;
begin
  MemoryLeakDetection := True;
  SetHeapTraceOptions([htoCheckHeap, htoTraceErrors, htoUseHeapTrace]);
end;

class procedure TNakoMemoryManager.DumpMemoryStats;
begin
  WriteLn('=== Memory Statistics ===');
  WriteLn(Format('Active allocations: %d', [AllocationCount]));
  WriteLn(Format('Total allocated: %d bytes', [TotalAllocated]));
  WriteLn('========================');
end;

class function TNakoMemoryManager.SecureStrCopy(Dest, Source: PChar; DestSize: SizeInt): PChar;
var
  SourceLen: SizeInt;
begin
  if not Assigned(Dest) or (DestSize <= 0) then
    raise Exception.Create('Invalid destination buffer');
  
  if not Assigned(Source) then
  begin
    Dest^ := #0;
    Exit(Dest);
  end;
  
  SourceLen := StrLen(Source);
  if SourceLen >= DestSize then
    SourceLen := DestSize - 1;
  
  Move(Source^, Dest^, SourceLen);
  Dest[SourceLen] := #0;
  Result := Dest;
end;

class function TNakoMemoryManager.SecureStrCat(Dest, Source: PChar; DestSize: SizeInt): PChar;
var
  DestLen, SourceLen: SizeInt;
begin
  if not Assigned(Dest) or (DestSize <= 0) then
    raise Exception.Create('Invalid destination buffer');
  
  if not Assigned(Source) then
    Exit(Dest);
  
  DestLen := StrLen(Dest);
  SourceLen := StrLen(Source);
  
  if DestLen + SourceLen >= DestSize then
    SourceLen := DestSize - DestLen - 1;
  
  if SourceLen > 0 then
  begin
    Move(Source^, Dest[DestLen], SourceLen);
    Dest[DestLen + SourceLen] := #0;
  end;
  
  Result := Dest;
end;

initialization
  TNakoMemoryManager.Instance;

finalization
  FreeAndNil(TNakoMemoryManager.FInstance);

end.
