@ECHO OFF

SETLOCAL

IF NOT EXIST vars.bat GOTO :args

CALL vars.bat

REM Check if the approriate vars have been set; they're either all set or
REM you must use the command line args
IF ["%dayZServerRootDirectory%"]==[] GOTO :args

SET dayZServerRootDirectory="%dayZServerRootDirectory%"
GOTO :launchDayZServer

:args
IF [%1]==[] GOTO usage

SET dayZServerRootDirectory=%1

:launchDayZServer
SET profileDirectory=%~dp0serverProfile
SET mods=

REM Grab the names of all directories under the server root directory starting with '@'
REM These are our mods
SETLOCAL EnableDelayedExpansion
PUSHD %dayZServerRootDirectory%
FOR /D /r %%i in (@*.*) do call SET "mods=!mods!%%~ni;"
POPD

CALL START "" %dayZServerRootDirectory%\DayZServer_x64.exe -config=serverDZ.cfg -port=2302 -netlog -dologs -adminlog -netlog -freezecheck "-profiles=%profileDirectory%" -mod=%mods%

EXIT /B 0

GOTO :eof
:usage
@ECHO Usage: startServer.bat ^<DayZ Server root directory^>
@ECHO.
@ECHO Starts the DayZ server with all mods enabled.

EXIT /B 1

@ECHO ON
