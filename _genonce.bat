@echo off
SETLOCAL

cd /d %~dp0

set publisher_jar=input-cache\publisher.jar

if not exist "%publisher_jar%" (
  echo %publisher_jar% not found. Run _updatePublisher.bat first.
  exit /b 1
)

call sushi .
if errorlevel 1 exit /b %errorlevel%

java -jar "%publisher_jar%" -ig . %*

ENDLOCAL
