pushd %~dp0
@echo off
powershell -ExecutionPolicy Bypass -File .\setup.ps1 %* || exit /b 1
pause
popd