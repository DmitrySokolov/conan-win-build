# How to build `conan.exe`

1) Clone this repository, or just download `build_conan.ps1`

2) Run `.\build_conan.ps1 -Branch 'upstream/release/2.21'`


## Building from existed `conan` source folder

1a. Just copy `build_conan.ps1` to the existed `conan` source folder.

1b. Or specify the `conan` source folder using `-Path` parameter:

    `.\build_conan.ps1 -Path path\to\conan -Branch 'upstream/release/2.21'`


## Result binaries

The app binaries will be in the folder `.\installer\pyinstaller\dist\conan`
