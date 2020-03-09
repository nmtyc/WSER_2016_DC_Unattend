PUSHD %~DP0

::Microsoft Visual C++ Redistributable 2005 - 6.0.2900.2180
START "" /D "%CD%\2005" /WAIT "vcredist_x64.exe" /Q
START "" /D "%CD%\2005" /WAIT "vcredist_x86.exe" /Q

::Microsoft Visual C++ Redistributable 2008 - 9.0.30729.5677
START "" /D "%CD%\2008" /WAIT "vcredist_x64.exe" /Q
START "" /D "%CD%\2008" /WAIT "vcredist_x86.exe" /Q

::Microsoft Visual C++ Redistributable 2010 - 10.0.40219.325
START "" /D "%CD%\2010" /WAIT "vcredist_x64.exe" /PASSIVE /NORESTART
START "" /D "%CD%\2010" /WAIT "vcredist_x86.exe" /PASSIVE /NORESTART

::Microsoft Visual C++ Redistributable 2012 - 11.0.61030.0
START "" /D "%CD%\2012" /WAIT "vcredist_x64.exe" /PASSIVE /NORESTART
START "" /D "%CD%\2012" /WAIT "vcredist_x86.exe" /PASSIVE /NORESTART

::Microsoft Visual C++ Redistributable 2013 - 12.0.30501.0 /Quiet
START "" /D "%CD%\2013" /WAIT "vcredist_x64.exe" /PASSIVE /NORESTART
START "" /D "%CD%\2013" /WAIT "vcredist_x86.exe" /PASSIVE /NORESTART

::Microsoft Visual C++ Redistributable 2017 - 14.16.27012.6
START "" /D "%CD%\2017" /WAIT "vc_redist.x64.exe" /PASSIVE /NORESTART
START "" /D "%CD%\2017" /WAIT "vc_redist.x86.exe" /PASSIVE /NORESTART

POPD