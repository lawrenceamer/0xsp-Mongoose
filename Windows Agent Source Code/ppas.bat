@echo off
SET THEFILE=C:\mongoose\agent.exe
echo Linking %THEFILE%
C:\lazarus\fpc\3.0.4\bin\x86_64-win64\ld.exe -b pei-x86-64  --gc-sections  -s  --entry=_mainCRTStartup    -o C:\mongoose\agent.exe C:\mongoose\link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
