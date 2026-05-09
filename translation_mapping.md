# Nadesiko English Translation Mapping

## Core Function Translations

### Basic I/O Functions
| Japanese | English | Description |
|----------|---------|-------------|
| 表示 | PRINT | Display message |
| 言 | SAY | Speak message |
| もらう | INPUT | Get user input |
| イエスノー | YESNO | Ask yes/no question |
| エラー表示 | ERROR | Show error message |
| デバッグ | DEBUG | Show debug dialog |

### Control Flow
| Japanese | English | Description |
|----------|---------|-------------|
| もし | IF | Conditional statement |
| ならば | THEN | Then clause |
| 違えば | ELSE | Else clause |
| 繰り返す | LOOP | Repeat loop |
| ながら | WHILE | While loop |
| 回 | FOR | For loop |
| 抜ける | BREAK | Break from loop |
| 続ける | CONTINUE | Continue loop |

### Variable Operations
| Japanese | English | Description |
|----------|---------|-------------|
| 変数 | VAR | Variable declaration |
| それ | IT | Special variable "it" |
| 代入 | ASSIGN | Assignment |
| 参照 | REFERENCE | Reference |
| エイリアス | ALIAS | Create alias |

### Data Type Functions
| Japanese | English | Description |
|----------|---------|-------------|
| 文字列変換 | TOSTR | Convert to string |
| 整数変換 | TOINT | Convert to integer |
| 実数変換 | TOFLOAT | Convert to float |
| ハッシュ変換 | TOHASH | Convert to hash |
| 配列 | ARRAY | Array operations |
| ハッシュ | HASH | Hash operations |
| グループ | GROUP | Group operations |

### Mathematical Functions
| Japanese | English | Description |
|----------|---------|-------------|
| 足す | ADD | Addition |
| 引く | SUB | Subtraction |
| 掛ける | MUL | Multiplication |
| 割る | DIV | Division |
| 剰余 | MOD | Modulo |
| 整数 | INT | Integer part |
| 符号 | SIGN | Sign of number |
| サイン | SIN | Sine function |
| コサイン | COS | Cosine function |
| タンジェント | TAN | Tangent function |

### String Operations
| Japanese | English | Description |
|----------|---------|-------------|
| 文字列 | STRING | String operations |
| 文字抜出 | SUBSTR | Extract substring |
| 文字置換 | REPLACE | Replace text |
| 文字検索 | FIND | Find text |
| 文字長 | LENGTH | String length |
| 文字結合 | CONCAT | Concatenate strings |

### File Operations
| Japanese | English | Description |
|----------|---------|-------------|
| ファイル読 | FREAD | Read file |
| ファイル書 | FWRITE | Write file |
| ファイル存在 | FEXISTS | Check file exists |
| ファイル削除 | FDELETE | Delete file |
| フォルダ作成 | MKDIR | Create directory |
| フォルダ削除 | RMDIR | Remove directory |

### System Functions
| Japanese | English | Description |
|----------|---------|-------------|
| システム時間 | SYSTIME | Get system time |
| 実行 | EXEC | Execute command |
| 終了 | EXIT | Exit program |
| 待つ | WAIT | Wait/ delay |
| スリープ | SLEEP | Sleep |

### Comparison Operations
| Japanese | English | Description |
|----------|---------|-------------|
| 等しい | EQ | Equal comparison |
| 等しくない | NE | Not equal |
| 大きい | GT | Greater than |
| 小さい | LT | Less than |
| 以上 | GE | Greater or equal |
| 以下 | LE | Less or equal |

### Logical Operations
| Japanese | English | Description |
|----------|---------|-------------|
| かつ | AND | Logical AND |
| または | OR | Logical OR |
| でない | NOT | Logical NOT |

### Function Definition
| Japanese | English | Description |
|----------|---------|-------------|
| 関数 | FUNCTION | Function definition |
| 引数 | ARG | Function argument |
| 戻る | RETURN | Return value |

### Error Handling
| Japanese | English | Description |
|----------|---------|-------------|
| エラー | ERROR | Error handling |
| 例外 | EXCEPTION | Exception handling |
| 試す | TRY | Try block |
| 捕捉 | CATCH | Catch block |

### Plugin/System Extensions
| Japanese | English | Description |
|----------|---------|-------------|
| プラグイン | PLUGIN | Plugin operations |
| 読込 | IMPORT | Import module |
| 定義 | DEFINE | Definition |

## System Variable Translations

| Japanese | English | Description |
|----------|---------|-------------|
| なでしこバージョン | NADESIKO_VERSION | Nadesiko version |
| なでしこ最終更新日 | NADESIKO_UPDATE_DATE | Last update date |
| エラーメッセージ | ERROR_MESSAGE | Error message |
| 母艦パス | BASE_PATH | Base path |
| コマンドライン | COMMAND_LINE | Command line arguments |

## Particle Translations (助詞)

| Japanese | English | Usage |
|----------|---------|-------|
| と | WITH | "AとB" -> "A WITH B" |
| を | OBJECT | "Aを表示" -> "PRINT A" |
| に | TO | "AにBを" -> "B TO A" |
| の | OF | "AのB" -> "B OF A" |
| で | BY | "AでB" -> "B BY A" |
| から | FROM | "AからB" -> "B FROM A" |
| まで | UNTIL | "AまでB" -> "B UNTIL A" |
| は | TOPIC | "AはB" -> "TOPIC A, B" |
| も | ALSO | "AもB" -> "A ALSO B" |

## Implementation Strategy

1. **Function Names**: Translate Japanese function names to English equivalents
2. **System Messages**: Convert all system messages and error strings
3. **Comments**: Translate code comments to English
4. **Documentation**: Update all documentation files
5. **Sample Programs**: Translate sample code to demonstrate English usage
6. **Particle System**: Maintain particle-based syntax but with English particles where appropriate

## Priority Order

1. Core system functions (high priority)
2. Built-in functions (high priority) 
3. Error messages (high priority)
4. Component translations (medium priority)
5. Sample programs (medium priority)
6. Documentation (medium priority)
7. Build scripts (low priority)
