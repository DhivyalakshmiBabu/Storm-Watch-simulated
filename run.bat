@echo off
setlocal
cd /d "%~dp0"
echo ==========================================
echo         Storm Watch - Demo Launcher
echo ==========================================
where python >nul 2>nul
if errorlevel 1 (
  echo ERROR: Python was not found.
  echo Install Python 3.11 or newer from https://www.python.org/downloads/
  echo During installation, select "Add Python to PATH".
  pause
  exit /b 1
)
if not exist ".venv\Scripts\python.exe" (
  echo Creating virtual environment...
  python -m venv .venv
  if errorlevel 1 goto :error
)
echo Installing or checking dependencies...
call ".venv\Scripts\python.exe" -m pip install --upgrade pip
if errorlevel 1 goto :error
call ".venv\Scripts\python.exe" -m pip install -r requirements.txt
if errorlevel 1 goto :error
echo.
echo Starting Storm Watch...
echo When ready, open http://localhost:8501 in your browser.
call ".venv\Scripts\python.exe" -m streamlit run app.py
if errorlevel 1 goto :error
goto :eof
:error
echo.
echo Startup failed. Read the error above, check your internet connection, and try again.
pause
exit /b 1
