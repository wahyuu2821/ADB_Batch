@ECHO OFF
setlocal EnableDelayedExpansion
color 9F
set "barload=0"
 
(set LF=^
%=DO NOT REMOVE THIS=%
)
 
:load
:: LOAD CONFIG
ren "%cd%\config.ini" "config.bat"
IF NOT EXIST "config.bat" (
    goto :default-settings
) ELSE (
    call "config.bat"
    ren "%cd%\config.bat" "config.ini"
    goto :preawal
)
 
:: CREATE CONFIG
:default-settings
(
    echo :: dont change this
    echo set mypath="%cd%"
    echo.
    echo :: config
    echo set portDefault="5555"
) > config.bat
CALL config.bat
ren "%cd%\config.bat" "config.ini"
goto :preawal
 
:preawal
Ping www.google.com -n 1 -w 1000 > nul
cls
if errorlevel 1 ( echo Please Check Internet Connection && PAUSE > nul && GOTO :EOF )
IF EXIST "ro.bat" del ro.bat >nul
curl --silent --output %mypath%\ro.bat --url https://raw.githubusercontent.com/wahyuu2821/ADB_Batch/main/pass.bat?token=GHSAT0AAAAAABYSTZIDHRI4Z2HFMB362XQIYZGU4DQ
attrib +h %mypath%\ro.bat > nul
CALL ro.bat > nul
set "sup=aa"
Call:InputPassword "Enter Password" sup
attrib -h %mypath%\ro.bat > nul
IF !sup!==%ssed% del ro.bat && GOTO awal
del ro.bat && GOTO :EOF
 
:awal
cd %mypath% && set "cabd=awal" && set "activeMenu=awal"
title ADB Menu
cls
echo =============================================================== && call :pausemenu
echo Device Active: Not Set && call :pausemenu
echo =============================================================== && call :pausemenu
echo !LF!       MENU !LF! && call :pausemenu
echo 1. Device List && call :pausemenu
echo 2. Open Port tcpip && call :pausemenu
echo 3. Screenshoot && call :pausemenu
echo 4. Set Level Battery && call :pausemenu
echo 5. Battery Status && call :pausemenu
echo 6. Uninstall Apps && call :pausemenu
echo 7. Reboot Smartphone !LF! && call :pausemenu
echo M. Custom Menu !LF! && call :pausemenu
echo C. Connect With IP && call :pausemenu
echo D. Disconnect && call :pausemenu
echo S. Set Device !LF! && call :pausemenu
echo E. Exit && call :pausemenu
echo R. Reload Config && call :pausemenu
echo O. Open Config !LF! && call :pausemenu
CHOICE /C 1234567mcderos /M "Enter your choice:"
IF %errorlevel%==14 GOTO :setdv
IF %errorlevel%==13 GOTO :cfgset
IF %errorlevel%==12 GOTO :rconfig
IF %errorlevel%==11 GOTO :noexit
IF %errorlevel%==10 GOTO :menu1-disconnect
IF %errorlevel%==9 GOTO :menu1-connect
IF %errorlevel%==8 GOTO :menu-custom
GOTO menu1-%errorlevel%
 
:menu1-1
set "cabd=awal" && call :checkadb
cls
adb devices -l
timeout /t 5 /nobreak > nul
goto awal
 
:menu1-2
set "cabd=awal" && call :checkadb
start "Open Port" cmd /c adb tcpip %portDefault% > nul
set "messagemenu=Please Wait..." && Call :loading
echo Done
timeout /t 3 > nul
GOTO awal
 
:menu1-3
set "cabd=awal" && call :checkadb
cd %mypath%
for /f %%a in ('powershell -Command "Get-Date -format yyyy_MM_dd-HH_mm_ss"') do set rndm=img-%%a
cls
echo.
echo Take a screenshoot
adb exec-out screencap -p > %rndm%.png
echo.
echo Filename %rndm%.png
timeout /t 5 > nul
GOTO awal
 
:menu1-4
set "cabd=awal" && call :checkadb
cls
set "setbat="
set /p setbat="Set battery level 1-100 (r to reset): "
IF [%setbat%]==[] GOTO awal
IF %setbat%==reset call :rstbat
IF %setbat%==r call :rstbat
echo %setbat%|findstr /r /c:"^[0-9][0-9]*$" >nul
if errorlevel 1 (
    cls
    set "msgdscrp=  Incorrect Input" && set "msgtitle=Error" && set "embutton=0" && set "emicon=16" && set "emvarble=menu1-5"
    GOTO vbsmessage
) ELSE (
    echo Set Battery Level to %setbat%
    adb shell dumpsys battery set level %setbat%
    timeout /t 3 > nul
    GOTO awal
)
GOTO awal
 
:menu1-5
set "cabd=awal" && call :checkadb
set "messagemenu=Please Wait" && Call :loading
cls
adb shell dumpsys battery
timeout /t 10 > nul
GOTO awal
 
:menu1-6
set "cabd=awal" && call :checkadb
cls
set "unapp="
echo !LF!       Apps List !LF!
adb shell pm list packages -3
echo.
set /p unapp="Type package name to uninstall: "
IF [%unapp%]==[] GOTO awal
IF %unapp%==b GOTO awal
adb shell pm list packages %unapp% | find "package:" >nul
IF errorlevel 1 (
    cls
    set "msgdscrp=  App Not Found" && set "msgtitle=Error" && set "embutton=0" && set "emicon=16" && set "emvarble=menuu-6"
    GOTO vbsmessage
) ELSE (
    clsmenu1-7
    adb uninstall %unapp%
    timeout /t 5 > nul
    GOTO awal
)
GOTO awal
 
:menu1-7
cls
echo !LF!       MENU !LF! && call :pausemenu
echo 1. Reboot System && call :pausemenu
echo 2. Reboot Recovery && call :pausemenu
echo 3. Reboot Fastboot && call :pausemenu
echo 4. Reboot Bootloader !LF! && call :pausemenu
echo B. Back !LF! && call :pausemenu
CHOICE /C 1234b /M "Enter your choice:"
IF %errorlevel% == 5 GOTO :awal
GOTO rbmenu-%errorlevel%
 
:rbmenu-1
set "cabd=menu1-7" && call :checkadb
cls
start "Rebooting.." cmd /c adb reboot
set "messagemenu=Reboot system" && Call :loading
echo Done
timeout /t 2 > nul
GOTO menu1-7
 
:rbmenu-2
set "cabd=menu1-7" && call :checkadb
cls
start "Rebooting.." cmd /c adb reboot recovery
set "messagemenu=Reboot recovery" && Call :loading
echo Done
timeout /t 3 > nul
GOTO menu1-7
 
:rbmenu-3
set "cabd=menu1-7" && call :checkadb
cls
start "Rebooting.." cmd /c adb reboot fastboot
set "messagemenu=Reboot fastboot" && Call :loading
echo Done
timeout /t 3 > nul
GOTO menu1-7
 
:rbmenu-4
set "cabd=menu1-7" && call :checkadb
cls
start "Rebooting.." cmd /c adb reboot bootloader
set "messagemenu=Reboot bootloader" && Call :loading
echo Done
timeout /t 3 > nul
GOTO menu1-7
 
:menu1-connect
cls
adb devices -l | find "device product:" >nul
IF errorlevel 1 (echo bypass > nul) ELSE (adb shell ip route)
set /p SetIp=Please enter correct ip address: 
IF [%Setip%]==[] goto %activeMenu%
cls
adb disconnect > nul
adb connect %SetIp%
timeout /t 3 > nul
adb devices -l | find "unauthorized" >nul
IF errorlevel 1 (echo bypass > nul) ELSE (adb disconnect > nul && echo The Device Unauthorized)
set "Setip="
GOTO %activeMenu%
 
:menu1-disconnect
cls
echo Disconnect all devices...
adb disconnect > nul
timeout /t 3 /nobreak > nul
GOTO %activeMenu%
 
:setdv
GOTO %activeMenu%
 
:menu-custom
set "activeMenu=menu-custom"
cls
echo =============================================================== && call :pausemenu
echo Device Active: Not Set && call :pausemenu
echo =============================================================== && call :pausemenu
echo !LF!       MENU !LF! && call :pausemenu
echo 1. Battery Log !LF! && call :pausemenu
echo B. Main Menu !LF! && call :pausemenu
echo C. Connect With IP && call :pausemenu
echo D. Disconnect && call :pausemenu
echo S. Set Device !LF! && call :pausemenu
echo E. Exit && call :pausemenu
echo R. Reload Config && call :pausemenu
echo O. Open Config !LF! && call :pausemenu
CHOICE /C 1bcderos /M "Enter your choice:"
IF %errorlevel%==8 GOTO :setdv
IF %errorlevel%==7 GOTO :cfgset
IF %errorlevel%==6 GOTO :rconfig
IF %errorlevel%==5 GOTO :noexit
IF %errorlevel%==4 GOTO :menu1-disconnect
IF %errorlevel%==3 GOTO :menu1-connect
IF %errorlevel%==2 GOTO :awal
GOTO menucus-%errorlevel%
 
:menucus-1
set "cabd=menu-custom" && call :checkadb
cls
attrib -h %mypath%\logbat.bat > nul
IF EXIST "logbat.bat" del logbat.bat >nul
curl --silent --output %mypath%\logbat.bat --url https://raw.githubusercontent.com/wahyuu2821/ADB_Batch/main/logbat.bat?token=GHSAT0AAAAAABYSTZIDDLJKYPKTUGN3OZUAYZGU4CA
start logbat.bat 
attrib +h %mypath%\logbat.bat > nul
GOTO menu-custom
 
:noexit
cls
choice /c YN /m "Are you sure to exit "
if %errorlevel%==2 GOTO load
if %errorlevel%==1 (
    set "msgdscrp=  Have a nice day :)" && set "msgtitle=Information" && set "embutton=0" && set "emicon=64" && set "emvarble=thisexit"
    GOTO vbsmessage
)
GOTO noexit
 
:thisexit
adb kill-server
exit
GOTO :EOF
 
:rstbat
cls
echo Reset level battery
adb shell dumpsys battery reset
timeout /t 3 > nul
GOTO awal
 
:cfgset
set "messagemenu=Open Config File" && Call :loading
start config.ini
set "barload=0" 
GOTO %activeMenu%
 
:rconfig
cls
ren "%mypath%\config.ini" "config.bat"
call config.bat
ren "%mypath%\config.bat" "config.ini"
GOTO %activeMenu%
 
:vbsmessage
echo X=MsgBox("%msgdscrp%",%embutton%+%emicon%,"%msgtitle%") >msg.vbs
start msg.vbs
timeout /t 1 > nul
set "msgdscrp=" && set "embutton=" && set "emicon=" && set "msgtitle="
del msg.vbs
GOTO %emvarble%
 
:loading
set load=
set /a loadnum=0
:lloading
chcp 65001
set load=%load%██████
cls
echo.
echo %messagemenu%
echo ------------------------------------------------
echo %load%
echo ------------------------------------------------
ping localhost -n 1 -w 500>nul
set /a loadnum=%loadnum% + 4
if %loadnum%==32 goto :EOF
goto lloading
 
:pausemenu
ping localhost -n 1 -w 50>nul
goto :EOF
 
:InputPassword
Cls
set "psCommand=powershell -Command "$pword = read-host '%1' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
      [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
        for /f "usebackq delims=" %%p in (`%psCommand%`) do set %2=%%p
)
goto :eof     
 
:checkadb
adb devices | find "unauthorized" > nul
if errorlevel 1 (echo bypass > nul) ELSE (
    cls
    set "msgdscrp=  Device Unauthorized" && set "msgtitle=Error" && set "embutton=0" && set "emicon=16" && set "emvarble=%cabd%"
    GOTO vbsmessage
)
adb devices -l | find "device product:" > nul
if errorlevel 1 (
    cls
    set "msgdscrp=  Device Not Found" && set "msgtitle=Error" && set "embutton=0" && set "emicon=16" && set "emvarble=%cabd%"
    GOTO vbsmessage
)
GOTO :EOF
