# Skype export parser

## Description of problems
In the new Skype versions the only way to export threads is demanding export of your data at [Skype data export page](https://secure.skype.com/en/data-export).

After the data has been downloaded and extracted to a folder you find you cannot view it conveniently with local media files even if you use the [official Skype parser](https://go.skype.com/skype-parser).

Moreover, it is impossible to be seen which files belong to which threads in the **media** subfolder.

## What this script do
This Powershell script tries to resolve these problems.

It forms a local HTML file for each thread where local pictures and videos are linked and shown in a browser.

Optionally, it is possible to sort media files by separate folders and to rename those files by dates and thread names.

## How it works
The script asks two questions:

**1. Where is the main Skype export data folder?**<br>
Enter the full path like D:\Downloads\skype-export. In this folder you should have a **messages.json** file and a **media** subfolder.

**2. Do you want to sort media files by threads and rename them?**<br>
Type 1 and press enter if you accept. To refuse, press enter.

## Precautions
- Make sure you have enough free space on your disk because media files are copying during the process.
- This script has been tested only on Windows 10 with Powershell 5.1 and only on one Skype export dump. Use Powershell 4 and newer.
- All links inside HTML files are absolute, so if you move your Skype exported folder to another place, restart the script to renew HTML files (or search&replace links using any text editor if you know what I am talking about).

## Pictures
### This is how the data export folder looks after the work is completed
![pic1](https://github.com/v-bulynkin/skype-export-parser/blob/main/pics/skype-export-parser1.png)<br>

HTML files are threads. Folders with the same names contain extracted media files belong to those threads.

### HTML file opened in browser
![pic2](https://github.com/v-bulynkin/skype-export-parser/blob/main/pics/skype-export-parser2.png)

### Inside a thread folder
![pic3](https://github.com/v-bulynkin/skype-export-parser/blob/main/pics/skype-export-parser3.png)

