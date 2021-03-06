:: Install:
:: https://git-scm.com/download/win
:: ? for wix? Microsoft .NET Framework 3.5
:: http://wixtoolset.org/releases/ - WiX Toolset Visual Studio 2017 Extension
:: https://www.visualstudio.com/downloads/ - Visual Studio Community 2017 - Desktop development with C++
::                                                                           + Windows 8.1 SDK and UCRT SDK
::                                                                           + MFC and ATL support (x86 and x64)
::                                                                           ? C++/CLI support

:: call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64 8.1

SET PATH=%PATH%;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\
SET PATH=%PATH%;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\

devenv /upgrade odbc64.sln
devenv /upgrade odbc32.sln

msbuild /m /p:Configuration=Release odbc64.sln
msbuild /m /p:Configuration=Release odbc32.sln
msbuild /m /p:Configuration=Debug odbc64.sln
msbuild /m /p:Configuration=Debug odbc32.sln
