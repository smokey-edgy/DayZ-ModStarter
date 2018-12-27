@ECHO OFF

SETLOCAL

IF NOT EXIST vars.bat GOTO :args

CALL vars.bat

REM Check if the approriate vars have been set; they're either all set or
REM you must use the command line args
IF ["%dayZGamePath%"]==[] GOTO :args
IF ["%dayZServerRootDirectory%"]==[] GOTO :args

SET dayZGamePath="%dayZGamePath%"
SET dayZServerRootDirectory="%dayZServerRootDirectory%"
GOTO :launchDayZClient

:args
IF [%1]==[] GOTO usage
IF [%2]==[] GOTO usage

SET dayZGamePath=%1
SET dayZServerRootDirectory=%2

:launchDayZClient
REM Grab the names of all directories under the server root path starting with '@'
REM These are the mods we'll be loading on the client side
SETLOCAL EnableDelayedExpansion
PUSHD %dayZServerRootDirectory%
FOR /D /r %%i in (@*.*) do call SET "mods=!mods!%%~i;"
POPD
@ECHO Launching DayZ client automatically connecting to localhost:2302 with mods %mods%...
CALL START "" %dayZGamePath%\DayZ_BE.exe 0 1 1 -exe DayZ_x64.exe "-mod=%mods%" -connect=localhost -port=2302

EXIT /B 0

GOTO :eof
:usage
@ECHO Usage: startClient.bat ^<DayZ game path^> ^<DayZ server root path^>
@ECHO.
@ECHO A command line tool that starts the DayZ game/client and automatically connects to the development server (localhost:3302)
@ECHO This tool also starts the game with all mods discovered under the DayZ server root path.
@ECHO.

EXIT /B 1

@ECHO ON
