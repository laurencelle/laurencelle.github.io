@echo off
chcp 65001
setlocal enableextensions disabledelayedexpansion
set "desktopfolder="
for /F "skip=1 tokens=1,2*" %%I in ('%SystemRoot%\System32\reg.exe QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop 2^>nul') do if /I "%%I" == "Desktop" if not "%%~K" == "" if "%%J" == "REG_SZ" (set "desktopfolder=%%~K") else if "%%J" == "REG_EXPAND_SZ" call set "desktopfolder=%%~K"
if not defined desktopfolder for /F "skip=1 tokens=1,2*" %%I in ('%SystemRoot%\System32\reg.exe QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v Desktop 2^>nul') do if /I "%%I" == "Desktop" if not "%%~K" == "" if "%%J" == "REG_SZ" (set "desktopfolder=%%~K") else if "%%J" == "REG_EXPAND_SZ" call set "desktopfolder=%%~K"
if not defined desktopfolder set "desktopfolder=\"
if "%desktopfolder:~-1%"=="\" set "desktopfolder=%desktopfolder:~0,-1%"
if not defined desktopfolder set "desktopfolder=%userprofile%\Desktop"
setlocal enabledelayedexpansion
echo.
set dossier=%~dp0
set erreur=0
if "%dossier:~-1%"=="\" set "dossier=%dossier:~0,-1%"
if "%dossier%"=="%userprofile%\COBA" set erreur=1
if "%dossier%"=="%desktopfolder%" set erreur=1
if !erreur!==1 (
echo ATTENTION, erreur lors de l'installation...
echo.
echo Impossible d'installer COBA_Listes à partir du dossier ci-dessous :
echo   "%dossier%"
echo.
echo Appuyez sur une touche pour quitter l'installateur...
pause>nul
goto :eof
)
if exist "%userprofile%\COBA" if not exist "%userprofile%\COBA\" (
echo ATTENTION, erreur lors de l'installation...
echo.
echo Impossible d'installer COBA_Listes dans le DOSSIER "%userprofile%\COBA"
echo   car un FICHIER nommé "COBA" existe déjà dans le dossier "%userprofile%".
echo.
echo Appuyez sur une touche pour quitter l'installateur...
pause>nul
goto :eof
)
tasklist | find /i "COBA_Listes." && taskkill /im COBA_Listes.* /f
set ok=0
if exist "%~dp0COBA_Listes.exe" if exist "%~dp0COBA_Listes.a3x" if exist "%~dp0COBA_Listes.ico" if exist "%~dp0COBA_Listes.lnk" set ok=1
if !ok!==1 (
set deja=0
if exist "%userprofile%\COBA\COBA_Listes.exe" if exist "%userprofile%\COBA\COBA_Listes.a3x" if exist "%userprofile%\COBA\COBA_Listes.ico" if exist "%desktopfolder%\COBA_Listes.lnk" if exist "%appdata%\Microsoft\Windows\SendTo\COBA_Listes.lnk" set deja=1
if !deja!==1 (
echo ATTENTION, il semble que COBA_Listes soit déjà installé sur cet ordinateur...
echo.
choice /n /m "Souhaitez-vous quand même poursuivre l'installation ? [O = Oui / N = Non]"
if !errorlevel!==2 (
echo.
echo Installation annulée...
ping -n 3 127.0.0.1>nul
goto :eof
)
echo.
)
set %m%=Microsoft
set %w%=Windows
set %s%=SendTo
echo Installation de COBA_Listes à partir du dossier ci-dessous :
echo   "%dossier%"
if not exist "%userprofile%\COBA\" md "%userprofile%\COBA\"
if exist "%userprofile%\COBA_Listes.*" move "%userprofile%\COBA_Listes.*" "%userprofile%\COBA\"
copy "%~dp0COBA_Listes.exe" "%userprofile%\COBA\"
copy "%~dp0COBA_Listes.a3x" "%userprofile%\COBA\"
copy "%~dp0COBA_Listes.ico" "%userprofile%\COBA\"
copy "%~dp0COBA_Listes.lnk" "%desktopfolder%\"
copy "%~dp0COBA_Listes.lnk" "%appdata%\%m%\%w%\%s%\"
echo.
set ok=0
if exist "%userprofile%\COBA\COBA_Listes.exe" if exist "%userprofile%\COBA\COBA_Listes.a3x" if exist "%userprofile%\COBA\COBA_Listes.ico" if exist "%desktopfolder%\COBA_Listes.lnk" if exist "%appdata%\%m%\%w%\%s%\COBA_Listes.lnk" set ok=1
if !ok!==1 (
echo Installation réussie ^^!
if "%dossier:~-14%"=="COBA_L_install" (
echo.
echo Après avoir quitté l'installateur, vous pourrez supprimer :
echo   - le dossier "%dossier%" et tout son contenu
if exist "%dossier%\..\COBA_L_install.zip" (
echo   - le dossier compressé "COBA_L_install" ^(archive ZIP^).
)
)
) else (
echo ATTENTION, erreur lors de l'installation...
echo.
echo Fichiers non correctement installés :
if not exist "%userprofile%\COBA\COBA_Listes.exe" echo   - COBA_Listes.exe ^(compilateur^)
if not exist "%userprofile%\COBA\COBA_Listes.a3x" echo   - COBA_Listes.a3x ^(script^)
if not exist "%userprofile%\COBA\COBA_Listes.ico" echo   - COBA_Listes.ico ^(icône^)
if not exist "%desktopfolder%\COBA_Listes.lnk" echo   - COBA_Listes.lnk ^(raccourci sur le bureau^)
if not exist "%appdata%\%m%\%w%\%s%\COBA_Listes.lnk" echo   - COBA_Listes.lnk ^(raccourci dans le menu "Envoyer vers..."^)
echo.
echo Vérifiez la configuration de l'ordinateur ou contactez l'auteur du programme.
)
echo.
echo Appuyez sur une touche pour quitter l'installateur...
pause>nul
) else (
set ok=0
if exist "%userprofile%\COBA\COBA_Listes.exe" if exist "%userprofile%\COBA\COBA_Listes.a3x" if exist "%userprofile%\COBA\COBA_Listes.ico" if exist "%desktopfolder%\COBA_Listes.lnk" if exist "%appdata%\%m%\%w%\%s%\COBA_Listes.lnk" set ok=1
echo ATTENTION, erreur lors de l'installation de COBA_Listes...
echo.
echo Fichiers manquants dans le dossier de l'installateur :
if not exist "%~dp0COBA_Listes.exe" echo   - COBA_Listes.exe ^(compilateur^)
if not exist "%~dp0COBA_Listes.a3x" echo   - COBA_Listes.a3x ^(script^)
if not exist "%~dp0COBA_Listes.ico" echo   - COBA_Listes.ico ^(icône^)
if not exist "%~dp0COBA_Listes.lnk" echo   - COBA_Listes.lnk ^(raccourci^)
echo.
echo Assurez-vous que le dossier "%dossier%"
echo   comporte ces fichiers avant d'exécuter l'installateur.
echo.
if !ok!==1 (
echo Mais... il semble que COBA_Listes soit déjà installé sur cet ordinateur,
echo   alors vous pouvez probablement ignorer ce message ^^!
echo.
)
echo Appuyez sur une touche pour quitter l'installateur...
pause>nul
)