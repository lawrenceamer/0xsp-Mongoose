@echo off
SET THEFILE=C:\Users\Lawrence\Documents\GitHub\0xsp-Mongoose\agentsourcecode\agent.exe
echo Linking %THEFILE%
C:\fpcupdeluxe\fpc\bin\x86_64-win64\ld.exe -b pei-x86-64  --gc-sections  -s  --entry=_mainCRTStartup    -o C:\Users\Lawrence\Documents\GitHub\0xsp-Mongoose\agentsourcecode\agent.exe C:\Users\Lawrence\Documents\GitHub\0xsp-Mongoose\agentsourcecode\link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
