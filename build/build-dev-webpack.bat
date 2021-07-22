ECHO OFF
CLS

call npm install
call npm run build-dev

IF ERRORLEVEL 1 GOTO errorHandling

PAUSE
EXIT /b 0

:errorHandling
PAUSE
EXIT /b -1
