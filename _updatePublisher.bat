@echo off
SETLOCAL

set publisher_url=https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar
set input_cache=%~dp0input-cache

if not exist "%input_cache%" mkdir "%input_cache%"

if exist "%input_cache%\publisher.jar" (
  set /p reply="publisher.jar already exists. Overwrite? [y/N] "
  if /I not "%reply%"=="y" (
    echo Aborted.
    exit /b 0
  )
)

echo Downloading publisher.jar from %publisher_url%
curl -fL "%publisher_url%" -o "%input_cache%\publisher.jar"

ENDLOCAL
