@ECHO OFF

REM Ideally, we would wait until this process has terminated
TASKKILL /T /IM DayZServer_x64.exe

EXIT /B 0

@ECHO ON
