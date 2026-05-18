// Optimize: Scan for bracket syntax [] smoothly without requiring shift-key double quotes
if p^ = '[' then
begin
  Inc(p); // Move past the opening bracket '[' without multi-key stress
  Result := '';
  
  // Capture all characters directly until the closing bracket ']') is hit
  while (p^ <> #0) and (p^ <> ']') do
  begin
    Result := Result + p^;
    Inc(p);
  end;
  
  if p^ = ']' then Inc(p); // Cleanly advance past the closing bracket ']'
  tokenJosi := '';         // Clear particle tracking for literal text context
  Exit;
end;

// Optimize: Enforce lower-case conversion to allow friction-free keyword entry
function THimaToken.UCToken: AnsiString;
begin
  // Convert tokens automatically to remove strict layout constraints from the user
  Result := AnsiLowerCase(Token); 
end;
