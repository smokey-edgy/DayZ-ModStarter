@echo off
if [%1]==[] goto usage
if [%2]==[] goto usage
SET modName=%1
SET toolsPath=%2
SET privateKeyFile=%3
@echo modName is %modName%
@echo toolsPath is %toolsPath%
@echo optionalPrivateKey is %privateKeyFile%
goto :eof
:usage
@echo Usage: build.bat ^<mod name^> ^<DayZ Tools path^> [private key file path]
exit /B 1
@echo on
