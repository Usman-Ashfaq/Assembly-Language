[org 0x0100]
jmp start

; Subroutine to clear the screen
clrscr:
    mov ax, 0xb800
    mov es, ax
    mov di, 0
nextchar: 
    mov word [es:di], 0x0720    
    add di, 2
    cmp di, 4000
    jne nextchar 
    ret

; subroutine to print the desired pattern
print:
    mov ax, 0xb800
    mov es, ax
    mov cx, 5                    
    mov di, 200                   
Loop1:
    ; Print leading spaces
    mov bx, 5                     ; bx to 5 for the maximum number of spaces
    sub bx, cx                    
    mov dx, di                    ;  current `di` position for row start
print_space:
    cmp bx, 0
    je starLoop                   ;if no need of  spaces then dirctly jump to starloop
    mov word [es:di], 0x0720     
    add di, 2                     ;moving to next location
    dec bx                        
    jmp print_space             
    
starLoop:
    mov bx, cx                    ;bx with cx value which wil print aestericks 
print_star:
    mov word [es:di], 0x072A      
    add di, 2                     
    dec bx                       
    cmp bx, 0
    jne print_star                 ;checking if bx!=0 continue printing the aestericks in row

    ; Move to the next line
    mov di, dx                    ;restore above di
    add di, 160                   ;adding 160  to move on next line
    dec cx                        ;decrementing row to 4     
    cmp cx, 0                      ;if cx is not 0 move to loop1
    jne Loop1                    
    ret

start:
    call clrscr                   
    call print                   
    mov ax, 0x4c00
    int 0x21                    
