@ECHO OFF

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                            IN FirstLogon.CMD                       ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

ECHO %time% - IN FirstLogon.cmd


@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                             ���� �����                            ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

PUSHD "%SystemRoot%\Setup\Policys"
XCOPY "%CD%\GroupPolicy" "%SystemRoot%\System32\GroupPolicy" /I /R /E /Y
GPUPDATE /FORCE
POPD

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                                   ��װ���                         ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

PUSHD "%WINDIR%\Setup\Apps"

@ECHO 	Microsoft Visual C++ Redistributable
CALL "%CD%\Microsoft Visual C++ Redistributable\Install.cmd"

@ECHO   360 Chrome
CALL "%CD%\360Chrome\Install.cmd"

@ECHO 	Notepad2-mod
CALL "%CD%\NotePad2\Install.cmd"

@ECHO 	WinRAR
CALL "%CD%\WinRAR\Install.cmd"

POPD

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                                 ע���                             ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

:: ������������  - ��¼ʱ���Զ�����������������
Reg.exe add "HKCU\SOFTWARE\Microsoft\ServerManager" /v "DoNotOpenServerManagerAtLogon" /t REG_DWORD /d "1" /f

:: ������� - ���Ի� - ����ͼ������ - ��ʾ���������
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d "0" /f

:: ������� - ���Ի� - ����ͼ������ - ��ʾ��������塱
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d "0" /f

:: ������� - ���Ի� - ����ͼ������ - ���������������ͼ�� - �ر�
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes" /v "ThemeChangesDesktopIcons" /t REG_DWORD /d "0" /f

:: ������� - ����ʹ���������� - ���ĵ�¼���� - �� Caps Lock��Num Lock �� Scroll Lock ʱ��������
Reg.exe add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "63" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Accessibility" /v "Configuration" /t REG_SZ /d "togglekeys" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Accessibility\Session1" /v "Configuration" /t REG_SZ /d "" /f

:: ������� - ͼ����ʾ��ʽ
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v "AllItemsIconView" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v "StartupPage" /t REG_DWORD /d "1" /f

:: ������� - �û��˻� - �����û��˻��������� - �Ӳ�֪ͨ
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f

:: ������ - ���� - ����
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f

:: ������ - ��ʾ��������ͼ����ť - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f

:: ���� - ���Ի� - ��ʼ - ��ʾ��õ�Ӧ�� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d "0" /f

:: ���� - ���Ի� - ��ʼ - �ڡ���ʼ����Ļ������������ת�б�����ʾ����򿪵��� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d "0" /f

:: ���� - ���Ի� - ������ - �ϲ���������ť - �Ӳ�
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d "2" /f

:: ���� - ���Ի� - ������ - ֪ͨ���� - ѡ����Щͼ����ʾ���������� - ֪ͨ����ʼ����ʾ����ͼ�� - ֪ͨ����ʼ����ʾ����ͼ�� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "EnableAutoTray" /t REG_DWORD /d "0" /f

:: ���� - ���Ի� - ��ɫ - ʹ����ʼ���˵����������Ͳ�������͸�� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f

:: ���� - ����ʹ�� - ����ѡ�� - ��ʾ Windows ���� - ��
Reg.exe add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012038011000000" /f

:: ���� - �豸 - ���ʹ����� - ������ͣ�ڷǻ�����Ϸ�ʱ������й��� - ��
Reg.exe add "HKCU\Control Panel\Desktop" /v "MouseWheelRouting" /t REG_DWORD /d "0" /f

:: ���� - ϵͳ - ������ - ���ҵ���ĳ���������ڵĴ�Сʱ��Ҳ�����κ������������ڵĴ�С - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "JointResize" /t REG_DWORD /d "0" /f

:: ���� - ϵͳ - ������ - �����ڶ���ʱ����ʾ�ܹ������Ա߶�������� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapAssist" /t REG_DWORD /d "0" /f

:: ���� - ϵͳ - ������ - �������϶�����Ļ��Ե�����ʱ���Զ������������ - ��
Reg.exe add "HKCU\Control Panel\Desktop" /v "WindowArrangementActive" /t REG_SZ /d "0" /f

:: ���� - ϵͳ - ������ - ��������ʱ�Զ��������ڵĴ�С��ʹ֮�������ÿռ� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapFill" /t REG_DWORD /d "0" /f

:: ���� - ϵͳ - ƽ�����ģʽ - ��ѯ���ң��������л�
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "ConvertibleSlateModePromptPreference" /t REG_DWORD /d "0" /f

:: ���� - ϵͳ - ƽ�����ģʽ - ����ƽ�����ģʽʱ�����������ϵ�Ӧ��ͼ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAppsVisibleInTabletMode" /t REG_DWORD /d "1" /f

:: ���� - ϵͳ - ƽ�����ģʽ - ���ҵ�¼ʱ - ʹ������ģʽ
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "SignInMode" /t REG_DWORD /d "1" /f

:: ���� - ϵͳ - ֪ͨ�Ͳ��� - ��ȡ����Ӧ�ú����������ߵ�֪ͨ - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d "0" /f

:: ���� - ϵͳ - ֪ͨ�Ͳ��� - ��ȡ������Щ�����ߵ�֪ͨ - ��ȫ��ά�� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f

:: ���� - ϵͳ - ֪ͨ�Ͳ��� - ��ȡ������Щ�����ߵ�֪ͨ - �Զ����� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.AutoPlay" /v "Enabled" /t REG_DWORD /d "0" /f

:: ���� - ϵͳ - ֪ͨ�Ͳ��� - ��������������ʾ���������Ѻ� VoIP ���� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /t REG_DWORD /d "0" /f

:: ���� - ϵͳ - ֪ͨ�Ͳ��� - ��������������ʾ֪ͨ - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /t REG_DWORD /d "0" /f

:: ���� - ��˽ - ���� - �� SmartScreen ɸѡ���� �Լ�� Windows Ӧ���̵�Ӧ����ʹ�õ� Web ���ݣ�URL�� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f

:: ���� - ��˽ - ���� - ���������豸�ϵ�Ӧ�ô�Ӧ�ò��������豸�ϵ����� - ��
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" /v "UserAuthPolicy" /t REG_DWORD /d "0" /f

:: ���� - ��˽ - ���� - ������վͨ�������ҵ������б����ṩ����������� - ��
Reg.exe add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f

:: ���� - ��˽ - ��������� - Windows Ӧѯ���ҵ���� - �Ӳ�
Reg.exe add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f

:: ΢��ƴ�� - ���뷨���ü��û��Զ������ - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Enable EUDP" /t REG_DWORD /d "0" /f

:: ΢��ƴ�� - ��ʾ������ͼ��ť - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\CandidateWindow\CHS\1" /v "ShowSymbolViewActionButton" /t REG_DWORD /d "0" /f

:: ΢��ƴ�� - ��ʾ��ѡ�������Ĳ˵� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\CandidateWindow\CHS\1" /v "ContextMenuFlags" /t REG_DWORD /d "0" /f

:: ΢��ƴ�� - ѡ�����뷨Ĭ��ģʽ - Ӣ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d "1" /f

:: ΢��ƴ�� - �Ƽ��� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Enable Cloud Candidate" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\SHARED" /v "COCAvailablePrivacyConsentUXCount" /t REG_DWORD /d "0" /f

:: ΢��ƴ�� - רҵ�ʵ� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "EnableDomainType" /t REG_DWORD /d "0" /f

:: ΢��ƴ�� - �Զ�ƴ������ - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Enable Auto Correction" /t REG_DWORD /d "0" /f

:: �ļ���ѡ�� - �鿴 - ʹ�ù����򵼣��Ƽ��� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SharingWizardOn" /t REG_DWORD /d "0" /f

:: �ļ���ѡ�� - �鿴 - ���ָ���ļ��к�������ʱ��ʾ��ʾ��Ϣ - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowInfoTip" /t REG_DWORD /d "0" /f

:: �ļ���ѡ�� - �鿴 - ��ʾͬ���ṩ����֪ͨ - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f

:: �ļ���ѡ�� - �鿴 - ��ʾ���ص��ļ����ļ��к�������
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f

:: �ļ���ѡ�� - �鿴 - ������֪�ļ����͵���չ�� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f

:: �ļ���ѡ�� - ���� - ���ļ���Դ������ʱ�� - �˵���
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f

:: �ļ���ѡ�� - ���� - ����ļ���Դ��������ʷ��¼
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRULegacy" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU" /f

:: �ļ���ѡ�� - ���� - �ڡ����ٷ��ʡ�����ʾ�����ļ��� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d "0" /f

:: �ļ���ѡ�� - ���� - �ڡ����ٷ��ʡ�����ʾ���ʹ�õ��ļ� - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d "0" /f

:: �ļ���ѡ�� - ���� - ������δ����������λ��ʱ - ����ϵͳĿ¼ - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences" /v "SystemFolders" /t REG_DWORD /d "0" /f

:: �ļ���ѡ�� - ���� - ���ļ���������ϵͳ�ļ�ʱ��ʹ������ - ��
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences" /v "WholeFileSystem" /t REG_DWORD /d "1" /f

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                          һЩ������������ͽ���                    ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

@REM ��ȡ�����׺
@FOR /F "tokens=*" %%i IN ('REG QUERY HKLM\SYSTEM\CurrentControlSet\Services /K /F "OneSyncSvc" ^| FINDSTR /R /E /C:"_[0-9 a-z-]*$"') DO SET LINE=%%i
@SET POSTFIX=%LINE:~-5%
@ECHO %POSTFIX%

@ECHO 	ͬ������ - OneSyncSvc
:: Ĭ�� - �Զ�(�ӳ�����)
:: �˷���ͬ���ʼ�����ϵ�ˡ������͸��������û����ݡ�
:: �˷���û������ʱ�������ڴ˹��ܵ��ʼ�������Ӧ�ó����޷�����������
:: sc config OneSyncSvc start= DISABLED
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc_%POSTFIX%" /v "Start" /t REG_DWORD /d "4" /f

@ECHO 	User Data Access - UserDataSvc
:: Ĭ�� - �ֶ�
:: �ṩ�Խṹ���û�����(������ϵ����Ϣ����������Ϣ����������)��Ӧ�÷��ʡ�
:: ���ֹͣ����ô˷���ʹ�ô����ݵ�Ӧ�ÿ����޷�����������
:: sc config UserDataSvc start= DISABLED - SC ��Ȩ�޲���
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc_%POSTFIX%" /v "Start" /t REG_DWORD /d "4" /f

@ECHO 	User Data Storage - UnistoreSvc
:: SC ��Ȩ�޲���
:: Ĭ�� - �ֶ�
:: ����ṹ���û�����(������ϵ����Ϣ����������Ϣ����������)�Ĵ洢��
:: ���ֹͣ����ô˷���ʹ�ô����ݵ�Ӧ�ÿ����޷�����������
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UnistoreSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UnistoreSvc_%POSTFIX%" /v "Start" /t REG_DWORD /d "4" /f

@ECHO 	�����豸ƽ̨���� - CDPSvc
:: Ĭ�� - �Զ�(�ӳ�����)
:: �˷��������������豸��ͨ�ò���������
:: sc config CDPSvc start= DISABLED
:: sc config CDPUserSvc start= DISABLED
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc_%POSTFIX%" /v "Start" /t REG_DWORD /d "4" /f

@ECHO 	Windows ����֪ͨϵͳ���� - WpnService
:: Ĭ�� - �Զ�
:: �˷����ڻỰ 0 �����У����й�֪ͨƽ̨�������ṩ����(���ڴ����豸�� WNS ������֮�������)��
:: sc config WpnService start= DISABLED
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpnService" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpnService_%POSTFIX%" /v "Start" /t REG_DWORD /d "4" /f

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                              ���� EXPLORER                         ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

PAUSE

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                 ɾ������                                   ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::DEL /Q /F "%0"