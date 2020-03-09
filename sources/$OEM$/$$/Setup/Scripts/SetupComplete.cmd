@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                           SetupComplete.CMD                        ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

ECHO %time% - IN SetupComplete.cmd >>%~dp0\log.txt

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                                 skms                               ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

PUSHD "%WINDIR%\System32"
cscript //nologo slmgr.vbs -upk
cscript //nologo slmgr.vbs -ckms
cscript //nologo slmgr.vbs -skms 192.168.1.251
cscript //nologo slmgr.vbs -ipk CB7KF-BWN84-R7R2Y-793K2-8XDDG
POPD