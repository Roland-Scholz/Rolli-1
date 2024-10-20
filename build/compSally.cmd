@echo off
set TOOLS=C:\github\FABIAN
PATH=%PATH%;%TOOLS%\tools;%TOOLS%\tools\z88dk\bin;

set ASM=z80asm

rem ****************************************************
rem * compile Rolli-1
rem ****************************************************
call :compile SALLY-F000 F000
if not %ERRORLEVEL%==0 goto error

call :compile SALLY-0000 0000
if not %ERRORLEVEL%==0 goto error

call :compile rollitest 0000
if not %ERRORLEVEL%==0 goto error

del /Q	..\release\sally*.*

move ..\src\*.o ..\release	>nul 2>&1	
move ..\src\*.hex ..\release	>nul 2>&1
move ..\src\*.lis ..\release	>nul 2>&1
move ..\src\*.com ..\release	>nul 2>&1

pushd	..\release
copy	sally-0000.com /B + sally-f000.com /B sally.com /B
bin2hex sally.com sally.hex -o 0000
popd

pause
goto ende



pause
goto ende

rem ----------------------------------------------
:compile
	pushd ..\src
	echo *** compile %1
	%ASM% -mz80 %3 -b -l -o%1.com %1 
	if not %ERRORLEVEL%==0 goto ende

	bin2hex %1.com %1.hex -o %2
	popd
	goto ende
rem ----------------------------------------------

:error
	pause
:ende


