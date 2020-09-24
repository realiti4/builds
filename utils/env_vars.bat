set CONFIG=release

set CMAKE_GENERATOR=Ninja

set BUILD_TEST=0

set CUDA_PREFIX=cuda102
set MAGMA_VERSION=2.5.3

if not exist magma\ (
	curl -k https://s3.amazonaws.com/ossci-windows/magma_%MAGMA_VERSION%_%CUDA_PREFIX%_%CONFIG%.7z -o magma.7z
	7za x -aoa magma.7z -omagma
	del magma.7z
)

set DISTUTILS_USE_SDK=1

set MKLProductDIR=D:\Files\Program\IntelSWTools\compilers_and_libraries_2020.2.254\windows

set LIB=%MKLProductDir%\mkl\lib;%LIB%
set LIB=%MKLProductDir%\mkl\lib\intel64_win;%LIB%
set CMAKE_INCLUDE_PATH=%MKLProductDIR%\mkl\include;%CMAKE_INCLUDE_PATH%
set MAGMA_HOME=%cd%\magma
