@ECHO OFF

:: Mounts a Network Drive to the Container
:: PROTIP: Use a freakin' service account!
NET USE * \\UNC\PATH\TO\SHARE /USER:DOMAINNAME\Username PASSWORD_HERE_IN_THE_CLEAR

:: Create Directory Junction to the Media volume
mklink "C:\Media" "Z:\" /j
