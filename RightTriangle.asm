org 0x0100
jmp start
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
print:
mov ax,0
mov cx,1
mov di,2850
loop1:
push cx
jmp loop3
loop2:
add di,2
loop3:
mov word[es:di],0x072A
sub cx,1
jnz loop2
pop cx
mov ax,cx
shl ax,1
add di,160
sub di,ax
add cx,2
cmp cx,15
jle loop1
ret
start:
call cls
call print
mov ax,0x4c00
int 0x21
