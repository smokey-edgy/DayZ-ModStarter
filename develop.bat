@ECHO OFF

SETLOCAL

IF NOT EXIST vars.bat GOTO :args

CALL vars.bat

REM Check if the approriate vars have been set; they're either all set or
REM you must use the command line args
IF ["%modName%"]==[] GOTO :args
IF ["%version%"]==[] GOTO :args
IF ["%dayZToolsPath%"]==[] GOTO :args
IF ["%dayZServerRootDirectory%"]==[] GOTO :args
IF ["%dayZGamePath%"]==[] GOTO :args

GOTO :rebuildAndColdDeploy

:args
REM Check the provided arguments are what we expect:
REM modName, version, toolsPath and dayZServerRootDirectory are required
IF [%1]==[] GOTO usage
IF [%2]==[] GOTO usage
IF [%3]==[] GOTO usage
IF [%4]==[] GOTO usage
IF [%5]==[] GOTO usage

:rebuildAndColdDeploy
IF EXIST vars.bat (
  CALL vars.bat
  SET modName="%modName%"
  SET version="%version%"
  SET dayZToolsPath="%dayZToolsPath%"
  SET dayZServerRootDirectory="%dayZServerRootDirectory%"
  SET dayZGamePath="%dayZGamePath%"
  IF NOT [%optionalPrivateKeyFile%]==[] SET optionalPrivateKeyFile="%optionalPrivateKeyFile%"
  IF NOT [%optionalPublicKeyFile%]==[] SET optionalPublicKeyFile="%optionalPublicKeyFile%"
) ELSE (
  SET modName=%1
  SET version=%2
  SET dayZToolsPath=%3
  SET dayZServerRootDirectory=%4
  SET dayZGamePath=%5
  SET optionalPrivateKeyFile=%6
  SET optionalPublicKeyFile=%7
)

CALL stopServer.bat
CALL stopClient.bat

@ECHO.
@ECHO Give the server and client some time to terminate...
TIMEOUT /T 5 /NOBREAK

CALL build.bat %modName% %version% %dayZToolsPath% %optionalPrivateKeyFile% %optionalPublicKeyFile%
CALL deploy.bat %dayZServerRootDirectory%
CALL startServer.bat %dayZServerRootDirectory%
CALL startClient.bat %dayZGamePath% %dayZServerRootDirectory%

echo Press any key to rebuild and cold deploy your mod...
PAUSE >nul
GOTO rebuildAndColdDeploy

EXIT /B 0

GOTO :eof
:usage
@ECHO Usage: develop.bat ^<mod name^> ^<version^> ^<DayZ Tools path^> ^<DayZ Server Root path^> ^<DayZ Game path^> [private key file path] [public key file path]
@ECHO.
@ECHO A command line tool that rebuilds and cold deploys to the DayZ Server.
@ECHO A cold deploy means restarting the server and the client in order reload the latest built code.
@ECHO.

EXIT /B 1

@ECHO ON
