@ECHO OFF

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                             IN Specialize.cmd                      ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

ECHO %time% - IN Specialize.cmd

@ECHO 	��ʾ�����豸
SETX DEVMGR_SHOW_DETAILS 1 /M
SETX DEVMGR_SHOW_NONPRESENT_DEVICES 1 /M

@ECHO 	���ĵ�ԴģʽΪ������ POWERCFG -L ��ȡ�����б�
POWERCFG -S 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

@ECHO 	����������е��������Ʋ���
PUSHD "%WINDIR%\Setup\Policys\Templates"
CALL Import.cmd
POPD

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                                   ע���                           ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

@ECHO 	������� - ���Ի� - ����ͼ������ - ��ʾ���������
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d "0" /f

@ECHO 	������� - ���Ի� - ����ͼ������ - ��ʾ��������塱
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d "0" /f

@ECHO 	���� - ����ʹ�� - ����ѡ�� - ��ʾ Windows ���� - ��
:: ֱ��ʹ�õ� HKCU Ŀǰ����ֻ���������
Reg.exe add "HKU\.DEFAULT\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012038011000000" /f

@ECHO 	�޸� ʱ���������ַ
REG ADD "HKLM\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\DATETIME\SERVERS" /V "1" /T REG_SZ /D "ntp.aliyun.com" /F
REG ADD "HKLM\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\DATETIME\SERVERS" /V "2" /T REG_SZ /D "CN.NTP.ORG.CN" /F

@ECHO 	�Զ����� Num ���ּ���
REG ADD "HKU\.DEFAULT\Control Panel\Keyboard" /V "InitialKeyboardIndicators" /T REG_SZ /D "2" /F

@ECHO 	���ô��̿ռ�ͼ�������
:: https://answers.microsoft.com/en-us/windows/forum/windows_10-performance/low-disk-space-warning/2985f242-fee7-4e1f-89e9-1f136b016aa5
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /t REG_DWORD /d "1" /f

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                               �ƻ�����                             ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

:: ϵͳ���󱨸�
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /DISABLE

:: DiskDiagnostic - Windows ������ϻ�Ϊ����ͻ�����ƻ����û��� Microsoft ���泣��Ĵ��̺�ϵͳ��Ϣ��
SCHTASKS /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /DISABLE

:: ������Ϣ�ռ���
:: SCHTASKS /Change /TN "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /DISABLE

:: ϵͳ����ǽ���˹���
:: SCHTASKS /Change /TN "\Microsoft\Windows\Windows Filtering Platform\BfeOnServiceStartTypeChange" /DISABLE

:: Defrag - �������Ż����ش洢������
SCHTASKS /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /DISABLE

:: Ч�ܷ���
SCHTASKS /Change /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /DISABLE

:: �����¼���־
SCHTASKS /Change /TN "\Microsoft\Windows\Location\Notifications" /DISABLE

:: ���������ƻ�
:: SCHTASKS /Change /TN "\Microsoft\Windows\Bluetooth\UninstallDeviceTask" /DISABLE

:: WindowsUpdate - ��������������Ҫʱ���� Windows ���·�����ִ�мƻ��Ĳ���(��ɨ��)��
SCHTASKS /Change /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /DISABLE

:: DiskCleanup - ��ά��������ϵͳ�����ڿ��ô��̿ռ䲻��ʱ��������ʾ�Զ���������
SCHTASKS /Change /TN "\Microsoft\Windows\DiskCleanup\SilentCleanup" /DISABLE

:: Wininet - Wininet ��������
SCHTASKS /Change /TN "\Microsoft\Windows\Wininet\CacheTask" /DISABLE

:: WindowsColorSystem - ������Ӧ����ɫУ׼���á�
:: SCHTASKS /Change /TN "\Microsoft\Windows\WindowsColorSystem\Calibration Loader" /DISABLE

:: User Profile Service - �������Զ��������û������ļ���ע������õ�Ԫ���ص�������λ�á�
:: SCHTASKS /Change /TN "\Microsoft\Windows\User Profile Service\HiveUploadTask" /DISABLE

:: Time Zone - ����ʱ����Ϣ�������ֹͣ��������ĳЩʱ���ı���ʱ����ܲ�׼ȷ��
:: SCHTASKS /Change /TN "\Microsoft\Windows\Time Zone\SynchronizeTimeZone" /DISABLE

:: Registry - ע�����б�������
SCHTASKS /Change /TN "\Microsoft\Windows\Registry\RegIdleBackup" /DISABLE

:: Maintenance - ����ϵͳ�����ܺ͹���
SCHTASKS /Change /TN "\Microsoft\Windows\Maintenance\WinSAT" /DISABLE

:: Data Integrity Scan - ɨ���ݴ���Ǳ����
SCHTASKS /Change /TN "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan" /DISABLE

:: Chkdsk - NTFS ��״��ɨ��
SCHTASKS /Change /TN "\Microsoft\Windows\Chkdsk\ProactiveScan" /DISABLE

:: Autochk - ����Ѿ����μ� Microsoft �ͻ�������Ƽƻ�����������ռ��������Զ���� SQM ���ݡ�
SCHTASKS /Change /TN "\Microsoft\Windows\Autochk\Proxy" /DISABLE

:: Maps - ��������������ص��ѻ�ʹ�õ�ͼ�ĸ��¡����ô�������ֹ Windows ֪ͨ���и��µĵ�ͼ��
SCHTASKS /Change /TN "\Microsoft\Windows\Maps\MapsUpdateTask" /DISABLE

:: Diagnosis - Windows �ƻ���ά������ͨ���Զ��޸������ͨ������ȫ��ά��������������Լ����ϵͳִ�ж���ά����
SCHTASKS /Change /TN "\Microsoft\Windows\Diagnosis\Scheduled" /DISABLE

:: Customer Experience Improvement Program - ����û���ͬ����� Windows �ͻ�������Ƽƻ�������ҵ���ռ�ʹ��������ݣ����� Microsoft ������Щ���ݡ�
SCHTASKS /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /DISABLE

:: Application Experience - �����ѡ����� Microsoft �ͻ�������Ƽƻ�������ռ�����ң����Ϣ��
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /DISABLE

:: Application Experience - ���ѡ�� Microsoft �ͻ�������Ƽƻ�������ռ�����ң����Ϣ
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /DISABLE

:: Application Experience - ɨ�����������������������������û�����֪ͨ��
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /DISABLE

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                                  ϵͳ����                          ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

@ECHO 	Volume Shadow Copy - VSS
:: Ĭ�� �ֶ�
:: ����ִ�����ڱ��ݺ�������;�ľ�Ӱ���ơ�����˷�����ֹ�����ݽ�û�о�Ӱ���ƣ����ұ��ݻ�ʧ�ܡ�
:: ����˷��񱻽��ã��κ��������ķ����޷�������
sc config VSS start= DISABLED

@ECHO 	Print Spooler - Spooler
:: Ĭ�� �Զ�
:: �÷����ں�ִ̨�д�ӡ��ҵ���������ӡ���Ľ�����
:: ����رո÷������޷����д�ӡ��鿴��ӡ����
sc config Spooler start= DISABLED

@ECHO 	Connected User Experiences and Telemetry - DiagTrack
:: Ĭ�� - �Զ�
:: Connected User Experiences and Telemetry ���������õĹ���֧��Ӧ�ó������û���������ӵ��û����顣
:: ���⣬����ڡ���������ϡ���������Ϻ�ʹ�������˽ѡ�����ã���˷�����Ը����¼���������Ϻ�ʹ�������Ϣ���ռ��ʹ���(���ڸĽ� Windows ƽ̨�����������)��
sc config DiagTrack start= DISABLED

@ECHO 	IP Helper - iphlpsvc
:: Ĭ�� - �Զ�
:: ʹ�� IPv6 ת������(6to4��ISATAP���˿ڴ���� Teredo)�� IP-HTTPS �ṩ������ӡ�
:: ���ֹͣ�÷��������������߱���Щ�����ṩ����ǿ�������ơ�
sc config iphlpsvc start= DISABLED

@ECHO 	Program Compatibility Assistant Service - PcaSvc
:: Ĭ�� - �Զ�
:: �˷���Ϊ�������������(PCA)�ṩ֧�֡�PCA �������û���װ�����еĳ��򣬲������֪���������⡣
:: ���ֹͣ�˷���PCA ���޷��������С�
sc config PcaSvc start= DISABLED

@ECHO 	Themes - Themes
:: Ĭ�� - �Զ�
:: Ϊ�û��ṩʹ�������������顣
sc config Themes start= DISABLED

@ECHO 	Remote Registry - RemoteRegistry
:: Ĭ�� - �Զ�
:: ʹԶ���û����޸Ĵ˼�����ϵ�ע������á�
:: ����˷�����ֹ��ֻ�д˼�����ϵ��û������޸�ע�������˷��񱻽��ã��κ��������ķ����޷�������
sc config RemoteRegistry start= DISABLED

@ECHO 	Downloaded Maps Manager - MapsBroker
:: Ĭ�� - �Զ�(�ӳ�����)
:: ��Ӧ�ó�����������ص�ͼ�� Windows ����
:: �˷����ɷ��������ص�ͼ��Ӧ�ó��������������ô˷�����ֹӦ�÷��ʵ�ͼ��
sc config MapsBroker start= DISABLED

@ECHO 	Diagnostic Policy Service - DPS
:: Ĭ�� - �Զ�(�ӳ�����)
:: ��ϲ��Է��������� Windows ����������⡢���ѽ��ͽ������������÷���ֹͣ����Ͻ��������С�
sc config DPS start= DISABLED

@ECHO 	Diagnostic Service Host - WdiServiceHost
:: Ĭ�� - �ֶ�
::��Ϸ�����������ϲ��Է�������������Ҫ�ڱ��ط��������������е���ϡ�
:: ���ֹͣ�÷����������ڸ÷�����κ���Ͻ��������С�
sc config WdiServiceHost start= DISABLED

@ECHO 	Diagnostic System Host - WdiSystemHost
:: Ĭ�� - �ֶ�
:: ���ϵͳ��������ϲ��Է�������������Ҫ�ڱ���ϵͳ�����������е���ϡ�
:: ���ֹͣ�÷����������ڸ÷�����κ���Ͻ��������С�
sc config WdiSystemHost start= DISABLED

@ECHO 	Distributed Transaction Coordinator - MSDTC
:: Ĭ�� - �Զ�
:: Э���������ݿ⡢��Ϣ���С��ļ�ϵͳ����Դ������������
:: ���ֹͣ�˷�����Щ���񽫻�ʧ�ܡ�������ô˷�����ʽ�����˷�������������޷�������
:: ���ʹ�� MSSQL, ��Ӧ����Ĭ��
sc config MSDTC start= DISABLED

@ECHO 	Distributed Link Tracking Client - TrkWks
:: Ĭ�� - �Զ�
:: ά��ĳ��������ڻ�ĳ�������еļ������ NTFS �ļ�֮������ӡ�
sc config TrkWks start= DISABLED

@ECHO 	Server - LanmanServer
:: Ĭ�� - �Զ�
:: ֧�ִ˼����ͨ��������ļ�����ӡ���������ܵ�����
:: �������ֹͣ����Щ���ܲ����á�������񱻽��ã��κ�ֱ�������ڴ˷���ķ����޷�������
sc config LanmanServer start= DISABLED

@ECHO 	SSDP Discovery - SSDPSRV
:: Ĭ�� - �ֶ�
:: ��������ʹ�� SSDP Э��������豸�ͷ����� UPnP �豸��ͬʱ�������������ڱ��ؼ������ʹ�õ� SSDP �豸�ͷ���
:: ���ֹͣ�˷��񣬻��� SSDP ���豸�����ᱻ���֡�������ô˷����κ������˷���ķ����޷�����������
sc config SSDPSRV start= DISABLED

@ECHO 	Device Setup Manager - DsmSvc
:: Ĭ�� - �ֶ�(����������)
:: ֧�ּ�⡢���غͰ�װ���豸��ص������
:: ����˷��񱻽��ã������ʹ�ù���������豸�������ã�����豸�����޷�����������
:: ��ע - ���������Զ�������������, ���� �Կ�, ���� ����.
sc config DsmSvc START= DISABLED

@ECHO 	Windows Search - WSearch
:: Ĭ�� - ����
:: Ϊ�ļ��������ʼ������������ṩ�������������Ի�������������
sc config WSearch start= DISABLED

@ECHO 	Superfetch - SysMain
:: Ĭ�� - �ֶ�
:: ά�������һ��ʱ���ڵ�ϵͳ���ܡ�
sc config SysMain start= DISABLED

@ECHO 	Function Discovery Resource Publication - FDResPub
:: Ĭ�� - �ֶ�
:: �����ü�����Լ����ӵ��ü��������Դ���Ա��ܹ��������Ϸ�����Щ��Դ��
:: ����÷���ֹͣ�������ٷ���������Դ�������ϵ�������������޷�������Щ��Դ��
sc config FDResPub start= DISABLED

@ECHO 	Function Discovery Provider Host - fdPHost
:: Ĭ�� - �ֶ�
:: FDPHOST ������ع��ܷ���(FD)���緢���ṩ������Щ FD �ṩ����Ϊ�򵥷�����Э��(SSDP)�� Web ������(WS-D)Э���ṩ���緢�ַ���
:: ʹ�� FD ʱֹͣ����� FDPHOST ���񽫽�����ЩЭ������緢�֡�
:: ���÷��񲻿���ʱ��ʹ�� FD ��������Щ����Э�����������޷��ҵ�����������Դ��
sc config fdPHost start= DISABLED

@ECHO 	Windows Ԥ�������Ա���� - wisvc
:: Ĭ�� - �ֶ�
:: Ϊ Windows Ԥ������ƻ��ṩ�����ṹ֧�֡��˷�����뱣������״̬��Windows Ԥ������ƻ������������С�
sc config wisvc start= DISABLED

@ECHO 	User Access Logging Service - UALSVC
:: Ĭ�� - �Զ�(�ӳ�����)
:: �˷����� IP ��ַ���û�������ʽ��¼���ط������ϰ�װ�Ĳ�Ʒ�ͽ�ɫ�����пͻ��˷������󡣼�¼����Ϣ���� IP ��ַ���û������������Ա��Ҫ�����ͻ��˵ķ���������������Խ����ѻ��ͻ��˷������֤(CAL)�������ǿ�ͨ�� Powershell ��ѯ��Щ��Ϣ��
:: ������ø÷����򲻻��¼�ͻ�������Ҳ�޷�ͨ�� Powershell ��ѯ������Щ����
:: ֹͣ�÷��񲻻�Ӱ����ʷ���ݲ�ѯ(��μ�֧���ĵ����˽�ɾ����ʷ���ݵĲ���)������ϵͳ����Ա��������� Windows Server ��������ȷ����ȷ��ɷ������������� CAL ������ʹ�� UAL ��������ݲ�����ı���������
sc config UALSVC start= DISABLED

@ECHO 	Windows Remote Management (WS-Management) - WinRM
:: Ĭ�� - �Զ�
:: Windows Զ�̹���(WinRM)����ִ�� WS-Management Э����ʵ��Զ�̹���WS-Management ������Զ�������Ӳ������ı�׼ Web ����Э�顣
:: WinRM �������������ϵ� WS-Management ���󲢶����ǽ��д���ͨ������Ի�ʹ�� winrm.cmd �����й��ߵ��������������� WinRM ������ʹ���ͨ������������
:: WinRM �����ṩ�� WMI ���ݵķ��ʲ������¼����ϡ��¼����ϼ����¼��Ķ�����Ҫ����������״̬��
:: ���� WinRM ��Ϣʱʹ�� HTTP �� HTTPS Э�顣
:: WinRM ���������� IIS ������ͬһ�������Ԥ����Ϊ�� IIS ����˿ڡ�WinRM ������ /wsman URL ǰ׺��
:: ��Ҫ��ֹ�� IIS ������ͻ������ԱӦȷ�� IIS �ϳ��ص�������վ����ʹ�� /wsman URL ǰ׺��
sc config WinRM start= DISABLED

@ECHO 	Optimize drives - defragsvc
:: Ĭ�� - �ֶ�
:: ͨ���Ż��洢�������ϵ��ļ����������������Ч�����С�
sc config defragsvc start= DISABLED

@ECHO 	luafv - luafv
:: Ĭ�� - 2
:: 
sc config luafv start= DISABLED

@ECHO 	Windows Connection Manager - Wcmsvc
:: Ĭ�� - �Զ�
:: ���ݵ��Ե�ǰ���õ���������ѡ�������Զ�����/�Ͽ����Ӿ��ߣ������ݡ�����ԡ����������������ӹ���
sc config Wcmsvc start= DISABLED