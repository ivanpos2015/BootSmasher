bits 16 ; 16-bit Real Mode
org 0x7c00 ; BIOS boot origin 

jmp main ;Jump to start main() entry-point 

;;;;;;;;;;;;;;
; Use NASM to convert this program into a bootable .bin file: nasm -f bin booter.asm -o booter.bin
;;;;;;;;;;;;;;

Message db "You need to take your computer to the Geek Squad! It is doomed!", 0x0 
MessageB db "U Mad Bro? ;]", 0x0

;Print characters to the screen 
Println:
    lodsb ;Load string 
    or al, al
    jz complete
    mov ah, 0x0e  
    int 0x10 ;BIOS Interrupt 0x10 - Used to print characters on the screen via Video Memory 
    jmp Println ;Loop    
complete:
    call PrintNwL

;Prints empty new lines like '\n' in C/C++  
PrintNwL: 
    mov al, 0 ; null terminator '\0'
    stosb       ; Store string 

    ;Adds a newline break '\n'
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A 
    int 0x10
 ret

;Bootloader entry-code 
main:
   cli ;Clear interrupts 
   ;Setup stack segments 
   mov ax,cs              
   mov ds,ax   
   mov es,ax               
   mov ss,ax                
   sti ;Enable interrupts 

   ;Print the first characters  
   mov si, Message 
   call Println 

   mov si, MessageB
   call Println 

   call PrintNwL
   call PrintNwL

   times 510 - ($-$$) db 0 ;Fill the rest of the bootloader with zeros 
   dw 0xAA55 ;Boot signature