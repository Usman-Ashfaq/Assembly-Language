org 0x0100
jmp start
;subroutne to clear the screen
cls:
push ax
push bx
push di
mov ax,0xb800
mov es,ax
mov di,0
space:
mov word[es:di],0x0720
add di,2
cmp di,4000
jne space
pop di
pop bx
pop ax
ret
;subroutine to print the diamond
print:
mov ax,0
mov cx,1
mov di,1040
loop1:
push cx
jmp loop3
loop2:
add di,2
loop3:
cmp cx,1
je ppp1
cmp cx,ax
je ppp1
sub cx,1
jnz loop2
ppp1:
mov word[es:di],0x072A
sub cx,1
jnz loop2
pop cx
mov ax,cx
shl ax,1
add di,160             ;for next line
sub di,ax
add cx,2
mov ax,cx
cmp cx,15
jle loop1
loop4:
mov cx,13
mov ax,cx
mov ax,cx
add di,4
loop6:
push cx
loop5:
cmp cx,1
je ppp
cmp cx,ax
je ppp
add di,2
sub cx,1
jnz loop5
ppp:
mov word[es:di],0x072A
add di,2
sub cx,1
jnz loop5
pop cx
add di,160
mov ax,cx
shl ax,1
sub ax,2
sub di,ax
sub cx,2
mov ax,cx
cmp cx,0
jge loop6
ret
start:
call cls
call print
mov ax,0x4c00
int 0x21
