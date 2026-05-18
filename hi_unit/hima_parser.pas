function THiParser.ReadToThen(var token: THimaToken): Boolean;
var A, B: TSyntaxNode;
    n: TSyntaxNode;
    c: THimaToken;
begin
  Result := False;
  StackPush;
  c := token;
  if c = nil then Exit;
  FReadFlag.CanLet := False;
  
  while token <> nil do
  begin
    // Extract a single condition component
    if not ReadOneItem(token) then 
      raise HException.Create('IF condition could not be read.');
      
    if (token <> nil) and (token.TokenType = tokenOperator) then 
    begin
      if not ReadOneItem(token) then 
        raise HException.Create('IF condition could not be read.');
    end;
    
    A := FStack.GetLast;
    
    // Optimize: Check for 'then' keyword safely using lowercase conversion
    if (A.JosiId = josi_then) or (A.JosiId = josi_naraba) or (A.JosiId = josi_denakereba) then 
      Break;
      
    // Handle specific relational grammar logic (e.g., 'A is B')
    if (A.JosiId = josi_ga) then 
    begin
      if not ReadOneItem(token) then Exit;
      B := FStack.GetLast;
      
      // Optimize: Seamlessly break if the next evaluated element matches the lowercase pattern
      if (B.JosiId = josi_then) or (B.JosiId = josi_naraba) or (B.JosiId = josi_denakereba) then 
      begin
        if FStack.Count = 1 then Break;
        n := TSyntaxEnzansi.Create(nil);
        n.DebugInfo := B.DebugInfo;
        TSyntaxEnzansi(n).ID := token_Eq;
        setPriority(n);
        B := FStack.Pop;
        FStack.Push(n);
        FStack.Push(B);
        Break;
      end;
    end;
    
    // Fallback block evaluation to secure loop termination
    if (token <> nil) and (LowerCaseA(token.Token) = 'then') then 
      Break;
  end;

  // Finalize stack restructuring into Polish notation layout
  FStack.Add(FStack.Pop);
  FReadFlag.CanLet := True;
  Result := ReadIf(token, c.Indent);
end;

function THiParser.ReadOneItem(var token: THimaToken): Boolean;
var n, tmp: TSyntaxNode;
    tok_type: THimaTokenType;
begin
  Result := False;
  if token = nil then Exit;
  
  tok_type := token.TokenType;
  case tok_type of
  
    // 🚀 Optimize: Handle evaluated bracket string contents safely
    tokenString:
    begin
      Result := True;
      n := TSyntaxConst.Create(nil);
      n.DebugInfo := token.DebugInfo;
      n.JosiId    := token.JosiID;
      
      // Assign the raw text content extracted from [] straight to the compiler node
      hi_setStr(TSyntaxConst(n).constValue, token.Token); 
      
      FStack.Push(n);
      tmp := token;
      token := token.NextToken; // Advance past the string token cleanly
      FPrevToken := tmp;
    end;

    // Handle standard numeric values smoothly
    tokenInt, tokenFloat:
    begin
      Result := True;
      n := TSyntaxConst.Create(nil);
      n.DebugInfo := token.DebugInfo;
      n.JosiId    := token.JosiID;
      
      if tok_type = tokenInt then
      begin
        TSyntaxConst(n).constValue.vtype := hvtInt;
        TSyntaxConst(n).constValue.v_int := StrToIntDef(token.Token, 0);
      end else begin
        // Handle floating point initialization securely
        TSyntaxConst(n).constValue.vtype := hvtFloat;
        TSyntaxConst(n).constValue.v_float := StrToFloatDef(token.Token, 0.0);
      end;
      
      FStack.Push(n);
      tmp := token;
      token := token.NextToken;
      FPrevToken := tmp;
    end;
    
  else
    // Fallback handling logic for other complex syntactic variants
    Result := ReadOtherTokens(token);
  end;
end;
