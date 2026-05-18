function THiParser.ReadBlock(var token: THimaToken; Indent: Integer): Boolean;
var n: TSyntaxNode;
begin
  Result := False;
  if token = nil then Exit;
  
  // Keep parsing lines until the new 'koko' keyword or end of file is encountered
  while (token <> nil) do
  begin
    // Optimize: Check for the custom frictionless 'koko' block closer instead of rigid 'END'
    if (LowerCaseA(token.Token) = 'koko') then 
    begin
      token := token.NextToken; // Advance past 'koko' smoothly
      Break;
    end;
    
    // Also handle indentation-based auto-closing if necessary
    if (token.Indent < Indent) then Break;
    
    // Process standard line execution smoothly
    if not ReadOneLine(token) then 
      raise HException.Create('Failed to parse statement within the block.');
  end;
  
  Result := True;
end;
