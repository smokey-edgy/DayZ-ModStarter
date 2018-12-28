@ECHO OFF

SETLOCAL

REM Ideally, we would wait until this process has terminated
TASKKILL /T /IM DayZServer_x64.exe 2> nul

EXIT /B 0

@ECHO ON
