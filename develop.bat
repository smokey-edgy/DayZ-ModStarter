@ECHO OFF

REM Check the provided arguments are what we expect:
REM modName, version and toolsPath and dayZServerRootDirectory are required
IF [%1]==[] GOTO usage
IF [%2]==[] GOTO usage
IF [%3]==[] GOTO usage
IF [%4]==[] GOTO usage

:rebuildAndColdDeploy
SET modName=%1
SET version=%2
SET toolsPath=%3
SET dayZServerRootDirectory=%4
SET optionalPrivateKeyFile=%5
SET optionalPublicKeyFile=%6

@ECHO ON
CALL stopServer.bat
CALL stopClient.bat
@ECHO ON
CALL build.bat %modName% %version% %toolsPath% %optionalPrivateKeyFile% %optionalPublicKeyFile%
CALL deploy.bat %dayZServerRootDirectory%
CALL startServer.bat %dayZServerRootDirectory%
@ECHO OFF
echo Press any key to rebuild and cold deploy your mod...
PAUSE >nul
GOTO rebuildAndColdDeploy

EXIT /B 0

GOTO :eof
:usage
@ECHO Usage: develop.bat ^<mod name^> ^<version^> ^<DayZ Tools path^> ^<DayZ Server Root path^> [private key file path] [public key file path]
@ECHO.
@ECHO A command line tool that rebuilds and cold deploys to the DayZ Server.
@ECHO A cold deploy means restarting the server (and possibly terminating the client)
@ECHO in order reload the latest built code.
@ECHO.

EXIT /B 1

@ECHO ON
