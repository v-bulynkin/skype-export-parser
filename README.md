# Skype export parser

## Description of problems
In the new Skype versions the only way to export threads is demanding export of your data at [Skype data export page](https://secure.skype.com/en/data-export).

After the data has been downloaded and extracted to a folder you find you cannot view it conveniently with local media files even if you use the [official Skype parser](https://go.skype.com/skype-parser).

Moreover, it is impossible to detect which files belongs to which threads in the **media** subfolder.

## What this script do
This Powershell script tries to resolve these problems.

It forms local HTML files for each thread where local pictures and videos are linked and shown in a browser.

Optionally, it is possible to sort media files to separate folders and to rename those files by dates and thread names.

## Precautions
- Make sure you have enough free space on your disk because media files are copied during the process.
- This script has been tested only on Windows 10 with Powershell 5.1 and only on one Skype export dump.
- All links inside HTML files are hard, so if you choose to move your Skype exported folder to another place, restart the script after moving.

## Pictures
### This is how the data export folder looks after the work is completed
![pic1](https://github.com/v-bulynkin/skype-export-parser/blob/main/pics/skype-export-parser1.png)<br>

HTML files are threads and folders with the same names contains extracted media files belongs to those threads.

### HTML file opened in browser
![pic2](https://github.com/v-bulynkin/skype-export-parser/blob/main/pics/skype-export-parser2.png)

### Inside a thread folder
![pic3](https://github.com/v-bulynkin/skype-export-parser/blob/main/pics/skype-export-parser3.png)

