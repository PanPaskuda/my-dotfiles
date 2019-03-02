
@echo off
set DIR=%~dp0

echo ____________________
echo creating symbolic links from %DIR% to your _vimrc in %userprofile%
echo ABORT script if you wanted to save your setting first!
pause

del /f %userprofile%\_vimrc 
mklink %userprofile%\_vimrc %DIR%.vimrc 
echo "1: Work"
echo "2: Private"

echo "install settings for a:"
SET /P PLACE=""
2>NUL CALL :CASE_%PLACE%
IF ERRORLEVEL 1 CALL :DEFAULT_CASE

ECHO Done.
EXIT /B

:CASE_1 #WORK
  del /f %userprofile%\.gitconfig 
  mklink %userprofile%\.gitconfig %DIR%.gitconfig_work
  SET /P MAIL="write your email: "
  SET /P NAME="write your name: "
  git config --global user.email %MAIL%
  git config --global user.name %NAME%
  GOTO END_CASE

:CASE_2 #PRIVATE
  del /f %userprofile%\.gitconfig
  mklink %userprofile%\.gitconfig %DIR%.gitconfig_private
  GOTO END_CASE

:DEFAULT_CASE
  echo bad argument 
  GOTO END_CASE

:END_CASE
  VER > NUL # reset ERRORLEVEL
  GOTO :EOF # return from CALL


