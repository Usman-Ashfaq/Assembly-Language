
[org 0x0100]
jmp main
; Sub-Routine to print diagonal boundary on the screen
border:		
                        push bp
			mov bp, sp
			sub sp, 2          ; Allocate space for [bp-2] (diagonal position)
			mov word[bp-2], 0  ; Start at top-left corner for diagonal boundary
			push ax
			push di
			push es
			mov ax, 0xb800
			mov es, ax			

			mov ax, 0x1720     ; Character and attribute for the diagonal line
;subroutine for diagonal			
diagonal:	
                        mov di, word[bp-2]
			mov [es:di], ax    ; Write the diagonal character
			add word[bp-2], 166 ; Move diagonally (row+1, column+1)
			cmp word[bp-2], 4000 ; Check if the diagonal has reached the bottom
			ja diagonal_end    ; Exit if beyond screen memory
			
			jmp diagonal       ; Continue drawing diagonal
			
diagonal_end:	
                        pop es
			pop di
			pop ax
			mov sp, bp
			pop bp
			ret
main:
call border
mov ax,0x4c00
int 0x21
