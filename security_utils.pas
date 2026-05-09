unit security_utils;

// Security utilities for なでしこ modernization
// Input validation, sanitization, and security functions

interface

uses
  SysUtils, Classes, StrUtils;

type
  TNakoSecurityUtils = class
  public
    // Input validation
    class function ValidateFilePath(const Path: string): Boolean;
    class function ValidateFileName(const FileName: string): Boolean;
    class function ValidateCommand(const Command: string): Boolean;
    
    // Input sanitization
    class function SanitizeFileName(const FileName: string): string;
    class function SanitizeCommandLine(const CmdLine: string): string;
    class function SanitizeHTML(const HTML: string): string;
    
    // Path security
    class function IsPathSafe(const BasePath, TargetPath: string): Boolean;
    class function GetCanonicalPath(const Path: string): string;
    
    // String security
    class function SecureCompare(const Str1, Str2: string): Boolean;
    class function GenerateSecureToken: string;
    
    // Encoding security
    class function SafeBase64Encode(const Data: string): string;
    class function SafeBase64Decode(const Encoded: string): string;
  end;

// Security constants
const
  MAX_PATH_LENGTH = 260;
  MAX_COMMAND_LENGTH = 32768;
  ALLOWED_FILE_CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789._-';
  DANGEROUS_COMMANDS = ['DEL', 'FORMAT', 'RD', 'RMDIR', 'DELTREE', 'FORMAT.COM'];

implementation

{ TNakoSecurityUtils }

class function TNakoSecurityUtils.ValidateFilePath(const Path: string): Boolean;
var
  FullPath: string;
begin
  Result := False;
  
  // Check length
  if Length(Path) = 0 then Exit;
  if Length(Path) > MAX_PATH_LENGTH then Exit;
  
  // Check for dangerous patterns
  if ContainsStr(Path, '..') then Exit;
  if ContainsStr(Path, '://') then Exit;
  
  // Check for invalid characters
  if ContainsStr(Path, '<') or ContainsStr(Path, '>') or 
     ContainsStr(Path, '|') or ContainsStr(Path, '"') then Exit;
  
  // Check if path exists (optional)
  FullPath := GetCanonicalPath(Path);
  Result := DirectoryExists(ExtractFilePath(FullPath)) or FileExists(FullPath);
end;

class function TNakoSecurityUtils.ValidateFileName(const FileName: string): Boolean;
var
  i: Integer;
  c: Char;
begin
  Result := False;
  
  // Check length
  if Length(FileName) = 0 then Exit;
  if Length(FileName) > 255 then Exit;
  
  // Check for reserved names
  if SameText(FileName, 'CON') or SameText(FileName, 'PRN') or
     SameText(FileName, 'AUX') or SameText(FileName, 'NUL') then Exit;
  
  if StartsText('COM', FileName) or StartsText('LPT', FileName) then Exit;
  
  // Check each character
  for i := 1 to Length(FileName) do
  begin
    c := FileName[i];
    if Pos(c, ALLOWED_FILE_CHARS) = 0 then Exit;
  end;
  
  Result := True;
end;

class function TNakoSecurityUtils.ValidateCommand(const Command: string): Boolean;
var
  UpperCmd: string;
  i: Integer;
begin
  Result := False;
  
  // Check length
  if Length(Command) = 0 then Exit;
  if Length(Command) > MAX_COMMAND_LENGTH then Exit;
  
  // Check for dangerous commands
  UpperCmd := UpperCase(Command);
  for i := Low(DANGEROUS_COMMANDS) to High(DANGEROUS_COMMANDS) do
  begin
    if ContainsStr(UpperCmd, DANGEROUS_COMMANDS[i]) then Exit;
  end;
  
  // Check for pipe redirection (potential command injection)
  if ContainsStr(Command, '|') or ContainsStr(Command, '&') or
     ContainsStr(Command, ';') or ContainsStr(Command, '`') then Exit;
  
  Result := True;
end;

class function TNakoSecurityUtils.SanitizeFileName(const FileName: string): string;
var
  i: Integer;
  c: Char;
begin
  Result := '';
  
  for i := 1 to Length(FileName) do
  begin
    c := FileName[i];
    if Pos(c, ALLOWED_FILE_CHARS) > 0 then
      Result := Result + c
    else
      Result := Result + '_';
  end;
  
  // Ensure not empty
  if Result = '' then
    Result := 'unnamed';
end;

class function TNakoSecurityUtils.SanitizeCommandLine(const CmdLine: string): string;
var
  i: Integer;
  c: Char;
  InQuotes: Boolean;
begin
  Result := '';
  InQuotes := False;
  
  for i := 1 to Length(CmdLine) do
  begin
    c := CmdLine[i];
    
    case c of
      '"': InQuotes := not InQuotes;
      '|', '&', ';', '`', '<', '>': 
        if not InQuotes then
          Result := Result + ' '  // Replace dangerous chars with space
        else
          Result := Result + c;
    else
      Result := Result + c;
    end;
  end;
  
  // Trim and clean
  Result := Trim(Result);
end;

class function TNakoSecurityUtils.SanitizeHTML(const HTML: string): string;
begin
  Result := HTML;
  
  // Basic HTML sanitization
  Result := StringReplace(Result, '<', '&lt;', [rfReplaceAll]);
  Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll]);
  Result := StringReplace(Result, '"', '&quot;', [rfReplaceAll]);
  Result := StringReplace(Result, '''', '&#x27;', [rfReplaceAll]);
  Result := StringReplace(Result, '&', '&amp;', [rfReplaceAll]);
  
  // Fix &amp; that were already valid
  Result := StringReplace(Result, '&amp;amp;', '&amp;', [rfReplaceAll]);
end;

class function TNakoSecurityUtils.IsPathSafe(const BasePath, TargetPath: string): Boolean;
var
  CanonicalBase, CanonicalTarget: string;
begin
  CanonicalBase := GetCanonicalPath(BasePath);
  CanonicalTarget := GetCanonicalPath(TargetPath);
  
  // Check if target path is within base path
  Result := StartsText(CanonicalBase, CanonicalTarget);
end;

class function TNakoSecurityUtils.GetCanonicalPath(const Path: string): string;
begin
  Result := ExpandFileName(Path);
  Result := StringReplace(Result, '/', '\', [rfReplaceAll]);
  
  // Remove trailing backslash (except for root)
  if (Length(Result) > 3) and (Result[Length(Result)] = '\') then
    SetLength(Result, Length(Result) - 1);
end;

class function TNakoSecurityUtils.SecureCompare(const Str1, Str2: string): Boolean;
var
  i: Integer;
  Diff: Integer;
begin
  if Length(Str1) <> Length(Str2) then
  begin
    Result := False;
    Exit;
  end;
  
  Diff := 0;
  for i := 1 to Length(Str1) do
    Diff := Diff or Ord(Str1[i]) xor Ord(Str2[i]);
  
  Result := Diff = 0;
end;

class function TNakoSecurityUtils.GenerateSecureToken: string;
const
  TokenChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
var
  i: Integer;
begin
  Randomize;
  Result := '';
  for i := 1 to 32 do
    Result := Result + TokenChars[Random(Length(TokenChars)) + 1];
end;

class function TNakoSecurityUtils.SafeBase64Encode(const Data: string): string;
begin
  // Use built-in encoding with validation
  try
    Result := EncodeStringBase64(Data);
  except
    on E: Exception do
      raise Exception.CreateFmt('Base64 encoding failed: %s', [E.Message]);
  end;
end;

class function TNakoSecurityUtils.SafeBase64Decode(const Encoded: string): string;
begin
  // Validate input format first
  if Length(Encoded) = 0 then
    raise Exception.Create('Empty Base64 string');
  
  if Length(Encoded) mod 4 <> 0 then
    raise Exception.Create('Invalid Base64 format');
  
  try
    Result := DecodeStringBase64(Encoded);
  except
    on E: Exception do
      raise Exception.CreateFmt('Base64 decoding failed: %s', [E.Message]);
  end;
end;

end.
