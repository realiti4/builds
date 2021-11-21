set MAGMA_VERSION=2.5.4

set CONFIG=release

git clone https://github.com/peterjc123/magma.git magma

cd magma
mkdir build && cd build

set GPU_TARGET=All
set CUDA_ARCH_LIST= -gencode arch=compute_75,code=sm_75

set CC=cl.exe
set CXX=cl.exe

"D:\Files\Program\IntelSWTools\compilers_and_libraries_2020.4.311\windows\bin\compilervars.bat" intel64 vs2019

cmake .. -DGPU_TARGET="%GPU_TARGET%" ^
            -DUSE_FORTRAN=0 ^
            -DCMAKE_CXX_FLAGS="/FS /Zf" ^
            -DCMAKE_BUILD_TYPE=%CONFIG% ^
            -DCMAKE_GENERATOR=Ninja ^
            -DCMAKE_INSTALL_PREFIX=..\install\ ^
            -DCUDA_ARCH_LIST="%CUDA_ARCH_LIST%"
            
cmake --build . --target install --config %CONFIG% -- -j 4