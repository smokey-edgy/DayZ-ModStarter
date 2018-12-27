@ECHO OFF

REM Ideally, we would wait until these processes have been terminated
TASKKILL /T /F /IM DayZ_BE.exe
TASKKILL /T /F /IM DayZ_x64.exe

EXIT /B 0

@ECHO ON
