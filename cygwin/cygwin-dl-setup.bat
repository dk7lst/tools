@echo off
cd /d c:\cygwin
cd /d c:\cygwin64

copy setup-x86_64.exe setup-x86_64.exe.old
copy setup-x86_64.exe.sig setup-x86_64.exe.old.sig

del setup-x86_64.exe
del setup-x86_64.exe.sig

wget https://cygwin.com/setup-x86_64.exe
wget https://cygwin.com/setup-x86_64.exe.sig

icacls setup-x86_64.* /reset

rem Public Key: https://cygwin.com/key/pubring.asc
gpg2 --verify setup-x86_64.exe.sig

pause
