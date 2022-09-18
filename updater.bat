@ECHO OFF
setlocal EnableDelayedExpansion
set "curver=0.1.1"
set "curfol=%cd%\adb_batch"
cd adb_batch
attrib -h fconfig.bat
call fconfig.bat
attrib +h fconfig.bat

IF NOT EXIST "version.bat" (
    curl --silent --output %curfol%\version.bat --url https://raw.githubusercontent.com/wahyuu2821/ADB_Batch/main/version.bat?token=GHSAT0AAAAAABYSTZID2CXGNW7WU4MZGEXOYZGU4FQ
) ELSE (
    GOTO :adbb
)
timeout /t 1 > nul
IF NOT EXIST "version.bat" GOTO :end
call version.bat

:end
del version.bat
exit

:adbb
IF %curver%==%version% (
    IF NOT EXIST "adb_batch.bat" (
        curl --silent --output %curfol%\adb_batch.bat --url https://raw.githubusercontent.com/wahyuu2821/ADB_Batch/main/adb_batch.bat?token=GHSAT0AAAAAABYSTZICQO2V3XDIYKPTJIWUYZGU4BA
        timeout /t 2 > nul
        start adb_batch.bat
    ) ELSE (
        start adb_batch.bat
    )
) ELSE (
    curl --silent --output %curfol%\adb_batch.bat --url https://raw.githubusercontent.com/wahyuu2821/ADB_Batch/main/adb_batch.bat?token=GHSAT0AAAAAABYSTZICQO2V3XDIYKPTJIWUYZGU4BA
    curl --silent --output %curfol%\updater.bat --url https://raw.githubusercontent.com/wahyuu2821/ADB_Batch/main/updater.bat?token=GHSAT0AAAAAABYSTZID743UQJXDV3KBFR5WYZGU4EQ
    cd %batchfirst%
    timeout /t 2 > nul
    start test.bat
)
GOTO :EOF
