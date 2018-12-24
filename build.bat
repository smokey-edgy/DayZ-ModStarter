@ECHO OFF

REM Check the provided arguments are what we expect:
REM modName, version and toolsPath are required
IF [%1]==[] GOTO usage
IF [%2]==[] GOTO usage
IF [%3]==[] GOTO usage

SET modName=%~1
SET version=%~2
SET toolsPath=%~3
SET optionalPrivateKeyFile=%4
SET optionalPrivateKeyFileArg=
SET optionalPublicKeyFile=%5
SET sourceDirectory="%~dp0%modName%"
SET modDirectory="%~dp0build\@%modName%"
SET destinationDirectory=%modDirectory%\Addons

@ECHO.
@ECHO ===================================================================
@ECHO Building %modName% mod version %version%
@ECHO From source directory %sourceDirectory%
@ECHO Using DayZ Tools located at %toolsPath%

REM We will append the -sign argument to AddOnBuilder only if a private key file was provided
IF NOT [%optionalPrivateKeyFile%]==[] (
  SET optionalPrivateKeyFileArg=-sign=%optionalPrivateKeyFile%
  @ECHO Signed using private key file %optionalPrivateKeyFile%
)

@ECHO.
@ECHO @%modName% directory and .pbo file will be written to %destinationDirectory%
@ECHO ===================================================================
@ECHO.

IF EXIST build RD /S /Q build

REM Run the BI Addon build tool, AddonBuilder.exe
"%toolsPath%\Bin\AddonBuilder\AddonBuilder.exe" %sourceDirectory% %destinationDirectory% -pboversion=%version% -toolsDirectory="%toolsPath%" -clear -prefix=%modName% -include=include.txt %optionalPrivateKeyFileArg%

REM Unfortunately, AddonBuilder always returns an exit code of 0 even on error

if NOT [%optionalPublicKeyFile%]==[] (
  MD %modDirectory%\Keys
  COPY %optionalPublicKeyFile% %modDirectory%\Keys
)

EXIT /B 0

GOTO :eof
:usage
@ECHO Usage: build.bat ^<mod name^> ^<version^> ^<DayZ Tools path^> [private key file path] [public key file path]
@ECHO.
@ECHO A command line tool that wraps around the Bohemia Interactive DayZ Tools AddOnBuilder
@ECHO.
@ECHO - Generates a client/server ready @modName directory
@ECHO - Generates the .pbo file via AddOnBuilder (signed by the private key if provided)
@ECHO - The public key file (if provided) is copied to the Keys directory under @modName
@ECHO - The build assets are written to the 'build' directory in the root level of this project

EXIT /B 1

@ECHO ON
