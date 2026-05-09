# Nadesiko English Edition Guide

## Overview

This document describes the English translation of the Nadesiko programming language. The original Japanese language has been translated to English while maintaining the natural language programming paradigm that makes Nadesiko unique.

## Translation Philosophy

The translation maintains the core principles of Nadesiko:
- Natural language syntax
- Readability and expressiveness
- Easy learning curve for beginners
- Powerful functionality for advanced users

## Basic Syntax

### Variable Declaration
```
VAR X IS 10
VAR NAME IS "Nadesiko"
VAR ARRAY IS [1, 2, 3]
```

### Basic Operations
```
# Arithmetic
ASSIGN 5 to X
ADD 3 to X
RESULT = X + Y

# Comparison
IF X > Y THEN
  SAY "X is greater"
END

# Loops
FOR COUNT from 1 to 10
  SAY "Count: {COUNT}"
END

WHILE condition
  # loop body
END
```

## Function Categories

### Input/Output Functions
- `SAY "message"` - Display message in dialog
- `INPUT "prompt"` - Get user input
- `YESNO "question"` - Ask yes/no question
- `PRINT "text"` - Print text (traditional output)

### Mathematical Functions
- `ADD`, `SUB`, `MUL`, `DIV` - Basic arithmetic
- `SIN`, `COS`, `TAN` - Trigonometric functions
- `ABS`, `SQRT`, `EXP` - Mathematical utilities
- `RANDOM` - Generate random numbers

### Type Conversion
- `TOSTR(value)` - Convert to string
- `TOINT(value)` - Convert to integer
- `TOFLOAT(value)` - Convert to float
- `TOHASH(value)` - Convert to hash

### Control Flow
- `IF condition THEN ... ELSE ... END` - Conditional
- `FOR variable from start to end` - For loop
- `WHILE condition` - While loop
- `BREAK`, `CONTINUE` - Loop control
- `RETURN value` - Function return

### Variable Management
- `ENUM_VARS` - List variables
- `VAR_EXISTS` - Check variable existence
- `TYPEOF` - Get variable type
- `CREATE_ALIAS` - Create variable alias

### System Functions
- `SYSTIME` - Get system time
- `GET_ENV` - Get environment variable
- `COMMAND_LINE` - Get command line arguments
- `DEBUG` - Show debug dialog

## Comparison with Japanese Original

| Japanese | English | Description |
|----------|---------|-------------|
| 言う | SAY | Display message |
| もし | IF | Conditional statement |
| ならば | THEN | Then clause |
| 違えば | ELSE | Else clause |
| 繰り返す | REPEAT | Repeat loop |
| 足す | ADD | Addition |
| 引く | SUB | Subtraction |
| 掛ける | MUL | Multiplication |
| 割る | DIV | Division |

## Sample Programs

### Hello World
```nadesiko
SAY "Hello, World!"
```

### Calculator
```nadesiko
VAR A IS 10
VAR B IS 20
VAR RESULT

RESULT = A + B
SAY "Sum: {RESULT}"

RESULT = A * B
SAY "Product: {RESULT}"
```

### Loop Example
```nadesiko
FOR I from 1 to 5
  SAY "Number: {I}"
END
```

### Function Definition
```nadesiko
FUNCTION FACTORIAL(N)
  IF N <= 1 THEN
    RETURN 1
  ELSE
    RETURN N * FACTORIAL(N - 1)
  END
END

VAR RESULT = FACTORIAL(5)
SAY "5! = {RESULT}"
```

## Migration Guide

For existing Nadesiko programs in Japanese, here are common translation patterns:

1. Replace Japanese function names with English equivalents
2. Update particle usage (を → to, に → to, の → of, で → by/with)
3. Translate string literals and comments
4. Update variable names if desired (optional)

### Example Migration

**Original Japanese:**
```nadesiko
Aに5を足す。
Aを表示。
```

**English Translation:**
```nadesiko
ADD 5 to A
SAY A
```

## Compatibility

The English edition maintains full compatibility with:
- All existing Nadesiko libraries and plugins
- File I/O operations
- Network functions
- GUI components
- Database connectivity

## Future Development

The English translation opens Nadesiko to:
- International programming education
- Cross-language development teams
- English-speaking developer community
- Academic research in natural language programming

## Contributing

To contribute to the English translation:
1. Follow the established naming conventions
2. Maintain consistency with original functionality
3. Provide clear documentation for new functions
4. Test thoroughly with existing programs

## Resources

- Original Japanese documentation
- Translation mapping file (`translation_mapping.md`)
- Sample programs in `sample/` directory
- Build instructions in `ReadMe.md`

---

*This guide represents the first comprehensive English translation of the Nadesiko programming language, maintaining its natural language paradigm while making it accessible to English-speaking developers worldwide.*
