# Skype export parser

In new Skype versions the only way to export threads is demanding export of your data at [Skype data export page](https://secure.skype.com/en/data-export).

After the data has been downloaded and extracted to a folder you find you cannot view it conveniently with local media files even if you use the [official Skype parser](https://go.skype.com/skype-parser).

Moreover, it is impossible to be seen which files belong to which threads in the **media** subfolder.

## What this script does
It forms local HTML files for all Skype threads where local pictures and videos are linked and shown in a browser.

It sorts media files by separating folders and renaming those files by dates and thread names.

## How it works
The script asks where your export folder locates. This folder must contain a **messages.json** file and a **media** subfolder.

Since messages' timestamps in Skype export dumps are in UTC, the script converts them according to the timezone shift on your local computer.

## Precautions
- Make sure you have enough free space on your disk because media files are copying during the process.
- This script has been tested only on Windows 10 with Powershell 5.1 and 7.1.3 and only on one Skype export dump. Anyway, use Powershell 4 or newer.
- All links to media files inside HTML files are relative and point out to **media** subfolder.

## Pictures
### This is how the data export folder looks after the work is completed
![pic1](https://github.com/v-bulynkin/skype-export-parser/blob/main/pics/skype-export-parser1.png)<br>

HTML files are threads. Folders with the same names contain extracted media files belong to those threads.

### HTML file opened in browser
![pic2](https://github.com/v-bulynkin/skype-export-parser/blob/main/pics/skype-export-parser2.png)

### Inside a thread folder
![pic3](https://github.com/v-bulynkin/skype-export-parser/blob/main/pics/skype-export-parser3.png)

