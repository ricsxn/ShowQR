[![Build Status](https://travis-ci.org/ricsxn/ShowQR.svg?branch=master)](https://travis-ci.org/ricsxn/ShowQR)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://paypal.me/ricsxn?locale.x=it_IT)


# [ShowQR](http://ricsxn.github.io/ShowQR/) [Download][package]
Show QR code from any selected text on your Mac</br>
How shall I send text/URLs from my Mac to my Mobile in a fast and confortable way?<br/>
The ShowQR utility gratfully solves that!</br>
Once installed you can select any text from any application and with few mouse clicks the corresponding QR code containing that text will be promptly shown.</br>
You can use this little service for free or if you like this tool you can leave a donation by clicking [here][donate]

## Structure
ShowQR service consists of two components, a simple python script that triggers Preview.app containing the generated QR code taken from the stadard input, while the second component consists of an automator script that setup the system-wide service.

## Installation
The repository contains the [ShowQR.pkg][package] file that allows to install directly the utility into your Mac.
Altough the package should work for any MacOS X version, it is possible that the showQR application will not work due to specific Mac OS architecture differencies. In this case, it is suggested to build the code from sources as reported in the build section.

## Usage
Once installed the utilty; select any text from any application and use one of the following:
 - Go in the current app name menu and select: Services/ShowQR item
 - Right click on top of selected text and select in the contextual menu: ShowQR.
ShowQR generates a temporary file and triggers the Preview.app to show the generated QR code. The temporary file is already removed from the filesystem when it is displayed by the Preview application.

![][usecase]

## Build
The build process requires the following steps

### Python, pip, and requirements
ShowQR core component is a python2.7 script, the standard python interpreter provided by Mac OS may create problems, in such a case, the following commands use the [brew][brew] package, to setup python.

```bash
$ brew install python@2
$ easy_install pip
```

### ShowQR compilation
ShowQR compile the python application using pyinstaller. The necessary commands to compile the source code are managed by the Makefile. Following rules are available:

```bash
$ make
Usage:
    make clean   - Cleanup project folder
    make showqr  - Generate the showqr application
    make test    - Test the showqr executable
    make install - Install ShowQR (brew)
```

The make install has been thought to integrate ShowQR in homebrew. In this case the ShowQR utility works only at user level. The installation made with the package will activate ShowQR for all users. This change can be easily modified changin paths inside the `install` Makefile rule.

### Package creation
The package project file `showQRPackages.pkgproj`, already contains the necessary configuration to create the [ShowQR.pkg][package] file, however in order to open this project file the [Packages][packages] application must be installed first. Once opened the package project file, just select the menu Build/Build.
If everithing is fine, the new ShowQR.pkg file will be generated successfully

[brew]: https://brew.sh/index_it
[packages]: http://s.sudre.free.fr/Software/Packages/about.html
[donate]: https://paypal.me/ricsxn?locale.x=it_IT
[package]: https://github.com/ricsxn/ShowQR/blob/master/build/ShowQR.pkg
[usecase]: https://github.com/ricsxn/ShowQR/raw/master/docs/ShowQR_use.jpg
