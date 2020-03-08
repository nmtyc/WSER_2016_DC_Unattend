@ECHO OFF

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                             IN Specialize.cmd                      ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

ECHO %time% - IN Specialize.cmd

@ECHO 	显示隐藏设备
SETX DEVMGR_SHOW_DETAILS 1 /M
SETX DEVMGR_SHOW_NONPRESENT_DEVICES 1 /M

@ECHO 	更改电源模式为高性能 POWERCFG -L 获取方案列表
POWERCFG -S 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

@ECHO 	导入组策略中的密码限制部分
PUSHD "%WINDIR%\Setup\Policys\Templates"
CALL Import.cmd
POPD

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                                   注册表                           ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

@ECHO 	控制面板 - 个性化 - 桌面图标设置 - 显示“计算机”
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d "0" /f

@ECHO 	控制面板 - 个性化 - 桌面图标设置 - 显示“控制面板”
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d "0" /f

@ECHO 	设置 - 轻松使用 - 其他选项 - 显示 Windows 背景 - 关
:: 直接使用的 HKCU 目前好像只有这个能用
Reg.exe add "HKU\.DEFAULT\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012038011000000" /f

@ECHO 	修改 时间服务器地址
REG ADD "HKLM\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\DATETIME\SERVERS" /V "1" /T REG_SZ /D "ntp.aliyun.com" /F
REG ADD "HKLM\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\DATETIME\SERVERS" /V "2" /T REG_SZ /D "CN.NTP.ORG.CN" /F

@ECHO 	自动开启 Num 数字键盘
REG ADD "HKU\.DEFAULT\Control Panel\Keyboard" /V "InitialKeyboardIndicators" /T REG_SZ /D "2" /F

@ECHO 	禁用磁盘空间低检测和提醒
:: https://answers.microsoft.com/en-us/windows/forum/windows_10-performance/low-disk-space-warning/2985f242-fee7-4e1f-89e9-1f136b016aa5
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /t REG_DWORD /d "1" /f

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                               计划任务                             ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

:: 系统错误报告
SCHTASKS /Change /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /DISABLE

:: DiskDiagnostic - Windows 磁盘诊断会为加入客户体验计划的用户向 Microsoft 报告常规的磁盘和系统信息。
SCHTASKS /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /DISABLE

:: 网络信息收集器
:: SCHTASKS /Change /TN "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /DISABLE

:: 系统防火墙过滤规则
:: SCHTASKS /Change /TN "\Microsoft\Windows\Windows Filtering Platform\BfeOnServiceStartTypeChange" /DISABLE

:: Defrag - 此任务将优化本地存储驱动器
SCHTASKS /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /DISABLE

:: 效能分析
SCHTASKS /Change /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /DISABLE

:: 本地事件日志
SCHTASKS /Change /TN "\Microsoft\Windows\Location\Notifications" /DISABLE

:: 蓝牙启动计划
:: SCHTASKS /Change /TN "\Microsoft\Windows\Bluetooth\UninstallDeviceTask" /DISABLE

:: WindowsUpdate - 此任务用于在需要时启动 Windows 更新服务以执行计划的操作(如扫描)。
SCHTASKS /Change /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /DISABLE

:: DiskCleanup - 该维护任务由系统用来在可用磁盘空间不足时启动无提示自动磁盘清理。
SCHTASKS /Change /TN "\Microsoft\Windows\DiskCleanup\SilentCleanup" /DISABLE

:: Wininet - Wininet 缓存任务
SCHTASKS /Change /TN "\Microsoft\Windows\Wininet\CacheTask" /DISABLE

:: WindowsColorSystem - 此任务将应用颜色校准设置。
:: SCHTASKS /Change /TN "\Microsoft\Windows\WindowsColorSystem\Calibration Loader" /DISABLE

:: User Profile Service - 该任务自动将漫游用户配置文件的注册表配置单元上载到其网络位置。
:: SCHTASKS /Change /TN "\Microsoft\Windows\User Profile Service\HiveUploadTask" /DISABLE

:: Time Zone - 更新时区信息。如果已停止此任务，则某些时区的本地时间可能不准确。
:: SCHTASKS /Change /TN "\Microsoft\Windows\Time Zone\SynchronizeTimeZone" /DISABLE

:: Registry - 注册表空闲备份任务
SCHTASKS /Change /TN "\Microsoft\Windows\Registry\RegIdleBackup" /DISABLE

:: Maintenance - 度量系统的性能和功能
SCHTASKS /Change /TN "\Microsoft\Windows\Maintenance\WinSAT" /DISABLE

:: Data Integrity Scan - 扫描容错卷的潜在损坏
SCHTASKS /Change /TN "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan" /DISABLE

:: Chkdsk - NTFS 卷状况扫描
SCHTASKS /Change /TN "\Microsoft\Windows\Chkdsk\ProactiveScan" /DISABLE

:: Autochk - 如果已决定参加 Microsoft 客户体验改善计划，则此任务收集和上载自动检查 SQM 数据。
SCHTASKS /Change /TN "\Microsoft\Windows\Autochk\Proxy" /DISABLE

:: Maps - 此任务查找你下载的脱机使用地图的更新。禁用此任务将阻止 Windows 通知你有更新的地图。
SCHTASKS /Change /TN "\Microsoft\Windows\Maps\MapsUpdateTask" /DISABLE

:: Diagnosis - Windows 计划的维护任务通过自动修复问题或通过“安全和维护”来报告问题对计算机系统执行定期维护。
SCHTASKS /Change /TN "\Microsoft\Windows\Diagnosis\Scheduled" /DISABLE

:: Customer Experience Improvement Program - 如果用户已同意参与 Windows 客户体验改善计划，此作业将收集使用情况数据，并向 Microsoft 发送这些数据。
SCHTASKS /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /DISABLE

:: Application Experience - 如果已选择加入 Microsoft 客户体验改善计划，则会收集程序遥测信息。
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /DISABLE

:: Application Experience - 如果选择 Microsoft 客户体验改善计划，则会收集程序遥测信息
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /DISABLE

:: Application Experience - 扫描启动项，并在启动项过多的情况下向用户发出通知。
SCHTASKS /Change /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /DISABLE

@ECHO=
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO     ::                                  系统服务                          ::
@ECHO     ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO=

@ECHO 	Volume Shadow Copy - VSS
:: 默认 手动
:: 管理并执行用于备份和其它用途的卷影复制。如果此服务被终止，备份将没有卷影复制，并且备份会失败。
:: 如果此服务被禁用，任何依赖它的服务将无法启动。
sc config VSS start= DISABLED

@ECHO 	Print Spooler - Spooler
:: 默认 自动
:: 该服务在后台执行打印作业并处理与打印机的交互。
:: 如果关闭该服务，则无法进行打印或查看打印机。
sc config Spooler start= DISABLED

@ECHO 	Connected User Experiences and Telemetry - DiagTrack
:: 默认 - 自动
:: Connected User Experiences and Telemetry 服务所启用的功能支持应用程序中用户体验和连接的用户体验。
:: 此外，如果在“反馈和诊断”下启用诊断和使用情况隐私选项设置，则此服务可以根据事件来管理诊断和使用情况信息的收集和传输(用于改进 Windows 平台的体验和质量)。
sc config DiagTrack start= DISABLED

@ECHO 	IP Helper - iphlpsvc
:: 默认 - 自动
:: 使用 IPv6 转换技术(6to4、ISATAP、端口代理和 Teredo)和 IP-HTTPS 提供隧道连接。
:: 如果停止该服务，则计算机将不具备这些技术提供的增强连接优势。
sc config iphlpsvc start= DISABLED

@ECHO 	Program Compatibility Assistant Service - PcaSvc
:: 默认 - 自动
:: 此服务为程序兼容性助手(PCA)提供支持。PCA 监视由用户安装和运行的程序，并检测已知兼容性问题。
:: 如果停止此服务，PCA 将无法正常运行。
sc config PcaSvc start= DISABLED

@ECHO 	Themes - Themes
:: 默认 - 自动
:: 为用户提供使用主题管理的体验。
sc config Themes start= DISABLED

@ECHO 	Remote Registry - RemoteRegistry
:: 默认 - 自动
:: 使远程用户能修改此计算机上的注册表设置。
:: 如果此服务被终止，只有此计算机上的用户才能修改注册表。如果此服务被禁用，任何依赖它的服务将无法启动。
sc config RemoteRegistry start= DISABLED

@ECHO 	Downloaded Maps Manager - MapsBroker
:: 默认 - 自动(延迟启动)
:: 供应用程序访问已下载地图的 Windows 服务。
:: 此服务由访问已下载地图的应用程序按需启动。禁用此服务将阻止应用访问地图。
sc config MapsBroker start= DISABLED

@ECHO 	Diagnostic Policy Service - DPS
:: 默认 - 自动(延迟启动)
:: 诊断策略服务启用了 Windows 组件的问题检测、疑难解答和解决方案。如果该服务被停止，诊断将不再运行。
sc config DPS start= DISABLED

@ECHO 	Diagnostic Service Host - WdiServiceHost
:: 默认 - 手动
::诊断服务主机被诊断策略服务用来承载需要在本地服务上下文中运行的诊断。
:: 如果停止该服务，则依赖于该服务的任何诊断将不再运行。
sc config WdiServiceHost start= DISABLED

@ECHO 	Diagnostic System Host - WdiSystemHost
:: 默认 - 手动
:: 诊断系统主机被诊断策略服务用来承载需要在本地系统上下文中运行的诊断。
:: 如果停止该服务，则依赖于该服务的任何诊断将不再运行。
sc config WdiSystemHost start= DISABLED

@ECHO 	Distributed Transaction Coordinator - MSDTC
:: 默认 - 自动
:: 协调跨多个数据库、消息队列、文件系统等资源管理器的事务。
:: 如果停止此服务，这些事务将会失败。如果禁用此服务，显式依赖此服务的其他服务将无法启动。
:: 如果使用 MSSQL, 则应保持默认
sc config MSDTC start= DISABLED

@ECHO 	Distributed Link Tracking Client - TrkWks
:: 默认 - 自动
:: 维护某个计算机内或某个网络中的计算机的 NTFS 文件之间的链接。
sc config TrkWks start= DISABLED

@ECHO 	Server - LanmanServer
:: 默认 - 自动
:: 支持此计算机通过网络的文件、打印、和命名管道共享。
:: 如果服务停止，这些功能不可用。如果服务被禁用，任何直接依赖于此服务的服务将无法启动。
sc config LanmanServer start= DISABLED

@ECHO 	SSDP Discovery - SSDPSRV
:: 默认 - 手动
:: 当发现了使用 SSDP 协议的网络设备和服务，如 UPnP 设备，同时还报告了运行在本地计算机上使用的 SSDP 设备和服务。
:: 如果停止此服务，基于 SSDP 的设备将不会被发现。如果禁用此服务，任何依赖此服务的服务都无法正常启动。
sc config SSDPSRV start= DISABLED

@ECHO 	Device Setup Manager - DsmSvc
:: 默认 - 手动(触发器启动)
:: 支持检测、下载和安装与设备相关的软件。
:: 如果此服务被禁用，则可能使用过期软件对设备进行配置，因此设备可能无法正常工作。
:: 备注 - 这个服务会自动下载驱动程序, 比如 显卡, 声卡 驱动.
sc config DsmSvc START= DISABLED

@ECHO 	Windows Search - WSearch
:: 默认 - 禁用
:: 为文件、电子邮件和其他内容提供内容索引、属性缓存和搜索结果。
sc config WSearch start= DISABLED

@ECHO 	Superfetch - SysMain
:: 默认 - 手动
:: 维护和提高一段时间内的系统性能。
sc config SysMain start= DISABLED

@ECHO 	Function Discovery Resource Publication - FDResPub
:: 默认 - 手动
:: 发布该计算机以及连接到该计算机的资源，以便能够在网络上发现这些资源。
:: 如果该服务被停止，将不再发布网络资源，网络上的其他计算机将无法发现这些资源。
sc config FDResPub start= DISABLED

@ECHO 	Function Discovery Provider Host - fdPHost
:: 默认 - 手动
:: FDPHOST 服务承载功能发现(FD)网络发现提供程序。这些 FD 提供程序为简单服务发现协议(SSDP)和 Web 服务发现(WS-D)协议提供网络发现服务。
:: 使用 FD 时停止或禁用 FDPHOST 服务将禁用这些协议的网络发现。
:: 当该服务不可用时，使用 FD 和依靠这些发现协议的网络服务将无法找到网络服务或资源。
sc config fdPHost start= DISABLED

@ECHO 	Windows 预览体验成员服务 - wisvc
:: 默认 - 手动
:: 为 Windows 预览体验计划提供基础结构支持。此服务必须保持启用状态，Windows 预览体验计划才能正常运行。
sc config wisvc start= DISABLED

@ECHO 	User Access Logging Service - UALSVC
:: 默认 - 自动(延迟启动)
:: 此服务以 IP 地址和用户名的形式记录本地服务器上安装的产品和角色的特有客户端访问请求。记录的信息包括 IP 地址和用户名。如果管理员需要衡量客户端的服务器软件需求量以进行脱机客户端访问许可证(CAL)管理，他们可通过 Powershell 查询这些信息。
:: 如果禁用该服务，则不会记录客户端请求，也无法通过 Powershell 查询检索这些请求。
:: 停止该服务不会影响历史数据查询(请参见支持文档以了解删除历史数据的步骤)。本地系统管理员必须查阅其 Windows Server 许可条款，以确定正确许可服务器软件所需的 CAL 数量；使用 UAL 服务和数据并不会改变这种义务。
sc config UALSVC start= DISABLED

@ECHO 	Windows Remote Management (WS-Management) - WinRM
:: 默认 - 自动
:: Windows 远程管理(WinRM)服务执行 WS-Management 协议来实现远程管理。WS-Management 是用于远程软件和硬件管理的标准 Web 服务协议。
:: WinRM 服务侦听网络上的 WS-Management 请求并对它们进行处理。通过组策略或使用 winrm.cmd 命令行工具的侦听程序，来配置 WinRM 服务，以使其可通过网络侦听。
:: WinRM 服务提供对 WMI 数据的访问并启用事件集合。事件集合及对事件的订阅需要服务处于运行状态。
:: 传输 WinRM 消息时使用 HTTP 和 HTTPS 协议。
:: WinRM 服务不依赖于 IIS ，但在同一计算机上预配置为与 IIS 共享端口。WinRM 服务保留 /wsman URL 前缀。
:: 若要防止与 IIS 发生冲突，管理员应确保 IIS 上承载的所有网站均不使用 /wsman URL 前缀。
sc config WinRM start= DISABLED

@ECHO 	Optimize drives - defragsvc
:: 默认 - 手动
:: 通过优化存储驱动器上的文件来帮助计算机更高效地运行。
sc config defragsvc start= DISABLED

@ECHO 	luafv - luafv
:: 默认 - 2
:: 
sc config luafv start= DISABLED

@ECHO 	Windows Connection Manager - Wcmsvc
:: 默认 - 自动
:: 根据电脑当前可用的网络连接选项做出自动连接/断开连接决策，并根据“组策略”设置启用网络连接管理。
sc config Wcmsvc start= DISABLED