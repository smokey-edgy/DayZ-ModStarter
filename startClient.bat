@ECHO OFF

IF [%1]==[] GOTO usage
IF [%2]==[] GOTO usage

SET dayZGamePath=%1
SET dayZServerRootPath=%2

REM Grab the names of all directories under the server root path starting with '@'
REM These are the mods we'll be loading on the client side
SETLOCAL EnableDelayedExpansion
PUSHD %dayZServerRootPath%
FOR /D /r %%i in (@*.*) do call SET "mods=!mods!%%~i;"
POPD

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
