[org 0x0100]          
 
call main           

 
; Clear the screen 
clrscr:
mov ax,0xb800           
mov es,ax             
mov di,0              
mov ax,0x0720          
mov cx,2000            
cld                    
rep stosw              
ret                   

 ;name on the screen 
printname:
mov ah, 0x13           ; BIOS video function to write string
mov al, 1            
mov bh, 0              ; Output on page 0
mov bl, 7             
mov dx, 0x0101        ;row=0,col=0
mov cx, 21            
push cs               
pop es                 
mov bp, name           
int 0x10               ; Call BIOS video interrupt 
ret                   
 

;  Roll number on the screen 
printroll:
mov ah, 0x13           ; BIOS video function 
mov al, 1              
mov bh, 0              ; Output on page 0
mov bl, 7              
mov dx, 0x0201         ; row= 1, column =0
mov cx, 17              ; Length of the roll number string
push cs              
pop es                 
mov bp, rollno    
int 0x10               ; Call BIOS video interrupt to print the string
ret                    

; show  section on the screen 
printsec:
mov ah, 0x13           ; BIOS video function to write string
mov al, 1              
mov bh, 0              ; Output on page 0
mov bl, 7              ; Set text attribute to white on black
mov dx, 0x0301         ; row= 2, column= 0
mov cx, 11              ; Length of the section string
push cs                
pop es                
mov bp, sect       ; Offset of the section string in memory
int 0x10               ; BIOS video interrupt 
ret                  
 

; Main program logic
main:
call clrscr            ;call clear screen
call printname        ; call printname
call printroll        ; call print roll number
call printsec         ; call section

name: db 'Name   : Usman Ashfaq'      ;  name    lenght 21
rollno: db 'Roll no: 2299232 '     ; sroll number length 17
sect: db 'Section: F'                  ;  the section length 11
mov ax,0x4c00         
int 0x21