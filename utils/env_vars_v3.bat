set CONFIG=release

set CMAKE_GENERATOR=Ninja
REM #set CMAKE_GENERATOR=Visual Studio 16 2019
REM #set CMAKE_GENERATOR_TOOLSET_VERSION=14.27

REM #set USE_CUDA=0
REM #set TH_BINARY_BUILD=1
REM #set BUILD_TEST=0
set USE_DISTRIBUTED=0
set INSTALL_TEST=0
set DISTUTILS_USE_SDK=1

set CUDA_PREFIX=cuda111
set MAGMA_VERSION=2.5.4

set TMP_DIR_WIN=F:\virtualenvs\builds\library\

:check_magma
if not exist %TMP_DIR_WIN%\magma\ (
	curl -k https://s3.amazonaws.com/ossci-windows/magma_%MAGMA_VERSION%_%CUDA_PREFIX%_%CONFIG%.7z -o %TMP_DIR_WIN%\magma.7z
	7za x -aoa %TMP_DIR_WIN%\magma.7z -o%TMP_DIR_WIN%\magma
	del %TMP_DIR_WIN%\magma.7z
)

set MAGMA_HOME=%TMP_DIR_WIN%\magma
set libuv_ROOT=C:\packages\libuv-1.40.0

"D:\Files\Program\IntelSWTools\compilers_and_libraries_2020.3.279\windows\bin\compilervars.bat" intel64 vs2019
