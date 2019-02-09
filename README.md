# [ShowQR](http://ricsxn.github.io/ShowQR/)
Show QR code from any selected text on your Mac</br>
How shall I send text/URLs from my Mac to my Mobile in a fast and confortable way?<br/>
The ShowQR utility gratfully solves that!</br>
Once installed you can select any text from any application and with few mouse clicks the corresponding QR code containing that text will be promptly shown.</br>
You can use this little service for free or if you like this tool you can leave a donation by clicking [here][donate]

## Structure
ShowQR service consists of two components, a simple python script that triggers Preview.app containing the generated QR code taken from the stadard input, while the second component consists of an automator script that setup the system-wide service.

## [ShowQR.pkg][package]
The repository contains the ShowQR.pkg file that allows to install directly the utility into your Mac.
Altough the package should work for any MacOS X version, it is possible that the showQR application will not work. In this case, it is suggested to build the code as reported in the Build section.

## Usage
Once installed the utilty; select any text from any application and use one of the following:
 - Go in the current app name menu and select: Services/ShowQR item
 - Right click on top of selected text and select in the contextual menu: Services/ShowQR.
ShowQR generates a temporary file and triggers the Preview.app to show the generated QR code. The temporary file is already removed from the filesystem when is is displayed by the Preview application.

![][usecase]

## Build
The build process requires the following steps

### Python, pip, virtualenv and requirements
ShowQR core component is a python2.7 script, the standard python interpreter provided by Mac OS may create problems to setup pip, virtualenv and the necessary packages specified in the requirements.txt.
The following commands use the [brew][brew] package, to setup python.

```bash
$ brew install python@2
$ easy_install pip
$ pip install virtualenv
$ virtualenv venv
$ . venv/bin/activate
$ pip install -r requirements.txt
$ # You can now test the python code with
$ echo "Test ShowQR" | python showqr.py 
```
### ShowQR compilation
ShowQR compile the python application using pyinstaller. The necessary command to compile the source code is inside the file `mkshowqr`. To compile just execute:

```bash
$ ./mkshowqr
```

### Package creation
The package project file `showQRPackages.pkgproj`, already contains the necessary configuration to create the ShowQR.pkg file, however in order to open this project file the [Packages][packages] application must be installed first. Once opened the package project file, just select the menu Build/Build.
If everithing is fine, the new ShowQR.pkg file will be generated 

[brew]: https://brew.sh/index_it
[packages]: http://s.sudre.free.fr/Software/Packages/about.html
[donate]: http://ricsxn.duckdns.org/donate.html
[package]: https://github.com/ricsxn/ShowQR/blob/master/ShowQR.pkg
[usecase]: https://github.com/ricsxn/ShowQR/raw/master/showQRpkg/Resources/ShowQR_use.jpg
