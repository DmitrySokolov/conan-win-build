# How to build `conan.exe`

1) Clone this repository, or just download `build_conan.ps1`

2) Run `.\build_conan.ps1 -Branch 'origin/release/2.19'`


## Building from existed `conan` source folder

Just copy `build_conan.ps1` to the existed `conan` source folder.

Or specify the `conan` source folder using `-Path` parameter:

    `.\build_conan.ps1 -Path path\to\conan -Branch 'origin/release/2.19'`
