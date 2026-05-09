@echo off
echo Building Nadesiko v2.0...

REM Check if FPC is installed
where fpc >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Error: Free Pascal compiler not found
    echo Please install Free Pascal from https://www.freepascal.org/
    pause
    exit /b 1
)

REM Create directories
if not exist "build" mkdir "build"
if not exist "bin" mkdir "bin"

echo Building cnako.exe...
fpc -Mobjfpc -Scghi -O3 -Ci -Co -Cr -Sa -dUNICODE -dRELEASE -FEbin -FUbuild -Fihi_unit -Ficomponent cnako.dpr

if %ERRORLEVEL% equ 0 (
    echo SUCCESS: cnako.exe built
) else (
    echo FAILED: cnako.exe build failed
    pause
    exit /b 1
)

echo Build completed!
echo Executable: bin\cnako.exe
pause
