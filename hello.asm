[org 0x0100]

jmp start

message:  db '0  0  49'         ; First row string
message2: db '0  0  84'         ; Second row string
message3: db '0  0  36'         ; Third row string
length:   dw 8                  ; Length of the strings

; Subroutine to clear the screen
clrscr:
    push es
    push ax
    push di
    mov ax, 0xb800             ; Video memory segment
    mov es, ax
    mov di, 0                  ; Top-left corner of the screen
nextloc:
    mov word [es:di], 0x0720   ; Clear screen (space with normal attribute)
    add di, 2                  ; Move to the next screen position
    cmp di, 4000               ; Check if entire screen is cleared
    jne nextloc
    pop di
    pop ax
    pop es
    ret

; Subroutine to print a string at a specific position
; Parameters:
; - DI: Position in video memory
; - SI: Address of the string
; - CX: Length of the string
printstr:
    push es
    push ax
    push cx
    push si
    mov ax, 0xb800             ; Video memory segment
    mov es, ax
nextchar:
    lodsb                      ; Load the next character from string (SI -> AL)
    mov ah, 0x07               ; Normal attribute
    mov [es:di], ax            ; Write character to video memory
    add di, 2                  ; Move to the next screen position
    loop nextchar
    pop si
    pop cx
    pop ax
    pop es
    ret

start:
    call clrscr                ; Clear the screen

    ; Print the first message
    mov di, 0                  ; Top-left corner of the screen (row 0)
    mov si, message            ; Address of the first message
    mov cx, [length]           ; Length of the string
    call printstr

    ; Print the second message
    mov di, 160                ; Start of the second row (80 columns × 2 bytes)
    mov si, message2           ; Address of the second message
    mov cx, [length]
    call printstr

    ; Print the third message
    mov di, 320                ; Start of the third row
    mov si, message3           ; Address of the third message
    mov cx, [length]
    call printstr

    ; Terminate the program
    mov ax, 0x4c00
    int 0x21
