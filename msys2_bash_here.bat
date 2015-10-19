@echo off

set WD=%~dp0
set MSYSTEM=MSYS

if NOT EXIST %WD%usr\bin\msys-2.0.dll goto PathError

rem Run directly, add context menu entry to reginstry
if "%1" == "" goto INSTALL
goto START

:START
rem Start bash from the directory of %1
cd /d %1
start %WD%usr\bin\mintty -i /msys2.ico /bin/env CHERE_INVOKING=1 /bin/bash --login
exit

:INSTALL
set /p answer="Add msys2 bash here context menu entry? [Y/N]"
if "%answer%" == "y" goto DOINSTALL
if "%answer%" == "Y" goto DOINSTALL
exit

:DOINSTALL
reg add HKCU\Software\Classes\Directory\Background\Shell\msys2_bash_here /d "MSys2 Ba&sh Here" /f
reg add HKCU\Software\Classes\Directory\Background\Shell\msys2_bash_here\command /d "cmd /a /k %WD%msys2_bash_here.bat \"%%V\"" /f
reg add HKCU\Software\Classes\Directory\Background\Shell\msys2_bash_here /v "Icon" /t REG_SZ /d "%WD%msys2.ico" /f

reg add HKCU\Software\Classes\Folder\Shell\msys2_bash_here /d "MSys2 Ba&sh Here" /f
reg add HKCU\Software\Classes\Folder\Shell\msys2_bash_here\command /d "cmd /a /k %WD%msys2_bash_here.bat \"%%V\"" /f
reg add HKCU\Software\Classes\Folder\Shell\msys2_bash_here /v "Icon" /t REG_SZ /d "%WD%msys2.ico" /f
echo "Add to registry finished"
pause
exit

:EXIT
exit

:PathError
echo "This batch script should locate at the root directory of msys2"
pause
exit