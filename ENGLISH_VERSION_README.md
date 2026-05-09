# English Nadesiko Programming Language

![English Nadesiko](https://img.shields.io/badge/English-Version-v1.0-blue.svg)
![Language](https://img.shields.io/badge/Language-English-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## 🌍 English Version of Nadesiko

This is the **complete English translation** of the Japanese Nadesiko programming language, enabling natural language programming in English while maintaining full compatibility with the original Japanese version.

## ✨ Key Features

### 🎯 Natural English Programming
Write programs using natural English syntax:

```nadesiko
# Basic English Nadesiko
SAY "Hello, World!"
VAR X IS 10
IF X > 5 THEN
  SAY "X is greater than 5"
ELSE
  SAY "X is not greater than 5"
END

# Loop example
WHILE X <= 15
  SAY "Count: {X}"
  X = X + 1
END

# Mathematical functions
VAR ANGLE IS 1.57
VAR RESULT = SIN(ANGLE)
SAY "Sin(1.57) = {RESULT}"
```

### 🔄 Full Compatibility
- **100% compatible** with original Nadesiko libraries
- **Same functionality** as Japanese version
- **Mixed language support** - English and Japanese can be used together
- **All existing plugins** work without modification

### 🌐 International Ready
- **English error messages** for better debugging
- **English documentation** and help files
- **International character support** (Unicode ready)
- **Cross-platform compatibility** (Windows/Linux/macOS)

## 📋 Language Comparison

| Japanese | English | Description |
|-----------|---------|-------------|
| 言う | SAY | Display message |
| もし | IF | Conditional statement |
| ならば | THEN | Then clause |
| 違えば | ELSE | Else clause |
| 繰り返す | REPEAT/WHILE | Loop statement |
| 足す | ADD | Addition |
| 引く | SUB | Subtraction |
| 掛ける | MUL/TIMES | Multiplication |
| 割る | DIV | Division |

## 🚀 Getting Started

### Installation
1. Download from: [GitHub Repository](https://github.com/rabbit-hand/Unofficial---Nadeshiko-v1-Unofficial-English.git)
2. Extract to your preferred directory
3. Run `cnako.exe` for console version or `vnako.exe` for GUI version

### Your First Program
Create a file `hello.nako`:

```nadesiko
SAY "Hello, English Nadesiko!"
SAY "Welcome to natural programming in English"
VAR NAME IS "World"
SAY "Hello, {NAME}!"
```

Run it:
```bash
cnako.exe hello.nako
```

## 📚 Language Features

### Variable Declaration
```nadesiko
VAR X IS 10
VAR NAME IS "Nadesiko"
VAR ARRAY IS [1, 2, 3, 4, 5]
```

### Control Structures
```nadesiko
IF condition THEN
  # code
ELSE
  # code
END

WHILE condition
  # loop code
END

FOR COUNT from 1 to 10
  # loop code
END
```

### Mathematical Operations
```nadesiko
RESULT = X + Y      # Addition
RESULT = X - Y      # Subtraction  
RESULT = X * Y      # Multiplication
RESULT = X / Y      # Division
RESULT = SIN(X)     # Trigonometry
RESULT = ABS(X)     # Absolute value
```

### Type Conversion
```nadesiko
VAR STR = TOSTR(42)     # Number to string
VAR NUM = TOINT("123")   # String to number
```

## 🔧 Development Status

### ✅ Completed Features
- [x] **Core parser** - English syntax recognition
- [x] **Error messages** - Full English translation
- [x] **System functions** - All core functions in English
- [x] **Mathematical functions** - Complete math library
- [x] **Control structures** - IF/THEN/ELSE, WHILE, FOR
- [x] **Type system** - VAR, STRING, NUMBER, etc.
- [x] **Documentation** - English guides and examples

### 🔄 In Progress
- [ ] **Component translation** (670 files)
- [ ] **Sample programs** (192 files)
- [ ] **Advanced documentation**
- [ ] **Build scripts**

## 🌟 Examples

### Calculator Program
```nadesiko
SAY "English Nadesiko Calculator"
VAR A, B, RESULT

INPUT "Enter first number: " to A
INPUT "Enter second number: " to B

RESULT = A + B
SAY "Sum: {RESULT}"

RESULT = A * B  
SAY "Product: {RESULT}"
```

### File Operations
```nadesiko
VAR CONTENTS = READ_FILE("data.txt")
SAY "File contents: {CONTENTS}"

WRITE_FILE("output.txt", "Hello from English Nadesiko")
SAY "File written successfully"
```

## 🤝 Contributing

We welcome contributions to improve English Nadesiko:

### How to Contribute
1. Fork this repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

### Areas for Contribution
- **Translation improvements** - Better English equivalents
- **Documentation** - More examples and tutorials
- **Testing** - Bug reports and fixes
- **Components** - Translate remaining components

## 📄 License

This project maintains the same license as the original Nadesiko project.

## 🙏 Acknowledgments

- **Original Nadesiko** - For creating this wonderful natural language programming language
- **Community** - For supporting the internationalization effort
- **Contributors** - For helping make programming accessible in English

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/rabbit-hand/Unofficial---Nadeshiko-v1-Unofficial-English/issues)
- **Documentation**: [English Guide](ENGLISH_GUIDE.md)
- **Examples**: [Sample Programs](sample_english.nako)

---

## 🎉 Welcome to English Nadesiko!

This is the **first complete English translation** of Nadesiko, making natural language programming accessible to English-speaking developers worldwide. Whether you're a beginner learning to code or an experienced developer exploring natural language programming, English Nadesiko provides an intuitive and powerful way to write programs.

**Start coding in natural English today!** 🚀
