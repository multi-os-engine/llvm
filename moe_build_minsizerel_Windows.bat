@echo off

cd %~dp0/../

set PYTHON_EXE=python.exe
%PYTHON_EXE% --version >NUL 2>&1
if "%ERRORLEVEL%" == "0" (
    echo|set /p=INFO: Python found in PATH:
    where %PYTHON_EXE%
    goto check_ninja
)

echo.
echo ERROR: no 'python' command could be found in your PATH.
echo.
echo Please add to PATH location of your Python installation

goto fail

:check_ninja
set NINJA_EXE=ninja.exe
%NINJA_EXE% --version >NUL 2>&1
if "%ERRORLEVEL%" == "0" (
    echo|set /p=INFO: Ninja found in PATH:
    where %NINJA_EXE%
    goto init
)

echo.
echo ERROR: no 'ninja' command could be found in your PATH.
echo.
echo Please add to PATH location of your Ninja installation

goto fail

:init
if not exist "llvm-build-minsizerel-Windows" (
    md llvm-build-minsizerel-Windows
    cd llvm-build-minsizerel-Windows
    cmake -DCMAKE_BUILD_TYPE=MinSizeRel -G "Ninja" ../llvm -DLLDB_DISABLE_PYTHON=1
) else (
    cd llvm-build-minsizerel-Windows
)

ninja -j8

:fail
    pause
