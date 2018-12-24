@echo off

REM Check the provided arguments are what we expect:
REM modName, version and toolsPath are required
if [%1]==[] goto usage
if [%2]==[] goto usage
if [%3]==[] goto usage

SET modName=%~1
SET version=%~2
SET toolsPath=%~3
SET optionalPrivateKeyFile=%4
SET optionalPrivateKeyFileArg=
SET sourceDirectory="%~dp0%modName%"
SET destinationDirectory="%~dp0artifacts"

@echo.
@echo ===================================================================
@echo Building %modName% mod version %version%
@echo From source directory %sourceDirectory%
@echo Using DayZ Tools located at %toolsPath%

REM We will append the -sign argument to AddOnBuilder only if a private key file was provided
if NOT [%optionalPrivateKeyFile%]==[] (
  SET optionalPrivateKeyFileArg=-sign=%optionalPrivateKeyFile%
  @echo Signed using private key file %optionalPrivateKeyFile%
)

@echo.
@echo @%modName% directory and .pbo file will be written to %destinationDirectory%
@echo ===================================================================
@echo.

REM Run the BI Addon build tool, AddonBuilder.exe
"%toolsPath%\Bin\AddonBuilder\AddonBuilder.exe" %sourceDirectory% %destinationDirectory% -pboversion=%version% -toolsDirectory="%toolsPath%" -clear -prefix=%modName% -include=include.txt %optionalPrivateKeyFileArg%

REM Unfortunately, AddonBuilder always returns an exit code of 0 even on error
exit /B 0

goto :eof
:usage
@echo Usage: build.bat ^<mod name^> ^<version^> ^<DayZ Tools path^> [private key file path]
@echo.
@echo A command line tool that wraps around the Bohemia Interactive DayZ Tools AddOnBuilder
@echo.
@echo - Generates a server ready @modName directory that can be copied over to your DayZ server root folder
@echo - Generates the .pbo file via AddOnBuilder
@echo - The generated assets above are written to the 'artifacts' directory in the root level of this project

exit /B 1

@echo on
