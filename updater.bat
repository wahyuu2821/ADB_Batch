@ECHO OFF
setlocal EnableDelayedExpansion
set "curver=0.1.1"
attrib -h fconfig.bat
call fconfig.bat
attrib +h fconfig.bat

IF NOT EXIST "version.bat" (
    curl --silent --output %cd%\version.bat --url https://raw.githubusercontent.com/wahyuu2821/ADB_Batch/main/version.bat?token=GHSAT0AAAAAABYSTZID2CXGNW7WU4MZGEXOYZGU4FQ
)
IF NOT EXIST "version.bat" GOTO :EOF
call version.bat

IF %curver%==%version% (
    IF NOT EXIST "adb_batch.bat" (
        curl --silent --output %cd%\adb_batch.bat --url https://raw.githubusercontent.com/wahyuu2821/ADB_Batch/main/adb_batch.bat?token=GHSAT0AAAAAABYSTZICQO2V3XDIYKPTJIWUYZGU4BA
    ) ELSE (
        call adb_batch.bat
    )
) ELSE (
    curl --silent --output %cd%\adb_batch.bat --url https://raw.githubusercontent.com/wahyuu2821/ADB_Batch/main/adb_batch.bat?token=GHSAT0AAAAAABYSTZICQO2V3XDIYKPTJIWUYZGU4BA
    curl --silent --output %cd%\updater.bat --url https://raw.githubusercontent.com/wahyuu2821/ADB_Batch/main/updater.bat?token=GHSAT0AAAAAABYSTZID743UQJXDV3KBFR5WYZGU4EQ
    call %batchfirst%/test.bat
)

del version.bat
