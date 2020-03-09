@ECHO OFF

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                            IN FirstLogon.CMD                       ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

ECHO %time% - IN FirstLogon.cmd


@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                             配置 组策略                            ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

PUSHD "%SystemRoot%\Setup\Policys"
XCOPY "%CD%\GroupPolicy" "%SystemRoot%\System32\GroupPolicy" /I /R /E /Y
GPUPDATE /FORCE
POPD

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                                   安装软件                         ::
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
@ECHO     ::                                 注册表                             ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

:: 服务器管理器  - 登录时不自动启动服务器管理器
Reg.exe add "HKCU\SOFTWARE\Microsoft\ServerManager" /v "DoNotOpenServerManagerAtLogon" /t REG_DWORD /d "1" /f

:: 控制面板 - 个性化 - 桌面图标设置 - 显示“计算机”
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d "0" /f

:: 控制面板 - 个性化 - 桌面图标设置 - 显示“控制面板”
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d "0" /f

:: 控制面板 - 个性化 - 桌面图标设置 - 允许主题更改桌面图标 - 关闭
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes" /v "ThemeChangesDesktopIcons" /t REG_DWORD /d "0" /f

:: 控制面板 - 轻松使用设置中心 - 更改登录设置 - 按 Caps Lock、Num Lock 或 Scroll Lock 时听见声音
Reg.exe add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "63" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Accessibility" /v "Configuration" /t REG_SZ /d "togglekeys" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Accessibility\Session1" /v "Configuration" /t REG_SZ /d "" /f

:: 控制面板 - 图标显示方式
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v "AllItemsIconView" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v "StartupPage" /t REG_DWORD /d "1" /f

:: 控制面板 - 用户账户 - 更改用户账户控制设置 - 从不通知
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f

:: 任务栏 - 搜索 - 隐藏
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f

:: 任务栏 - 显示“任务视图”按钮 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f

:: 设置 - 个性化 - 开始 - 显示最常用的应用 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d "0" /f

:: 设置 - 个性化 - 开始 - 在“开始”屏幕或任务栏的跳转列表中显示最近打开的项 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d "0" /f

:: 设置 - 个性化 - 任务栏 - 合并任务栏按钮 - 从不
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d "2" /f

:: 设置 - 个性化 - 任务栏 - 通知区域 - 选择那些图标显示在任务栏上 - 通知区域始终显示所有图标 - 通知区域始终显示所有图标 - 开
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "EnableAutoTray" /t REG_DWORD /d "0" /f

:: 设置 - 个性化 - 颜色 - 使“开始”菜单、任务栏和操作中心透明 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f

:: 设置 - 轻松使用 - 其他选项 - 显示 Windows 背景 - 关
Reg.exe add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012038011000000" /f

:: 设置 - 设备 - 鼠标和触摸板 - 当我悬停在非活动窗口上方时对其进行滚动 - 关
Reg.exe add "HKCU\Control Panel\Desktop" /v "MouseWheelRouting" /t REG_DWORD /d "0" /f

:: 设置 - 系统 - 多任务 - 当我调整某个贴靠窗口的大小时，也调整任何相邻贴靠窗口的大小 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "JointResize" /t REG_DWORD /d "0" /f

:: 设置 - 系统 - 多任务 - 将窗口对齐时，显示能够在其旁边对齐的内容 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapAssist" /t REG_DWORD /d "0" /f

:: 设置 - 系统 - 多任务 - 将窗口拖动到屏幕边缘或角落时，自动对其进行排列 - 关
Reg.exe add "HKCU\Control Panel\Desktop" /v "WindowArrangementActive" /t REG_SZ /d "0" /f

:: 设置 - 系统 - 多任务 - 贴靠窗口时自动调整窗口的大小，使之填满可用空间 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapFill" /t REG_DWORD /d "0" /f

:: 设置 - 系统 - 平板电脑模式 - 不询问我，不进行切换
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "ConvertibleSlateModePromptPreference" /t REG_DWORD /d "0" /f

:: 设置 - 系统 - 平板电脑模式 - 处于平板电脑模式时隐藏任务栏上的应用图标
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAppsVisibleInTabletMode" /t REG_DWORD /d "1" /f

:: 设置 - 系统 - 平板电脑模式 - 当我登录时 - 使用桌面模式
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "SignInMode" /t REG_DWORD /d "1" /f

:: 设置 - 系统 - 通知和操作 - 获取来自应用和其他发送者的通知 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d "0" /f

:: 设置 - 系统 - 通知和操作 - 获取来自这些发送者的通知 - 安全和维护 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f

:: 设置 - 系统 - 通知和操作 - 获取来自这些发送者的通知 - 自动播放 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.AutoPlay" /v "Enabled" /t REG_DWORD /d "0" /f

:: 设置 - 系统 - 通知和操作 - 在锁屏界面上显示警报、提醒和 VoIP 来电 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /t REG_DWORD /d "0" /f

:: 设置 - 系统 - 通知和操作 - 在锁屏界面上显示通知 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /t REG_DWORD /d "0" /f

:: 设置 - 隐私 - 常规 - 打开 SmartScreen 筛选器， 以检查 Windows 应用商店应用所使用的 Web 内容（URL） - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f

:: 设置 - 隐私 - 常规 - 允许其他设备上的应用打开应用并继续此设备上的体验 - 关
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" /v "UserAuthPolicy" /t REG_DWORD /d "0" /f

:: 设置 - 隐私 - 常规 - 允许网站通过访问我的语言列表来提供本地相关内容 - 关
Reg.exe add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f

:: 设置 - 隐私 - 反馈和诊断 - Windows 应询问我的意见 - 从不
Reg.exe add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f

:: 微软拼音 - 输入法内置及用户自定义短语 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Enable EUDP" /t REG_DWORD /d "0" /f

:: 微软拼音 - 显示符号视图按钮 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\CandidateWindow\CHS\1" /v "ShowSymbolViewActionButton" /t REG_DWORD /d "0" /f

:: 微软拼音 - 显示候选项上下文菜单 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\CandidateWindow\CHS\1" /v "ContextMenuFlags" /t REG_DWORD /d "0" /f

:: 微软拼音 - 选择输入法默认模式 - 英文
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d "1" /f

:: 微软拼音 - 云计算 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Enable Cloud Candidate" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\SHARED" /v "COCAvailablePrivacyConsentUXCount" /t REG_DWORD /d "0" /f

:: 微软拼音 - 专业词典 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "EnableDomainType" /t REG_DWORD /d "0" /f

:: 微软拼音 - 自动拼音纠错 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Enable Auto Correction" /t REG_DWORD /d "0" /f

:: 文件夹选项 - 查看 - 使用共享向导（推荐） - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SharingWizardOn" /t REG_DWORD /d "0" /f

:: 文件夹选项 - 查看 - 鼠标指向文件夹和桌面项时显示提示信息 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowInfoTip" /t REG_DWORD /d "0" /f

:: 文件夹选项 - 查看 - 显示同步提供程序通知 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f

:: 文件夹选项 - 查看 - 显示隐藏的文件、文件夹和驱动器
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f

:: 文件夹选项 - 查看 - 隐藏已知文件类型的扩展名 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f

:: 文件夹选项 - 常规 - 打开文件资源管理器时打开 - 此电脑
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f

:: 文件夹选项 - 常规 - 清除文件资源管理器历史纪录
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRULegacy" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU" /f

:: 文件夹选项 - 常规 - 在“快速访问”中显示常用文件夹 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d "0" /f

:: 文件夹选项 - 常规 - 在“快速访问”中显示最近使用的文件 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d "0" /f

:: 文件夹选项 - 搜索 - 在搜索未建立索引的位置时 - 包括系统目录 - 关
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences" /v "SystemFolders" /t REG_DWORD /d "0" /f

:: 文件夹选项 - 搜索 - 在文件夹中搜索系统文件时不使用索引 - 开
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences" /v "WholeFileSystem" /t REG_DWORD /d "1" /f

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                          一些主副服务的类型禁用                    ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

@REM 获取服务后缀
@FOR /F "tokens=*" %%i IN ('REG QUERY HKLM\SYSTEM\CurrentControlSet\Services /K /F "OneSyncSvc" ^| FINDSTR /R /E /C:"_[0-9 a-z-]*$"') DO SET LINE=%%i
@SET POSTFIX=%LINE:~-5%
@ECHO %POSTFIX%

@ECHO 	同步主机 - OneSyncSvc
:: 默认 - 自动(延迟启动)
:: 此服务将同步邮件、联系人、日历和各种其他用户数据。
:: 此服务没有运行时，依赖于此功能的邮件和其他应用程序将无法正常工作。
:: sc config OneSyncSvc start= DISABLED
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc_%POSTFIX%" /v "Start" /t REG_DWORD /d "4" /f

@ECHO 	User Data Access - UserDataSvc
:: 默认 - 手动
:: 提供对结构化用户数据(包括联系人信息、日历、消息和其他内容)的应用访问。
:: 如果停止或禁用此服务，使用此数据的应用可能无法正常工作。
:: sc config UserDataSvc start= DISABLED - SC 无权限操作
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc_%POSTFIX%" /v "Start" /t REG_DWORD /d "4" /f

@ECHO 	User Data Storage - UnistoreSvc
:: SC 无权限操作
:: 默认 - 手动
:: 处理结构化用户数据(包括联系人信息、日历、消息和其他内容)的存储。
:: 如果停止或禁用此服务，使用此数据的应用可能无法正常工作。
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UnistoreSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UnistoreSvc_%POSTFIX%" /v "Start" /t REG_DWORD /d "4" /f

@ECHO 	连接设备平台服务 - CDPSvc
:: 默认 - 自动(延迟启动)
:: 此服务用于已连接设备和通用玻璃方案。
:: sc config CDPSvc start= DISABLED
:: sc config CDPUserSvc start= DISABLED
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc_%POSTFIX%" /v "Start" /t REG_DWORD /d "4" /f

@ECHO 	Windows 推送通知系统服务 - WpnService
:: 默认 - 自动
:: 此服务在会话 0 中运行，并托管通知平台和连接提供程序(用于处理设备与 WNS 服务器之间的连接)。
:: sc config WpnService start= DISABLED
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpnService" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpnService_%POSTFIX%" /v "Start" /t REG_DWORD /d "4" /f

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                              重启 EXPLORER                         ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

PAUSE

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                 删除自身                                   ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::DEL /Q /F "%0"