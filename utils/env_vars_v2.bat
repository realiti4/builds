set CONFIG=release

set CMAKE_GENERATOR=Ninja
REM #set CMAKE_GENERATOR=Visual Studio 16 2019
REM #set CMAKE_GENERATOR_TOOLSET_VERSION=14.27

REM #set USE_CUDA=0
REM #set TH_BINARY_BUILD=1
REM #set BUILD_TEST=0
set INSTALL_TEST=0

set CUDA_PREFIX=cuda102
set MAGMA_VERSION=2.5.3

set TMP_DIR_WIN=F:\virtualenvs\builds\library\

:check_sccache
taskkill /im sccache.exe /f /t || ver > nul
del %TMP_DIR_WIN%\bin\sccache.exe || ver > nul
del %TMP_DIR_WIN%\bin\sccache-cl.exe || ver > nul
curl --retry 3 -k https://s3.amazonaws.com/ossci-windows/sccache.exe --output %TMP_DIR_WIN%\bin\sccache.exe
curl --retry 3 -k https://s3.amazonaws.com/ossci-windows/sccache-cl.exe --output %TMP_DIR_WIN%\bin\sccache-cl.exe

:check_magma
if not exist %TMP_DIR_WIN%\magma\ (
	curl -k https://s3.amazonaws.com/ossci-windows/magma_%MAGMA_VERSION%_%CUDA_PREFIX%_%CONFIG%.7z -o %TMP_DIR_WIN%\magma.7z
	7za x -aoa %TMP_DIR_WIN%\magma.7z -o%TMP_DIR_WIN%\magma
	del %TMP_DIR_WIN%\magma.7z
)

REM #set CMAKE_VERBOSE_MAKEFILE=1
set USE_DISTRIBUTED=0
set DISTUTILS_USE_SDK=1

set PATH=%TMP_DIR_WIN%\bin;%PATH%

REM #sccache --stop-server
REM #sccache --start-server
REM #sccache --zero-stats
REM #set CC=sccache-cl
REM #set CXX=sccache-cl

set MKLProductDIR=D:\Files\Program\IntelSWTools\compilers_and_libraries_2020.3.279\windows

set CMAKE_INCLUDE_PATH=%MKLProductDIR%\mkl\include;%CMAKE_INCLUDE_PATH%
set LIB=%MKLProductDir%\mkl\lib;%LIB%
set MAGMA_HOME=%TMP_DIR_WIN%\magma

"D:\Files\Program\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.27
