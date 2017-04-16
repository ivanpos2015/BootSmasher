BootSmasher

This program erases the Master Boot Record in Microsoft Windows and replaces it with a BIN file called Booter.bin.

System Requirements: 
Administrator privileges 
Framework version 4.0
Visual C++ Redistributable for Visual Studio 2015
Operating System: Windows 7/10 

Instructions:
For Developers
Use Visual Studio 2015 to build the program. Compile the program using the x64 architecture. 

Notepad++ will allow you to edit the Booter.asm file.

To create a bin file, use NASM and this command "nasm -f bin booter.asm -o booter.bin" This changes a .asm file to a bootable .bin file.

Optional: Format a flash drive with a program called Rufus with the Booter.bin file as the image. You can boot the .bin file from the flash drive
to test how the final payload will appear on the boot screen. This way, you do not have to destroy a Windows image over ASCII art.

For Script Kiddies
Download this repository and place the files in the folder from Put_This_In_The_C_Drive_Root to "C:\". Then, run as administrator BootSmasher.exe 
on your target computer. 

---------------------------------------------------------------------
                              Updates
---------------------------------------------------------------------
Version: 1.0
Date: 4/16/2017
- Initial release.