@ECHO OFF

IF [%1]==[] GOTO usage

SET dayZRootDirectory=%1
SET dayZServerKeysDirectory=%dayZRootDirectory%\keys


@ECHO.
@ECHO ===================================================================
@ECHO Deploying everything that is under build to %dayZRootDirectory%
@ECHO ===================================================================
@ECHO.
XCOPY build\* %dayZRootDirectory% /S /E /Y

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
