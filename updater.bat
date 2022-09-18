@ECHO OFF
setlocal EnableDelayedExpansion
set "curver=0.1.1"
attrib -h fconfig.bat
call fconfig.bat
attrib +h fconfig.bat

IF NOT EXIST "version.bat" (
    curl --silent --output %cd%\version.bat --url https://pastebin.com/raw/6BdvzXwS
)
IF NOT EXIST "version.bat" GOTO :EOF
call version.bat

IF %curver%==%version% (
    IF NOT EXIST "adb_batch.bat" (
        curl --silent --output %cd%\adb_batch.bat --url https://pastebin.com/raw/8THjqKAE
    ) ELSE (
        call adb_batch.bat
    )
) ELSE (
    curl --silent --output %cd%\adb_batch.bat --url https://pastebin.com/raw/8THjqKAE
    curl --silent --output %cd%\updater.bat --url https://pastebin.com/raw/vNTVsXFi
    call %batchfirst%/test.bat
)

del version.bat
