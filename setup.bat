@echo off

REM Check if Conda is available
where conda >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Conda is not installed. Downloading and installing Miniconda...

    REM Download Miniconda installer
    powershell -Command "Invoke-WebRequest -Uri 'https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe' -OutFile 'Miniconda3-latest-Windows-x86_64.exe'"
    
    REM Run the Miniconda installer silently
    powershell -Command "Start-Process -Wait -FilePath '.\Miniconda3-latest-Windows-x86_64.exe' -ArgumentList '/InstallationType=JustMe', '/RegisterPython=0', '/AddToPath=0', '/S', '/D=%UserProfile%\Miniconda3'"
    
    REM Initialize Conda for PowerShell
    powershell -Command "& '%UserProfile%\Miniconda3\Scripts\conda.exe' init"
    
    REM Restart PowerShell to apply changes
    echo Please restart PowerShell and run setup.bat again.
    pause
    exit /b 1
)

REM Check if the user wants to skip setup
if "%1"=="--skip-setup" (
    goto run_app
)

REM Check if the environment already exists
conda env list | findstr "colorization_env" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Conda environment 'colorization_env' already exists. Skipping setup...
) else (
    REM Check if Python is available
    where python >nul 2>&1
    if %ERRORLEVEL% NEQ 0 (
        echo Python is not installed. Downloading and installing Python...
        
        REM Download Python installer
        powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.8.10/python-3.8.10-amd64.exe' -OutFile 'python-3.8.10-amd64.exe'"
        
        REM Run the Python installer silently
        powershell -Command "Start-Process -Wait -FilePath '.\python-3.8.10-amd64.exe' -ArgumentList '/quiet', 'InstallAllUsers=1', 'PrependPath=1'"
        
        REM Check Python installation
        where python >nul 2>&1
        if %ERRORLEVEL% NEQ 0 (
            echo Failed to install Python. Please install Python manually.
            pause
            exit /b 1
        )
    )

    REM Create the conda environment
    echo Creating the conda environment...
    conda env create -f environment.yml

    if %ERRORLEVEL% NEQ 0 (
        echo Failed to create the conda environment. Please check the environment.yml file.
        pause
        exit /b 1
    )

    echo Environment created successfully.
)

REM Activate the environment
echo Activating the environment...
call conda activate colorization_env

if %ERRORLEVEL% NEQ 0 (
    echo Failed to activate the conda environment.
    pause
    exit /b 1
)

:run_app
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
