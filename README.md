# <img src="https://github.com/ricsxn/ShowQR/blob/master/showQRpkg/Contents/Library/Services/ShowQR.workflow/Contents/QuickLook/Thumbnail.png" width="100" />ShowQR
Show QR code from any selected text on your Mac

How shall I send text/URLs from my Mac to my Mobile in a fast and confortable way?
The ShowQR utility gratfully solves that!
Once installed you can select any text, right click on it and choose the contextual menu voice: 'services/ShowQR'. After a few seconds the corresponding QR will be shown.
You can use this litte service for free or if you like you can leave a donation by clicking [here][donate]

## Structure
ShowQR service consists of two components, a simple python script that triggers Preview.app containing the generated QR code taken from the stadard input, while the second component consists of an automator script that setup the system-wide service.

## ShowQR.pkg
The repository contains the ShowQR.pkg file that allows to install directly the utility into your Mac.
In earlier versions of ShowQR the package has been built using PackageManager. Since this utility has been deprecated the package is now created by Packages which configuration file still uses paths used by the previous tool.

## Usage
Once installed the utilty; select any text from any application and use one of the following:
 - Go in the current app name menu and select: Services/ShowQR item
 - Right click on top of selected text and select in the contextual menu: Services/ShowQR.
ShowQR generates a temporary file and triggers the Preview.app to show the generated QR code. The temporary file is already removed from the filesystem when is is displayed by the Preview application.

 
[donate]: http://ricsxn.duckdns.org/donate.html
