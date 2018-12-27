@ECHO OFF

SETLOCAL

IF NOT EXIST vars.bat GOTO :args

CALL vars.bat

REM Check if the approriate vars have been set; they're either all set or
REM you must use the command line args
IF ["%dayZServerRootDirectory%"]==[] GOTO :args
SET dayZServerRootDirectory="%dayZServerRootDirectory%"

GOTO :build

REM Check the provided arguments are what we expect:
REM dayZServerRootDirectory
:args
IF [%1]==[] GOTO usage

SET dayZServerRootDirectory=%1

:build
SET dayZServerKeysDirectory=%dayZServerRootDirectory%\keys

@ECHO.
@ECHO ===================================================================
@ECHO Deploying everything that is under build to %dayZServerRootDirectory%
@ECHO ===================================================================
@ECHO.
XCOPY build\* %dayZServerRootDirectory% /S /E /Y

@ECHO ===================================================================
@ECHO Copying all .bikey files found under build to %dayZServerKeysDirectory%
@ECHO ===================================================================
@ECHO.
PUSHD build
for /r %%i in (*.bikey) do XCOPY "%%i" %dayZServerKeysDirectory% /S /E /Y
POPD

EXIT /B 0

GOTO :eof
:usage
@ECHO Usage: deploy.bat ^<DayZ Server root directory^>
@ECHO.
@ECHO Deploys everything under the build directory to the DayZ Server.
@ECHO Also copies all public keys to the server 'keys' directory.

EXIT /B 1

@ECHO ON
