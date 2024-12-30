org 0x0100
jmp start
cls:
push ax
push bx
push di
mov ax,0xb800
mov es,ax
mov di,0
space:                 ;printitng the spaces on whole screen
mov word[es:di],0x0720
add di,2
cmp di,4000
jne space
pop di
pop bx
pop ax
ret

shape:
mov cx,9
mov di,2000
loop1:
push cx
loop2:
mov word[es:di],0x072A
add di,2
sub cx,1
jnz loop2
pop cx
mov ax,cx
shl ax,1
add di,160
sub di,ax
add di,2
sub cx,2
cmp cx,0
jg loop1
ret
start:
call cls
call shape
mov ax,0x4c00
int 0x21