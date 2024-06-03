@echo off

REM Check if conda is available
where conda >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Conda is not installed. Please run setup.bat first.
    pause
    exit /b 1
)

REM Check if the environment exists
call conda activate colorization_env >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo The conda environment does not exist. Please run setup.bat first.
    pause
    exit /b 1
)

REM Launch the Gradio application
echo Launching the Gradio application...
python app.py --port 7860 --server_name localhost

if %ERRORLEVEL% NEQ 0 (
    echo Failed to launch the Gradio application.
    pause
    exit /b 1
)

echo Gradio application is running on http://localhost:7860
pause
