@echo off
rem ssx3: the project CLI (ssx3.py). Python 3.9 or newer.
where py >nul 2>nul
if %errorlevel%==0 (
    py -3 "%~dp0ssx3.py" %*
) else (
    python "%~dp0ssx3.py" %*
)
exit /b %errorlevel%
