@echo OFF
setlocal enabledelayedexpansion

set /p file=File Name: 
IF [%file%]==[] call :filenamechange
:juak
set /p inter=Interval: 
if [%inter%]==[] set "inter=5"
echo %inter%|findstr /r /c:"^[0-9][0-9]*$" >nul
if errorlevel 1 GOTO juak
if %inter% LSS 5 cls && echo Less Than 5 && timeout /t 3 > nul && GOTO :juak
set /p total=Total:
if [%total%]==[] set "total=5"
echo %total%|findstr /r /c:"^[0-9][0-9]*$" >nul
if errorlevel 1 GOTO juak
if %total% LSS 5 cls && echo Less Than 5 && timeout /t 3 > nul && GOTO :juak

cls
set /a langu= 1
:ulang
if %langu% == 1 (echo. > nul) ELSE (echo. >> "%file%.txt" && echo.)
echo -------------------------------------- >> "%file%.txt" && echo --------------------------------------
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2% %ldt:~8,2%:%ldt:~10,2%:%ldt:~12,6%
echo %ldt% >> "%file%.txt" && echo %ldt%
adb shell dumpsys battery > 01.txt
adb shell dumpsys battery | findstr /v "Max charging" > 11.txt
attrib +h %cd%\?1.txt
find "AC powered: false" 01.txt > nul
if %errorlevel%==1 (
    echo Charging AC: True >> "%file%.txt" && echo Charging AC: True
    for /f "tokens=*" %%i in ('FINDSTR /C:"Max" 01.txt') do echo %%i >> "%file%.txt" && echo %%i 
)
for /f "tokens=*" %%i in ('FINDSTR /C:"voltage" 11.txt') do echo %%i mV >> "%file%.txt" && echo %%i mV 
for /f "tokens=*" %%i in ('FINDSTR /C:"level" 01.txt') do echo %%i%% >> "%file%.txt" && echo %%i%% 
for /f "tokens=*" %%i in ('FINDSTR /C:"temperature" 01.txt') do echo %%i >> "%file%.txt" && echo %%i
echo -------------------------------------- >> "%file%.txt" && echo --------------------------------------
attrib -h %cd%\?1.txt
del ?1.txt
if %langu% == %total% GOTO :end
timeout /t %inter% /nobreak > nul
set /a langu=%langu% + 1
GOTO :ulang

:end
PAUSE
attrib -h logbat.bat
timeout /t 1 > nul
del logbat.bat & exit

:filenamechange
set /a turu = 1
:loopfile
IF EXIST "log-%turu%.txt" ( set /a turu = %turu% + 1 && GOTO loopfile )
set "file=log-%turu%"
GOTO :EOF
