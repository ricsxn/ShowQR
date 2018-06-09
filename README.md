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
In earlier versions of ShowQR the package has been built using PackageManager. Since this utility has been deprecated the package is now created by Packages which configuration file still uses paths used by the previous tool.

## Usage
Once installed the utilty; select any text from any application and use one of the following:
 - Go in the current app name menu and select: Services/ShowQR item
 - Right click on top of selected text and select in the contextual menu: Services/ShowQR.
ShowQR generates a temporary file and triggers the Preview.app to show the generated QR code. The temporary file is already removed from the filesystem when is is displayed by the Preview application.

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&encrypted=-----BEGIN PKCS7-----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-----END PKCS7-----")
![][usecase]
 
[donate]: http://ricsxn.duckdns.org/donate.html
[package]: https://github.com/ricsxn/ShowQR/blob/master/ShowQR.pkg
[usecase]: https://github.com/ricsxn/ShowQR/raw/master/showQRpkg/Resources/ShowQR_use.jpg
