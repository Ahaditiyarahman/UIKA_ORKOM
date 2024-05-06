@ECHO OFF
SETLOCAL enabledelayedexpansion
CLS

:selectdisk
ECHO List Drive Active
REM Cari disk yang active, output disimpan di drives.txt[temp]
FOR %%v IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (
	IF EXIST "%%v:\\" (
		ECHO %%v:\
		ECHO %%v:\ >> drives.txt
		)
	)
	SET /P disk="Pilih Drive : "
	FINDSTR /I !disk! drives.txt > selecteddrives.txt
		REM IF Success
		IF !ERRORLEVEL! EQU 0 (
			FOR /F %%g IN (selecteddrives.txt) DO (
			SET "drive=%%g"
			)
			CLS
			DEL drives.txt selecteddrives.txt
			ECHO Selected drive is !drive!
			GOTO :main
		)
		REM IF Failed (no matched file)
		IF !ERRORLEVEL! EQU 1 (
			CLS
			DEL drives.txt selecteddrives.txt
			ECHO Disk not found
			GOTO :selectdisk
		)
		REM IF Error
		IF !ERRORLEVEL! EQU 2 (
			CLS
			DEL drives.txt selecteddrives.txt
			ECHO Unexpected Error
			PAUSE
			QUIT
		)
GOTO :eof

:main
SET /P scope="Cakupan directory ? !drive!"
SET /P search="File apa yang dicari ? "

TREE !drive!!scope! /F /A > tree.txt
	FINDSTR /I !search! tree.txt > hasil_tree.txt
		IF !ERRORLEVEL! EQU 0 (
			ECHO Found
			TYPE hasil_tree.txt
			DEL tree.txt hasil_tree.txt
			PAUSE
		)ELSE (
			ECHO File not found
			DEL tree.txt hasil_tree.txt
			PAUSE
		)
GOTO :eof