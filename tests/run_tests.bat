@echo off

for %%f in (samples\*.lua) do (
    build\premake5 generic --file=%%f
)

build\premake5 vs2015 --file=build\premake5.lua

pushd %cd%
cd build\vs2015
call "%VS140COMNTOOLS%\vsvars32.bat"
devenv Tests.sln /Build Debug
popd
