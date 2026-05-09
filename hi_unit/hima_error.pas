unit hima_error;

interface
//{$DEFINE ERROR_LOG}


uses
  {$IFDEF Win32}
  Windows,
  mmsystem,
  {$ELSE}
  unit_fpc,
  dos,
  {$ENDIF}
  SysUtils, Classes, hima_types;

type
  // デバッグ.ソースコード情報 32 bit
  TDebugInfo = packed record
    Flag    : Byte; // 未使用
    FileNo  : Byte; // 0..255
    LineNo  : WORD; // 0..65535
  end;

  EHimaSyntax = class(Exception)
  public
    constructor Create(FileNo, LineNo: Integer; Msg: AnsiString; Args: array of const); overload;
    constructor Create(DInfo: TDebugInfo; Msg: AnsiString; Args: array of const); overload;
  end;
  EHimaRuntime = class(EHimaSyntax)
  end;

const
  // 構文のメッセージ
  ERR_NOPAIR_STRING   = 'Unmatched quotation mark.';
  ERR_NOPAIR_STRING2  = 'Unmatched brackets 「」.';
  ERR_NOPAIR_STRING3  = 'Unmatched quotes "...".';
  ERR_NOPAIR_STRING4  = 'Unmatched backquotes `...`.';
  ERR_NOPAIR_COMMENT  = 'Unmatched comment /* ... */.';
  ERR_NOPAIR_KAKU     = 'Unmatched square brackets [...].';
  ERR_NOPAIR_KAKKO    = 'Unmatched parentheses (...).';
  ERR_NOPAIR_NAMI     = 'Unmatched braces {...}.';
  ERR_INVALID_SIKI    = 'Failed to parse calculation expression.';
  ERR_SYNTAX          = 'Syntax error.';
  ERR_STACK_OVERFLOW  = 'Recursion stack depth exceeded.';
  ERR_SECURITY        = 'Security error.';
  // 一つのメッセージ
  ERR_S_SOURCE_DUST   = 'Unknown character "%s" in program.';
  ERR_S_UNDEFINED     = 'Undefined word "%s".';
  ERR_S_UNDEF_OPTION  = '"%s" is undefined execution option.';
  ERR_S_UNDEF_MARK    = 'Unary operator "%s" found. Has no meaning alone.';
  ERR_S_UNDEF_GROUP   = '"%s" is not defined as group.';
  ERR_S_SYNTAX        = 'Syntax error. Cannot use "%s" at this position.';
  ERR_S_STRICT_UNDEF  = 'Undefined word "%s". Please declare it.';
  ERR_S_VARINIT_UNDEF = 'Using word "%s" without initialization.';
  ERR_S_VAR_ELEMENT   = 'Cannot read element of variable "%s".';
  ERR_S_DEF_FUNC      = 'Syntax error in function "%s" declaration.';
  ERR_S_DEF_GROUP     = 'Syntax error in group "%s" declaration.';
  ERR_S_DEF_VAR       = 'Variable "%s" definition is incorrect.';
  ERR_S_DLL_FUNCTION_EXEC = 'Error occurred in DLL function "%s" execution.';
  ERR_S_FUNCTION_EXEC = 'Error occurred in function "%s" execution.';
  ERR_S_CALL_FUNC     = 'Syntax error in function "%s" call.';
  // 二つのメッセージ
  ERR_SS_FUNC_ARG     = 'Argument "%s" of function "%s" is missing.';
  ERR_SS_UNDEF_GROUP  = 'Group "%s" does not have member "%s". Please check.';

  //----------------------------------------------------------------------------
  // 実行のエラー(なし)
  ERR_RUN_CALC        = 'Duplicate calculation found in expression.';
  // 実行のエラー(あり)
  ERR_S_RUN_VALUE     = 'Cannot get value of variable "%s".';


var
  HimaErrorMessage: AnsiString;
  HimaFileList: TStringList; // ひまわりで使うファイルの管理用

function setSourceFileName(fname: string): Integer; // ソースファイルを登録する
function ErrFmt(FileNo, LineNo: Integer; Msg: AnsiString; Args: array of const): AnsiString;

procedure debugi(i:Integer);
procedure debugs(s: AnsiString);

var useErrorLog:Boolean = False; // <--- for DEBUG
var FileErrLog: TextFile;
procedure errLog(s: AnsiString);

implementation

uses hima_string, unit_string, hima_variable, hima_system;

var
  HimaLog: AnsiString = '';

procedure debugi(i:Integer);
var s: AnsiString;
begin
  s := IntToStrA(i);
  {$IFDEF Win32}
  MessageBoxA(0, PAnsiChar(s), 'debug', MB_OK);
  {$ELSE}
  WriteLn('[DEBUG]', s);
  {$ENDIF}
end;

procedure debugs(s: AnsiString);
begin
  {$IFDEF Win32}
  MessageBoxA(0, PAnsiChar(s), 'debug', MB_OK);
  {$ELSE}
  WriteLn('[DEBUG]', s);
  {$ENDIF}
end;

function setSourceFileName(fname: string): Integer;
begin
  Result := HimaFileList.IndexOf(fname);
  if Result < 0 then
  begin
    Result := HimaFileList.Add(fname);
  end;
end;

var last_err_result : AnsiString = '';
var last_err_file   : AnsiString = '';

function ErrFmt(FileNo, LineNo: Integer; Msg: AnsiString; Args: array of const): AnsiString;
var
  fname, s, file_info: AnsiString;
const
  err_h    = '[ERROR] ';
  err_same = 'Error for same reason as previous.';
begin
  //=== ファイル名の取得
  if FileNo < 0 then
  begin
    fname := '評価式';
  end else
  begin
    // ファイル名を得る
    if FileNo < HimaFileList.Count then
    begin
      try
        fname := AnsiString(ExtractFileName(HimaFileList.Strings[FileNo]));
      except fname := ''; end;
    end else
    begin
      fname := '評価式';
    end;
  end;
  //=== エラーメッセージと引数を組み合わせる
  try
    s := FormatA(Msg, Args);
  except
    s := Msg;
  end;

  //=== ファイル番号とエラーメッセージを組み立てる
  file_info := fname + '(' + IntToStrA(LineNo) + '): ';

  // 重複する部分を削除

  if last_err_result <> '' then // 前回との完全重複を削除
  begin
    s := JReplaceA(s, last_err_result, '');
  end;

  if (Copy(s, 1, Length(err_h))=err_h) then // head
  begin
    getToken_s(s, ':'); // ヘッダをばっさり切り取る
  end;

  s := TrimA(s);
  if (s = '')and(HimaErrorMessage <> '') then
  begin
    s := err_same;
  end;

  //-------------------
  // 結果を返す
  Result := err_h + file_info + s;
  last_err_result := Result;

  // もしエラーメッセージ中で重複がなければ追加
  if (Pos(Result, HimaErrorMessage) = 0) then
  begin
    if PosA(err_same, Result) > 0 then // 同じだが前回と違う行なら出力
    begin
      if last_err_file = file_info then Exit;
    end;
    HimaErrorMessage := HimaErrorMessage + Result + #13#10;
    last_err_file := file_info;
  end;

end;

var
  LogTime: DWORD;
  fOpen: Boolean = False;

function TempDir: string;
{$IFDEF Win32}
var
 TempTmp: Array [0..MAX_PATH] of Char;
begin
 GetTempPath(MAX_PATH, TempTmp);
 Result:= string(TempTmp);
 if Copy(Result,Length(Result),1)<>'\' then Result := Result + '\';
end;
{$ELSE}
var home: string;
begin
  home := GetEnv('HOME');
  Result := home + '/.temp';
end;
{$ENDIF}

procedure errLog(s: AnsiString);
var
  logname: string;
begin
  if not useErrorLog then Exit;
  if not fOpen then
  begin
    logname := string(TempDir + 'nakolog_' + FormatDateTime('hhnnss',Now) + '.txt');
    AssignFile(FileErrLog, logname);
    Rewrite(FileErrLog);
    LogTime := timeGetTime;
    fOpen := True;
  end;
  Writeln(
    FileErrLog,
    Format('%0.5d',[(timeGetTime-LogTime)]) + ':' + string(s)
  );
end;

{ EHimaSyntax }

constructor EHimaSyntax.Create(FileNo, LineNo: Integer; Msg: AnsiString;
  Args: array of const);
begin
  inherited Create(
    string(ErrFmt(FileNo, LineNo, (Msg), Args))
  );
  hi_setStr(HiSystem.ErrMsg, HimaErrorMessage);
end;

constructor EHimaSyntax.Create(DInfo: TDebugInfo; Msg: AnsiString;
  Args: array of const);
begin
  inherited Create(string(ErrFmt(DInfo.FileNo, DInfo.LineNo, Msg, Args)));
  hi_setStr(HiSystem.ErrMsg, HimaErrorMessage);
end;

initialization
  HimaFileList := TStringList.Create;

finalization
  FreeAndNil(HimaFileList);
  if useErrorLog then CloseFile(FileErrLog);


end.
