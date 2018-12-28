@ECHO OFF

SETLOCAL

REM Ideally, we would wait until these processes have been terminated
TASKKILL /T /F /IM DayZ_BE.exe 2> nul
TASKKILL /T /F /IM DayZ_x64.exe 2> nul

EXIT /B 0

@ECHO ON
